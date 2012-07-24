From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] attr: make sure we have an xdg path before using it
Date: Tue, 24 Jul 2012 07:53:57 -0400
Message-ID: <20120724115357.GA7353@sigill.intra.peff.net>
References: <20120724115305.GA7328@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 13:54:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Stdgk-0000Ty-UE
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 13:54:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753482Ab2GXLyB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 07:54:01 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60136 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753468Ab2GXLyA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 07:54:00 -0400
Received: (qmail 15927 invoked by uid 107); 24 Jul 2012 11:54:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 Jul 2012 07:54:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jul 2012 07:53:57 -0400
Content-Disposition: inline
In-Reply-To: <20120724115305.GA7328@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202028>

If we don't have a core.attributesfile configured, we fall
back to checking XDG config. This is usually
$HOME/.config/attributes. However, if $HOME is unset, then
home_config_paths will return NULL, and we end up calling
fopen(NULL).

Depending on your system, this may or may not cause the
accompanying test to fail (e.g., on Linux and glibc, the
address will go straight to open, which will return EFAULT).
However, valgrind will reliably notice the error.

Signed-off-by: Jeff King <peff@peff.net>
---
[oops, resending because I forgot to cc git@vger]

This is another instance of Matthieu's e3ebc35 (config: fix several
access(NULL) calls, 2012-07-12). I guess it wasn't caught
because of the lack of a test without HOME set (I found it
because t5541 can trigger it in a very roundabout way).

 attr.c               | 12 +++++++-----
 t/t1306-xdg-files.sh |  6 ++++++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/attr.c b/attr.c
index aef93d8..b52efb5 100644
--- a/attr.c
+++ b/attr.c
@@ -520,11 +520,13 @@ static void bootstrap_attr_stack(void)
 		home_config_paths(NULL, &xdg_attributes_file, "attributes");
 		git_attributes_file = xdg_attributes_file;
 	}
-	elem = read_attr_from_file(git_attributes_file, 1);
-	if (elem) {
-		elem->origin = NULL;
-		elem->prev = attr_stack;
-		attr_stack = elem;
+	if (git_attributes_file) {
+		elem = read_attr_from_file(git_attributes_file, 1);
+		if (elem) {
+			elem->origin = NULL;
+			elem->prev = attr_stack;
+			attr_stack = elem;
+		}
 	}
 
 	if (!is_bare_repository() || direction == GIT_ATTR_INDEX) {
diff --git a/t/t1306-xdg-files.sh b/t/t1306-xdg-files.sh
index 3c75c3f..1569596 100755
--- a/t/t1306-xdg-files.sh
+++ b/t/t1306-xdg-files.sh
@@ -106,6 +106,12 @@ test_expect_success 'Checking attributes in the XDG attributes file' '
 	test_cmp expected actual
 '
 
+test_expect_success 'Checking XDG attributes when HOME is unset' '
+	>expected &&
+	(sane_unset HOME &&
+	 git check-attr -a f >actual) &&
+	test_cmp expected actual
+'
 
 test_expect_success 'Checking attributes in both XDG and local attributes files' '
 	echo "f -attr_f" >.gitattributes &&
-- 
1.7.11.3.4.g9f70dbb
