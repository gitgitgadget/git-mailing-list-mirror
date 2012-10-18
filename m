From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] filter-branch: use git-sh-setup's ident parsing
 functions
Date: Thu, 18 Oct 2012 06:26:27 -0400
Message-ID: <20121018102627.GA17543@sigill.intra.peff.net>
References: <20121018072207.GA1605@sigill.intra.peff.net>
 <20121018072535.GB9999@sigill.intra.peff.net>
 <507FB470.2060404@viscovery.net>
 <20121018075429.GD9999@sigill.intra.peff.net>
 <20121018102217.GA17332@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ilya Basin <basinilya@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Oct 18 12:26:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOnJK-0002qI-5V
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 12:26:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754978Ab2JRK0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 06:26:30 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37708 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754194Ab2JRK0a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 06:26:30 -0400
Received: (qmail 4686 invoked by uid 107); 18 Oct 2012 10:27:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 18 Oct 2012 06:27:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2012 06:26:27 -0400
Content-Disposition: inline
In-Reply-To: <20121018102217.GA17332@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207993>

On Thu, Oct 18, 2012 at 06:22:17AM -0400, Jeff King wrote:

> Hrm. We _do_ test this in t7003. Weirder, if I instrument filter-branch
> like this:
> [...]
> and run t7003, it shows that the variable is properly exported to the
> sub-process! But I can't seem to figure out why. Confused...

Oh, I see. The variables are already exported by test-lib.sh. You can
see the breakage with:

diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 4d13e10..1e7a209 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -167,10 +167,11 @@ test_expect_success 'author information is preserved' '
 	test_tick &&
 	GIT_AUTHOR_NAME="B V Uips" git commit -m bvuips &&
 	git branch preserved-author &&
-	git filter-branch -f --msg-filter "cat; \
+	(sane_unset GIT_AUTHOR_NAME &&
+	 git filter-branch -f --msg-filter "cat; \
 			test \$GIT_COMMIT != $(git rev-parse master) || \
 			echo Hallo" \
-		preserved-author &&
+		preserved-author) &&
 	test 1 = $(git rev-list --author="B V Uips" preserved-author | wc -l)
 '
 

-Peff
