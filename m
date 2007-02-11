From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-pull and tag objects
Date: Sun, 11 Feb 2007 13:41:23 -0800
Message-ID: <7v3b5ce5j0.fsf@assigned-by-dhcp.cox.net>
References: <1170933407.15431.38.camel@okra.transitives.com>
	<81b0412b0702090133qa4eb0c0v6a2d309fe9653a3f@mail.gmail.com>
	<7v4ppurka1.fsf@assigned-by-dhcp.cox.net>
	<20070210142322.GB25607@thunk.org>
	<Pine.LNX.4.64.0702100938540.8424@woody.linux-foundation.org>
	<7vy7n5gs0y.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702110948120.8424@woody.linux-foundation.org>
	<7vire8ec6w.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702111124410.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>, Alex Riesen <raa.lkml@gmail.com>,
	Alex Bennee <kernel-hacker@bennee.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Feb 11 22:41:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGMRr-0005L0-To
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 22:41:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbXBKVlZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 16:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbXBKVlZ
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 16:41:25 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:35497 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908AbXBKVlY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 16:41:24 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070211214124.LKAR1306.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sun, 11 Feb 2007 16:41:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id NMhP1W00S1kojtg0000000; Sun, 11 Feb 2007 16:41:24 -0500
In-Reply-To: <Pine.LNX.4.64.0702111124410.8424@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sun, 11 Feb 2007 11:25:15 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39306>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, 11 Feb 2007, Junio C Hamano wrote:
>> 
>> Well, what you are saying is that it used to be Ok in Jul 5 2005
>> version but with tag following it is not Ok anymore, isn't it?
>
> Do we actually do it with automatic tag following? I tested, and it didn't 
> do anything bad for me.

You are right.

The only iffy case that is remaining is "git fetch --tags $URL".
The user is explicitly saying "I want all tags from there", but
the user may not be expecting tags that are already present in
the local repository to be overwritten.

The filtering on the auto-follow codepath Johannes added with
"git-show-ref --exclude-existing" would fix this case as well.

-- >8 --
[PATCH] "git-fetch --tags $URL" should not overwrite existing tags

Use the same --exclude-existing filter as we use for automatic
tag following to avoid overwriting existing tags with replacement
ones the other side created.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/git-fetch.sh b/git-fetch.sh
index 357cac2..ca984e7 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -253,23 +253,10 @@ if test "$tags"
 then
 	taglist=`IFS='	' &&
 		  echo "$ls_remote_result" |
+		  git-show-ref --exclude-existing=refs/tags/ |
 	          while read sha1 name
 		  do
-			case "$sha1" in
-			fail)
-				exit 1
-			esac
-			case "$name" in
-			*^*) continue ;;
-			refs/tags/*) ;;
-			*) continue ;;
-			esac
-		  	if git-check-ref-format "$name"
-			then
-			    echo ".${name}:${name}"
-			else
-			    echo >&2 "warning: tag ${name} ignored"
-			fi
+			echo ".${name}:${name}"
 		  done` || exit
 	if test "$#" -gt 1
 	then
