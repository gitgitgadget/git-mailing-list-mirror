From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Thu, 19 Jul 2007 11:54:19 +0200
Message-ID: <86k5swen1w.fsf@lola.quinscape.zz>
References: <85lkdezi08.fsf@lola.goethe.zz> <Pine.LNX.4.64.0707180135200.14781@racer.site> <858x9ez1li.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org> <vpq4pk1vf7q.fsf@bauges.imag.fr>  =?ISO-8859-1?Q?=20<?=
	=?ISO-8859-1?Q?alpine.LFD.0.999?= =?ISO-8859-1?Q?.0707181004330.=04?=
	=?ISO-8859-1?Q?27353@woody.linu?= =?ISO-8859-1?Q?x-foundation.org?=
	=?ISO-8859-1?Q?>?= <85644hxujp.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org> <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org> <85abttwa7m.fsf@lola.goethe.zz>  =?ISO-8859-1?Q?=20<?=
	=?ISO-8859-1?Q?alpine.LFD.0.999?= =?ISO-8859-1?Q?.070718=041710271.?=
	=?ISO-8859-1?Q?27353@woody.linu?= =?ISO-8859-1?Q?x-foundation.org?=
	=?ISO-8859-1?Q?>?= <7vbqe93qtv.fsf@assigned-by-dhcp.cox.net> <85zm1tue6a.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 11:54:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBSiU-0001h2-Ba
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 11:54:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbXGSJyf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 05:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbXGSJyf
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 05:54:35 -0400
Received: from main.gmane.org ([80.91.229.2]:55217 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750781AbXGSJyd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 05:54:33 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IBSiJ-00051M-4a
	for git@vger.kernel.org; Thu, 19 Jul 2007 11:54:27 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Jul 2007 11:54:27 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Jul 2007 11:54:27 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:1xpXdrPGJhJGyVsb/CvsocO2xgk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52958>

David Kastrup <dak@gnu.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Another issue I thought about was what you would do in the step
>> 3 in the following:
>>
>>  1. David says "mkdir D; git add D"; you add S_IFDIR entry in
>>     the index at D;
>>
>>  2. David says "date >D/F; git add D/F"; presumably you drop D
>>     from the index (to keep the index more backward compatible)
>>     and add S_IFREG entry at D/F.
>
> I don't think that one should drop D here.  Operation 1 _is_ not
> backward compatible, so if you want to revert it, you should
> explicitly remove D.  And we can't "keep" the index backward
> compatible if it isn't so after step 1.
>
>>  3. David says "git rm D/F".
>>
>> Have we stopped keeping track of the "empty directory" at this
>> point?
>
> The case I am worrying about is rather
>
> mkdir D
> mkdir D/E
> touch D/E/file
> git add D
> [*]
> git rm D/E/file
>
> From a user perspective, E should be registered still.  Compare this
> with
>
> mkdir D
> mkdir D/E
> touch D/E/file
> git add D/E/file
> [*]
> git rm D/E/file

Let's take this through the motions with my last proposal: at the
first [*], the index now contains

D/.        [dir]
D/E/.      [dir]
D/E/file   [file]

After git rm D/E/file, it contains

D/.        [dir]
D/E/.      [dir]

Compared with the second, where we just have in the index

D/E/file   [file]

and it is gone again after the remove.

After commiting in the first case, we have in the repository
D          [tree]
D/.        [dir]
D/E        [tree]
D/E/.      [dir]
D/E/file   [file]

Now we do
git rm D/E, and the index contains

D/E/.      [remove dir]
D/E/file   [remove file]

If we commit now,
D/E        [tree]
becomes empty and is removed.  All that stays is

D          [tree]
D/.        [dir]

So we still have [tree] items only in the repository, not in the
index, and there is no such thing as an empty tree.  But directories
have a presence in index and repository.  They are not containers of
files, that role is retained by trees.  Rather they are siblings of
the files in their associated tree.

As a note aside: if one wanted to track directory permissions, one
would track them in the [dir] entries, not in the [tree] entries.
Trees remain abstract structuring entities in the repository that
don't have an outside representation.  Directories will be
auto-created and deleted as necessary in the work directory to
facilitate having a place for checking tree elements out and in.

This means that
git add D/E/file
would _not_ track permissions of D and E (nor their existence).

However, Linus is right that permissions are something to be discussed
separately.  But separating [tree] and [dir] makes for a plausible and
understandable way of treating them.

-- 
David Kastrup
