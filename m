From: Jeff King <peff@peff.net>
Subject: Re: What can cause empty GIT_AUTHOR_NAME for 'git filter-branch
 --tree-filter' on Solaris?
Date: Wed, 17 Oct 2012 18:09:12 -0400
Message-ID: <20121017220912.GA21742@sigill.intra.peff.net>
References: <1109432467.20121017104729@gmail.com>
 <507E5CE0.10002@viscovery.net>
 <1013956402.20121017125847@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Ilya Basin <basinilya@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 18 00:09:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TObnr-0004L4-Oh
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 00:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930Ab2JQWJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 18:09:17 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56943 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751736Ab2JQWJO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 18:09:14 -0400
Received: (qmail 30513 invoked by uid 107); 17 Oct 2012 22:09:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 17 Oct 2012 18:09:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Oct 2012 18:09:12 -0400
Content-Disposition: inline
In-Reply-To: <1013956402.20121017125847@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207943>

On Wed, Oct 17, 2012 at 12:58:47PM +0400, Ilya Basin wrote:

> JS> Most likely, your sed has problems with a sed script in function
> JS> get_author_ident_from_commit. I tested it like this:
> 
> JS> $ sh -c '. $(git --exec-path)/git-sh-setup;
> JS>                 get_author_ident_from_commit HEAD'
> JS> GIT_AUTHOR_NAME='Johannes Sixt'
> JS> GIT_AUTHOR_EMAIL='j6t@kdbg.org'
> JS> GIT_AUTHOR_DATE='@1350025129 +0200'
> 
> JS> -- Hannes
> 
> Both systems have GNU sed 4.2.1 installed. I wrote a wrapper script wor sed.
> It's output attached.
> The difference is letter case in sed input data:
> Solaris:
>   /^AUTHOR /
> Windows:
>   /^author /

Ah, so it's tr that is the culprit. We've had problems with Solaris tr
before, but usually around NULs or the use of brackets. But according to
40a7ce6 (tr portability fixes, 2008-03-12), filter-branch is already
doing it the portable way.

If you apply this patch, does your filter-branch work?

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 178e453..58b1d69 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -68,8 +68,8 @@ set_ident () {
 # "author" or "committer
 
 set_ident () {
-	lid="$(echo "$1" | tr "[A-Z]" "[a-z]")"
-	uid="$(echo "$1" | tr "[a-z]" "[A-Z]")"
+	lid="$(echo "$1" | tr ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz)"
+	uid="$(echo "$1" | tr abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ)"
 	pick_id_script='
 		/^'$lid' /{
 			s/'\''/'\''\\'\'\''/g

That seems like crazy overkill, but it at least will let us double-check
that the tr sequences are the problem.

-Peff
