From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH] clone: introduce clone.submoduleGitDir to relocate $GITDIR
Date: Mon, 15 Apr 2013 17:05:05 +0530
Message-ID: <CALkWK0n_vOwQkJ6BMXdE06cUJhiJdWNYq3vPDDOZHvji6FyKow@mail.gmail.com>
References: <1365881007-25731-1-git-send-email-artagnon@gmail.com>
 <7vy5ck4m6b.fsf@alter.siamese.dyndns.org> <7v61zo4igg.fsf@alter.siamese.dyndns.org>
 <CALkWK0m-X7K=WXFiiMkqZBBTBB9KC6myeN+s_xYLXfadGJCdZQ@mail.gmail.com> <7v61zo14p8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 13:35:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URhhO-000555-UJ
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 13:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471Ab3DOLfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 07:35:47 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:45922 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317Ab3DOLfq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 07:35:46 -0400
Received: by mail-ie0-f180.google.com with SMTP id a11so5548523iee.39
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 04:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=GJfionTytHEwH06/U23XFUCDMBZd6xCFeYxAy9svs4I=;
        b=vgAGIl9MkeaENHZxdXYYAiaFG+9g+A7q28wAaJm1CvD0G34DA5HVzQETugR4DW/zGw
         6F9QmkfeoKEE2XI9GnlqQk9UzCNoXo+6+SFQ4KzGuENyVeZbgwec6Xgj1aw5LZ2hkVYt
         yC1Qfr0scm4q8bcamoqoFVrsDJ+lyu22uZu9H508ULU9IZDjhk4uVGPN2YQM5DdsZ4Fi
         LwZcT7hAgjONqzpScrzxzot26uOPTigRJifjRo1DpuQ0ah7MXhEDIXU/4QKCIoRpm1rx
         OQd6BJUGOUdjTxLQRsbP/o2UprJ8XZcn6Q36FRJskQvMQx7l0/NEK7mBF5Lgq9RhqC4A
         WYiw==
X-Received: by 10.50.108.235 with SMTP id hn11mr4847971igb.107.1366025745586;
 Mon, 15 Apr 2013 04:35:45 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Mon, 15 Apr 2013 04:35:05 -0700 (PDT)
In-Reply-To: <7v61zo14p8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221222>

Junio C Hamano wrote:
> When we discuss "git add", the "one unit of work" is at much higher
> level than that of "git update-index".  "git add dir/" has to do a
> lot more than "git add file", and "git add symlink" has to do quite
> a different thing from "git add file", but to the end user, all of
> them are about doing everything necessary to add what the user named
> to the index. "git add submodule/" that does whatever necessary to
> add the submodule to the index is still doing one thing well inside
> the same framework, and that may include moving the $GIT_DIR and
> turning it into a gitfile.

You're looking at it from an end-user point of view, while I'm looking
at it from the implementation point of view.  Here's a coarse
simplification of what git add does:

1. Lock the index file, and grab a FILE handle to read/ write the file.

2. Update active_cache.  Depending on the pathspec, we might be adding
one entry or multiple entries, with different modes to the index.
Nowhere did I say that it should add exactly one entry to active_cache
with a predefined mode.  Sure, tools that operate a lower layer of
abstraction like update-index can be more picky about this.

3. Write tree and blob objects to the database corresponding to the
worktree entries.  Files and symbolic links get blob objects, while
directories get tree objects.

4. Write active_cache to FILE handler we grabbed in step 1, and
release the lock.

What it does not do:

1. Move random files/ directory around in the worktree.

2. Mangle existing files in the worktree. (Although I know that the
.gitmodules-mangling is coming soon, I'm not exactly elated with it
[1])

3. Write commit or tag objects to the database.

4. Update random refs.

5. Make coffee for the user to applaud him on the successful add.

In my opinion, with some minor exceptions, all git tools follow these
principles.  Briefly, branch is a refs/heads/* helper, checkout is a
HEAD + worktree helper, fetch is a receive-pack + refs/remotes/*
helper, and reset is a bit of a swiss army knife that operates on HEAD
+ index + worktree.

In general, I like git because commands don't create unnatural or
heavy abstractions on top of these concepts.  With some minor
exceptions, all the commands are easy to understand and consistent.

[1]: This is what led to my OBJ_LINK proposal.

> Not that I am saying I prefer "add --url=xxx". Quite the opposite.
> I very much prefer the "clone and then add, but clone drops the
> repository at the right place from the beginning" approach than "add
> that knows about URL only for submodules", which is an ugly kludge.

I don't know why you brought up the alternative in the first place.
We both agree that it is git clone's job, although your reason is more
superficial and mine's tied to the implementation.

> If the user creates here/.git without gitlink with whatever means,
> it is "git add here"'s job, if it wants to make it a submodule and
> if it wants to make it possible to later check out another branch
> that does not have the submodule, to stash away the repository and
> turn it into gitfile, if it is part of what is needed to add a
> submodule.

I disagree.  I think we should get a first-class tool to attach/
detach worktrees from a GITDIR.  It can incoporate the logic from
contrib/workdir/git-new-workdir to optionally create a worktree with
an independent index, HEAD, and logs/HEAD.

> Of course, we could start from teaching "submodule add" to do so,
> and then internally redirect "git add subm" to "git submodule add",
> but that is a minor implementation detail that does not affect the
> end user experience.

Yuck.  Don't you care about the implementation, as long as it fixes
the end-user's problem?
