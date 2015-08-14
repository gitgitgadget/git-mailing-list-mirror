From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/4] path: optimize common dir checking
Date: Fri, 14 Aug 2015 13:27:17 -0700
Message-ID: <xmqq1tf5ipju.fsf@gitster.dls.corp.google.com>
References: <1439416645-19173-1-git-send-email-dturner@twopensource.com>
	<1439416645-19173-2-git-send-email-dturner@twopensource.com>
	<55CC5DED.5050304@alum.mit.edu>
	<xmqqtws1iyxn.fsf@gitster.dls.corp.google.com>
	<1439582644.8855.89.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	chriscool@tuxfamily.org, pclouds@gmail.com
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 22:32:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQLZU-00024c-9c
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 22:27:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150AbbHNU1U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 16:27:20 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33508 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143AbbHNU1T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 16:27:19 -0400
Received: by pabyb7 with SMTP id yb7so66221469pab.0
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 13:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=8Hk1MxnNYkSCUt/J9pKXcLW3nRqWmbbxYmMYpltJt+I=;
        b=AvDR4e07QlkJp31qwzri5r21hnTIVKFLkDaoEGPEQGSbHDa6y4mTDsGmD2iEKHWwDT
         sN6iOTvD5oFrlWjPxgBTfcG+tEHpmTRmai+YYa8May/ogWH9dcazgc1HCUo3mCswRBCc
         xgdqidZC+up4sqrimTCEV74iU8AreLAVCfbge6W3X+mcTdumtFzyUhYiZJ+Pz/A0kVfL
         w3sO3biMol8zie2eN5NK3nGeWi6bSAWomB7ZmIHuX31alUO4ZNfGFt0Okkv0Mr0ncEsy
         tOeraCWgdWd9GyDsWGm05P5E1MhM/nnFk1YLbfb82vYmMGqNeLzvzG9JJD0i8bgsrJQQ
         1tMg==
X-Received: by 10.68.192.9 with SMTP id hc9mr73941543pbc.57.1439584038748;
        Fri, 14 Aug 2015 13:27:18 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a820:aa0d:2b52:954f])
        by smtp.gmail.com with ESMTPSA id fy3sm7020808pac.37.2015.08.14.13.27.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 14 Aug 2015 13:27:18 -0700 (PDT)
In-Reply-To: <1439582644.8855.89.camel@twopensource.com> (David Turner's
	message of "Fri, 14 Aug 2015 16:04:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275939>

David Turner <dturner@twopensource.com> writes:

> Random side note: the present workspace path name component is not
> acceptable for this if alternate ref backends use a single db for
> storage across all workspaces.  That's because you might create a
> workspace at foo, then manually rm -r it, and then create a new one also
> named foo.  The database wouldn't know about this series of events, and
> would then have stale per-workspace refs for foo.

The users can do "Create, manuallly rm -r and recreate" dance all
they want, but the result must still honor the invariant:

    For any $workspace, $workspace/.git is a "gitdir:" file that
    points at one subdirectory in $GIT_COMMON_DIR/worktrees/.

The "name" I had in mind was the names of the directories in
$GIT_COMMON_DIR/worktrees/ that by definition has to be unique.

Another invariant 

    $GIT_COMMON_DIR/worktrees/$that_subdirectory has commondir file
    that points at the $GIT_COMMON_DIR/.

must also be preserved by "Create, manuallly rm -r and recreate"
dance, but it is not important to define what the workspace ID is.

> That said, with my lmdb backend, I've been falling back to the files
> backend for per-workspace refs.

I think that is perfectly fine and within the 3-bullet design
guideline we saw earlier.  Your backend is honoring the decision
made by the system as a whole what is private and what is shared,
which is the only thing that counts in the larger picture.  It is up
to individual ref-backend implementations how they do so, and it is
perfectly fine that your backend takes advantage of the ref layout
by storing some stuff in lmdb storage (which I presume will live in
"common" part of the filesystem storage) and some other stuff
directly in the filesystem.

> There is one case where the refs code will probably need to directly
> call git_workspace_path: when we fix git prune to handle detached HEADs
> in workspaces.  It could just set the workspace and then call git_path,
> but that is less elegant.  So I think when we fix that (which should
> probably wait on for_each_worktree), we can implement Junio's proposal.

Yeah, I said *three* helper functions, but we do need the "enumerate
all workspaces" if we want to go that route, and we do need to
expose Michael's common_path() and workspace_path() to the code that
needs such an enumeration.
