From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/5] refactor userdiff textconv code
Date: Fri, 24 Oct 2008 09:51:32 -0400
Message-ID: <20081024135132.GA11568@coredump.intra.peff.net>
References: <20081024024631.GA20365@coredump.intra.peff.net> <20081024025330.GC2831@coredump.intra.peff.net> <4901762A.3090003@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Oct 24 15:53:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtN6R-0003I6-JO
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 15:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752976AbYJXNvg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 09:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752890AbYJXNvf
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 09:51:35 -0400
Received: from peff.net ([208.65.91.99]:3449 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752876AbYJXNve (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 09:51:34 -0400
Received: (qmail 19202 invoked by uid 111); 24 Oct 2008 13:51:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 24 Oct 2008 09:51:33 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Oct 2008 09:51:32 -0400
Content-Disposition: inline
In-Reply-To: <4901762A.3090003@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99036>

On Fri, Oct 24, 2008 at 09:15:54AM +0200, Johannes Sixt wrote:

> +cat >expect.typechange <<'EOF'
> +Binary files a/file and /dev/null differ
> +diff --git a/file b/file
> +new file mode 120000
> +index ad8b3d2..67be421
> +--- /dev/null
> ++++ b/file
> +@@ -0,0 +1 @@
> ++frotz
> +\ No newline at end of file
> +EOF

Actually, I don't think this is right. The typechange has been broken
into two parts: the removal of the file contents and the addition of the
symlink. So the first part _should_ use the textconv, since it is just
comparing the file contents to /dev/null. But the second part should
not, since it is by definition just the text of the symlink. Ditto for
gitlinks, which have a special text representation. So how about this?

-- >8 --
only textconv regular files

We treat symlinks as text containing the results of the
symlink, so it doesn't make much sense to text-convert them.

Similarly gitlink components just end up as the text
"Subproject commit $sha1", which we should leave intact.

Note that a typechange may be broken into two parts: the
removal of the old part and the addition of the new. In that
case, we _do_ show the textconv for any part which is the
addition or removal of a file we would ordinarily textconv,
since it is purely acting on the file contents.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c                   |    3 +++
 t/t4030-diff-textconv.sh |   28 ++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index 52feba7..ce1317d 100644
--- a/diff.c
+++ b/diff.c
@@ -289,6 +289,9 @@ static int diff_filespec_textconv(struct diff_filespec *one)
 	if (!DIFF_FILE_VALID(one))
 		return 0;
 
+	if (!S_ISREG(one->mode))
+		return 0;
+
 	diff_filespec_load_driver(one);
 	if (!one->driver->textconv)
 		return 0;
diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
index e456746..a5cd99b 100755
--- a/t/t4030-diff-textconv.sh
+++ b/t/t4030-diff-textconv.sh
@@ -19,6 +19,22 @@ cat >expect.text <<'EOF'
 +1
 EOF
 
+cat >expect.typechange <<'EOF'
+--- a/file
++++ /dev/null
+@@ -1,2 +0,0 @@
+-0
+-1
+diff --git a/file b/file
+new file mode 120000
+index ad8b3d2..67be421
+--- /dev/null
++++ b/file
+@@ -0,0 +1 @@
++frotz
+\ No newline at end of file
+EOF
+
 cat >hexdump <<'EOF'
 #!/bin/sh
 perl -e '$/ = undef; $_ = <>; s/./ord($&)/ge; print $_' "$1"
@@ -75,4 +91,16 @@ test_expect_success 'format-patch produces binary' '
 	test_cmp expect.binary actual
 '
 
+# make a symlink the hard way that works on symlink-challenged file systems
+test_expect_failure 'textconv does not act on symlinks' '
+	echo -n frotz > file &&
+	git add file &&
+	git ls-files -s | sed -e s/100644/120000/ |
+		git update-index --index-info &&
+	git commit -m typechange &&
+	git show >diff &&
+	find_diff <diff >actual &&
+	test_cmp expect.typechange actual
+'
+
 test_done
-- 
1.6.0.3.523.ge05eb.dirty
