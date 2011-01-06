From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Resumable clone/Gittorrent (again)
Date: Thu, 6 Jan 2011 08:32:12 +0700
Message-ID: <AANLkTi=_R53fm5Er0CdtZCFvDpE-Dqt8tMHAubcjOUBb@mail.gmail.com>
References: <AANLkTinUV9Z_w85Gz13J+bm8xqnxJ9jBJXJm9bn5Y2ec@mail.gmail.com> <loom.20110105T222915-261@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Maaartin <grajcar1@seznam.cz>
X-From: git-owner@vger.kernel.org Thu Jan 06 02:32:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Paeii-0005Yr-3u
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 02:32:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421Ab1AFBco (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 20:32:44 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46493 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753231Ab1AFBcn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 20:32:43 -0500
Received: by wyb28 with SMTP id 28so15958569wyb.19
        for <git@vger.kernel.org>; Wed, 05 Jan 2011 17:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=PLrRbIc2sA0JUjgoryIGHbJ1xXgQ9C73E08AONAJONM=;
        b=Fb8fVDlwQ6z7ugvYNUZvJpwGdYDpE5tAtKSHkw2NuXnmuO/PpgGPI+rY3dqMx3NHUM
         j1FNngEB98Ggp7laLVcJbhtSdiDgjtasUZm6wDDKerKvDJXSRacQmkS2ivMJt+zjX4SR
         4+jUB/4h1xgM7uq1r3ZKHFUyrU57Yrk7+OsFk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=B3znAv+HZi+lrZEfNQwIc3j5Dqe9Is3oBZlgsmN20zZgNhTg0eDQzuxW4UclZLkaKp
         GaHVrrC/zGb5pLf9U49nQUa2GrmRyi1ObhSQSb3o2FmAlT72T7JUSQe9GIyIRhaiFLNf
         Q1BqFduDNjcn+O4rB+an1EEbeXpJTt+YV/fro=
Received: by 10.216.24.134 with SMTP id x6mr134452wex.34.1294277562524; Wed,
 05 Jan 2011 17:32:42 -0800 (PST)
Received: by 10.216.63.14 with HTTP; Wed, 5 Jan 2011 17:32:12 -0800 (PST)
In-Reply-To: <loom.20110105T222915-261@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164618>

On Thu, Jan 6, 2011 at 6:28 AM, Maaartin <grajcar1@seznam.cz> wrote:
> Nguyen Thai Ngoc Duy <pclouds <at> gmail.com> writes:
>
>> I've been analyzing bittorrent protocol and come up with this. The
>> last idea about a similar thing [1], gittorrent, was given by Nicolas.
>> This keeps close to that idea (i.e the transfer protocol must be around git
>> objects, not file chunks) with a bit difference.
>>
>> The idea is to transfer a chain of objects (trees or blobs), including
>> base object and delta chain. Objects are chained in according to
>> worktree layout, e.g. all objects of path/to/any/blob will form a
>> chain, from a commit tip down to the root commits. Chains can have
>> gaps, and don't need to start from commit tip. The transfer is
>> resumable because if a delta chain is corrupt at some point, we can
>> just request another chain from where it stops. Base object is
>> obviously resumable.
>
> I may be talking nonsense, please bare with me.
>
> I'm not sure if it works well, since chains defined this way change over time.
> I may request commits A and B while declaring to possess commits C and D. One
> server may be ahead of A, so should it send me more data or repack the chain so
> that the non-requested versions get excluded? At the same time the server may
> be missing B and posses only some ancestors of it. Should it send me only a
> part of the chain or should I better ask a different server?

I'll keep it simple. A chain is defined by one commit head. Such a
chain can't change over time. But you can ask for just part of the
chain, rev-list syntax can be used here. For example if you already
have commits C and D and 10 delta in the chain (linear history for
simplicity here), requesting "give me A~10 ^C ^D" should give required
commits.

> Moreover, in case a directory gets renamed, the content may get transfered
> needlessly. This is probably no big problem.

Yes, the chain constraint can backfire in these cases. We can mix
standard upload-pack/fetch-pack and this if the server can recognize
these cases, by cutting commit history into chunks. The dir rename
chunks can be fetched with git-fetch.

> I haven't read the whole other thread yet, but what about going the other way
> round? Use a single commit as a chain, create deltas assuming that all
> ancestors are already available. The packs may arrive out of order, so the
> decompression may have to wait. The number of commits may be one order of
> magnitude larger than the the number of paths (there are currently 2254 paths
> and 24235 commits in git.git), so grouping consequent commits into one larger
> pack may be useful.

The number of commits can increase fast. I'd rather have a
small/stable number over time. And commits depend on other commits so
you can't verify a commit until you have got all of its parents. That
does apply to file, but then this file chain does not interfere other
file chains.

> The advantage is that the packs stays stable over time, you may create them
> using the most aggressive and time-consuming settings and store them forever.
> You could create packs for single commits, packs for non-overlapping
> consecutive pairs of them, for non-overlapping pairs of pairs, etc. I mean with
> commits numbered 0, 1, 2, ... create packs [0,1], [2,3], ..., [0,3], [4,7],
> etc. The reason for this is obviously to allow reading groups of commits from
> different servers so that they fit together (similar to Buddy memory
> allocation). Of course, there are things like branches bringing chaos in this
> simple scheme, but I'm sure this can be solved somehow.

Pack encoding can change. And packs can contain objects you don't want
to share (i.e. hidden from public view).

> Another problem is the client requesting commits A and B while declaring to
> possess commits C and D. When both C and D are ancestors of either A or B, you
> can ignore it (as you assume this while packing, anyway). The other case is
> less probable, unless e.g. C is the master and A is a developing branch.
> Currently. I've no idea how to optimize this and whether this could be
> important.

As I said, we can request just part of a chain (from A+B to C+D).
git-fetch should be used if the repo is quite uptodate though. It's
just more efficient.
-- 
Duy
