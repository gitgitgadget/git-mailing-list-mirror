From: David Kastrup <dak@gnu.org>
Subject: Re: possible bug in git apply?
Date: Sun, 05 Aug 2007 19:53:18 +0200
Message-ID: <85hcndj2b5.fsf@lola.goethe.zz>
References: <Pine.LNX.4.64.0708041243070.6905@asgard.lang.hm>
	<alpine.LFD.0.999.0708042141510.5037@woody.linux-foundation.org>
	<7vvebuh8g8.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.999.0708050949220.5037@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, david@lang.hm,
	git@vger.kernel.org, rob@landley.net
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 19:53:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHkIC-0006Dp-B5
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 19:53:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbXHERxY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 13:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751865AbXHERxY
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 13:53:24 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:57332 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751691AbXHERxX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Aug 2007 13:53:23 -0400
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net [151.189.8.13])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 9D5B627F85;
	Sun,  5 Aug 2007 19:53:21 +0200 (CEST)
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net [151.189.21.53])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id 6D50312E01B;
	Sun,  5 Aug 2007 19:53:21 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-057-031.pools.arcor-ip.net [84.61.57.31])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id 2490925D379;
	Sun,  5 Aug 2007 19:53:21 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 531DB1C3D500; Sun,  5 Aug 2007 19:53:19 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.999.0708050949220.5037@woody.linux-foundation.org> (Linus Torvalds's message of "Sun\, 5 Aug 2007 09\:59\:03 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3862/Sun Aug  5 15:38:34 2007 on mail-in-13.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55047>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, 4 Aug 2007, Junio C Hamano wrote:
>> >
>> > Does this fix it? Totally untested, but it _looks_ obvious enough..
>> 
>> That would regress the fix made in aea19457, I am afraid.
>
> The fix in aea19457 is broken anyway.
>
> Why? 
>
> That whole "do it in two phases" thing breaks it.

Did not know that.

> What can happen is that you have a directory with 100 files, and:
>  - a patch modifies 99 of them
>  - and removes one
>
> What happens is that during phase 0, we'll remove all the files (and *not* 
> write new ones), and then beause the last patch entry is a removal, we'll 
> also remove the directory (which succeeds, because all the files that got 
> modified are all long gone).
>
> Then, in phase 1, we'll re-create the files that we modified, and create a 
> whole new directory.
>
> IOW, as far as I can see we _already_ delete and then recreate the 
> directory structure under some circumstances.

Which will let the user sit in an empty directory void of . and ..,
and a parallel directory with the old name elsewhere.  Unpretty...

> I just extended it to also do it for "rename" and not just delete,
> since a rename may be renaming it to another directory.
>
> So I'd say that my patch is a clear improvement on the current
> situation.
>
> That said, if we really wanted to get it right, we should do this as
> a three-phase thing: (1) remove old files (2) create new files (3)
> for all removals and renames, try to remove source directories that
> might have become empty.
>
> That would fix it properly and for all cases.

Stupid question from someone without good background: why do we need
two passes in the first place?  Can't we just do phase 1/2/3 for every
file in one step?  Is there any case where not having done (1) for a
_different_ file is going to cause trouble for (2)?  I presume this is
intended for something like

create a    (plain file, coming in sort order before a/)
delete a/x
delete a/y  (last file in a/)

in the index and frankly, this will cease working in your three-phase
scheme.

The problem is that we really need a -depth sort order for deletion in
the index, meaning that
delete xxx/yyy
sorts before
create xxx*

When we don't change the sorting order, one can do so with recursion:
when finding
create a
we postpone processing it until a prospective
delete a/*
is over.  That means first processing a.txt, a.whatever/ and so on.  I
think that is not sane.

As far as I can see, changing the index sort order for deletions is
probably the sanest _working_ way to go about this.

One problem is that corresponding "delete" and "create" items are then
no longer necessarily adjacent in the index.  The sensible way to go
about this is to sort the requests into _two_ linked lists, one in
"create" order, one in "delete" order, and when merging a "create"
request in the index, one compares with the head of the "create"
ordered list, and when merging a "delete" request in the index, one
compares with the head of the "delete" ordered list.

Is this pretty?  Not at all.  But I don't see that any _fixed_ number
of phases will buy us out of the principal problem, namely that
deletions have to be done depth-first, and deletions of a directory
have to be finished before we can attempt creating a new file in their
place.

Yes, this implies changing the index sort order, unfortunately.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
