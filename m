Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D29620193
	for <e@80x24.org>; Wed,  2 Nov 2016 13:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752546AbcKBNIw (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 09:08:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:37460 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751722AbcKBNIv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 09:08:51 -0400
Received: (qmail 22827 invoked by uid 109); 2 Nov 2016 13:08:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Nov 2016 13:08:50 +0000
Received: (qmail 2726 invoked by uid 111); 2 Nov 2016 13:09:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Nov 2016 09:09:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Nov 2016 09:08:49 -0400
Date:   Wed, 2 Nov 2016 09:08:49 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 4/5] attr: do not respect symlinks for in-tree .gitattributes
Message-ID: <20161102130848.qpigt4hxpoyfjf7x@sigill.intra.peff.net>
References: <20161102130432.d3zprdul4sqgcfwu@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161102130432.d3zprdul4sqgcfwu@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The attributes system may sometimes read in-tree files from
the filesystem, and sometimes from the index. In the latter
case, we do not resolve symbolic links (and are not likely
to ever start doing so). Let's open filesystem links with
O_NOFOLLOW so that the two cases behave consistently.

As a bonus, this means that git will not follow such
symlinks to read and parse out-of-tree paths. It's unlikely
that this could have any security implications (a malicious
repository can already feed arbitrary content to the
attribute parser, and any disclosure of the out-of-tree
contents happens only to stderr). But it's one less oddball
thing to worry about.

Note that O_NOFOLLOW only prevents following links for the
path itself, not intermediate directories in the path.  At
first glance, it seems like

  ln -s /some/path in-repo

might still look at "in-repo/.gitattributes", following the
symlink to "/some/path/.gitattributes". However, if
"in-repo" is a symbolic link, then we know that it has no
git paths below it, and will never look at its
.gitattributes file.

We will continue to support out-of-tree symbolic links
(e.g., in $GIT_DIR/info/attributes); this just affects
in-tree links. When a symbolic link is encountered, the
contents are ignored and a warning is printed. POSIX
specifies ELOOP in this case, so the user would generally
see something like:

  warning: unable to access '.gitattributes': Too many levels of symbolic links

Signed-off-by: Jeff King <peff@peff.net>
---
 attr.c                | 17 +++++++++++++----
 t/t0003-attributes.sh | 31 +++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/attr.c b/attr.c
index 79bd89226..abf375c8a 100644
--- a/attr.c
+++ b/attr.c
@@ -153,6 +153,7 @@ static const char blank[] = " \t\r\n";
 
 /* Flags usable in read_attr() and parse_attr_line() family of functions. */
 #define READ_ATTR_MACRO_OK (1<<0)
+#define READ_ATTR_NOFOLLOW (1<<1)
 
 /*
  * Parse a whitespace-delimited attribute state (i.e., "attr",
@@ -371,16 +372,24 @@ static struct index_state *use_index;
 
 static struct attr_stack *read_attr_from_file(const char *path, unsigned flags)
 {
-	FILE *fp = fopen(path, "r");
+	int fd;
+	FILE *fp;
 	struct attr_stack *res;
 	char buf[2048];
 	int lineno = 0;
 
-	if (!fp) {
+	if (flags & READ_ATTR_NOFOLLOW)
+		fd = open_nofollow(path, O_RDONLY);
+	else
+		fd = open(path, O_RDONLY);
+
+	if (fd < 0) {
 		if (errno != ENOENT && errno != ENOTDIR)
 			warn_on_inaccessible(path);
 		return NULL;
 	}
+	fp = xfdopen(fd, "r");
+
 	res = xcalloc(1, sizeof(*res));
 	while (fgets(buf, sizeof(buf), fp)) {
 		char *bufp = buf;
@@ -528,7 +537,7 @@ static void bootstrap_attr_stack(void)
 	}
 
 	if (!is_bare_repository() || direction == GIT_ATTR_INDEX) {
-		elem = read_attr(GITATTRIBUTES_FILE, flags);
+		elem = read_attr(GITATTRIBUTES_FILE, flags | READ_ATTR_NOFOLLOW);
 		elem->origin = xstrdup("");
 		elem->originlen = 0;
 		elem->prev = attr_stack;
@@ -620,7 +629,7 @@ static void prepare_attr_stack(const char *path, int dirlen)
 			strbuf_add(&pathbuf, path, cp - path);
 			strbuf_addch(&pathbuf, '/');
 			strbuf_addstr(&pathbuf, GITATTRIBUTES_FILE);
-			elem = read_attr(pathbuf.buf, 0);
+			elem = read_attr(pathbuf.buf, READ_ATTR_NOFOLLOW);
 			strbuf_setlen(&pathbuf, cp - path);
 			elem->origin = strbuf_detach(&pathbuf, &elem->originlen);
 			elem->prev = attr_stack;
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index f0fbb4255..bd01945e5 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -297,4 +297,35 @@ test_expect_success 'bare repository: test info/attributes' '
 	)
 '
 
+check_symlink () {
+	echo "$1: symlink: $2" >expect &&
+	git check-attr symlink "$1" >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success SYMLINKS 'set up attr file for symlink tests' '
+	echo "* symlink" >attr
+'
+
+test_expect_success SYMLINKS 'symlinks respected in core.attributesFile' '
+	test_when_finished "rm symlink" &&
+	ln -s attr symlink &&
+	test_config core.attributesFile "$(pwd)/symlink" &&
+	check_symlink file set
+'
+
+test_expect_success SYMLINKS 'symlinks respected in info/attributes' '
+	test_when_finished "rm .git/info/attributes" &&
+	ln -s ../../attr .git/info/attributes &&
+	check_symlink file set
+'
+
+test_expect_success SYMLINKS 'symlinks not respected in-tree' '
+	test_when_finished "rm .gitattributes" &&
+	ln -sf attr .gitattributes &&
+	mkdir subdir &&
+	ln -sf ../attr subdir/.gitattributes &&
+	check_symlink subdir/file unspecified
+'
+
 test_done
-- 
2.11.0.rc0.258.gf434c15

