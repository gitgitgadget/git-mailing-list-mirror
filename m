From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Thu, 1 Feb 2007 00:58:42 +0100
Message-ID: <200702010058.43431.jnareb@gmail.com>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com> <eppshi$1l4$1@sea.gmane.org> <20070131222507.GO10108@waste.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: mercurial@selenic.com, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Matt Mackall <mpm@selenic.com>
X-From: git-owner@vger.kernel.org Thu Feb 01 00:57:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCPKk-0002EI-7W
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 00:57:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933361AbXAaX5a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 18:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933363AbXAaX5a
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 18:57:30 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:41596 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933361AbXAaX51 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 18:57:27 -0500
Received: by ug-out-1314.google.com with SMTP id 44so324595uga
        for <git@vger.kernel.org>; Wed, 31 Jan 2007 15:57:24 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=kvixLPL97zybR46HnZ7qXokzsF2y3pDIii2cT3kuqJI03g7AnOSYiwoipL6z1CutM7NT9mukobn8lFZEIYuKPYyPYIwyJhwUt+GeWhYp2OO7mdxHuyuLREHuN+e1c+wEnq9AMMU9AqOhH5TrIbdqj1MIc5mhwumHZqGinwU/1Go=
Received: by 10.66.232.11 with SMTP id e11mr1811483ugh.1170287844476;
        Wed, 31 Jan 2007 15:57:24 -0800 (PST)
Received: from host-81-190-29-4.torun.mm.pl ( [81.190.29.4])
        by mx.google.com with ESMTP id k28sm2139680ugd.2007.01.31.15.57.23;
        Wed, 31 Jan 2007 15:57:24 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20070131222507.GO10108@waste.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38311>

Matt Mackall wrote:
> On Wed, Jan 31, 2007 at 11:56:01AM +0100, Jakub Narebski wrote:
>> Theodore Tso wrote:
>> 
>>> On Tue, Jan 30, 2007 at 11:55:48AM -0500, Shawn O. Pearce wrote:
>>>> I think hg modifies files as it goes, which could cause some issues
>>>> when a writer is aborted.  I'm sure they have thought about the
>>>> problem and tried to make it safe, but there isn't anything safer
>>>> than just leaving the damn thing alone.  :)
>>> 
>>> To be fair hg modifies files using O_APPEND only.  That isn't quite
>>> as safe as "only creating new files", but it is relatively safe.
>> 
>>>From (libc.info):
>> 
>>  -- Macro: int O_APPEND
[...] 
>> I don't quote understand how that would help hg (Mercurial) to have
>> operations like commit, pull/fetch or push atomic, i.e. all or
>> nothing. 
> 
> That's because it's unrelated.
[...]
> Mercurial has write-side locks so there can only ever be one writer at
> a time. There are no locks needed on the read side, so there can be
> any number of readers, even while commits are happening.
> 
>> What happens if operation is interrupted (e.g. lost connection to
>> network during fetch)?
> 
> We keep a simple transaction journal. As Mercurial revlogs are
> append-only, rolling back a transaction just means truncating all
> files in a transaction to their original length.

Thanks a lot for complete answer. So Mercurial uses write-side locks
for dealing with concurrent operations, and transaction journal for
dealing with interrupted operations. I guess that incomplete transactions
are rolled back on next hg command...

I guess (please correct me if I'm wrong) that git uses "put reference
after putting data" scheme, and write-side lock in few places when it
is needed.
 
>> In git both situations result in some prune-able and fsck-visible crud in
>> repository, but repository stays uncorrupted, and all operations are atomic
>> (all or nothing).
> 
> If a Mercurial transaction is interrupted and not rolled back, the
> result is prune-able and fsck-visible crud. But this doesn't happen
> much in practice.
> 
> The claim that's been made is that a) truncate is unsafe because Linux
> has historically had problems in this area and b) git is safer because
> it doesn't do this sort of thing. 
> 
> My response is a) those problems are overstated and Linux has never
> had difficulty with the sorts of straightforward single writer
> operations Mercurial uses and b) normal git usage involves regular
> rewrites of data with packing operations that makes its exposure to
> filesystem bugs equivalent or greater.

Rewrites in git perhaps are (or should be) regular, but need not be often.
And with new idea/feature of kept packs rewrite need not be of full data.

One command which _is_ (a bit) unsafe in git is git-prune. I'm not sure
if it could be made safe. But not doing prune affects only a bit
repository size (where git is best I think of all SCMs) and not performance.

On the other hand hg repository structure (namely log like append changelog
/ revlog to store commits) makes it I think hard to have multiple persistent
branches.

Sidenote 1: it looks like git is optimized for speed of merge and checkout
(branch switching, or going to given point in history for bisect), and
probably accidentally for multi-branch repos, while Mercurial is optimized
for speed of commit and patch.

Sidenote 2: Mercurial repository structure might make it use "file-ids"
(perhaps implicitely), with all the disadvantages (different renames
on different branches) of those.

> In either case, both provide strong integrity checks with recursive
> SHA1 hashing, zlib CRCs, and GPG signatures (as well as distributed
> "back-up"!) so this is largely a non-issue relative to traditional
> systems.

Integrity checks can tell you that repository is corrupted, but it would
be better if it didn't get corrupted in first place.

Besides: zlib CRC for Mercurial? I thought that hg didn't compress the
data, only delta chain store it?
-- 
Jakub Narebski
Poland
