From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v3 2/4] path: optimize common dir checking
Date: Fri, 14 Aug 2015 16:04:04 -0400
Organization: Twitter
Message-ID: <1439582644.8855.89.camel@twopensource.com>
References: <1439416645-19173-1-git-send-email-dturner@twopensource.com>
	 <1439416645-19173-2-git-send-email-dturner@twopensource.com>
	 <55CC5DED.5050304@alum.mit.edu>
	 <xmqqtws1iyxn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	chriscool@tuxfamily.org, pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 22:04:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQLD6-0006vJ-5I
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 22:04:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073AbbHNUEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 16:04:11 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:34002 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752061AbbHNUEI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 16:04:08 -0400
Received: by qgeg42 with SMTP id g42so59220369qge.1
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 13:04:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=qHPQr2dqSrLVksMFaK9KBZGqRZOLgF7aIX1J35IDgEU=;
        b=cVSKBhlD/PVDhpCRr79uutvGh91cdhLYDSzudllspxQ6xy1eJ9UmTabVJZom0iOzEd
         G0unZ15s/N4ueNYHLK6jhVg2bXaFG9UnHvSwL1bzq21ewoeE6WcF3U6vH5jEprQe7ydq
         DQG3WLOtBEeAO1i4kjOXM4JEv2Ns2qs4muNSeP88JaUev4NCks05cZBWL0RDCUg4+TTw
         I9qYmqlqimgOHTzlKKtg6AVvUear6qst2lJREP38XoFO7TV352Crecy22MmCSMEA+Bme
         zYpIYSYnPHGOarm0kJGOdzXVoRU3joaAaLsbtZ6cm74npngUxdy/MX506pdnahk8w2XC
         ZgQA==
X-Gm-Message-State: ALoCoQlcx6l1ta3kVTefAb0zfLETDBnbn6lNbwJjSBHPt9kWXJdqk0J9F/dp4NvzZ6wQ5s+nxxMd
X-Received: by 10.140.16.161 with SMTP id 30mr51110147qgb.95.1439582647029;
        Fri, 14 Aug 2015 13:04:07 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id 16sm3598416qhg.32.2015.08.14.13.04.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Aug 2015 13:04:06 -0700 (PDT)
In-Reply-To: <xmqqtws1iyxn.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275934>

On Fri, 2015-08-14 at 10:04 -0700, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
> > Let's take a step back.
> >
> > We have always had a ton of code that uses `git_path()` and friends to
> > convert abstract things into filesystem paths. Let's take the
> > reference-handling code as an example:
> > ...
> > This seems crazy to me. It is the *reference* code that should know
> > whether a particular reference should be stored under `$GIT_DIR` or
> > `$GIT_COMMON_DIR`, or indeed whether it should be stored in a database.
> 
> It is more like:
> 
>  1. The system as a whole should decide if HEAD and refs/heads/
>     should be per workspace or shared across a repository (and we say
>     the former should be per workspace, the latter should be shared).
> 
>  2. The reference code should decide which ref-backend is used to
>     store refs.
> 
>  3. And any ref-backend should follow the decision made by the
>     system as a whole in 1.
> 
> I'd imagine that David's ref-backend code inherited from Ronnie
> would still accept the string "refs/heads/master" from the rest of
> the system (i.e. callers that call into the ref API) to mean "the
> ref that represents the 'master' branch", and uses that as the key
> to decide "ok, that is shared across workspaces" to honor the
> system-wide decision made in 1.  The outside callers wouldn't pass
> the result of calling git_path("refs/heads/master") into the ref
> API, which may expand to "$somewhere_else/refs/heads/master" when
> run in a secondary workspace to point at the common location.
> 
> I'd also imagine that the workspace API would give ways for the
> implementation of the reference API to ask these questions:
> 
>  - which workspace am I operating for?  where is the "common" thing?
>    how would I identify this workspace among the ones that share the
>    same "common" thing?
> 
>  - is this ref (or ref-like thing) supposed to be in common or per
>    workspace?
> 
> I agree with you that there needs an intermediate level, between
> what Duy and David's git_path() does (i.e. which gives the final
> result of deciding where in the filesystem the thing should go) and
> your two stupid functions would do (i.e. knowing which kind the
> thing is, give you the final location in the filesystem).  That is,
> to let the caller know if the thing is supposed to be shared or per
> workspace in the first place.
> 
> With that intermediate level function, a database-based ref-backend
> could make ('common', ref/heads/master) as the key for the current
> value of the master branch and (workspace-name, HEAD) as the key for
> the current value of the HEAD for a given workspace.
> 
> > We should have two *stupid* functions, `git_workspace_path()` and
> > `git_common_path()`, and have the *callers* decide which one to call.
> 
> So I think we should have *three* functions:
> 
>  - git_workspace_name(void) returns some name that uniquely
>    identifies the current workspace among the workspaces linked to
>    the same repository.

Random side note: the present workspace path name component is not
acceptable for this if alternate ref backends use a single db for
storage across all workspaces.  That's because you might create a
workspace at foo, then manually rm -r it, and then create a new one also
named foo.  The database wouldn't know about this series of events, and
would then have stale per-workspace refs for foo.

That said, with my lmdb backend, I've been falling back to the files
backend for per-workspace refs.  This also means I don't have to worry
about expiring per-workspace refs when a workspace is removed. 

I could change this, but IIRC, there are a fair number of things that
care about the existence of a file called HEAD, so the fallback was
easier.  (That is, the other way was a giant hassle).

>  - is_common_thing(const char *) takes a path (that is relative to
>    $GIT_DIR where the thing would have lived at in a pre-workspace
>    world), and tells if it is a common thing or a per-workspace
>    thing.
> 
>  - git_path() can stay the external interface and can be thought of:
> 
> 	git_path(const char *path)
>         {
> 		if (is_common_thing(path))
> 			return git_common_path(path);
> 		return git_workspace_path(git_workspace_name(), path);
> 	}
> 
>    if you think in terms of your two helpers.
> 
> But I do not think that git_common_path() and git_workspace_path()
> need to be called from any other place in the system, and that is
> the reason why I did not say we should have four functions (or five,
> counting git_path() itself).

I wrote an email arguing for Michael's position on this, and by the time
I was done writing it, I had come around to more-or-less Junio's
position.

My argument for keeping git_path as the external interface is this: in
the multiple worktree world, $GIT_DIR is effectively an overlay
filesystem.  It's not a complete overlay API: e.g. we don't have a
git_path_opendir function that special-cases refs/ to add in
refs/worktree.  But it handles the common cases.

It is true that even if we had a complete overlay API, it would not be
sufficient to hide all of the complexity of per-worktree refs (the files
ref backend still needs to know not to pack per-worktree refs).  But
that is equally true if we have the refs code call
git_common_path/git_worktree_path.  So we're not successfully hiding
details by using git_common_path/git_worktree_path in refs.c.

For this patch series, I don't think we need to change anything (except
that I realized that I forgot to add logs/refs/worktree to refs, and
people will probably find some issues once they start reviewing the
details of my code). In the present code, adjust_git_path already
handles the git_common_path vs git_workspace_path thing; it just does it
in a slightly less elegant way than Junio's proposal.  Implementing
Junio's proposal would not affect this series; it would just be an
additional patch on top (or beforehand).

There is one case where the refs code will probably need to directly
call git_workspace_path: when we fix git prune to handle detached HEADs
in workspaces.  It could just set the workspace and then call git_path,
but that is less elegant.  So I think when we fix that (which should
probably wait on for_each_worktree), we can implement Junio's proposal.
