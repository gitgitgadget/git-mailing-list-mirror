From: Jeff King <peff@peff.net>
Subject: [PATCH v3 6/8] only textconv regular files
Date: Sun, 26 Oct 2008 00:46:21 -0400
Message-ID: <20081026044621.GF21047@coredump.intra.peff.net>
References: <20081026043802.GA14530@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 26 05:47:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtxXN-0005VK-4w
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 05:47:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627AbYJZEqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2008 00:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbYJZEqY
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 00:46:24 -0400
Received: from peff.net ([208.65.91.99]:2253 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751391AbYJZEqY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2008 00:46:24 -0400
Received: (qmail 5024 invoked by uid 111); 26 Oct 2008 04:46:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 26 Oct 2008 00:46:23 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 26 Oct 2008 00:46:21 -0400
Content-Disposition: inline
In-Reply-To: <20081026043802.GA14530@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99146>

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
Same as before.

 diff.c                   |    2 ++
 t/t4030-diff-textconv.sh |    2 +-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index 608223a..23d454e 100644
--- a/diff.c
+++ b/diff.c
@@ -1311,6 +1311,8 @@ static const char *get_textconv(struct diff_filespec *one)
 {
 	if (!DIFF_FILE_VALID(one))
 		return NULL;
+	if (!S_ISREG(one->mode))
+		return NULL;
 	diff_filespec_load_driver(one);
 	return one->driver->textconv;
 }
diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
index 1df48ae..3945731 100755
--- a/t/t4030-diff-textconv.sh
+++ b/t/t4030-diff-textconv.sh
@@ -104,7 +104,7 @@ index ad8b3d2..67be421
 \ No newline at end of file
 EOF
 # make a symlink the hard way that works on symlink-challenged file systems
-test_expect_failure 'textconv does not act on symlinks' '
+test_expect_success 'textconv does not act on symlinks' '
 	echo -n frotz > file &&
 	git add file &&
 	git ls-files -s | sed -e s/100644/120000/ |
-- 
1.6.0.3.524.ge8b2e.dirty
