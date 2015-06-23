From: David Turner <dturner@twopensource.com>
Subject: Re: RFC/Pull Request: Refs db backend
Date: Tue, 23 Jun 2015 15:53:25 -0400
Organization: Twitter
Message-ID: <1435089205.28466.56.camel@twopensource.com>
References: <1435020656.28466.8.camel@twopensource.com>
	 <55898073.4010105@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jun 23 21:53:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7UGE-0003vG-Au
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 21:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932648AbbFWTxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 15:53:30 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:33122 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932323AbbFWTx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 15:53:28 -0400
Received: by qkhu186 with SMTP id u186so10751007qkh.0
        for <git@vger.kernel.org>; Tue, 23 Jun 2015 12:53:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=aTIayJx7g2RyvRfFkbGjI3ujSsUjC+NdvNsynTKxAtY=;
        b=m84JeBQm2SBD9JiRo8xadIxnPaWiy/cmPKqxfyAETsuqk1SJ/LUKyUPX71OKcL0sn/
         m10L5E/EBcqv95+/XyNKhfzn0UnO6EXG6m/Gcoy65dE6xS4gGHTsfHhEbMcylJVwVY0a
         bKCKWhiLtVpK4QqG4H/sRAqfJbZGk2i7etZRduj8b4NlLKwyb3CQaM9wezZPz9R6ekdC
         lhCK3J37RVGBZuecHJHTeZ3AgG/cE0BfUPPaFZj7qMjeQ9b1Bd4HCrGguGOqhU0q4qYa
         G09Bi6VgGpWQvXLxVRaTIiEq/W+TZwnWuwpTK+/htLv0feVzMSdMzBXory65J+3CUeRX
         5hfA==
X-Gm-Message-State: ALoCoQkZTtTP19uAiPEvcRZ6NIus/Ycm4PV0kw5s9CPjEqPNUnShii/Bhem/GocITA9/LfHLe/J7
X-Received: by 10.140.23.5 with SMTP id 5mr46547938qgo.106.1435089207606;
        Tue, 23 Jun 2015 12:53:27 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by mx.google.com with ESMTPSA id o65sm1993336qge.34.2015.06.23.12.53.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jun 2015 12:53:26 -0700 (PDT)
In-Reply-To: <55898073.4010105@alum.mit.edu>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272489>

On Tue, 2015-06-23 at 17:51 +0200, Michael Haggerty wrote:
> On 06/23/2015 02:50 AM, David Turner wrote:
> > I've revived and modified Ronnie Sahlberg's work on the refs db
> > backend.  
> > 
> > The work is on top of be3c13e5564, Junio's "First batch for 2.5 cycle".
> > I recognize that there have been changes to the refs code since then,
> > and that there are some further changes in-flight from e.g. Michael
> > Haggerty.  If there is interest in this, I can rebase once Michael's
> > changes land.
> 
> It's awesome that you are working on this!
> 
> I'm reading through your commits and will add comments as they pop into
> my head...
> 
> * I initially read "refs-be-files" to be a short version of "references,
> they be files". I might never be able to get that pronunciation out of
> my head :-)

That's OK so long as I can keep pronouncing "reflog" as "re-flog". ;)

> * It would be more modest to call the files implementing the LMDB
> backend "refs-be-lmdb.[c,h]" rather than "refs-be-db.[c,h]".

Agreed.  Will fix.

> * I wonder whether `refname_is_safe()` might eventually have to become
> backend-specific. For example, maybe one backend will have to impose a
> limit of 128 characters or something? No matter, though...it can be
> moved later.

I think it would be an error to allow backends to impose additional
limits on ref names.  The limits imposed by the current backend have
been the cause of much sadness here at Twitter (primarily,
case-conflicts combined with d/f conflicts).

> * You have put `format_reflog_msg()` in the public interface. It
> probably makes sense, because more than one backend might want to use
> it. But another backend might want to store (refname, old_sha1,
> new_sha1, ...) as separate columns in a database. As long as
> `format_reflog_msg()` is seen as a helper function and is not called by
> any of the shared code, it shouldn't be a problem.

Agreed.

> * I wonder whether `init_backend()` will be general enough. 

We can always upgrade it later.

> * Your "methods for bulk updates" are I think analogous to the
> `initial_ref_transaction_commit()` function that I recently submitted
> [1]. Either way, the goal is to abstract away the fact that the
> file-based backend uses packed and loose references with tradeoffs that
> callers currently have to know about.

Yes, I saw your work after I had already started mine.

> * I don't like the fact that you have replaced `struct ref_transaction
> *` with `void *` in the public interface. On a practical level, I like
> the bit of type-safety that comes with the more specific declaration.
> But on a more abstract level, I think that the concept of a transaction
> could be useful across backends, for example in utility functions that
> verify that a proposed set of updates are internally consistent. I would
> rather see either
> 
>   * backends "extend" a basic `struct ref_transaction` to suit their
> needs, and upcast/downcast pointers at the module boundary, or
> 
>   * `struct ref_transaction` itself gets a `void *` member that backends
> can use for whatever purposes they want.

There are no common fields between refs-be-file transactions and
refs-be-lmdb transactions.  I don't see much gain from adding an empty
ref_transaction that backends could extend, since we would have to
explicitly upcast/downcast all over the place.

> * Regarding MERGE_HEAD: you take the point of view that it must continue
> to be stored as a file. And yet it must also behave somewhat like a
> reference; for example, `git rev-parse MERGE_HEAD` works today.
> MERGE_HEAD is also used for reachability, right?
> 
> Another point of view is that MERGE_HEAD is a plain old boring
> reference, but there is some other metadata related to it that the refs
> backend has to store. The file-based backend would have special-case
> code to read the additional data from the tail of the loose refs file
> (and be sure to write the metadata when writing the reference), but
> other backends could store the reference with the rest but do their own
> thing with the metadata. So I guess I'm wondering whether the refs API
> needs a MERGE_HEAD-specific way to read and write MERGE_HEAD along with
> its metadata.

You are probably right that this is a good idea.

> * Don't the same considerations that apply to MERGE_HEAD also apply to
> FETCH_HEAD?

All of the tests pass without any special handling of FETCH_HEAD.

> * I'm showing my ignorance of LMDB, but I don't see where the LMDB
> backend initializes its database during `git init-db`. Is that what
> `init_env()` does? But it looks like `init_env()` is called on every git
> invocation (via `git_config_early()`). Puzzled.

There is no need to explicitly create the database (other than with
mkdir); init_env does everything for you.

> * Meanwhile, `create_default_files()` (in `builtin/init-db`) still
> creates directories `refs`, `refs/heads`, and `refs/tags`.

Yeah, that's legit.  I'll create a backend initdb function, and rename
init to setup.

> * Rehash of the last two points: I expected one backend function that is
> used to initialize the refs backend when a new repository is created
> (e.g., in `git init`). The file-based backend would use this function to
> create the `refs`, `refs/heads`, and `refs/tags` directories. I expected
> a second function that is called once every time git runs in an existing
> repository (this one might, for example, open a database connection).
> And maybe even a third one that closes down the database connection
> before git exits. Would you please explain how this actually works?

LMDB doesn't really have the concept of a "connection".  It's basically
just a couple of files that communicate using shared memory (and maybe
some other locking that I haven't paid attention to).  There is the
concept of a "transaction", which is the unit of concurrency (each
thread may only have one open transaction).  Transactions are either
read-only or read-write, and there can only be one read-write
transaction open at a time (across the entire system).  Read-only
transactions take a snapshot of the DB state at transaction start time.
This combination of features means that we need to be a bit clever about
read-only transactions; if a read-write transaction occurs in a separate
process, we need to restart any read-only transactions to pick up its
changes.

Requiring an explicit disconnect from the database would be problematic
because of the number of situations in which git just calls die(). If a
backend desires a disconnect, it would be best to just call atexit().

> * `lmdb_init_backend()` leaks `path` if `env` is already set (in which
> case it needn't compute `path` in the first place).

Will fix, thanks.

> * You have the constraint that submodules need to use the same reference
> backend as the main repository. But it looks like each submodule has its
> own independent database. So why the restriction?
>
> It might be a sign that the design is not optimal if it is only able to
> handle one *type* of reference backend in a single run.

Yes, that is the reason.  I think it would be rather difficult to fix
this, but I guess it's possible.

> In object-oriented language, I would expect a `Refs` object to represent
> the reference storage for a single repository or submodule. The VTABLE
> for the object would be a `struct ref_be`. But the object should also
> have an object pointer that can store per-instance data. I think the
> per-instance data is missing in your design.

For some of the code, that's the transaction.  But since we only ever
have one transaction, we could just move all that to the `Refs` object.

<snip arguments for this> 

I'll try to write some code and see what this looks like.

> * You explain in the docstring to `lmdb_transaction_begin_flags()` that
> it is dangerous to call a callback function while a write transaction is
> open if the callback function might want to initiate another write
> transaction. This would obviously also apply to running hooks.

I carefully limit the scope of write transactions to avoid problems like
this.

>  This is a
> limitation of LMDB because writers block each other. I can't think of
> anyplace that this would be a problem in our codebase. But if it were,
> it seems to me that you could take an approach like the file-based
> backend, which collects the transaction in a `ref_transaction` data
> structure, and executes the entire transaction within a single call to
> `ref_transaction_commit()`. This approach would prevent callers outside
> of the refs module from ever bumping against this limitation.

The file-based backend does per-ref locking early, and then applies the
transactions. Here, taking the write transaction is how the lmdb backend
does locking.  So the situations are not quite the same.  But I think
keeping the scope of transactions small is the best plan.

> So, that was my stream-of-consciousness about your patch series. Overall
> I like it very much. I have only skimmed it so far, and hardly read the
> last two patches at all, but what I saw all looked good and well-organized.

Thanks.  A fair amount of it is Ronnie's work, and I tried to copy his
approach as much as possible.

> Please CC me on future versions of this patch series, because it is very
> close to my interests. I've put a lot of effort into encapsulating and
> abstracting the refs module with the goal of getting to pluggable
> reference backends (plus some other stuff), so it's great to see what
> you have accomplished!

Will do!

> Let me know if you need any help rebasing your work onto my recent
> changes. It would probably work best if you break your patch series into
> smaller pieces to make them easier for the mailing list to digest. For
> example, the first installment could be the patches that make sense even
> independent of the plan to add support for multiple backends: the first
> two patches, plus the ones related to CHERRY_PICK_HEAD and its cousins,
> the abstraction of the reflog functions, and the `git reflog create` and
> `git reflog exists` subcommands.

I would love some help rebasing. I'll break out the patches you suggest
and send them to the list, then create a new branch with the rest of the
changes.  Would that be a good place for you to start?
