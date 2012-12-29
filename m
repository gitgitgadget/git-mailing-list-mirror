From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Lockless Refs?  (Was [PATCH] refs: do not use cached refs in repack_without_ref)
Date: Sat, 29 Dec 2012 14:29:55 -0700
Message-ID: <befe9a89-8f71-437e-ad33-c4dc4ee90507@email.android.com>
References: <20121221080449.GA21741@sigill.intra.peff.net> <50DAB447.8000101@alum.mit.edu> <201212271611.52203.mfick@codeaurora.org> <201212280750.14695.mfick@codeaurora.org> <20121229081200.GD15408@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <sop@google.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 29 22:35:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tp44R-0006sf-9e
	for gcvg-git-2@plane.gmane.org; Sat, 29 Dec 2012 22:35:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753302Ab2L2Vfb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2012 16:35:31 -0500
Received: from wolverine02.qualcomm.com ([199.106.114.251]:60833 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161Ab2L2Vfa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2012 16:35:30 -0500
X-IronPort-AV: E=Sophos;i="4.84,378,1355126400"; 
   d="scan'208";a="17057558"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine02.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 29 Dec 2012 13:35:30 -0800
Received: from [192.168.1.181] (pdmz-ns-snip_218_1.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 6E83F10004B1;
	Sat, 29 Dec 2012 13:35:23 -0800 (PST)
User-Agent: K-9 Mail for Android
In-Reply-To: <20121229081200.GD15408@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212319>

Jeff King <peff@peff.net> wrote:

>On Fri, Dec 28, 2012 at 07:50:14AM -0700, Martin Fick wrote:
>
>> Hmm, actually I believe that with a small modification to the 
>> semantics described here it would be possible to make multi 
>> repo/branch commits work.   Simply allow the ref filename to 
>> be locked by a transaction by appending the transaction ID to 
>> the filename.  So if transaction 123 wants to lock master 
>> which points currently to abcde, then it will move 
>> master/abcde to master/abcde_123.  If transaction 123 is 
>> designed so that any process can commit/complete/abort it 
>> without requiring any locks which can go stale, then this ref 
>> lock will never go stale either (easy as long as it writes 
>> all its proposed updates somewhere upfront and has atomic 
>> semantics for starting, committing and aborting).  On commit, 
>> the ref lock gets updated to its new value: master/newsha and 
>> on abort it gets unlocked: master/abcde.
>
>Hmm. I thought our goal was to avoid locks? Isn't this just locking by
>another name?

It is a lock, but it is a lock with an owner: the transaction.  If the transaction has reliable recovery semantics, then the lock will be recoverable also.  This is possible if we have lock ownership (the transaction) which does not exist today for the ref locks.  With good lock ownership we gain the ability to reliably delete locks for a specific owner without the risk of deleting the lock when held by another owner (putting the owner in the filename is "good", while putting the owner in the filecontents is not).   Lastly, for reliable recovery of stale locks we need the ability to determine when an owner has abandoned a lock.  I believe that the transaction semantics laid out below give this.


>I guess your point is to have no locks in the "normal" case, and have
>locked transactions as an optional add-on?

Basically.  If we design the transaction into the git semantics we could ensure that it is recoverable and we should not need to expose these reflocks outside of the transaction APIs.

To illustrate a simple transaction approach (borrowing some of Shawn's ideas), we could designate a directory to hold transaction files *1.  To prepare a transaction: write a list of repo:ref:oldvalue:newvalue to a file named id.new (in a stable sorted order based on repo:ref to prevent deadlocks).  This is not a state change and thus this file could be deleted by any process at anytime (preferably after a long grace period).

If file renames are atomic on the filesystem holding the transaction files then 1, 2, 3 below will be atomic state changes.  It does not matter who performs state transitions 2 or 3.  It does not matter who implements the work following any of the 3 transitions, many processes could attempt the work in parallel (so could a human).
 
1) To start the transaction, rename the id.new file to id.  If the rename fails, start over if desired/still possible.  On success, ref locks for each entry should be acquired in listed order (to prevent deadlocks), using transaction id and oldvalue.  It is never legal to unlock a ref in this state (because a block could cause the unlock to be delayed until the commit phase).  However, it is legal for any process to transition to abort at any time from this state, perhaps because of a failure to acquire a lock (held by another transaction), and definitely if a ref has changed (is no longer oldvalue).

2) To abort the transaction, rename the id file to id.abort.  This should only ever fail if commit was achieved first.  Once in this state, any process may/should unlock any ref locks belonging to this transaction id.  Once all refs are unlocked, id.abort may be deleted (it could be deleted earlier, but then cleanup will take longer).

3) To commit the transaction, rename the file to id.commit.  This should only ever fail if abort was achieved first. This transition should never be done until every listed ref is locked by the current transaction id.  Once in this phase, all refs may/should be moved to their new values and unlocked by any process. Once all refs are unlocked, id.commit may be deleted. 

Since any process attempting any of the work in these transactions could block at any time for an indefinite amount of time, these processes may wake after the transaction is aborted or comitted and the transaction files are cleaned up.  I believe that in these cases the only actions which could succeed by these waking processes is the ref locking action.  All such abandoned ref locks may/should be unlocked by any process.  This last rule means that no transaction ids should ever be reused,

-Martin


*1 We may want to adapt the simple model illustrated above to use git mechanisms such as refs to hold transaction info instead of files in a directory, and git submodule files to hold the list of refs to update.  

Employee of Qualcomm Innovation Center,Inc. which is a member of Code Aurora Forum
