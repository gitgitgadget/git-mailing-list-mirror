From: Maaartin-1 <grajcar1@seznam.cz>
Subject: Re: Resumable clone/Gittorrent (again)
Date: Thu, 06 Jan 2011 04:34:51 +0100
Message-ID: <4D25385B.3010103@seznam.cz>
References: <AANLkTinUV9Z_w85Gz13J+bm8xqnxJ9jBJXJm9bn5Y2ec@mail.gmail.com> <loom.20110105T222915-261@post.gmane.org> <AANLkTi=_R53fm5Er0CdtZCFvDpE-Dqt8tMHAubcjOUBb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 06 04:35:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pagcu-0007tS-I6
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 04:35:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754751Ab1AFDez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 22:34:55 -0500
Received: from smtp.seznam.cz ([77.75.72.43]:53447 "EHLO smtp.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754159Ab1AFDey (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 22:34:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=beta; d=seznam.cz;
	h=X-Seznam-DomainKeys:X-Seznam-SPF:X-Virus-Info:Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Smtpd:X-Seznam-User:X-Session:X-Country:X-QM-Mark;
	b=SqJmEPcNECBfa7wNEJOOYTWi/C5vPB34eH2NzLCn+zONUqF5ojDFwkrRdOtUAypy9
	3zWBzfiaVhOUaW5pPPy1mvLdkvw1zw3EhszSDRlYrBWprimGGhbcuANSKQjG2uM/fLw
	GUKmr0V3z3bob3P5gm0Bh3oW0rw66DdLK+WL9ro=
X-Seznam-DomainKeys: unknown
X-Seznam-SPF: neutral
X-Virus-Info: clean
Received: from [10.0.3.100] (188-120-198-113.luckynet.cz [188.120.198.113])
	by email-relay1.go.seznam.cz (Seznam SMTPD 1.2.14@16206) with ESMTP;
	Thu, 06 Jan 2011 04:34:50 +0100 (CET)  
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.2; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <AANLkTi=_R53fm5Er0CdtZCFvDpE-Dqt8tMHAubcjOUBb@mail.gmail.com>
X-Smtpd: 1.2.14@16206
X-Seznam-User: grajcar1@seznam.cz
X-Session: 3789
X-Country: CZ
X-QM-Mark: email-qm3<453975811>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164621>

On 11-01-06 02:32, Nguyen Thai Ngoc Duy wrote:
> On Thu, Jan 6, 2011 at 6:28 AM, Maaartin <grajcar1@seznam.cz> wrote:
>> Nguyen Thai Ngoc Duy <pclouds <at> gmail.com> writes:

>> I haven't read the whole other thread yet, but what about going the other way
>> round? Use a single commit as a chain, create deltas assuming that all
>> ancestors are already available. The packs may arrive out of order, so the
>> decompression may have to wait. The number of commits may be one order of
>> magnitude larger than the the number of paths (there are currently 2254 paths
>> and 24235 commits in git.git), so grouping consequent commits into one larger
>> pack may be useful.
> 
> The number of commits can increase fast. I'd rather have a
> small/stable number over time.

In theory, I could create many commits per seconds. I could create many
unique paths per seconds, too. But I don't think it really happens. I do
know no larger repository than git.git and I don't want to download it
just to see how many commits, paths, and object it contains, but I'd
suppose it's less than one million commits, which should be manageable,
especially when commits get grouped together as I described below.

> And commits depend on other commits so
> you can't verify a commit until you have got all of its parents. That
> does apply to file, but then this file chain does not interfere other
> file chains.

That's true, but the verification is something done locally on the
client, it consumes no network traffic and no server resources, so I
consider it to be cheap. I need less than half a minute (using only a
single core) for verifying of the whole git.git repository (36 MB). This
is no problem, even when it had to wait until the download finishes. I'm
sure, the OP of [1] would be happy if he could wait for this.

>> The advantage is that the packs stays stable over time, you may create them
>> using the most aggressive and time-consuming settings and store them forever.
>> You could create packs for single commits, packs for non-overlapping
>> consecutive pairs of them, for non-overlapping pairs of pairs, etc. I mean with
>> commits numbered 0, 1, 2, ... create packs [0,1], [2,3], ..., [0,3], [4,7],
>> etc. The reason for this is obviously to allow reading groups of commits from
>> different servers so that they fit together (similar to Buddy memory
>> allocation). Of course, there are things like branches bringing chaos in this
>> simple scheme, but I'm sure this can be solved somehow.
> 
> Pack encoding can change.

I see I didn't explain it clear enough (or am missing something
completely). I know why the packs normally used by git can't be used for
this purpose. Let me retry: Let's assume there's a commit chain
A-B-C-D-E-F-..., the client has already commit B and requests commit F.
It may send requests to up to 4 servers, asking for C, D, E, and F,
respectively. The server being asked for E _creates_ a pack containing
all the information needed to create E given _all of_ A, B, C, D. As
base for any blob/whatever in E it may choose any blob contained in any
of these commits. Of course, it may also choose a blob already packed in
this pack. It may not choose any other blob, so any client having all
ancestors of E can use the pack. Different server and/or program
versions may create different packs for E, but all of them are
_interchangeable_. Because of this, it makes sense to _store_ it for
future reuse.

Compared to the way git packing normally works, this is a restriction,
but I don't think it leads to significantly worse compression. You guys
working on git can confirm or disprove it.

> And packs can contain objects you don't want
> to share (i.e. hidden from public view).

This pack would contain only commit E. I also described pairing intended
for greater efficiency. In this case a server creates a pack allowing
e.g. to create commits E and F given all their ancestors (while other
server creates a pack for C and D). This way the number of packs needed
may be a fraction of the total number of commits requested.

>> Another problem is the client requesting commits A and B while declaring to
>> possess commits C and D. When both C and D are ancestors of either A or B, you
>> can ignore it (as you assume this while packing, anyway). The other case is
>> less probable, unless e.g. C is the master and A is a developing branch.
>> Currently. I've no idea how to optimize this and whether this could be
>> important.
> 
> As I said, we can request just part of a chain (from A+B to C+D).
> git-fetch should be used if the repo is quite uptodate though. It's
> just more efficient.

[1] http://article.gmane.org/gmane.comp.version-control.git/164564
