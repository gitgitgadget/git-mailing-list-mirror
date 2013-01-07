From: Martin Fick <mfick@codeaurora.org>
Subject: Re: [PATCH] refs: do not use cached refs in repack_without_ref
Date: Mon, 7 Jan 2013 11:14:22 -0700
Organization: CAF
Message-ID: <201301071114.22526.mfick@codeaurora.org>
References: <20121221080449.GA21741@sigill.intra.peff.net> <20121229071630.GA15408@sigill.intra.peff.net> <201301071109.12086.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 07 19:14:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsHDh-0003t5-Ll
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 19:14:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753634Ab3AGSOZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2013 13:14:25 -0500
Received: from wolverine02.qualcomm.com ([199.106.114.251]:54029 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068Ab3AGSOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2013 13:14:25 -0500
X-IronPort-AV: E=Sophos;i="4.84,425,1355126400"; 
   d="scan'208";a="18380824"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine02.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Jan 2013 10:14:24 -0800
Received: from mfick-lnx.localnet (pdmz-ns-snip_218_1.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 7D84F10004B7;
	Mon,  7 Jan 2013 10:14:24 -0800 (PST)
User-Agent: KMail/1.13.5 (Linux/2.6.32.49+drm33.21-mfick7; KDE/4.4.5; x86_64; ; )
In-Reply-To: <201301071109.12086.mfick@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212911>

...[Sorry about the previous HTML reposts]

Jeff King <peff@peff.net> wrote:
>On Mon, Dec 31, 2012 at 03:30:53AM -0700, Martin Fick 
wrote:
>
>> The general approach is to setup a transaction and
>> either commit or abort it. A transaction can be setup
>> by renaming an appropriately setup directory to the
>> "ref.lock" name. If the rename succeeds, the
>> transaction is begun. Any actor can abort the
>> transaction (up until it is committed) by simply
>> deleting the "ref.lock" directory, so it is not at
>> risk of going stale.
>
> Deleting a directory is not atomic, as you first have
> to remove the contents, putting it into a potentially
> inconsistent state. I'll assume you deal with that
> later...

Right, these simple single file transactions have at 
best 1 important file/directory in them, once deleted 
the transaction is aborted (can no longer complete).  
However to support multi file transactions, a better 
approach is likely to rename the uuid directory to have 
a .delete extension before deleting stuff in it.


> > One important piece of the transaction is the use
> > of uuids. The uuids provide a mechanism to tie the
> > atomic commit pieces to the transactions and thus to
> > prevent long sleeping process from inadvertently
> > performing actions which could be out of date when
> > they wake finally up.
> >
>Has this been a problem for you in practice?

No, but as you say, we don't currently hold locks for 
very long. I anticipate it being a problem in a 
clustered environment when transactions start spanning 
repos from java processes, with insane amounts of RAM, 
which can sometimes have unpredictable indeterminately 
long java GC cycles at inopportune times.. It would seem 
short sighted if Gerrit at least did not assume this 
will be a problem.

But, deletes today in git are not so short and Michael's 
fixes may make things worse? But, as you point out, that 
should perhaps be solved a different way.


> Avoiding this is one of the reasons that git does not
> take out long locks; instead, it takes the lock only
> at the moment it is ready to write, and aborts if it
> has been updated since the longer-term operation
> began. This has its own problems (you might do a lot
> of work only to have your operation aborted), but I
> am not sure that your proposal improves on that.

It does not, it might increase this.


> Git typically holds ref locks for a few syscalls. If
> you are conservative about leaving potentially stale
> locks in place (e.g., give them a few minutes to
> complete before assuming they are now bogus), you will
> not run into that problem.

In a distributed environment even a few minutes might 
not be enough, processes could be on a remote server 
with a temporarily split network, that could cause 
delays longer than your typical local expectations.

But there is also the other piece of this problem, how 
do you detect stale locks? How long will it be stale 
until a user figures it out and reports it? How many 
other users will simply have failed pushes and wonder 
why without reporting them?


> > In each case, the atomic commit piece is the
> > renaming of a file. For the create and update
> > pieces, a file is renamed from the "ref.lock" 
> > dir to the "ref" file resulting in an update to 
> > the sha for the ref.
>
> I think we've had problems with cross-directory
> renames on some filesystems, but I don't recall the
> details. I know that Coda does not like 
> cross-directory links, but cross-directory renames 
> are OK (and in fact we fall back to the latter when
> the former does not work).
>
> Ah, here we go: 5723fe7 (Avoid cross-directory renames
> and linking on object creation, 2008-06-14). Looks
> like NFS is the culprit.

If the renames fail we can fall back to regular file 
locking, the hard part to detect and deal with would be 
if the renames don't fail but become copies/mkdirs.


>> In the case of a delete, the actor may verify that
>> "ref" currently contains the sha to "prune" if it
>> needs to, and then renames the "ref" file to
>> "ref.lock/uuid/delete". On success, the ref was
>> deleted.
>>
>> Whether successful or not, the actor may now simply
>> delete the "ref.lock" directory, clearing the way for
>> a new transaction. Any other actor may delete this
>> directory at any time also, likely either on conflict
>> (if they are attempting to initiate a transaction),
>> or after a grace period just to cleanup the FS. Any
>> actor may also safely cleanup the tmp directories,
>> preferably also after a grace period.
>
> Hmm. So what happens to the "delete" file when the
> ref.lock directory is being deleted? Presumably
> deleting the ref.lock directory means doing it
> recursively (which is non-atomic). But then why are 
> we keeping the delete file at all, if we're just about
> to remove it?

We are not trying to keep it, but we need to ensure that 
our transaction has not yet been aborted: the rename 
does this.  If we just deleted the file, we may sleep 
and another transaction may abort our transaction and 
complete before we wake up and actually delete the file. 
But by using a rename we tie the delete atomically to 
the transaction, it cannot succeed if our transaction 
was aborted during a sleep since the directory we are 
renaming the file into would be gone! This is sort of 
the magic piece that makes the whole scheme special, 
safe deletes tend to be the hardest part.


>What happens if another process wants to cancel a
> transaction that is partially done? That is, the
> ref.lock directory is created, but it contains the
> uuid subdir? It sounds like it's OK to just delete
> from it, and the original process will then fail at
> its rename?

Yes, exactly.  But again, it might be better to cause a 
rename of the uuid dir before deleting it.


>> One neat part about this scheme is that I believe it
>> would be backwards compatible with the current
>> locking mechanism since the transaction directory
>> will simply appear to be a lock to older clients. 
>> And the old lock file should continue to lock
>> out these newer transactions.
>
>Yeah, I don't see anything that would prevent that. 
> The current code only cares about open("$ref.lock",
> O_EXCL). But that should be correct and atomic with
> respect to the renamed directories. You are depending
> on atomic directory renames. Those aren't used
> anywhere yet in git, as far as I know. So that may run
> into problems (but there's no reason this system
> couldn't be optional for filesystems that are more
> abled, and other systems could fall back to the
> straight-file locking).

Right.


> So in response to your question, no, I don't see any
> real showstoppers here. 

Alright, cool, thanks for the review and analysis, I 
appreciate it.


> And unlike the "all refs are files in a directory"
> scheme, it's confined to writing, which solves the
> readdir() atomicity questions I had there.


Right, I couldn't see a way around those, I think it was 
inherently flawed.


> I still can't say I'm super excited about it, just
> because it seems like a solution in search of a
> problem that I have not experienced myself.

It might be.  But at least a solution is out there now. 
If time indicates that it is needed, I feel better 
knowing there is a solution. 

Murphy has a way of making unlikely problems real 
annoyances in automated distributed environments. The 
problem is not usually one real annoying problem, those 
get fixed. The problem we deal mostly with is 1000 
infrequent problems, all different, but they add up to a 
system which needs constant maintenance. And the 
maintenance is hard since each problem is different, the 
analysis is difficult and requires expertise.


> Fixing the minor remaining races on ref packing would
> be nice, but I do not think those are a problem of the
> on-disk lock representation. The reason they are not
> fixed now is from an attempt to keep lock contention
> low between unrelated updates (something which we
> should probably give up on in favor of correctness;
> but that is orthogonal to whether we do it with the
> existing file locks or with a new system).

Agreed.


>A much stronger fix for that would be to record deletes
> in the loose ref storage so that we don't have to
> update the packed-refs file as often (because it is
> inherently a lock bottleneck, and because it is
> wasteful when you have a very large number of refs).
> But that means dealing with directory/file conflicts
> between deleted and existing branches, which is a
> pain.

Makes sense.

Thanks again for your thoughts,

-Martin

-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation
