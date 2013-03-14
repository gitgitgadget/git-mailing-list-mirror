From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] t2200: check that "add -u" limits itself to
 subdirectory
Date: Thu, 14 Mar 2013 02:44:04 -0400
Message-ID: <20130314064404.GA6103@sigill.intra.peff.net>
References: <20130313040845.GA5057@sigill.intra.peff.net>
 <20130313041022.GA5378@sigill.intra.peff.net>
 <7vli9r2o06.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 14 07:44:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UG1ty-0001Gz-UG
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 07:44:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754249Ab3CNGoI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 02:44:08 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51427 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752601Ab3CNGoH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 02:44:07 -0400
Received: (qmail 12352 invoked by uid 107); 14 Mar 2013 06:45:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Mar 2013 02:45:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Mar 2013 02:44:04 -0400
Content-Disposition: inline
In-Reply-To: <7vli9r2o06.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218119>

On Wed, Mar 13, 2013 at 10:44:25AM -0700, Junio C Hamano wrote:

> > +# Note that this is scheduled to change in Git 2.0, when
> > +# "git add -u" will become full-tree by default.
> > +test_expect_success 'update did not touch files at root' '
> > +	cat >expect <<-\EOF &&
> > +	check
> > +	top
> > +	EOF
> > +	git diff-files --name-only >actual &&
> > +	test_cmp expect actual
> > +'
> 
> The last "git add -u" we have beforet his block is this test piece:
> 
>  test_expect_success 'update from a subdirectory' '
>         (
>                 cd dir1 &&
>                 echo more >sub2 &&
>                 git add -u sub2
>         )
>  '
> 
> That is not "git add -u" without pathspec, which is the only thing
> we are transitioning at Git 2.0 boundary.

Oops, you're right. I just saw the "cd" and totally missed the pathspec.
The correct test should be:

-- >8 --
Subject: [PATCH] t2200: check that "add -u" limits itself to subdirectory

This behavior is due to change in the future, but let's test
it anyway. That helps make sure we do not accidentally
switch the behavior too soon while we are working in the
area, and it means that we can easily verify the change when
we do make it.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t2200-add-update.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index 4cdebda..c317254 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -80,6 +80,22 @@ test_expect_success 'change gets noticed' '
 
 '
 
+# Note that this is scheduled to change in Git 2.0, when
+# "git add -u" will become full-tree by default.
+test_expect_success 'non-limited update in subdir leaves root alone' '
+	(
+		cd dir1 &&
+		echo even more >>sub2 &&
+		git add -u
+	) &&
+	cat >expect <<-\EOF &&
+	check
+	top
+	EOF
+	git diff-files --name-only >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success SYMLINKS 'replace a file with a symlink' '
 
 	rm foo &&
-- 
1.8.2.rc2.7.gef06216
