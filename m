From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-pull and tag objects
Date: Sat, 10 Feb 2007 21:52:29 -0800
Message-ID: <7vy7n5gs0y.fsf@assigned-by-dhcp.cox.net>
References: <1170933407.15431.38.camel@okra.transitives.com>
	<81b0412b0702090133qa4eb0c0v6a2d309fe9653a3f@mail.gmail.com>
	<7v4ppurka1.fsf@assigned-by-dhcp.cox.net>
	<20070210142322.GB25607@thunk.org>
	<Pine.LNX.4.64.0702100938540.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>, Alex Riesen <raa.lkml@gmail.com>,
	Alex Bennee <kernel-hacker@bennee.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Feb 11 06:52:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HG7dk-0001U1-Ny
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 06:52:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753023AbXBKFwl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 00:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752958AbXBKFwl
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 00:52:41 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:42804 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752976AbXBKFwk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 00:52:40 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070211055241.RGER22948.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sun, 11 Feb 2007 00:52:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id N5sf1W00G1kojtg0000000; Sun, 11 Feb 2007 00:52:40 -0500
In-Reply-To: <Pine.LNX.4.64.0702100938540.8424@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sat, 10 Feb 2007 09:56:25 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39273>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> But if you have pushed things out (or others could just read your 
> repository directly), then others will have already seen the old tag. In 
> that case you can do one of two things:
> ...
>  - The insane thing.
>
>    You really want to call the new version "X" too, _even_though_ others 
>    have already seen the old one. So just use "git tag -f" again, as if 
>    you hadn't already published the old one.
>
>    HOWEVER!
>
>    Git does *not* (and in my very very strong opinion, MUST NOT!) change 
>    tags behind users back. So if somebody already got the old tag, doing a 
>    "git pull" on your tree shouldn't just make them overwrite the old one. 
>
> And I really think that git does the right thing. If somebody got a 
> release tag from you, you cannot just change the tag for them by updating 
> your own one. I think this is a BIG security issue, in that people MUST be 
> able to trust their tag-names. If I got a particular tag, NO WAY IN HELL 
> must git just replace it for me because you happened to have a newer one!
>
> So if you really want to do the insane thing, you need to just fess up to 
> it, and tell people that you messed up.

Confession time.

Although it is correct that the people who already saw the
original tag would not lose the tag object from their repository
when you publish a replacement tag, we have _always_ overwritten
the refs/tags/$tag to point at the new one, effectively losing
the original.

* 0a623e7c (Jul 5, 2005)
In this version "git fetch $repo tag v2.6.13" would have done just

	echo "$head" >"$GIT_DIR/$destination"

without checking if it already existed.

* ae2da406 (Aug 22, 2005)

We started checking if the fetched/followed tag already existed
with this version.  However, the result of the check was only
used to say "$tagname: updating with $new_sha1 from $old_sha1"
in the status message.

And after numerous code reorganizations of git-fetch throughout
its life, this logic has never been touched.  This comment
around ll. 170 we currently have:

    case "$1" in
    refs/tags/*)
	# Tags need not be pointing at commits so there
	# is no way to guarantee "fast-forward" anyway.

was introduced with 853a3697 (Aug 20, 2005) and stayed there
ever since.

I think it is worth fixing this by tightening the rule as you
described, even with this late in the game for 1.5.0.  The user
either needs to force it, or remove it beforehand.


diff --git a/git-fetch.sh b/git-fetch.sh
index 357cac2..1078016 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -169,14 +169,18 @@ update_local_ref () {
 
     case "$1" in
     refs/tags/*)
-	# Tags need not be pointing at commits so there
-	# is no way to guarantee "fast-forward" anyway.
+	# Tags should never be blindly overwritten without user's
+	# consent.
 	if test -n "$oldshort_"
 	then
 		if now_=$(git show-ref --hash "$1") && test "$now_" = "$2"
 		then
 			[ "$verbose" ] && echo >&2 "* $1: same as $3"
 			[ "$verbose" ] && echo >&2 "  $label_: $newshort_" ||:
+		elif test -z "$force$single_force"
+		then
+			echo >&2 "* $1: refusing to update with $3"
+			false
 		else
 			echo >&2 "* $1: updating with $3"
 			echo >&2 "  $label_: $newshort_"
