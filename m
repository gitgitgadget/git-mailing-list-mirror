From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Lockless Refs?  (Was [PATCH] refs: do not use cached refs in repack_without_ref)
Date: Fri, 4 Jan 2013 11:01:02 -0700
Organization: CAF
Message-ID: <201301041101.02756.mfick@codeaurora.org>
References: <20121221080449.GA21741@sigill.intra.peff.net> <201301031652.44982.mfick@codeaurora.org> <871B6C10EBEFE342A772D1159D1320853A011469@umechphj.easf.csd.disa.mil>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Pyeron, Jason J CTR (US)" <jason.j.pyeron.ctr@mail.mil>
X-From: git-owner@vger.kernel.org Fri Jan 04 19:01:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrBa9-0003hW-TH
	for gcvg-git-2@plane.gmane.org; Fri, 04 Jan 2013 19:01:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754567Ab3ADSBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2013 13:01:06 -0500
Received: from wolverine01.qualcomm.com ([199.106.114.254]:21442 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755166Ab3ADSBF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2013 13:01:05 -0500
X-IronPort-AV: E=Sophos;i="4.84,411,1355126400"; 
   d="scan'208";a="17823368"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine01.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 04 Jan 2013 10:01:03 -0800
Received: from mfick-lnx.localnet (pdmz-ns-snip_218_1.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id A187E10004BE;
	Fri,  4 Jan 2013 10:01:03 -0800 (PST)
User-Agent: KMail/1.13.5 (Linux/2.6.32.49+drm33.21-mfick7; KDE/4.4.5; x86_64; ; )
In-Reply-To: <871B6C10EBEFE342A772D1159D1320853A011469@umechphj.easf.csd.disa.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212635>

On Friday, January 04, 2013 10:52:43 am Pyeron, Jason J 
CTR (US) wrote:
> > From: Martin Fick
> > Sent: Thursday, January 03, 2013 6:53 PM
> > 
> > Any thoughts on this idea?  Is it flawed?  I am 
trying
> > to write it up in a more formal generalized manner 
and
> > was hoping to get at least one "it seems sane" 
before
> > I do.
> 
> If you are assuming that atomic renames, etc. are
> available, then you should identify a test case and a
> degrade operation path when it is not available.

Thanks, sound reasonable.  Where you thinking a runtime 
test case that would be run before every transaction?  I 
was anticipating a per repo config option called 
something like "core.locks = recoverable" that would be 
needed to turn them on?  I was thinking that this was 
something that server sites could test in advance on 
their repos and then enable it for them.  Maybe a git-
lock tool with a --test-recoverable option?

-Martin


> > 
> > On Monday, December 31, 2012 03:30:53 am Martin Fick 
wrote:
> > > On Thursday, December 27, 2012 04:11:51 pm Martin
> > > Fick
> > 
> > wrote:
> > > > It concerns me that git uses any locking at all,
> > > > even for refs since it has the potential to 
leave
> > > > around stale locks.
> > > > ...
> > > > [a previous not so great attempt to fix this]
> > > > ...
> > > 
> > > I may have finally figured out a working loose ref
> > > update mechanism which I think can avoid stale
> > > locks. Unfortunately it requires atomic directory
> > > renames and universally unique identifiers 
(uuids). 
> > > These may be no-go criteria?  But I figure it is
> > > worth at least exploring this idea because of the
> > > potential benefits?
> > > 
> > > The general approach is to setup a transaction and
> > > either commit or abort it.  A transaction can be
> > > setup by renaming an appropriately setup directory
> > > to the "ref.lock" name.  If the rename succeeds, 
the
> > > transaction is begun.  Any actor can abort the
> > > transaction (up until it is committed) by simply
> > > deleting the "ref.lock" directory, so it is not at
> > > risk of going stale.  However, once the actor who
> > > sets up the transaction commits it, deleting the
> > > "ref.lock" directory simply aids in cleaning it up
> > > for the next transaction (instead of aborting it).
> > > 
> > > One important piece of the transaction is the use 
of
> > > uuids. The uuids provide a mechanism to tie the
> > > atomic commit pieces to the transactions and thus 
to
> > > prevent long sleeping process from inadvertently
> > > performing actions which could be out of date when
> > > they wake finally up.  In each case, the atomic
> > > commit piece is the renaming of a file.   For the
> > > create and update pieces, a file is renamed from 
the
> > > "ref.lock" dir to the "ref" file resulting in an
> > > update to the sha for the ref. However, in the
> > > delete case, the "ref" file is instead renamed to
> > > end up in the "ref.lock" directory resulting in a
> > > delete of the ref.  This scheme does not affect 
the
> > > way refs are read today,
> > > 
> > > To prepare for a transaction, an actor first
> > > generates a uuid (an exercise I will delay for 
now).
> > >  Next, a tmp directory named after the uuid is
> > > generated in the parent directory for the ref to 
be
> > > updated, perhaps something like:  ".lock_uuid". In
> > > this directory is places either a file or a
> > > directory named after the uuid, something like:
> > > ".lock_uuid/,uuid".  In the case of a create or an
> > > update, the new sha is written to this file.  In 
the
> > > case of a delete, it is a directory.
> > > 
> > > Once the tmp directory is setup, the initiating 
actor
> > > attempts to start the transaction by renaming the 
tmp
> > > directory to "ref.lock".  If the rename fails, the
> > > update fails. If the rename succeeds, the actor 
can
> > > then attempt to commit the transaction (before
> > > another actor aborts it).
> > > 
> > > In the case of a create, the actor verifies that
> > > "ref" does not currently exist, and then renames 
the
> > > now named "ref.lock/uuid" file to "ref". On 
success,
> > > the ref was created.
> > > 
> > > In the case of an update, the actor verifies that
> > > "ref" currently contains the old sha, and then 
also
> > > renames the now named "ref.lock/uuid" file to 
"ref".
> > > On success, the ref was updated.
> > > 
> > > In the case of a delete, the actor may verify that
> > > "ref" currently contains the sha to "prune" if it
> > > needs to, and then renames the "ref" file to
> > > "ref.lock/uuid/delete". On success, the ref was
> > > deleted.
> > > 
> > > Whether successful or not, the actor may now 
simply
> > > delete the "ref.lock" directory, clearing the way
> > > for a new transaction.  Any other actor may delete
> > > this directory at any time also, likely either on
> > > conflict (if they are attempting to initiate a
> > > transaction), or after a grace period just to
> > > cleanup the FS.  Any actor may also safely cleanup
> > > the tmp directories, preferably also after a grace
> > > period.
> > > 
> > > One neat part about this scheme is that I believe 
it
> > > would be backwards compatible with the current
> > > locking mechanism since the transaction directory
> > > will simply appear to be a lock to older clients. 
> > > And the old lock file should continue to lock out
> > > these newer transactions.
> > > 
> > > Due to this backwards compatibility, I believe 
that
> > > this could be incrementally employed today without
> > > affecting very much.  It could be deployed in 
place
> > > of any updates which only hold ref.locks to update
> > > the loose ref.  So for example I think it could
> > > replace step 4a below from Michael Haggerty's
> > > description of today's loose ref pruning during
> > > 
> > > ref packing:
> > > > * Pack references:
> > > ...
> > > 
> > > > 4. prune_refs(): for each ref in the 
ref_to_prune
> > > > list,
> > > > 
> > > > call  prune_ref():
> > > >     a. Lock the reference using lock_ref_sha1(),
> > > >     verifying that the recorded SHA1 is still
> > > >     valid.  If it is, unlink the loose reference
> > > >     file then free the lock; otherwise leave the
> > > >     loose reference file untouched.
> > > 
> > > I think it would also therefore be able to replace
> > > the loose ref locking in Michael's new ref-packing
> > > scheme as well as the locking in Michael's new ref
> > > deletion scheme (again steps
> > > 
> > > 4):
> > > > * Delete reference foo:
> > > ...
> > > 
> > > >   4. Delete loose ref for "foo":
> > > >      a. Acquire the lock
> > > >      $GIT_DIR/refs/heads/foo.lock
> > > >      
> > > >      b. Unlink $GIT_DIR/refs/heads/foo if it is
> > > >      unchanged.
> > > >  
> > > >  If it is changed, leave it untouched.  If it is
> > > >  deleted,
> > > > 
> > > > that is OK too.
> > > > 
> > > >      c. Release lock 
$GIT_DIR/refs/heads/foo.lock
> > > 
> > > ...
> > > 
> > > > * Pack references:
> > > ...
> > > 
> > > >   4. prune_refs(): for each ref in the 
ref_to_prune
> > > >   list,
> > > > 
> > > > call prune_ref():
> > > >      a. Lock the loose reference using
> > > >      lock_ref_sha1(),
> > > > 
> > > > verifying that the recorded SHA1 is still valid
> > > > 
> > > >      b. If it is, unlink the loose reference 
file
> > > > 
> > > > (otherwise, leave it untouched)
> > > > 
> > > >      c. Release the lock on the loose reference
> > > 
> > > To be honest, I suspect I missed something obvious
> > > because this seems almost too simple to work.  I 
am
> > > ashamed that it took me so long to come up with 
(of
> > > course, I will be even more ashamed :( when it is
> > > shown to be flawed!) This scheme also feels
> > > extensible. if there are no obvious flaws in it, I
> > > will try to post solutions for ref packing and for
> > > multiple repository/ref transactions also soon.
> > > 
> > > I welcome any comments/criticisms,
> > > 
> > > -Martin
> > > --
> > > To unsubscribe from this list: send the line
> > > "unsubscribe git" in the body of a message to
> > > majordomo@vger.kernel.org More majordomo info at
> > > http://vger.kernel.org/majordomo-info.html
> > 
> > --
> > To unsubscribe from this list: send the line
> > "unsubscribe git" in the body of a message to
> > majordomo@vger.kernel.org More majordomo info at 
> > http://vger.kernel.org/majordomo-info.html

-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation
