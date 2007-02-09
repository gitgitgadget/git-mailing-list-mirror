From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-pull and tag objects
Date: Fri, 09 Feb 2007 15:19:50 -0800
Message-ID: <7v4ppurka1.fsf@assigned-by-dhcp.cox.net>
References: <1170933407.15431.38.camel@okra.transitives.com>
	<81b0412b0702090133qa4eb0c0v6a2d309fe9653a3f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Alex Bennee" <kernel-hacker@bennee.com>, git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 10 00:20:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFf2J-0006Gv-It
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 00:20:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547AbXBIXTx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Feb 2007 18:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752518AbXBIXTx
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 18:19:53 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:51342 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547AbXBIXTw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Feb 2007 18:19:52 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070209231951.WZXZ21704.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Fri, 9 Feb 2007 18:19:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id MbKq1W00a1kojtg0000000; Fri, 09 Feb 2007 18:19:51 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39200>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> You have to use "git pull ../baseline master:somewhere".
> This "master:somewhere" expression makes git fetch and stores
> the tags along with the branch' commits. Better yet, create an
> entry in remotes: .git/remotes or .git/config, depending on the version
> of git you have. The current master on kernel.org has the support
> for latter (branches in .git/config), which will also be in the upcoming
> release 1.5.

While this is technically correct, the automatic tag following
performed by git-fetch (git-pull invokes git-fetch internally
and it is done as the side effect) probably needs a bit more
detailed explanation.

Automatic tag following is done by first fetching from the
remote using the given <refspec>s, and if the repository has
objects that are pointed by remote tags that it does not yet
have, then fetch those missing tags.  If the other end has tags
that point at branches you are not interested in, you will not
get them.

There are currently two ways for you to get tags and one and
half ways to decline.

 * "git fetch --tags URL <refspec>..." will download all tags.
   This has nothing to do with the automatic following.

 * "git fetch URL <refspec>..." (including the case where
   <refspec>s are taken from the configuration files) will
   trigger automatic tag following only when <refspec>s store
   the fetch result in tracking branches (this is what raa
   pointed out)

 * "git fetch --no-tags URL <refspec>..." forbids automatic tag
   following, even when <refspec>s are the tracking kind.

The other half way to decline that is implicit in the above is
to use <refspec>s that do not store the result in tracking
branches.

Now, the --no-tags option means "Do not automatically follow
tags".  But the --tags option does not mean the opposite.  It
means "Do fetch _all_ tags".  We do not have an explicit option
that says "Do follow tags".  It is implicitly decided based on
the kind of <refspec>.

This is not a problem in practice and is a good heuristics that
does the right thing for both people near the toplevel and
people who only follow others trees.

If you are following somebody else's tree, you are most likely
using tracking branches (refs/heads/origin in traditional
layout, or refs/remotes/origin/master in the separate-remote
layout).  You usually want the tags from the other end.

On the other hand, if you are fetching because you would want a
one-shot merge from somebody else, you typically do not want to
get tags from there.  This happens more often for people near
the toplevel but not limited to them.  Mere mortals when pulling
from each other do not necessarily want to automatically get
private 'anchor point' tags from the other person.

You would notice "please pull" messages on the mailing list says
repo URL and branch name alone.  This is designed to be easily
cut&pasted to "git fetch" command line:

	Linus, please pull from

        	git://git..../proj.git master

	to get the following updates...

becomes:

        $ git pull git://git..../proj.git master

In such a case, you do not want to automatically follow other's
tags.

One important aspect of git is it is distributed, and being
distributed largely means there is no inherent "upstream" or
"downstream" in the system.  On the face of it, the above
example might seem to indicate that the tag namespace is owned
by upper echelon of people and tags only flow downwards, but
that is not the case.  It only shows that the usage pattern
determines who are interested in whose tags.

A one-shot pull is a sign that a commit history is now crossing
the boundary between one circle of people (e.g. "people who are
primarily interested in networking part of the kernel") who may
have their own set of tags (e.g. "this is the third release
candidate from the networking group to be proposed for general
consumption with 2.6.21 release") to another circle of people
(e.g. "people who integrate various subsystem improvements").
The latter are usually not interested in the detailed tags used
internally in the former group (that is what "internal" means).
That is why it is desirable not to follow tags automatically in
this case.

It may well be that among networking people, they may want to
exchange the tags internal to their group, but in that workflow
they are most likely tracking with each other's progress by
having tracking branches.  Again, the existing heuristic would
automatically follow such tags and that is a good thing.

Although I do not think it is necessary for the above reasons,
if somebody wanted to do it, it is easy and straightforward to
make the automated tag following more orthogonal by letting you
pass --do-follow-tags to "git fetch" to explicitly tell it to
follow tags even when you are not tracking the other side.

--
diff --git a/git-fetch.sh b/git-fetch.sh
index 357cac2..aef2159 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -17,6 +17,7 @@ IFS="$LF"
 
 no_tags=
 tags=
+follow_tags=
 append=
 force=
 verbose=
@@ -46,6 +47,9 @@ do
 	-t|--t|--ta|--tag|--tags)
 		tags=t
 		;;
+	--fol|--foll|--follo|--follow)
+		follow_tags=t
+		;;
 	-n|--n|--no|--no-|--no-t|--no-ta|--no-tag|--no-tags)
 		no_tags=t
 		;;
@@ -454,12 +458,11 @@ fetch_main () {
 fetch_main "$reflist" || exit
 
 # automated tag following
-case "$no_tags$tags" in
-'')
-	case "$reflist" in
-	*:refs/*)
-		# effective only when we are following remote branch
-		# using local tracking branch.
+if test -z "$no_tags$tags" && {
+	test -n "$follow_tags" ||
+	case "$reflist" in *:refs/*) :;; *) false ;; esac
+   }
+then
 		taglist=$(IFS='	' &&
 		echo "$ls_remote_result" |
 		git-show-ref --exclude-existing=refs/tags/ |
@@ -469,7 +472,6 @@ case "$no_tags$tags" in
 			echo >&2 "Auto-following $name"
 			echo ".${name}:${name}"
 		done)
-	esac
 	case "$taglist" in
 	'') ;;
 	?*)
@@ -477,7 +479,7 @@ case "$no_tags$tags" in
 		shallow_depth=
 		fetch_main "$taglist" || exit ;;
 	esac
-esac
+fi
 
 # If the original head was empty (i.e. no "master" yet), or
 # if we were told not to worry, we do not have to check.
