From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2 42/43] refs: add LMDB refs backend
Date: Tue, 06 Oct 2015 21:51:00 -0400
Organization: Twitter
Message-ID: <1444182660.7739.77.camel@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
	 <1443477738-32023-43-git-send-email-dturner@twopensource.com>
	 <56129B77.1030409@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 07 03:51:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zjdsv-0001x9-F3
	for gcvg-git-2@plane.gmane.org; Wed, 07 Oct 2015 03:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753040AbbJGBvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2015 21:51:08 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:35219 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752960AbbJGBvF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2015 21:51:05 -0400
Received: by qgt47 with SMTP id 47so2928117qgt.2
        for <git@vger.kernel.org>; Tue, 06 Oct 2015 18:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=sj+mKjhfMuH+CY17xN5DCUpC8SBgl9X6TU5ho2/JLyI=;
        b=jal8q9HqJcd52aqjzUlEW+oH50YbWRY10RlwSo03My/Zw5+vUyKbgXhV+cmvdCtAhx
         IuMvkME6ZGenzFceGEtEK+FgQInhugt1S1SpUNEzTVaLRxUZj4x2C5pYe4yeWU+DZpwP
         MeevFzA7uJURU4qwDOQCVTiNNYLzqb8mlerl3pNs6+Jn3Buf/XGFU5oUcL5i11Wb/Axj
         slDPjXOXu3dhgjzayOF6RN1TG/Ee/YMmM9GEh6YrX2M5O3WmvDapaUGT4Jd9Qz9xs0cs
         2/52qWSB5eHCobQZf2YIeAoiE4cNHu9SHuubyUJsJW1Bgp7T7Vahm/77pcNKjWfiRPAy
         olTw==
X-Gm-Message-State: ALoCoQkVw4On7Utk+1Zf8XX2y2H3UPsPP8YoGQL8N/K431U6f3w8x4soBYGZdIS9WPipRO3XijUl
X-Received: by 10.140.216.213 with SMTP id m204mr53683217qhb.34.1444182662064;
        Tue, 06 Oct 2015 18:51:02 -0700 (PDT)
Received: from ubuntu ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id z196sm15138205qhd.22.2015.10.06.18.51.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Oct 2015 18:51:01 -0700 (PDT)
In-Reply-To: <56129B77.1030409@alum.mit.edu>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279172>

On Mon, 2015-10-05 at 17:47 +0200, Michael Haggerty wrote:
> On 09/29/2015 12:02 AM, David Turner wrote:
> > Add a database backend for refs using LMDB.  This backend runs git
> > for-each-ref about 30% faster than the files backend with fully-packed
> > refs on a repo with ~120k refs.  It's also about 4x faster than using
> > fully-unpacked refs.  In addition, and perhaps more importantly , it
> > avoids case-conflict issues on OS X.
> > 
> > LMDB has a few features that make it suitable for usage in git:
> > 
> > 1. It is relatively lightweight; it requires only one header file, and
> > the library code takes under 64k at runtime.
> > 
> > 2. It is well-tested: it's been used in OpenLDAP for years.
> > 
> > 3. It's very fast.  LMDB's benchmarks show that it is among
> > the fastest key-value stores.
> > 
> > 4. It has a relatively simple concurrency story; readers don't
> > block writers and writers don't block readers.
> 
> It would be great if you would go into more detail about this point in
> the permanent technical documentation
> (Documentation/technical/refs-be-lmdb.txt): how exactly do readers &
> writers interact with each others, and how do writers interact with
> other writers?

I'll add a bit of text on that.

> I think you have said before that if one writer holds the write lock on
> the DB, then other writers fail immediately. Is that correct? If so, is
> that something that can be adjusted? I think it would be preferable for
> the second writer to retry acquiring the write lock for a little while
> with a timeout (as we now do when trying to acquire the packed-refs
> lock). Otherwise you could have the unhappy situation that somebody
> spends a long time pushing a packfile to a server, only to have the
> reference update be rejected at the last moment due to a lock conflict
> with another process that was touching completely different references.
> We already do before/after consistency checks when updating references,
> so you wouldn't even have to add such code in the backend yourself.

No, the second writer waits for the first writer to unlock (or for it to
crash).

> > +Keys for refs are the name of the ref (e.g. refs/heads/master).
> > +Values are the value of the ref
> > +(e.g. 61f23eb0f81357c19fa91e2b8c6f3906c3a8f9b0).
> 
> Please document more unambiguously whether the value is stored as
> 40-char hexadecimal or 20-byte binary.

Will fix.

> Do you store "peeled" reference values for tags, as is done in
> packed-refs? I think that is an important optimization.

No.  Do you happen to know in what situations this is a performance
benefit, so that I can benchmark?  I suspect it would matter much less
for the LMDB backend, because lookups are pretty quick.

> > +All per-worktree refs (refs/bisect/* and HEAD) are store using
> > +the traditional files-based backend.
> > +
> > +Reflogs are stored as a series of database entries.
> > +
> > +For an empty reflog, there is a "header" entry to show that a reflog
> > +exists.
> 
> What key is used for the "header" entry? Does it have a value?

Will fix.

> > +         For non-empty reflogs, there is one entry per logged ref
> > +update.  The key format is logs/[refname]\0[timestamp].  The timestamp
> > +is a 64-bit unsigned integer number of nanoseconds since 1/1/1970.
> > +This means that reflog entries are chronologically ordered.  Because
> > +LMDB is a btree database, we can efficiently iterate over these keys.
> 
> Currently we discard the reflog for a reference when the reference is
> deleted. This is mostly due to a limitation of the filesystem-based
> storage scheme--otherwise the reflog left over from a deleted reference
> could prevent the creation of a reflog for another reference whose name
> overlaps with it (in the sense of is_refname_available()).
> 
> It is a pretty nasty limitation because it is one of the few ways that
> your actions can cause Git to lose data in a way that it is hard to
> recover from.
> 
> Have you thought about removing this limitation in the lbdb backend?

I'm going for feature parity first.  We can always add new functionality
later.  This particular function would be pretty straightforward to add,
I think.

> > +Reflog values are in the same format as the original files-based
> > +reflog.
> > +
> > +Weaknesses:
> > +-----------
> > +
> > +The reflog format is somewhat inefficient: a binary format could store
> > +reflog date/time information in somewhat less space.
> > +
> > +The rsync and file:// transports don't work yet, because they
> > +don't use the refs API.
> 
> Do they fail gracefully?

Not particularly gracefully.

rsync: link_stat "/home/dturner/git/t/trash
directory.t5510-fetch/.git/packed-refs" failed: No such file or
directory (2)
rsync error: some files/attrs were not transferred (see previous errors)
(code 23) at main.c(1183) [sender=3.1.1]
fatal: Could not run rsync to get refs
-------------

The problem is that rsync on the client assumes that packed-refs exists.
We could hack it to also check for refdb.

> > +#ifdef USE_LIBLMDB
> > +			refs_backend_type = refdb_data.refs_backend_type;
> > +			register_refs_backend(&refs_be_lmdb);
> > +			set_refs_backend(refs_backend_type, &refdb_data);
> > +#else
> > +			die("Git was not built with USE_LIBLMDB, so the db refs backend is not available");
> 
> s/db/lmdb/
> 
> I'm somewhat surprised that you only register the lmdb backend if it is
> used in the main repo. I would expect the backend to be registered
> unconditionally on startup. The cost is trivial, isn't it?

Yeah, but this was the easiest place to do it.

> It appears that you recognize "lmdb" but you treat a missing value *or
> any other value* like "files". I think you should be more conservative
> here and die() if you see a backend type that you don't recognize.

Will fix, thanks.

> > diff --git a/contrib/workdir/git-new-workdir b/contrib/workdir/git-new-workdir
> > index 888c34a..9761a1a 100755
> > --- a/contrib/workdir/git-new-workdir
> > +++ b/contrib/workdir/git-new-workdir
> > @@ -28,6 +28,8 @@ git_dir=$(cd "$orig_git" 2>/dev/null &&
> >    git rev-parse --git-dir 2>/dev/null) ||
> >    die "Not a git repository: \"$orig_git\""
> >  
> > +test -d $git_dir/refdb && die "git-new-workdir is incompatible with the refs db backend"
> > +
> 
> It would be safer to check $(git config core.refs-backend-type) to avoid
> depending on an implementation detail of the LMDB backend (and as a bit
> of safety against any backends that might be added in the future).

Will fix, thanks.

> > +static void init_env(MDB_env **env, const char *path)
> > +{
> > +	int ret;
> > +	if (*env)
> > +		return;
> > +
> > +	if ((ret = mdb_env_create(env)) != MDB_SUCCESS)
> > +		die("mdb_env_create failed: %s", mdb_strerror(ret));
> 
> The LMDB docs seem to say that their functions "return a non-zero error
> value on failure and 0 on success". So can we avoid writing MDB_SUCCESS
> everywhere and just compare to zero?

Sure.

> Also, the Git project CodingGuidelines say to avoid assignments in the
> condition of an "if" statement.
> 
> So all in all I think these should be written like
> 
>         ret = mdb_env_create(env);
>         if (ret)
>                 die("mdb_env_create failed: %s", mdb_strerror(ret));

OK.

> > +
> > +int ref_update_cmp(const void *entry, const void *entry_or_key, const void *keydata)
> 
> The usual convention for a "cmp" function is that it returns <0, =0, or
> >0 depending on the relative ordering of its arguments. This one can
> only be used for equality/inequality. Please add a comment warning the
> reader of this (and maybe rename it, e.g., to ref_update_not_equal(), to
> further reduce the chance of confusion).

Will fix.

> > +	if (total_commands_run != last_commands_run) {
> > +		/*
> > +		 * Since each transaction sees a consistent view of
> > +		 * the db, downstream processes that write the db
> > +		 * won't be seen in this transaction.  We don't know
> > +		 * whether any given downstream process has made any
> > +		 * writes, so if there have been any downstream processes,
> > +		 * we had better reopen the transaction.
> > +		 */
> 
> Is it possible to tell from the database whether there has been a write
> since the current read transaction was started? 

Actually, yes.  Fixed.

> It seems like this would
> be a more reliable method, given that an unrelated process might have
> updated references while this command was running, or a long-running
> background process (like Duy's background `git gc --auto`) might still
> continue running even after the original command exits.
> 
> Of course in the end checks like this can never 100% prevent races. The
> only way, it would seem, would be to check-and-set during a single write
> transaction that holds a write lock on the DB.
> 
> That's exactly what we do for file-based references: ideally, the only
> allowed changes are compare-and-set operations that are made atomic by
> holding a lock while it is occurring (one or more loose reference
> lockfiles and/or the packed-refs lockfile). That is why our ref_updates
> have old_sha1 and new_sha1, and old_sha1 is always used for operations
> that start before a lock is held.
> 
> So I guess my question is this: to what extent are you relying on this
> total_commands_run mechanism for correctness, vs. just using it to avoid
> using reference values that are *really* old?

Some tests fail without it, unfortunately.  (I can't remember which ones
now).

> It seems to me that a very important feature of Git is the following:
> 
>     Two processes *must not* block each other (except possibly
>     for a very brief time) if they are updating disjoint sets
>     of references.
>
> With the file-backed reference backend, this feature is accomplished via
> the following mechanisms:
> 
> * Locks are only held for very short periods of time, and never when
>   calling other processes.
> 
> * Locks usually only apply to single references (loose references).
>   Sometimes the packed-refs file has to be locked, but in such cases
>   a second writer retries the lock acquisition for long enough that
>   it should usually succeed.
> 
> * If a reference value was checked before a lock was held, then it
>   is always re-checked after acquiring the lock to make sure that
>   another process didn't change it in the meantime. (If the
>   reference *was* changed from its expected value, it is ok to
>   die().) This is necessary to preserve safety even if a lock is
>   not held for the duration of a command.
> 
> In particular, locks are only held for the duration of the call to
> ref_transaction_commit(), *not* while building up a transaction using
> ref_transaction_update() etc.
> 
> I am afraid that the LMDB backend as currently implemented will be more
> subject to locking conflicts because the LMDB locks are broader in both
> time and space:
> 
> 1. You are holding the LMDB transaction open for longer (during the
>    whole time that the ref_transaction is being built up). This is
>    worse simply because it is a longer time. But it is also worse
>    because the process that is building up the transaction might be
>    doing other things while holding the write lock. Have you checked
>    whether any callers do things that could change references (for
>    example, invoke user hooks) between the calls to
>    ref_transaction_begin() and ref_transaction_commit()? With the
>    files backend this isn't an issue because the lock isn't acquired
>    until ref_transaction_commit() is called.
> 
> 2. The LMDB write lock is database-wide. This means that a single
>    writer, even if modifying only a single reference, blocks all
>    writes to all references.
> 
> Therefore I am worried that the LMDB backend will be susceptable to more
> lock conflicts than the files backend.
> 
> [What] would be the disadvantage of letting ref_transaction_update() and
> its friends build up `struct ref_update` objects in memory (much like
> they do in the files backend), and only start the LMDB write transaction
> when ref_transaction_commit() is called? Obviously it would cost some
> more bookkeeping, but that code is already written. This would be much
> closer to the files backend model.
> 
> This is where I stopped for the day.

I think you have convinced me to switch over to this method.  Unless
something weird comes up while I'm doing the switch, in which case I'll
send email.

> I have a bunch of small stylistic and formatting suggestions regarding
> this patch in particular. Rather than describe them all in prose, I just
> made the suggested changes and pushed them to my GitHub fork [1], branch
> "refs-be-lmdb-housecleaning". Feel free to squash the ones you want into
> this commit.

I took them all.  THanks.

> A lot of these problems were found by gcc, which I apparently have
> configured more strictly than yours. You might want to pick some options
> from my config.mak [2] to make gcc enforce some of the Git project
> policies automatically. (Every dev on this list probably has his/her own
> variation on this file.)

I've adopted yours, thanks.

> I apologize again for not having reviewed your patches more promptly. I
> really think it is good and important work. I've just been so busy with
> other things and I knew it would take a couple of solid days of work to
> get through it. I'll try to review the rest tomorrow, but since I don't
> know anything about the LMDB API, the review will either be superficial
> or it will take a long time...

Thanks for the hard work here.  I know this is a big chunk of code to
review, and I'm grateful for the thoughts.
