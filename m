From: linux@horizon.com
Subject: Re: git-name-rev off-by-one bug
Date: 29 Nov 2005 16:40:55 -0500
Message-ID: <20051129214055.8689.qmail@science.horizon.com>
References: <20051129103157.GW22159@pasky.or.cz>
Cc: git@vger.kernel.org, linux@horizon.com
X-From: git-owner@vger.kernel.org Tue Nov 29 22:44:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhDDo-0007ke-8D
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 22:41:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbVK2VlF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 16:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbVK2VlF
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 16:41:05 -0500
Received: from science.horizon.com ([192.35.100.1]:13126 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S932418AbVK2VlC
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2005 16:41:02 -0500
Received: (qmail 8690 invoked by uid 1000); 29 Nov 2005 16:40:55 -0500
To: junkio@cox.net, pasky@suse.cz
In-Reply-To: <20051129103157.GW22159@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12956>

I'm feeling slightly guilty about eliciting such a flood of help, but I'm
certainly leraning a lot.  But there's one statement that, while I'm not
doubting it's accuracy, seems at odds with the mental model I'm building.
I must be misunderstanding something.

junkio wrote:
>> Okay, so git-update-index will overwrite a staged file with a
>> fresh stage-0 copy.  And git-commit will refuse to commit
>> (to be precise, it'll stop at the git-write-tree stage) if there
>> are unresolved conflicts.
>
> Sorry, I was unclear that I was talking about end-user level
> tool.  The update-index here is not about the conflict
> resolution in the index file read-tree documentation talks
> about.  That has already been done when "merge" ran in the
> conflicting case.  In the conflicting case, the working tree
> holds 3-way merge conflicting result, and the index holds HEAD
> version at stage0 for such a path.  Hand resolving after
> update-index is to record what you eventually want to commit
> (i.e. you are not replacing higher stage entry in the index with
> stage0 entry -- you are replacing stage0 entry with another).
> 
>> If you want to see the unmodified input files, you can find their
>> IDs with "git-ls-files -u" and then get a copy with "git-cat-file blob"
>> or "git-unpack-file".  git-merge-index is basically a different way to
>> process the output of git-ls-files -u.
>
> Yes, in principle.  But in practice you usually do not use these
> low level tools yourself.  When git-merge returns with
> conflicting paths, most of them have already been collapsed into
> stage0 and git-ls-files --unmerged would not show.  The only
> case I know of that you may still see higher stage entries in
> the index these days is merging paths with different mode bits.
> We used to leave higher stage entries when both sides added new
> file at the same path, but even that we show as merge from
> common these days.

And pasky reiterated:
>   From the user POV, the main difference between Cogito and GIT merging
> is that:
>
>  (i) Cogito tries to never leave the index "dirty" (i.e. containing
> unmerged entries), and instead all conflicts should propagate to the
> working tree, so that the user can resolve them without any further
> special tools. (What is lacking here is that Cogito won't proofcheck
> that you really resolved them all during a commit. That's a big TODO.
> But core GIT won't you warn about committing the classical << >> ==
> conflicts either.)

This seems odd to me.  There's an alternate implementation that
I described that makes a lot more sense to me, based on my current
state of knowledge.  Can someone explain why my idea is silly?


I'd imagine you'd consider user editing to be a last-resort merge
algorithm, but treat it like the other merges, and leave the file
staged while it's in progress.

Either git-checkout-index or something similar would "check out"
the staged file with CVS-style merge markers.  And an eventual
git-update-index would replace the staged file with a stage-0,
just like git-merge-one-file does automatically.

"git-diff" could default to diffing against the stage-2 file to
produce the same reults as now, but you could also have an
option to diff against a different stage, which might be useful.

(This is another reason for my earlier comment that I don't think
the distinction between stage-0 and stage-2 is actually necessary.)

And git-write-tree would naturally stop you from committing with
unresolved conflicts.  You could still commit the conflict
markers, but it would be a two-step process.

You'd have the simple principle that all merges start with git-read-tree
producing a staged file, and end with git-update-index collapsing
them when it's been resolved.  (Or something like git-reset throwing
everything away.)


Having said all this, there's presumably a good reason why this is a
bad idea.  Could someone enlighten me?

Thanks!
