From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Resumable clone/Gittorrent (again)
Date: Fri, 7 Jan 2011 13:34:31 +0700
Message-ID: <AANLkTik_Q-W2yjnyB3=NKGQcn-MeFwnPQqnrGgWN_Q7C@mail.gmail.com>
References: <AANLkTinUV9Z_w85Gz13J+bm8xqnxJ9jBJXJm9bn5Y2ec@mail.gmail.com> <alpine.LFD.2.00.1101061956470.22191@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Jan 07 07:35:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pb5v2-00022b-Bw
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 07:35:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754053Ab1AGGfF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jan 2011 01:35:05 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:53284 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753904Ab1AGGfD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jan 2011 01:35:03 -0500
Received: by wwa36 with SMTP id 36so18198578wwa.1
        for <git@vger.kernel.org>; Thu, 06 Jan 2011 22:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=KICgASXEFOCwCSgyhEqDsilnd2Q66qJLXvuLrWhix7k=;
        b=WvJfs8X2Zl87lBvaRpEJYsFKNx2USd6bWJF0A4iwzCKN8MhVE2lgAvoSF7OtZfn5p0
         bwk/kofo16dTSOP5WVQiuLPxIAkjwmAJQB2nHNFp9pGoNA1rgYLhUTf8r1FAEMs3jSgL
         mGuSEGHUEiWNDjrsEEJNjoUdhJJqrqDOoc4qY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=a02U1ViJ4lnD7JNsLLkUjwyrGiNdcDcqpHB8nbS3On2nz7uVqhSX4BODYgGd1I/WAN
         M+T0Ropd+lVjsz+eaQ+AbM+4YsmjrYzqxfwV9NlPlIjSVi4UVQRvJEsuAjgM9+myDUXd
         UBbY6UZZiohEAWVdov+YDMMgaJ7mscW3+6k1Q=
Received: by 10.216.177.9 with SMTP id c9mr25120024wem.34.1294382101205; Thu,
 06 Jan 2011 22:35:01 -0800 (PST)
Received: by 10.216.63.14 with HTTP; Thu, 6 Jan 2011 22:34:31 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1101061956470.22191@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164702>

On Fri, Jan 7, 2011 at 10:21 AM, Nicolas Pitre <nico@fluxnic.net> wrote=
:
> How do you actually define your chain? =C2=A0Given that Git is concep=
tually
> snapshot based, there is currently no relationship between two blobs
> forming the content for two different versions of the same file. =C2=A0=
Even
> delta objects are not really part of the Git data model as they are o=
nly
> an encoding variation of a given primary object. =C2=A0In fact, we ma=
y and
> actually do have deltas where the base object is not from the same
> worktree file as the delta object itself.
>
> The only thing that
> ties this all together is the commit graph. =C2=A0And that graph migh=
t have
> multiple forks and merges so any attempt at a linearity representatio=
n
> into a chain is rather futile. =C2=A0Therefore it is not clear to me =
how you
> can define a chain with a beginning and an end, and how this can be
> resumed midway.

There's no need to be linear. OK it's not a chain, but a DAG of
objects that has the same path, in the same structure of commit DAG.

>> We start by fetching all commit contents reachable from a commit tip=
=2E
>
> Sure. =C2=A0This is doable today and is called a shalow clone with de=
pth=3D1.

I meant only commit objects, no trees nor blobs.

>> This is a chain, therefore resumable.
>
> I don't get that part though. =C2=A0How is this resumable? =C2=A0That=
's the very
> issue we have with a clone.

I assume that all commits are sent in an order that parent commits are
always after the commit in question. We can make a pack of undeltified
commit objects in such order. That would make sure we could recover a
continuous commit DAG from the tip if the pack cannot be sent
completely to client.

We can traverse commit graph we have, and request for a pack of
missing commits to grow the commit DAG until we have all commits.

> I proposed a solution to that already, which is to use
> git-upload-archive for one of the tip commit since the data stream
> produced by upload-archive (once decompressed) is actually
> deterministic. =C2=A0Once completed, this can be converted into a sha=
low
> clone on the client side, and can be deepened in smaller steps
> afterwards.

You see, I don't send trees and blobs in this phase. There are three
phases. Phase 1 fetches all commits. Once we have all commits. We can
use them to request packs of trees of the same path. Those packs are
like the commit pack, but deltified. That's phase 2. When we have
enough trees, we can proceed to phase 3: fetching packs of blobs.

>> From there each commit can be
>> examined. Missing trees and blobs will be fetched as chains. Everyti=
me
>> a delta is received, we can recreate the new object and verify it (w=
e
>> should have its SHA-1 from its parent trees/commits).
>
> What if the delta is based on an object from another chain? =C2=A0How=
 do you
> determine which chain to ask for to get that base?

Chains should be independent. If a chain is based on another chain and
we have not got its base yet (because the other chain is not
completed), we can fetch the base separately. In theory we need to
fetch a version of all paths once for them to become bases. So it's
like a broken down version of git-upload-archive.

>> Because these chains are quite independent, in a sense that a blob
>> chain is independent from another blob chain (but requires tree
>> chains, of course). We can fetch as many as we want in parallel, onc=
e
>> we're done with the commit chain.
>
> But in practice, most of those chains will end up containing objects
> which are duplicate of objects in another chain. =C2=A0How do you tel=
l the
> remote that you want part of a chain because you've got 96% of it in
> another chain already?

Because all clients should have full commit graph (without trees and
blobs) before doing anything, they should be able to specify a rev
list for the chain they need. So if you only need SHA1~76..SHA1~100 of
a path, say so to remote side. SHA-1 must be one of the refs on remote
side, so it can parse the syntax and verify quickly if "SHA1~76" is
reachable/allowed to transfer.

>> The last thing I like about these chains is that the number of chain=
s
>> is reasonable. It won't increase too fast over time (as compared to
>> the number of commits). As such it maps well to BitTorrent's "pieces=
".
>
> My problem right now is that I don't see how this maps well to Git.

Git sees a repository as history of snapshots. This way I see it as a
bunch of "git log -- path", not that bad.
--=20
Duy
