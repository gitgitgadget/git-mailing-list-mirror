From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 2/3] worktree: move/refactor find_shared_symref from branch.c
Date: Fri, 11 Sep 2015 09:16:07 -0700
Message-ID: <xmqqk2rx0w54.fsf@gitster.mtv.corp.google.com>
References: <1441402769-35897-1-git-send-email-rappazzo@gmail.com>
	<1441402769-35897-3-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: sunshine@sunshineco.com, dturner@twopensource.com,
	git@vger.kernel.org
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 18:21:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaQzn-0006cz-40
	for gcvg-git-2@plane.gmane.org; Fri, 11 Sep 2015 18:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbbIKQQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2015 12:16:10 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35468 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617AbbIKQQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2015 12:16:09 -0400
Received: by pacfv12 with SMTP id fv12so80285949pac.2
        for <git@vger.kernel.org>; Fri, 11 Sep 2015 09:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=GurgJ/jiQvJsweRKVWXLM8NxuHk9ScacEqI6EipYKhg=;
        b=x/bXXzU6b2x/Ooz3p14cbWyKFTdmNzYA9/cMJc1tvIRz/bSkw9kHPhruVvqiahn4Im
         pqrgFeTBGFBUG4idxtnMmp3x53aB4idHNvHSAMSFgwpG/r/4ESa8PJkTKeba3p7OtPJH
         c6cPivBiJAjNg/Sxx/yjML/kUzSWeLYearX74Q/Avh0ZxLMnKm6741wkeqlpAnnwfCwY
         38usogM5tbvwJlKBQHP6T7p0nuMLTB6zNrEkGj6pTK7z7AA/X/x6dHqbLdn6HQZZK4nT
         DoqyVAYN8yyi0DpACUAKY+vpRUNkcTL1w87TuWbCYt4ax+JnfZdlorRvzVxgMTWew1BC
         CtoA==
X-Received: by 10.68.241.103 with SMTP id wh7mr96994964pbc.88.1441988168843;
        Fri, 11 Sep 2015 09:16:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7504:ea92:c75a:a933])
        by smtp.gmail.com with ESMTPSA id ns3sm1166311pbc.77.2015.09.11.09.16.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 11 Sep 2015 09:16:08 -0700 (PDT)
In-Reply-To: <1441402769-35897-3-git-send-email-rappazzo@gmail.com> (Michael
	Rappazzo's message of "Fri, 4 Sep 2015 17:39:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277677>

Michael Rappazzo <rappazzo@gmail.com> writes:

> The code formerly in branch.c was largely the basis of the
> get_worktree_list implementation is now moved to worktree.c,
> and the find_shared_symref implementation has been refactored
> to use get_worktree_list
>
> Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
> ---




>  branch.c        | 79 +--------------------------------------------------------
>  branch.h        |  8 ------
>  builtin/notes.c |  1 +
>  worktree.c      | 40 +++++++++++++++++++++++++++++
>  worktree.h      |  7 +++++
>  5 files changed, 49 insertions(+), 86 deletions(-)
>
> diff --git a/branch.c b/branch.c
> index d013374..77d7f2a 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -4,6 +4,7 @@
>  #include "refs.h"
>  #include "remote.h"
>  #include "commit.h"
> +#include "worktree.h"
>  
>  struct tracking {
>  	struct refspec spec;
> @@ -311,84 +312,6 @@ void remove_branch_state(void)
>  	unlink(git_path_squash_msg());
>  }
>  
> -static char *find_linked_symref(const char *symref, const char *branch,
> -				const char *id)

The title refers to a function with a different name ;-).

Copying the bulk of the function in 1/3 and then removing the
original here made it somewhat hard to compare what got changed in
the implementation.

I _think_ the code structure in the end result is more or less
right, though.

> diff --git a/worktree.c b/worktree.c
> index 33d2e57..e45b651 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -155,3 +155,43 @@ done:
>  	return list;
>  }
>  
> +char *find_shared_symref(const char *symref, const char *target)
> +{
> +	char *existing = NULL;
> +	struct strbuf path = STRBUF_INIT;
> +	struct strbuf sb = STRBUF_INIT;
> +	struct worktree_list *worktree_list = get_worktree_list();
> +	struct worktree_list *orig_list = worktree_list;
> +	struct worktree *matched = NULL;
> +
> +	while (!matched && worktree_list) {
> +		if (strcmp("HEAD", symref)) {
> +			strbuf_reset(&path);
> +			strbuf_reset(&sb);
> +			strbuf_addf(&path, "%s/%s", worktree_list->worktree->git_dir, symref);
> +
> +			if (_parse_ref(path.buf, &sb, NULL)) {
> +				continue;
> +			}

I forgot to say this on 1/3, but this helper function _parse_ref()
is obviously an implementation detail; does it have to be visible
outside the file, or can it become file-scope static?  There may
be other helpers that may not want to be global (I didn't check).

Provided that 1/3 will become accepable, this step looks sensible to
me.

Thanks.
