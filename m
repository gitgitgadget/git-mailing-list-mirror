From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] diff: don't use pathname-based diff drivers for
 symlinks
Date: Tue, 21 Sep 2010 17:01:24 -0400
Message-ID: <20100921210124.GA1188@sigill.intra.peff.net>
References: <20100921205914.GA1166@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Kirill Smelkov <kirr@landau.phys.spbu.ru>, git@vger.kernel.org,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?utf-8?Q?Cl=C3=A9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 21 23:01:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oy9xy-0000Zk-Ao
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 23:01:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756467Ab0IUVBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 17:01:25 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:55807 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756416Ab0IUVBY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 17:01:24 -0400
Received: (qmail 11955 invoked by uid 111); 21 Sep 2010 21:01:24 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 21 Sep 2010 21:01:24 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Sep 2010 17:01:24 -0400
Content-Disposition: inline
In-Reply-To: <20100921205914.GA1166@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156761>

When we're diffing symlinks, we consider the contents to be
the pathname that the symlink points to. When a user sets up
a userdiff driver like "*.pdf diff=pdf", their "diff.pdf.*"
config generally tells us what to do with the content of
pdf files.

With the current code, we will actually process a symlink
like "link.pdf" using a configured pdf driver, meaning we
are using contents which consist of a pathname with
configuration that is expecting contents that consist of an
actual pdf file.

The most noticeable example of this would have been
textconv; however, it was already protected in its own
textconv-specific code path. We can still see the breakage
with something like "diff.*.binary", though. You could
also see it with diff.*.funcname, though it is a bit harder
to trigger accidentally there.

This patch adds a check for S_ISREG lower in the callstack
than the textconv-specific check, which should block use of
any userdiff config for non-regular files. We can drop the
check in the textconv code, which is now redundant.

Signed-off-by: Jeff King <peff@peff.net>
---
Technically, this could be breaking somebody's setup if:

  1. They found some use for userdiff config on symlinks. Textconv is
     already disabled. A custom diff driver might work.

and

  2. They were willing to specify symlinks individually in
     .gitattributes, or name them according to some symlink-specific
     pattern. Attribute patterns that matched both regular files and
     symlinks were broken, as shown in the test.

I find it unlikely, and given the potential breakage, it seems more like
exploiting a bug to get what you want. A more sane way of doing the same
thing is provided in patch 2/2.

 diff.c                  |   11 ++++++++---
 t/t4011-diff-symlink.sh |   26 ++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 9a5c77c..276e029 100644
--- a/diff.c
+++ b/diff.c
@@ -1771,8 +1771,14 @@ static void emit_binary_diff(FILE *file, mmfile_t *one, mmfile_t *two, char *pre
 
 static void diff_filespec_load_driver(struct diff_filespec *one)
 {
-	if (!one->driver)
+	/* Use already-loaded driver */
+	if (one->driver)
+		return;
+
+	if (S_ISREG(one->mode))
 		one->driver = userdiff_find_by_path(one->path);
+
+	/* Fallback to default settings */
 	if (!one->driver)
 		one->driver = userdiff_find_by_name("default");
 }
@@ -1820,8 +1826,7 @@ struct userdiff_driver *get_textconv(struct diff_filespec *one)
 {
 	if (!DIFF_FILE_VALID(one))
 		return NULL;
-	if (!S_ISREG(one->mode))
-		return NULL;
+
 	diff_filespec_load_driver(one);
 	if (!one->driver->textconv)
 		return NULL;
diff --git a/t/t4011-diff-symlink.sh b/t/t4011-diff-symlink.sh
index 6f69489..408a19c 100755
--- a/t/t4011-diff-symlink.sh
+++ b/t/t4011-diff-symlink.sh
@@ -88,4 +88,30 @@ test_expect_success SYMLINKS \
     test_must_fail git diff --no-index pinky brain > output 2> output.err &&
     grep narf output &&
     ! grep error output.err'
+
+test_expect_success SYMLINKS 'setup symlinks with attributes' '
+	echo "*.bin diff=bin" >>.gitattributes &&
+	echo content >file.bin &&
+	ln -s file.bin link.bin &&
+	git add -N file.bin link.bin
+'
+
+cat >expect <<'EOF'
+diff --git a/file.bin b/file.bin
+index e69de29..d95f3ad 100644
+Binary files a/file.bin and b/file.bin differ
+diff --git a/link.bin b/link.bin
+index e69de29..dce41ec 120000
+--- a/link.bin
++++ b/link.bin
+@@ -0,0 +1 @@
++file.bin
+\ No newline at end of file
+EOF
+test_expect_success SYMLINKS 'symlinks do not respect userdiff config by path' '
+	git config diff.bin.binary true &&
+	git diff file.bin link.bin >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.7.3.256.gb9713
