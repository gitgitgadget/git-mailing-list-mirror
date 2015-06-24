From: David Turner <dturner@twopensource.com>
Subject: Re: RFC/Pull Request: Refs db backend
Date: Wed, 24 Jun 2015 13:31:29 -0400
Organization: Twitter
Message-ID: <1435167089.26709.14.camel@twopensource.com>
References: <1435020656.28466.8.camel@twopensource.com>
	 <55898073.4010105@alum.mit.edu>
	 <1435089205.28466.56.camel@twopensource.com>
	 <5589CF56.2010309@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 24 19:31:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7oWR-0004fX-GI
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 19:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412AbbFXRbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 13:31:35 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33457 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752608AbbFXRbd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 13:31:33 -0400
Received: by padev16 with SMTP id ev16so33056103pad.0
        for <git@vger.kernel.org>; Wed, 24 Jun 2015 10:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=6weMoiLMMVgVuC2Li9TD61Ivx3hHaQip5FH3bcKYcLE=;
        b=Gpn1JQ6ZmPq+QIXdUN0DqiGn6kHu6uhN77eqEH6gBcKZqogGBF7m66DqQXG5ermZjS
         0sb9RD84IHxwQ4Hrz5fYAP80XbOC+xEAe46n7jDPxPRi/Eki0vpRya1FtfekEskepmP2
         FW9OHXl2NLPHgFyQAI05zzNfUyWP4fQdYzeat0IWdqhGOIWgE1bz0BeivUgxAoZQpiYK
         vMoI0bKzxUSxK3CY9Qx6n3cgjR51lr9tuMnVb+EbnQIp2YXorDuFndMr/WF07vVkJ6bl
         9OS3GVmZgPHCD9ANNWNIfmNScnPFLDeASD6qbMwwUPO6wj2SiY9s+a0fJ+TsMC5vxR7X
         eX9A==
X-Gm-Message-State: ALoCoQnyfnp+ZYs0HndLZ0RrFpRFYwXyJtPQX/Go/PgCpyfj3wFpIM5GRKgMAkmPemGiHTkAjg8S
X-Received: by 10.66.169.39 with SMTP id ab7mr82277112pac.109.1435167092508;
        Wed, 24 Jun 2015 10:31:32 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by mx.google.com with ESMTPSA id nw8sm27434814pdb.30.2015.06.24.10.31.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jun 2015 10:31:31 -0700 (PDT)
In-Reply-To: <5589CF56.2010309@alum.mit.edu>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272571>

On Tue, 2015-06-23 at 23:27 +0200, Michael Haggerty wrote:
> On 06/23/2015 09:53 PM, David Turner wrote:
> > On Tue, 2015-06-23 at 17:51 +0200, Michael Haggerty wrote:
> > [...]
> >> * I don't like the fact that you have replaced `struct ref_transaction
> >> *` with `void *` in the public interface. On a practical level, I like
> >> the bit of type-safety that comes with the more specific declaration.
> >> But on a more abstract level, I think that the concept of a transaction
> >> could be useful across backends, for example in utility functions that
> >> verify that a proposed set of updates are internally consistent. I would
> >> rather see either
> >>
> >>   * backends "extend" a basic `struct ref_transaction` to suit their
> >> needs, and upcast/downcast pointers at the module boundary, or
> >>
> >>   * `struct ref_transaction` itself gets a `void *` member that backends
> >> can use for whatever purposes they want.
> > 
> > There are no common fields between refs-be-file transactions and
> > refs-be-lmdb transactions.  I don't see much gain from adding an empty
> > ref_transaction that backends could extend, since we would have to
> > explicitly upcast/downcast all over the place.
> 
> If you ask me, it would be better to do a bunch of up/downcasts within
> the single module (via two helper functions that could even do
> consistency checks) than have no help from the compiler in preventing
> people from passing unrelated pointer types into the `void *transaction`
> argument. Plus the `struct ref_transaction *` variables scattered
> throughout the code are a lot more self-explanatory than `void *`.

I'll take a look at what that would look like.

> >> * Regarding MERGE_HEAD: you take the point of view that it must continue
> >> to be stored as a file. And yet it must also behave somewhat like a
> >> reference; for example, `git rev-parse MERGE_HEAD` works today.
> >> MERGE_HEAD is also used for reachability, right?
> >>
> >> Another point of view is that MERGE_HEAD is a plain old boring
> >> reference, but there is some other metadata related to it that the refs
> >> backend has to store. The file-based backend would have special-case
> >> code to read the additional data from the tail of the loose refs file
> >> (and be sure to write the metadata when writing the reference), but
> >> other backends could store the reference with the rest but do their own
> >> thing with the metadata. So I guess I'm wondering whether the refs API
> >> needs a MERGE_HEAD-specific way to read and write MERGE_HEAD along with
> >> its metadata.
> > 
> > You are probably right that this is a good idea.
> > 
> >> * Don't the same considerations that apply to MERGE_HEAD also apply to
> >> FETCH_HEAD?
> > 
> > All of the tests pass without any special handling of FETCH_HEAD.
> 
> That's odd. From git-fetch.txt:
> 
>     The names of refs that are fetched, together with the object names
>     they point at, are written to `.git/FETCH_HEAD`.  This information
>     may be used by scripts or other git commands, such as
>     linkgit:git-pull[1].
> 
> It seems like the test suite is reading FETCH_HEAD via the refs API in a
> couple of places. I don't understand why these don't fail when LMDB is
> being used...

You are right; I did add some special-case code for FETCH_HEAD.

> >> * Rehash of the last two points: I expected one backend function that is
> >> used to initialize the refs backend when a new repository is created
> >> (e.g., in `git init`). The file-based backend would use this function to
> >> create the `refs`, `refs/heads`, and `refs/tags` directories. I expected
> >> a second function that is called once every time git runs in an existing
> >> repository (this one might, for example, open a database connection).
> >> And maybe even a third one that closes down the database connection
> >> before git exits. Would you please explain how this actually works?
> > 
> > LMDB doesn't really have the concept of a "connection".  It's basically
> > just a couple of files that communicate using shared memory (and maybe
> > some other locking that I haven't paid attention to).  There is the
> > concept of a "transaction", which is the unit of concurrency (each
> > thread may only have one open transaction).  Transactions are either
> > read-only or read-write, and there can only be one read-write
> > transaction open at a time (across the entire system).  Read-only
> > transactions take a snapshot of the DB state at transaction start time.
> > This combination of features means that we need to be a bit clever about
> > read-only transactions; if a read-write transaction occurs in a separate
> > process, we need to restart any read-only transactions to pick up its
> > changes.
> 
> If you are thinking about an *unrelated* separate process, then Git's
> philosophy is that if our process is reading *some* valid state of the
> references, it's all good even if that state is not quite the newest.
> After all, who's to say whether our process ran before or after the
> other process? As long as each process sees self-consistent views of the
> world as it existed at some recent time, we're satisfied.

No, I'm thinking about a subprocess that we stared ourself here.
Unrelated separate processes are fine, I think.

> To be sure, we even fail at that unambitious goal, because loose
> reference reads are not atomic. It is possible that we read some
> references in the state they had before the other process ran, and
> others in the state they had after the other process was finished. This
> can get ugly if, for example, the other process renamed a reference,
> because we might not see the reference under either its old *or* its new
> name. We might therefore conclude that the objects reachable from that
> reference are dangling and garbage-collect them.
> 
> If the other process is one that we started ourselves, then that is a
> different situation and we would want, for example, to invalidate our
> reference cache after the other process is done.

Yep, my code does this.

> One of the long-standing hopes of a DB-backed reference backend would be
> to improve this situation--allowing atomic writes *and* reads.

Reads are atomic across renames, since we do renames within a single
write transaction. 

> > [...]
> > 
> >> * You explain in the docstring to `lmdb_transaction_begin_flags()` that
> >> it is dangerous to call a callback function while a write transaction is
> >> open if the callback function might want to initiate another write
> >> transaction. This would obviously also apply to running hooks.
> > 
> > I carefully limit the scope of write transactions to avoid problems like
> > this.
> > 
> >>  This is a
> >> limitation of LMDB because writers block each other. I can't think of
> >> anyplace that this would be a problem in our codebase. But if it were,
> >> it seems to me that you could take an approach like the file-based
> >> backend, which collects the transaction in a `ref_transaction` data
> >> structure, and executes the entire transaction within a single call to
> >> `ref_transaction_commit()`. This approach would prevent callers outside
> >> of the refs module from ever bumping against this limitation.
> > 
> > The file-based backend does per-ref locking early, and then applies the
> > transactions. Here, taking the write transaction is how the lmdb backend
> > does locking.  So the situations are not quite the same.  But I think
> > keeping the scope of transactions small is the best plan.
> 
> The file-based backend locks the references early *within
> ref_transaction_commit()*, not as the transaction is being built up
> using ref_transaction_update() etc. This is a big difference, because
> code anywhere can call
> 
>     ref_transaction_begin(...);
>     ANYTHING
>     ref_transaction_update(...);
>     ANYTHING
>     ref_transaction_commit(...);
> 
> The only way to be sure that ANYTHING can't create a deadlock with the
> open transaction (for example by calling a hook script that runs a git
> command) is to audit all of that code now and in the future. Whereas the
> file-based backend doesn't do anything that is externally observable or
> deadlocky except within the single ref_transaction_commit() function
> call, so only that one function has to be audited for actions that could
> cause a deadlock.

A deadlock is impossible; a second writer will simply be unable to
acquire the lock and will die (same as in the file-based backend if two
writers try to update the same ref at the same time).

It's true that the scope for this is potentially larger.  On the other
hand, the file-based backend might fail in the same cases -- it would
fail when trying to verify refs that had changed out from under it. The 
failure is less likely, since it would only happen on conflicting refs.
