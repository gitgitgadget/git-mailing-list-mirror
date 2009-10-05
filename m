From: Jeff King <peff@peff.net>
Subject: Re: Confusing git pull error message
Date: Mon, 5 Oct 2009 07:53:08 -0400
Message-ID: <20091005115308.GA2122@coredump.intra.peff.net>
References: <43d8ce650909121301i4450489dhf475ff6894394a5f@mail.gmail.com>
 <20090912211119.GA30966@coredump.intra.peff.net>
 <7v1vmar353.fsf@alter.siamese.dyndns.org>
 <4AC9D952.3050108@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	John Tapsell <johnflux@gmail.com>,
	Git List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Oct 05 13:56:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MumAv-0004tU-Im
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 13:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758774AbZJELxy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 07:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758727AbZJELxy
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 07:53:54 -0400
Received: from peff.net ([208.65.91.99]:47943 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758661AbZJELxx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 07:53:53 -0400
Received: (qmail 17016 invoked by uid 107); 5 Oct 2009 11:56:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 05 Oct 2009 07:56:43 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Oct 2009 07:53:08 -0400
Content-Disposition: inline
In-Reply-To: <4AC9D952.3050108@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129555>

On Mon, Oct 05, 2009 at 01:32:34PM +0200, Johannes Sixt wrote:

> Unfortunately, this is not water-tight. See what I just observed:
> 
>   $ git pull hk
>   From /exports/repos/hk/viscovery
>      9455552..6429037  master     -> hk/master
>   Your configuration specifies to merge the ref
>   'master' from the remote, but no such ref
>   was fetched.
> 
> The message is confusing when it says "'master' was not fetched" when
> clearly master _was_ fetched.
> 
> More importantly, the message is wrong to say that "Your configuration
> specifies to merge the ref 'master' from the remote", because I have this
> configuration:

Ah, yeah. Looking at %(upstream) from for-each-ref (which is how we
determine to show that message) always uses the configured remote. But
if we have asked for another remote, then that doesn't make much sense.

So I think we need something like this. I wasn't able to figure out a
test case to trigger the first code path below, though. It may not be
possible; if we give a refspec on the command line, either it will be a
candidate for merging or, if it does not exist, fetch will barf. So it
may be that we can just collapse it down to a single case.

diff --git a/git-pull.sh b/git-pull.sh
index edf3ce3..a831db5 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -97,6 +97,18 @@ error_on_no_merge_candidates () {
 		echo "Please specify which branch you want to merge on the command"
 		echo "line and try again (e.g. 'git pull <repository> <refspec>')."
 		echo "See git-pull(1) for details."
+	elif [ -n "$1" ]; then
+		if [ $# -gt 1 ]; then
+			echo "You asked to pull from the remote '$1', but none"
+			echo "of the things you asked to fetch were candidates"
+			echo "for merging."
+		else
+			echo "You asked to pull from the remote '$1', but did"
+			echo "not specify a branch to merge. Because this is"
+			echo "not the default configured remote for your current"
+			echo "branch, you must specify a branch on the command"
+			echo "line."
+		fi
 	elif [ -z "$upstream" ]; then
 		echo "You asked me to pull without telling me which branch you"
 		echo "want to merge with, and 'branch.${curr_branch}.merge' in"
