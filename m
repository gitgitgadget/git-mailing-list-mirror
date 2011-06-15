From: Jeff King <peff@peff.net>
Subject: [PATCH 6/7] archive: match extensions from user-configured formats
Date: Wed, 15 Jun 2011 18:34:32 -0400
Message-ID: <20110615223432.GF16807@sigill.intra.peff.net>
References: <20110615223030.GA16110@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org,
	git-dev@github.com
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Jun 16 00:34:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWyfX-00007b-Jl
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 00:34:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753482Ab1FOWef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 18:34:35 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45261
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751991Ab1FOWee (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 18:34:34 -0400
Received: (qmail 7609 invoked by uid 107); 15 Jun 2011 22:34:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 15 Jun 2011 18:34:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Jun 2011 18:34:32 -0400
Content-Disposition: inline
In-Reply-To: <20110615223030.GA16110@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175862>

This lets you configure a format like:

  [tarfilter "tgz"]
    command = gzip
    extension = tgz
    extension = tar.gz

and have it automatically used for "foo.tgz" or "foo.tar.gz".

Signed-off-by: Jeff King <peff@peff.net>
---
 archive-tar-filter.c |   29 +++++++++++++++++++++++++++++
 archive.c            |   12 ++++++++++++
 archive.h            |    1 +
 t/t5000-tar-tree.sh  |    4 ++--
 4 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/archive-tar-filter.c b/archive-tar-filter.c
index ffe510e..e749133 100644
--- a/archive-tar-filter.c
+++ b/archive-tar-filter.c
@@ -39,6 +39,35 @@ struct tar_filter *tar_filter_by_name(const char *name)
 	return tar_filter_by_namelen(name, strlen(name));
 }
 
+static int match_extension(const char *filename, const char *ext)
+{
+	int prefixlen = strlen(filename) - strlen(ext);
+
+	/*
+	 * We need 1 character for the '.', and 1 character to ensure that the
+	 * prefix is non-empty (i.e., we don't match ".tar.gz" with no actual
+	 * filename).
+	 */
+	if (prefixlen < 2 || filename[prefixlen-1] != '.')
+		return 0;
+	return !strcmp(filename + prefixlen, ext);
+}
+
+struct tar_filter *tar_filter_by_extension(const char *filename)
+{
+	struct tar_filter *p;
+
+	for (p = tar_filters; p; p = p->next) {
+		int i;
+		for (i = 0; i < p->extensions.nr; i++) {
+			const char *ext = p->extensions.items[i].string;
+			if (match_extension(filename, ext))
+				return p;
+		}
+	}
+	return NULL;
+}
+
 static int tar_filter_config(const char *var, const char *value, void *data)
 {
 	struct tar_filter *tf;
diff --git a/archive.c b/archive.c
index e04f689..e509b6c 100644
--- a/archive.c
+++ b/archive.c
@@ -434,11 +434,23 @@ int write_archive(int argc, const char **argv, const char *prefix,
 
 const char *archive_format_from_filename(const char *filename)
 {
+	struct tar_filter *tf;
 	const char *ext = strrchr(filename, '.');
 	if (!ext)
 		return NULL;
 	ext++;
 	if (!strcasecmp(ext, "zip"))
 		return "zip";
+
+	/*
+	 * Fallback to user-configured tar filters; but note
+	 * that we might have to load config ourselves, first,
+	 * if we are not being called via write_archive.
+	 */
+	tar_filter_load_config();
+	tf = tar_filter_by_extension(filename);
+	if (tf)
+		return tf->name;
+
 	return NULL;
 }
diff --git a/archive.h b/archive.h
index 894d4c4..80c89dc 100644
--- a/archive.h
+++ b/archive.h
@@ -41,6 +41,7 @@ struct tar_filter {
 
 extern struct tar_filter *tar_filters;
 extern struct tar_filter *tar_filter_by_name(const char *name);
+extern struct tar_filter *tar_filter_by_extension(const char *filename);
 
 extern void tar_filter_load_config(void);
 
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 9f959b1..fe661f3 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -289,7 +289,7 @@ test_expect_success 'archive outputs in configurable format' '
 	test_cmp b.tar config.tar
 '
 
-test_expect_failure 'archive selects implicit format by configured extension' '
+test_expect_success 'archive selects implicit format by configured extension' '
 	git archive -o config-implicit.tar.foo HEAD &&
 	test_cmp config.tar.foo config-implicit.tar.foo &&
 	git archive -o config-implicit.bar HEAD &&
@@ -301,7 +301,7 @@ test_expect_success 'default output format remains tar' '
 	test_cmp b.tar config-implicit.baz
 '
 
-test_expect_failure 'extension matching requires dot' '
+test_expect_success 'extension matching requires dot' '
 	git archive -o config-implicittar.foo HEAD &&
 	test_cmp b.tar config-implicittar.foo
 '
-- 
1.7.6.rc1.4.g49204
