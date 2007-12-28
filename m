From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-pull: warn if only fetching tags with the -t switch
Date: Fri, 28 Dec 2007 13:58:43 -0800
Message-ID: <7v63yieb1o.fsf@gitster.siamese.dyndns.org>
References: <20071221124400.20725.qmail@db93e79e204cd8.315fe32.mid.smarden.org>
	<7v8x3oatvi.fsf@gitster.siamese.dyndns.org>
	<20071227093016.18337.qmail@e6d9fb481b7087.315fe32.mid.smarden.org>
	<7vwsr0ifqi.fsf@gitster.siamese.dyndns.org>
	<20071227144618.32373.qmail@5b51609f839e87.315fe32.mid.smarden.org>
	<7vve6je349.fsf@gitster.siamese.dyndns.org>
	<alpine.LNX.1.00.0712281141450.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gerrit Pape <pape@smarden.org>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Dec 28 22:59:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8NEb-0004ZR-DH
	for gcvg-git-2@gmane.org; Fri, 28 Dec 2007 22:59:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752415AbXL1V6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2007 16:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752435AbXL1V6w
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Dec 2007 16:58:52 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47655 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415AbXL1V6v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2007 16:58:51 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F89122CC;
	Fri, 28 Dec 2007 16:58:50 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A85922CA;
	Fri, 28 Dec 2007 16:58:45 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0712281141450.13593@iabervon.org> (Daniel
	Barkalow's message of "Fri, 28 Dec 2007 12:32:43 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69298>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On the other hand, the command that's difficult with (1) is "get all of 
> the latest tags, but not even the default other refs", and I don't think 
> that's something that people actually want to do in general, so it should 
> be fine to go with (1).

I agree.  "Behave as if no --tags was given (so an explicit
refspec on the command line overrides configured ones, or no
explicit refspecs on the command line takes configured ones),
but do not auto-follow tags and fetch all tags as not-for-merge
entries" would be the most sensible semantics for the option, as
you say.

>> This is a bit more involved change than I would want to have
>> during -rc freeze.
>
> Certainly. I think, though, that the OP's patch, plus a check that --tags 
> was given on the command line in the first place, would be worthwhile.

Sounds sensible.

---
 git-pull.sh |   66 +++++++++++++++++++++++++++++++++++-----------------------
 1 files changed, 40 insertions(+), 26 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 698e82b..fa97b0f 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -72,6 +72,40 @@ do
 	shift
 done
 
+error_on_no_merge_candidates () {
+	exec >&2
+	for opt
+	do
+		case "$opt" in
+		-t|--t|--ta|--tag|--tags)
+			echo "Fetching tags only, you probably meant:"
+			echo "  git fetch --tags"
+			exit 1
+		esac
+	done
+
+	curr_branch=${curr_branch#refs/heads/}
+
+	echo "You asked me to pull without telling me which branch you"
+	echo "want to merge with, and 'branch.${curr_branch}.merge' in"
+	echo "your configuration file does not tell me either.  Please"
+	echo "name which branch you want to merge on the command line and"
+	echo "try again (e.g. 'git pull <repository> <refspec>')."
+	echo "See git-pull(1) for details on the refspec."
+	echo
+	echo "If you often merge with the same branch, you may want to"
+	echo "configure the following variables in your configuration"
+	echo "file:"
+	echo
+	echo "    branch.${curr_branch}.remote = <nickname>"
+	echo "    branch.${curr_branch}.merge = <remote-ref>"
+	echo "    remote.<nickname>.url = <url>"
+	echo "    remote.<nickname>.fetch = <refspec>"
+	echo
+	echo "See git-config(1) for details."
+	exit 1
+}
+
 orig_head=$(git rev-parse --verify HEAD 2>/dev/null)
 git-fetch --update-head-ok "$@" || exit 1
 
@@ -105,33 +139,13 @@ merge_head=$(sed -e '/	not-for-merge	/d' \
 case "$merge_head" in
 '')
 	case $? in
-	  0) ;;
-	  1) echo >&2 "You are not currently on a branch; you must explicitly"
-	     echo >&2 "specify which branch you wish to merge:"
-	     echo >&2 "  git pull <remote> <branch>"
-	     exit 1;;
-	  *) exit $?;;
+	0) error_on_no_merge_candidates "$@";;
+	1) echo >&2 "You are not currently on a branch; you must explicitly"
+	   echo >&2 "specify which branch you wish to merge:"
+	   echo >&2 "  git pull <remote> <branch>"
+	   exit 1;;
+	*) exit $?;;
 	esac
-	curr_branch=${curr_branch#refs/heads/}
-
-	echo >&2 "You asked me to pull without telling me which branch you"
-	echo >&2 "want to merge with, and 'branch.${curr_branch}.merge' in"
-	echo >&2 "your configuration file does not tell me either.  Please"
-	echo >&2 "name which branch you want to merge on the command line and"
-	echo >&2 "try again (e.g. 'git pull <repository> <refspec>')."
-	echo >&2 "See git-pull(1) for details on the refspec."
-	echo >&2
-	echo >&2 "If you often merge with the same branch, you may want to"
-	echo >&2 "configure the following variables in your configuration"
-	echo >&2 "file:"
-	echo >&2
-	echo >&2 "    branch.${curr_branch}.remote = <nickname>"
-	echo >&2 "    branch.${curr_branch}.merge = <remote-ref>"
-	echo >&2 "    remote.<nickname>.url = <url>"
-	echo >&2 "    remote.<nickname>.fetch = <refspec>"
-	echo >&2
-	echo >&2 "See git-config(1) for details."
-	exit 1
 	;;
 ?*' '?*)
 	if test -z "$orig_head"
