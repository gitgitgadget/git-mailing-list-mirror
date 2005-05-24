From: David Mansfield <david@cobite.com>
Subject: Re: gitweb wishlist
Date: Tue, 24 May 2005 15:54:52 -0400
Message-ID: <4293868C.2080203@cobite.com>
References: <20050511012626.GL26384@pasky.ji.cz>  <1116384951.5094.83.camel@dhcp-188.off.vrfy.org>  <Pine.LNX.4.58.0505200948150.2206@ppc970.osdl.org>  <1116611932.12975.22.camel@dhcp-188>  <Pine.LNX.4.58.0505201111090.2206@ppc970.osdl.org>  <Pine.LNX.4.58.0505201123550.2206@ppc970.osdl.org>  <1116615600.12975.33.camel@dhcp-188>  <Pine.LNX.4.58.0505201219420.2206@ppc970.osdl.org> <428E49DD.406@zytor.com>  <Pine.LNX.4.58.0505201346330.2206@ppc970.osdl.org>  <428E4D8C.3020606@zytor.com> <1116626652.12975.118.camel@dhcp-188> <Pine.LNX.4.58.0505201604460.2206@ppc970.osdl.org> <428E745C.30304@zytor.com> <Pine.LNX.4.58.0505201702170.2206@ppc970.osdl.org> <4292A08A.5050108@cobite.com> <Pine.LNX.4.58.0505232048190.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505240110580.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505240849050.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505240911050.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Kay Sievers <kay.sievers@vrfy.org>, Petr Baudis <pasky@ucw.cz>,
	Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 21:55:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DafT3-0004o9-UA
	for gcvg-git@gmane.org; Tue, 24 May 2005 21:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbVEXTy6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 15:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbVEXTy6
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 15:54:58 -0400
Received: from iris.cobite.com ([208.222.83.2]:32898 "EHLO
	email-pri.cobite.com") by vger.kernel.org with ESMTP
	id S261974AbVEXTyy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2005 15:54:54 -0400
Received: from localhost (iris.cobite.com [127.0.0.1])
	by email-pri.cobite.com (Postfix) with ESMTP
	id C1461984F7; Tue, 24 May 2005 15:54:46 -0400 (EDT)
Received: from email-pri.cobite.com ([127.0.0.1])
 by localhost (iris.cobite.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 11741-06; Tue, 24 May 2005 15:54:46 -0400 (EDT)
Received: by email-pri.cobite.com (Postfix, from userid 45000)
	id 7A0A898502; Tue, 24 May 2005 15:54:46 -0400 (EDT)
Received: from [208.222.80.105] (gandalf.cobite.com [208.222.80.105])
	by email-pri.cobite.com (Postfix) with ESMTP
	id 36B6B984F7; Tue, 24 May 2005 15:54:46 -0400 (EDT)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505240911050.2307@ppc970.osdl.org>
X-Virus-Scanned: by amavisd-new at cobite.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 24 May 2005, Linus Torvalds wrote:
> 
>>Fixing the branch handling shows that cvsps does some really strange
>>things with the newly added "Ancestor grpah". Here's one example:
> 
> 
> Ahh, looking at cvsps source, I think I see what's going on. 
> 
> It's deciding the "previous branch" by looking at what the previous branch 
> for the first individual file in the PatchSet was, which fails because in 
> this case, PatchSet 372 was changing "syslinux.doc", and Patchset 374 was 
> changing "syslinux.c", and thus the previous version of the individual 
> _files_ were both in the HEAD branch.
> 
> So it does look like I should just ignore the "Ancestor branch" 
> information if the new branch already existed.
> 

I now consider all files in a commit, and all commits in a branch to 
determine the ancestor, and only report it in the first commit on the 
branch.

Strangely, you have to look at (potentially) all commits on a branch to 
find the 'true' ancestor branch.

The problem is for branch-off-branch branches where the first commit on 
the new branch modifies only files never modified on the branch-off-HEAD 
branch.  This is because cvs only REALLY creates the branch when the 
first commit is made (for that file) on the branch.  Before that, it is 
just a 'potential' branch...

But I have code now which (seems to) works, but needs a bit more checking.

> Of course, some semantics will never be translatable when trying to treat 
> CVS as a sane system (ie treating CVS as if it was changeset-based is 
> always going to cause strange corner cases since it really is file-based), 
> but that should most likely give the best approximation of what a 
> conversion should do.
> 

Yes.

David

