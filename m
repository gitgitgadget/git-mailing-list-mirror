Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76CB0205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 22:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756364AbdABWZi (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 17:25:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:34404 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934287AbdABWZM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 17:25:12 -0500
Received: (qmail 10212 invoked by uid 109); 2 Jan 2017 22:25:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Jan 2017 22:25:12 +0000
Received: (qmail 20238 invoked by uid 111); 2 Jan 2017 22:26:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Jan 2017 17:26:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Jan 2017 17:25:09 -0500
Date:   Mon, 2 Jan 2017 17:25:09 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH] archive-zip: load userdiff config
Message-ID: <20170102222509.ho7motscnffrtnfh@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 4aff646d17 (archive-zip: mark text files in archives,
2015-03-05), the zip archiver will look at the userdiff
driver to decide whether a file is text or binary. This
usually doesn't need to look any further than the attributes
themselves (e.g., "-diff", etc). But if the user defines a
custom driver like "diff=foo", we need to look at
"diff.foo.binary" in the config. Prior to this patch, we
didn't actually load it.

Signed-off-by: Jeff King <peff@peff.net>
---
I'd be surprised if anybody actually triggered this in practice. I don't
think any of the custom-driver fields except "binary" matter, and using
direct attributes is almost always easier than setting up a custom
driver. Though you could also do trickery with:

  git -c diff.default.binary=true archive ...

if you wanted to be really clever.

I ran across this while investigating a case where somebody's zipfile
was all marked as binary (it turned out not to be related; the issue was
just that their Git was pre-4aff646d17).

I also happened to notice that zipfiles are created using the local
timezone (because they have no notion of the timezone, so we have to
pick _something_). That's probably the least-terrible option, but it was
certainly surprising to me when I tried to bit-for-bit reproduce a
zipfile from GitHub on my local machine.

 archive-zip.c          |  7 +++++++
 t/t5003-archive-zip.sh | 22 ++++++++++++++++++----
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index 9db47357b0..b429a8d974 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -554,11 +554,18 @@ static void dos_time(time_t *time, int *dos_date, int *dos_time)
 	*dos_time = t->tm_sec / 2 + t->tm_min * 32 + t->tm_hour * 2048;
 }
 
+static int archive_zip_config(const char *var, const char *value, void *data)
+{
+	return userdiff_config(var, value);
+}
+
 static int write_zip_archive(const struct archiver *ar,
 			     struct archiver_args *args)
 {
 	int err;
 
+	git_config(archive_zip_config, NULL);
+
 	dos_time(&args->time, &zip_date, &zip_time);
 
 	zip_dir = xmalloc(ZIP_DIRECTORY_MIN_SIZE);
diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
index 14744b2a4b..55c7870997 100755
--- a/t/t5003-archive-zip.sh
+++ b/t/t5003-archive-zip.sh
@@ -64,6 +64,12 @@ check_zip() {
 		test_cmp_bin $original/nodiff.crlf $extracted/nodiff.crlf &&
 		test_cmp_bin $original/nodiff.lf   $extracted/nodiff.lf
 	"
+
+	test_expect_success UNZIP " validate that custom diff is unchanged " "
+		test_cmp_bin $original/custom.cr   $extracted/custom.cr &&
+		test_cmp_bin $original/custom.crlf $extracted/custom.crlf &&
+		test_cmp_bin $original/custom.lf   $extracted/custom.lf
+	"
 }
 
 test_expect_success \
@@ -78,6 +84,9 @@ test_expect_success \
      printf "text\r"	>a/nodiff.cr &&
      printf "text\r\n"	>a/nodiff.crlf &&
      printf "text\n"	>a/nodiff.lf &&
+     printf "text\r"	>a/custom.cr &&
+     printf "text\r\n"	>a/custom.crlf &&
+     printf "text\n"	>a/custom.lf &&
      printf "\0\r"	>a/binary.cr &&
      printf "\0\r\n"	>a/binary.crlf &&
      printf "\0\n"	>a/binary.lf &&
@@ -112,15 +121,20 @@ test_expect_success 'add files to repository' '
 test_expect_success 'setup export-subst and diff attributes' '
 	echo "a/nodiff.* -diff" >>.git/info/attributes &&
 	echo "a/diff.* diff" >>.git/info/attributes &&
+	echo "a/custom.* diff=custom" >>.git/info/attributes &&
+	git config diff.custom.binary true &&
 	echo "substfile?" export-subst >>.git/info/attributes &&
 	git log --max-count=1 "--pretty=format:A${SUBSTFORMAT}O" HEAD \
 		>a/substfile1
 '
 
-test_expect_success \
-    'create bare clone' \
-    'git clone --bare . bare.git &&
-     cp .git/info/attributes bare.git/info/attributes'
+test_expect_success 'create bare clone' '
+	git clone --bare . bare.git &&
+	cp .git/info/attributes bare.git/info/attributes &&
+	# Recreate our changes to .git/config rather than just copying it, as
+	# we do not want to clobber core.bare or other settings.
+	git -C bare.git config diff.custom.binary true
+'
 
 test_expect_success \
     'remove ignored file' \
-- 
2.11.0.519.g31435224cf
