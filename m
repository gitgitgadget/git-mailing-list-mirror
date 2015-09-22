From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 1/4] worktree: add top-level worktree.c
Date: Tue, 22 Sep 2015 10:16:31 -0700
Message-ID: <xmqqr3lq4bo0.fsf@gitster.mtv.corp.google.com>
References: <1442583027-47653-1-git-send-email-rappazzo@gmail.com>
	<1442583027-47653-2-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: sunshine@sunshineco.com, dturner@twopensource.com,
	git@vger.kernel.org
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 19:16:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeRBG-0002s4-R1
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 19:16:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758299AbbIVRQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 13:16:34 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36598 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758027AbbIVRQd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 13:16:33 -0400
Received: by pacgz1 with SMTP id gz1so11837648pac.3
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 10:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=vuNtw196MkQbjWTd/O59lUGtCX7POnHN1r0a59U1c0k=;
        b=thEWY1Dm+8UZo70IZknaUhj4tBfxZ/H9+u2Ovcvt1M7KmGbVgIhUbV/puVDg62s88A
         +hLigBZzzphmzZY9GcQXw1e2FSvYBb8gKAqoRgQIwuWMMLLXi2rbHBq/yiUSxEbY9H4N
         BDfuKJBTJK3GFbEDOAFRTJDkuuKfU/t4ALYk09O/Fqm9doGWGCmkwvSovlzW1cN3qpsW
         3PpULsWjeCBXIXweFgEJ62ToBANk9aHmRJXtHxKvMDAzcJlrFOHezKOBZ80GfCx5pscK
         rw7Y6rvqQi/khXyMy4r3igZw/GtE2aa66RxS4Ya6HB1diuTvKG1DHPLQDuMAEqnE4Lsd
         21vw==
X-Received: by 10.66.229.67 with SMTP id so3mr32495612pac.66.1442942193345;
        Tue, 22 Sep 2015 10:16:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:fd7e:7071:2eda:9c63])
        by smtp.gmail.com with ESMTPSA id e6sm3339427pas.35.2015.09.22.10.16.32
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 22 Sep 2015 10:16:32 -0700 (PDT)
In-Reply-To: <1442583027-47653-2-git-send-email-rappazzo@gmail.com> (Michael
	Rappazzo's message of "Fri, 18 Sep 2015 09:30:24 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278403>

Michael Rappazzo <rappazzo@gmail.com> writes:

> worktree.c contains functions to work with and get information from
> worktrees.  This introduction moves functions related to worktrees
> from branch.c into worktree.c
>
> Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
> ---
>  Makefile        |  1 +
>  branch.c        | 79 +-----------------------------------------------------
>  branch.h        |  8 ------
>  builtin/notes.c |  1 +
>  worktree.c      | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  worktree.h      | 12 +++++++++
>  6 files changed, 97 insertions(+), 86 deletions(-)
>  create mode 100644 worktree.c
>  create mode 100644 worktree.h
> ...
> diff --git a/branch.h b/branch.h
> index d3446ed..58aa45f 100644
> --- a/branch.h
> +++ b/branch.h
> @@ -59,12 +59,4 @@ extern int read_branch_desc(struct strbuf *, const char *branch_name);
>   */
>  extern void die_if_checked_out(const char *branch);
>  
> -/*
> - * Check if a per-worktree symref points to a ref in the main worktree
> - * or any linked worktree, and return the path to the exising worktree
> - * if it is.  Returns NULL if there is no existing ref.  The caller is
> - * responsible for freeing the returned path.
> - */
> -extern char *find_shared_symref(const char *symref, const char *target);
> -
>  #endif
> diff --git a/builtin/notes.c b/builtin/notes.c
> index 3608c64..8b30334 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -20,6 +20,7 @@
>  #include "notes-merge.h"
>  #include "notes-utils.h"
>  #include "branch.h"
> +#include "worktree.h"

I think you no longer need to include branch.h after this change.

Other than that, this step looks uncontroversial.

Thanks.
