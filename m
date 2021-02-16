Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554EFC433E9
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 14:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20B4764E00
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 14:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhBPOpX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 09:45:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:34200 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230153AbhBPOpP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 09:45:15 -0500
Received: (qmail 13414 invoked by uid 109); 16 Feb 2021 14:44:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Feb 2021 14:44:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24747 invoked by uid 111); 16 Feb 2021 14:44:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Feb 2021 09:44:32 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Feb 2021 09:44:32 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Blake Burkhart <bburky@bburky.com>,
        Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: [PATCH 4/6] attr: do not respect symlinks for in-tree .gitattributes
Message-ID: <YCvaUHnf6eFll++h@coredump.intra.peff.net>
References: <YCvaJg8o882IqNnx@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YCvaJg8o882IqNnx@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The attributes system may sometimes read in-tree files from the
filesystem, and sometimes from the index. In the latter case, we do not
resolve symbolic links (and are not likely to ever start doing so).
Let's open filesystem links with O_NOFOLLOW so that the two cases behave
consistently.

As a bonus, this means that git will not follow such symlinks to read
and parse out-of-tree paths. In some cases this could have security
implications, as a malicious repository can cause Git to open and read
arbitrary files. It could already feed arbitrary content to the parser,
but in certain setups it might be able to exfiltrate data from those
paths (e.g., if an automated service operating on the malicious repo
reveals its stderr to an attacker).

Note that O_NOFOLLOW only prevents following links for the path itself,
not intermediate directories in the path.  At first glance, it seems
like

  ln -s /some/path in-repo

might still look at "in-repo/.gitattributes", following the symlink to
"/some/path/.gitattributes". However, if "in-repo" is a symbolic link,
then we know that it has no git paths below it, and will never look at
its .gitattributes file.

We will continue to support out-of-tree symbolic links (e.g., in
$GIT_DIR/info/attributes); this just affects in-tree links. When a
symbolic link is encountered, the contents are ignored and a warning is
printed. POSIX specifies ELOOP in this case, so the user would generally
see something like:

  warning: unable to access '.gitattributes': Too many levels of symbolic links

Signed-off-by: Jeff King <peff@peff.net>
---
 attr.c                | 19 +++++++++++++++----
 t/t0003-attributes.sh | 36 +++++++++++++++++++++++++++++++++---
 2 files changed, 48 insertions(+), 7 deletions(-)

diff --git a/attr.c b/attr.c
index 7b0cab085f..a28177915b 100644
--- a/attr.c
+++ b/attr.c
@@ -280,6 +280,7 @@ static const char blank[] = " \t\r\n";
 
 /* Flags usable in read_attr() and parse_attr_line() family of functions. */
 #define READ_ATTR_MACRO_OK (1<<0)
+#define READ_ATTR_NOFOLLOW (1<<1)
 
 /*
  * Parse a whitespace-delimited attribute state (i.e., "attr",
@@ -704,13 +705,23 @@ void git_attr_set_direction(enum git_attr_direction new_direction)
 
 static struct attr_stack *read_attr_from_file(const char *path, unsigned flags)
 {
-	FILE *fp = fopen_or_warn(path, "r");
+	int fd;
+	FILE *fp;
 	struct attr_stack *res;
 	char buf[2048];
 	int lineno = 0;
 
-	if (!fp)
+	if (flags & READ_ATTR_NOFOLLOW)
+		fd = open_nofollow(path, O_RDONLY);
+	else
+		fd = open(path, O_RDONLY);
+
+	if (fd < 0) {
+		warn_on_fopen_errors(path);
 		return NULL;
+	}
+	fp = xfdopen(fd, "r");
+
 	res = xcalloc(1, sizeof(*res));
 	while (fgets(buf, sizeof(buf), fp)) {
 		char *bufp = buf;
@@ -870,7 +881,7 @@ static void bootstrap_attr_stack(const struct index_state *istate,
 	}
 
 	/* root directory */
-	e = read_attr(istate, GITATTRIBUTES_FILE, flags);
+	e = read_attr(istate, GITATTRIBUTES_FILE, flags | READ_ATTR_NOFOLLOW);
 	push_stack(stack, e, xstrdup(""), 0);
 
 	/* info frame */
@@ -961,7 +972,7 @@ static void prepare_attr_stack(const struct index_state *istate,
 		strbuf_add(&pathbuf, path + pathbuf.len, (len - pathbuf.len));
 		strbuf_addf(&pathbuf, "/%s", GITATTRIBUTES_FILE);
 
-		next = read_attr(istate, pathbuf.buf, 0);
+		next = read_attr(istate, pathbuf.buf, READ_ATTR_NOFOLLOW);
 
 		/* reset the pathbuf to not include "/.gitattributes" */
 		strbuf_setlen(&pathbuf, len);
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index b660593c20..1e4c672b84 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -4,12 +4,16 @@ test_description=gitattributes
 
 . ./test-lib.sh
 
-attr_check () {
+attr_check_basic () {
 	path="$1" expect="$2" git_opts="$3" &&
 
 	git $git_opts check-attr test -- "$path" >actual 2>err &&
 	echo "$path: test: $expect" >expect &&
-	test_cmp expect actual &&
+	test_cmp expect actual
+}
+
+attr_check () {
+	attr_check_basic "$@" &&
 	test_must_be_empty err
 }
 
@@ -331,12 +335,38 @@ test_expect_success 'binary macro expanded by -a' '
 	test_cmp expect actual
 '
 
-
 test_expect_success 'query binary macro directly' '
 	echo "file binary" >.gitattributes &&
 	echo file: binary: set >expect &&
 	git check-attr binary file >actual &&
 	test_cmp expect actual
 '
 
+test_expect_success SYMLINKS 'set up symlink tests' '
+	echo "* test" >attr &&
+	rm -f .gitattributes
+'
+
+test_expect_success SYMLINKS 'symlinks respected in core.attributesFile' '
+	test_when_finished "rm symlink" &&
+	ln -s attr symlink &&
+	test_config core.attributesFile "$(pwd)/symlink" &&
+	attr_check file set
+'
+
+test_expect_success SYMLINKS 'symlinks respected in info/attributes' '
+	test_when_finished "rm .git/info/attributes" &&
+	ln -s ../../attr .git/info/attributes &&
+	attr_check file set
+'
+
+test_expect_success SYMLINKS 'symlinks not respected in-tree' '
+	test_when_finished "rm -rf .gitattributes subdir" &&
+	ln -s attr .gitattributes &&
+	mkdir subdir &&
+	ln -s ../attr subdir/.gitattributes &&
+	attr_check_basic subdir/file unspecified &&
+	test_i18ngrep "unable to access.*gitattributes" err
+'
+
 test_done
-- 
2.30.1.986.gd86016a168

