From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2 38/43] refs: make some files backend functions public
Date: Wed, 07 Oct 2015 16:55:11 -0400
Organization: Twitter
Message-ID: <1444251311.8836.22.camel@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
		 <1443477738-32023-39-git-send-email-dturner@twopensource.com>
		 <56123CE3.9070909@alum.mit.edu>
	 <1444181145.7739.70.camel@twopensource.com> <56154194.9050607@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 07 22:55:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjvkD-0002LS-65
	for gcvg-git-2@plane.gmane.org; Wed, 07 Oct 2015 22:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006AbbJGUzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2015 16:55:16 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:33882 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753858AbbJGUzO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2015 16:55:14 -0400
Received: by qkdo1 with SMTP id o1so2094505qkd.1
        for <git@vger.kernel.org>; Wed, 07 Oct 2015 13:55:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=/RX/y6zkz+dDbuVRcsjtk4fH5LD4D7yYulQNi1Y71bE=;
        b=KSebSfNiI2MBVHSJReRP54n16cP8rADtlzuMH8l4HTW4fYqZvy7LG5Gym7TMJYBw/s
         XQAlUEXfR/kuLesCW5wR1shvdVqC1J6/EECldMBIaDnS4dZAufzizqfY7Y6SzTz1wQXy
         sHO+2ZZUg0z4slfJ9K/ho9J0QIKviSMgOBJXAS1B7lEeXYDQrGSMGvdQ/Fp3iNcmpArC
         SJDrpRJOSRpkOQ9ZlcaWAEQ6bm1KC5DgzCWcRE5qim38E421J9BF4k7LO2PE6pB2/VbV
         WtsapY1fvR7Hr4pJeuRgbpfbTdO2o6Lt3xqKOrM5Otu6gHbxl91IL9FzjiUSmvYhKbTg
         lK5A==
X-Gm-Message-State: ALoCoQn5SKPow/tBcxzvxN+O6XN6bhGODe/FFiWWRy0P9+vsGgyEQVmxtVm1OffTBBL/L48ka4Yi
X-Received: by 10.55.203.144 with SMTP id u16mr3923490qkl.36.1444251313893;
        Wed, 07 Oct 2015 13:55:13 -0700 (PDT)
Received: from ubuntu ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id h49sm17036941qgd.45.2015.10.07.13.55.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Oct 2015 13:55:12 -0700 (PDT)
In-Reply-To: <56154194.9050607@alum.mit.edu>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279197>

On Wed, 2015-10-07 at 18:00 +0200, Michael Haggerty wrote:
> On 10/07/2015 03:25 AM, David Turner wrote:
> > On Mon, 2015-10-05 at 11:03 +0200, Michael Haggerty wrote:
> >> On 09/29/2015 12:02 AM, David Turner wrote:
> >>> Because HEAD and stash are per-worktree, other backends need to
> >>> go through the files backend to manage these refs and their reflogs.
> >>>
> >>> To enable this, we make some files backend functions public.
> >>
> >> I have a bad feeling about this change.
> >>
> >> Naively I would expect a reference backend that cannot handle its own
> >> (e.g.) stash to instantiate internally a files backend object and to
> >> delegate stash-related calls to that object. That way neither class's
> >> interface has to be changed.
> >>
> >> Here you are adding a separate interface to the files backend. That
> >> seems like a more complicated and less flexible design. But I'm open to
> >> be persuaded otherwise...
> > 
> > After some thought, here's a summary of the problem:
> > 
> > Some writes are cross-backend writes.  For example, if HEAD is symref to
> > refs/head/master, a commit is a cross-backend write (HEAD itself is not
> > updated, but its reflog is).  Ronnie's design of the ref backend
> > structure did not account for cross-backend writes, because we didn't
> > have per-worktree refs at the time (there was only HEAD, and there was
> > only one copy of it).
> > 
> > Cross-backend writes are complicated because there is no way to tell a
> > backend to do only part of a ref update -- for instance, to tell the
> > files backend to update HEAD and HEAD's reflog but not
> > refs/heads/master.  Maybe we could set a flag that would do this, but
> > the synchronization would be fairly complicated.  For instance, an
> > update to HEAD might need to confirm the old sha for HEAD, meaning that
> > we couldn't do the db write first.  But if we move the db write second,
> > then when the db code goes to do its check of the HEAD sha, it might see
> > a new value.  Perhaps there's a way to make it work, but it seems
> > fragile/complex.
> > 
> > Right now, for cross-backend reads/writes, the lmdb code cheats. It
> > simply does the write directly and immediately.  This means that these
> > portions of transactions cannot be rolled back.  That's clearly bad. 
> 
> That's a really good point.
> 
> I hate to break it to you, but the handling of symrefs in Git is already
> a mess. HEAD is the only symref that I would really trust to work
> correctly all the time. So I think that changes needn't be judged on
> whether they handle symrefs perfectly. They should just not break them
> in any dramatic new ways.
> 
> So, you pointed out the problem that HEAD (a per-worktree reference) can
> be a symref that points at a shared reference. In fact, I think when
> HEAD is symbolic it is only allowed to point at a branch under
> refs/heads, so this particular problem is pretty well-constrained.
> 
> Are there other cases of cross-backend writes? I suppose there could be
> a symref elsewhere among the per-worktree references that points at a
> shared reference. But I can't think of any cases where this is done by
> standard Git. Not that it is forbidden; I just don't think it is done by
> any of the standard tools.

Another case would be an update-ref command that updates both
refs/bisect/something and refs/heads/something.  

I don't think git ever does this by default, but anyone can issue a
weird update-ref command if they feel like it.

> Or there could be a symref among the shared references that points at a
> per-worktree reference. But AFAIK the only other symrefs that are in
> common use are the refs/remotes/*/HEAD symrefs, and they always point at
> references within the same (shared) namespace.
> 
> If everything that I've said is correct, then my opinion is that it
> would be perfectly adequate if your code would handle the specific case
> of HEAD (by hook or by crook), and if there are any other cross-backend
> symrefs, just die with a message stating that such usage is unsupported.
> Junio, do you think that would be acceptable?

Hm.  I don't think it's significantly  easier to handle just HEAD than
it would be to handle all cases.  But I'll see what happens as I write
the code.

> > The simplest solution would be for the lmdb code to simply acquire
> > locks, and write to lock files, and then commit those lock files just
> > before the db transaction commits. Then the lmdb code would handle all
> > of the orchestration without the files backend having to be rewritten to
> > handle this case.
> 
> Wouldn't that essentially be re-implementing the files backend? I must
> be missing something.

There would be some amount of reimplementation, yes.  But if we assume
that the number of per-worktree refs is relatively small, we could make
some simplification.  But actually, see below.

> > [...]
> 
> BTW I just realized that if one backend should delegate to another, then
> the primary backend should be the per-worktree backend and it should
> delegate to the common backend. I think I described things the other way
> around in my earlier message. This makes more sense because it is
> acceptable for per-worktree references to refer to common references but
> not vice versa.

I think I might have a good way to deal with this:

If we're going to switch the lmdb transaction code over to accumulate
updates and then do them as one batch, then probably all other
backends will work the same way.  So maybe there is no need for all of
these backend functions:

	ref_transaction_begin_fn *transaction_begin;
	ref_transaction_update_fn *transaction_update;
	ref_transaction_create_fn *transaction_create;
	ref_transaction_delete_fn *transaction_delete;
	ref_transaction_verify_fn *transaction_verify;

Instead, the generic refs code will accumulate updates in a struct
ref_update.  Instead of a lock, the ref_update struct will have a void
pointer that backends can use for per-update data (such as the lock).
The generic code can also handle rejecting duplicate ref updates.

The per-backend transaction_commit method will just take a struct
ref_transaction (that is, what the current patchset calls a
files_ref_transaction) -- basically, a list of ref_updates -- and
attempt to apply it.

While we're doing this, the generic ref code can detect an update to
HEAD, and replace it with an update to whatever HEAD points to (if HEAD
is a symref).  Then it can call files_log_ref_write to write to HEAD's
reflog, if the main transaction commits successfully.  If HEAD is not a
symref, the generic code can just move the HEAD update over to the files
backend.

Does this make sense?
