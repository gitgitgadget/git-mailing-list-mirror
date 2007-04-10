From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/6] Initial subproject support (RFC?)
Date: Tue, 10 Apr 2007 13:52:46 -0700
Message-ID: <7vk5wkuf35.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
	<Pine.LNX.4.64.0704092133550.6730@woody.linux-foundation.org>
	<81b0412b0704100604x2841d96aq194d3dedd303c588@mail.gmail.com>
	<Pine.LNX.4.64.0704100758430.6730@woody.linux-foundation.org>
	<81b0412b0704100848n69c99f55xa7cc96087cad7e31@mail.gmail.com>
	<Pine.LNX.4.64.0704100852550.6730@woody.linux-foundation.org>
	<7v6484vxd5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0704101302480.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 11 05:17:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbNKx-0006Dv-KN
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 22:53:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030626AbXDJUwt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 16:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030660AbXDJUwt
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 16:52:49 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:36758 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030626AbXDJUws (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 16:52:48 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070410205246.KAMH1218.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Tue, 10 Apr 2007 16:52:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id lYsn1W0061kojtg0000000; Tue, 10 Apr 2007 16:52:47 -0400
In-Reply-To: <Pine.LNX.4.64.0704101302480.6730@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 10 Apr 2007 13:11:55 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44168>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, 10 Apr 2007, Junio C Hamano wrote:
>> 
>> Well, I was planning to apply this directly on 'master' after
>> giving them another pass.
>
> Goodie. I gave them another pass myself, and noticed a small leak and a 
> stupid copy-paste problem, fixed thus..

Yeah, I noticed the first one but not the second.  Thanks.

> diff --git a/read-cache.c b/read-cache.c
> index 8fe94cd..f458f50 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -279,7 +279,7 @@ int base_name_compare(const char *name1, int len1, int mode1,
>  	c2 = name2[len];
>  	if (!c1 && (S_ISDIR(mode1) || S_ISDIRLNK(mode1)))
>  		c1 = '/';
> -	if (!c2 && (S_ISDIR(mode2) || S_ISDIRLNK(mode1)))
> +	if (!c2 && (S_ISDIR(mode2) || S_ISDIRLNK(mode2)))
>  		c2 = '/';
>  	return (c1 < c2) ? -1 : (c1 > c2) ? 1 : 0;
>  }
> diff --git a/refs.c b/refs.c
> index 229da74..11a67a8 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -229,6 +229,7 @@ static int resolve_gitlink_packed_ref(char *name, int pathlen, const char *refna
>  	if (!f)
>  		return -1;
>  	read_packed_refs(f, &refs);
> +	fclose(f);
>  	ref = refs.packed;
>  	retval = -1;
>  	while (ref) {

By the way,...

People occasionally ask "how would I make a small fix to a
commit that is buried in the history", so let me take a moment
to give them a recipe.

Let's say while reviewing the code after applying all of the
6-series, you noticed the above thinko.  First find out which
commit caused it:

$ git checkout lt/gitlink
$ git blame -L229,+7 master.. -- refs.c
b60108a1 (Linus Torvalds 2007-04-09 21:14:26 -0700 229) 	if (!f)
b60108a1 (Linus Torvalds 2007-04-09 21:14:26 -0700 230) 		re..
b60108a1 (Linus Torvalds 2007-04-09 21:14:26 -0700 231) 	read_packe..
b60108a1 (Linus Torvalds 2007-04-09 21:14:26 -0700 232) 	ref = refs..
b60108a1 (Linus Torvalds 2007-04-09 21:14:26 -0700 233) 	retval = -..
b60108a1 (Linus Torvalds 2007-04-09 21:14:26 -0700 234) 	while (ref..
b60108a1 (Linus Torvalds 2007-04-09 21:14:26 -0700 235) 		if..

The commit to fix is b60108a1 (this is what I have in my private
repo, and I'll be rebuilding the series with this example, so
you will never see this commit object name in the end result
I'll be pushing out).  So I detach the HEAD at that commit and
make a fix:

$ git checkout b60108a1
$ edit refs.c
$ git diff; # just to make sure
$ git commit -a --amend

At this point, the detached HEAD and the original branch look
like this:

$ git show-branch lt/gitlink HEAD
! [lt/gitlink] Teach core object handling functions about gitlinks
 * [HEAD] Add 'resolve_gitlink_ref()' helper function
--
 * [HEAD] Add 'resolve_gitlink_ref()' helper function
+  [lt/gitlink] Teach core object handling functions about gitlinks
+  [lt/gitlink^] Teach "fsck" not to follow subproject links
+  [lt/gitlink~2] Add "S_IFDIRLNK" file mode infrastructure for git links
+  [lt/gitlink~3] Add 'resolve_gitlink_ref()' helper function
+* [HEAD^] Avoid overflowing name buffer in deep directory structures

We fixed lt/gitlink~3 and the fixed-up commit is at HEAD.  We
want to rebase the rest of lt/gitlink on top of HEAD, like this:

$ git rebase HEAD lt/gitlink

This will take us back on lt/gitlink branch, set the tip of the
branch to the commit we just made with the fix-up, and the first
round will try to apply the change lt/gitlink~3 brings in on top
of our HEAD.  This _will_ fail, but that is to be expected, as
we intend to replace that with what we just amended.  Just reset
it away and keep going.

$ git reset --hard
$ git rebase --skip

Dealing with the other one in read-cache.c can be handled
similarly after this. Luckily blame finds out that it is the
last in the series (i.e. at the tip of lt/gitlink branch), so
usual "fix the topmost commit" procedure applies.

$ edit read-cache.c
$ git diff ;# checking...
$ git commit -a --amend
