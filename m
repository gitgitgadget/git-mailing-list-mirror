From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: Re: Cogito nit: cg-update should default to "origin".
Date: Wed, 27 Apr 2005 23:57:48 -0400
Message-ID: <42705F3C.1000208@dwheeler.com>
References: <20050426214338.32e9ac27.akpm@osdl.org> <20050427235115.GN22956@pasky.ji.cz> <42702F20.3050200@dwheeler.com> <20050428005337.GA3422@pasky.ji.cz>
Reply-To: dwheeler@dwheeler.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 05:50:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR02i-000298-2K
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 05:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbVD1Dzh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 23:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbVD1Dzh
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 23:55:37 -0400
Received: from aibo.runbox.com ([193.71.199.94]:33741 "EHLO cujo.runbox.com")
	by vger.kernel.org with ESMTP id S261893AbVD1DzW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 23:55:22 -0400
Received: from [10.9.9.16] (helo=lassie.runbox.com)
	by greyhound.runbox.com with esmtp (Exim 4.34)
	id 1DR07V-0005MY-Nh; Thu, 28 Apr 2005 05:55:21 +0200
Received: from [70.18.249.32] (helo=[192.168.2.73])
	by lassie.runbox.com with asmtp (uid:258406) (Exim 4.34)
	id 1DR07V-0002wE-5Z; Thu, 28 Apr 2005 05:55:21 +0200
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050428005337.GA3422@pasky.ji.cz>
X-Sender: 258406@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I said:
>>Minor nit on Cogito: I think cg-update should default to "origin",
>>not the head, if you leave it unspecified. ... The origin seems (to me)
>>to be a MUCH more common situation (and thus the better default).

Petr Baudis replied:
> Actually, I wasn't too happy with the current update-to-HEAD special
> case...

Sounds like we're in agreement! Once the special case goes
away, cg-update in both concept & code essentially becomes:
  cg-pull ${1:-origin} && cg-merge
which has the wonderful advantage of being really, really
easy to explain.  ("cg-update ALWAYS pulls, then merges").

 > I think people do this cg-update without arguments so seldom
 > that changing this now shouldn't hurt much, right?

Absolutely!  Indeed, I find myself doing:
  cg-update {wait for something to happen} {oops} cg-update origin

> What about moving this special case
> to something like
> 	cg-restore
> and changing the defaulting of update and pull back to 'origin'?
...
> Another thing is to UI-wise maintain clear difference between cg-cancel
> and cg-restore. Do you think the names are distinctive enough? Any
> better naming ideas?

Good names for these operations seem to be tough to find.
"cg-cancel" seems odd anyway; you'd think you could
"cancel" a commit and then the commit would stop existing
(not true!).

I looked at a thesaurus; other options to cancel & restore
include: revert, recover, retrieve, reclaim, reclaim, undo.
You could even use the names cg-recover-deleted to recover
deleted files (what cg-update does now without parameters),
and use cg-cancel-edits or cg-cancel-changes to make
clearer commands.  But in the end I have a different idea, hold on...

elsewhere Dan Holmsand said:
 >How about making the restore thing a special case of cg-cancel instead?
 >"Restore deleted files", and "restore deleted and modified files and
 >unseek" are similar enough that people will now where to look.
 >Something like "cg-cancel -C" (for careful), that only restores deleted
 >files would do it, I think.

There's a big risk of not including the "-C" and suddenly losing
everthing.  Since there's NO way to recover these files,
a somewhat safer interface would probably be a better idea.
But merging the concepts may make sense if we can find a single
command name that would help people figure this out.

How about "cg-revert" or "cg-restore"?  The word "revert" is even
in the comments for cg-cancel, but now it makes sense to "revert"
or "restore" the existence of a file (whereas it's really odd
to "cancel" a file deletion).

A serious problem with cg-cancel (and previous cg-undo) is
big data loss, no recovery, of your recent work.... if it's
going to have less & more drastic operations, I'd sure hate
for the drastic operation to be the default.  There's also
missing functionality currently: often I want to revert to the
unedited state for just a single file, or just restore a single file.
So, how about this:

cg-revert [FILE...] or
cg-revert [-d|--deleted]|[-a|--all]
   Reverts some/all files back to the HEAD's state, eliminating changes

   If given a list of 1 or more files, this reverts just the named files
   to the HEAD state. If they were deleted, they are restored;
   if they were edited, their edits are PERMANENTLY LOST.
   If they haven't changed, nothing changes and there is no error.

   If given -d or --deleted, it reverts all deleted files.
   If given -a or --all, it reverts all files
   (everything), resuling in loss of all edits and removals.

How's that for a reasonable UI, replacing both cg-cancel
and cg-update's current no-parameter functionality?

--- David A. Wheeler

