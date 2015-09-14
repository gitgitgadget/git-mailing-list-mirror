From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 5/8] branch: drop non-commit error reporting
Date: Mon, 14 Sep 2015 12:49:36 -0700
Message-ID: <xmqqvbbcvl0v.fsf@gitster.mtv.corp.google.com>
References: <1442129035-31386-1-git-send-email-Karthik.188@gmail.com>
	<1442129035-31386-6-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 21:49:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbZl2-0006Sv-73
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 21:49:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824AbbINTtj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 15:49:39 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34484 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809AbbINTti (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 15:49:38 -0400
Received: by padhy16 with SMTP id hy16so152282607pad.1
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 12:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=3Ex858WuPmzSJ+bNJ8DViYtWcGbkj9bwr5MaMv7i+SU=;
        b=n4KvmBY7yw50b316JHoGQbWxB1uXF3gji2atx2AiDDnCVMVe8RiTY2SXfYfk5BbF/6
         CkYwIgzruh3GtL8imTEFN8M38tUGYlEpq4Nv2Fgf30w4kB58fi7TMXGrGfYPeooXbMg9
         +6H+fRbfnsWybc8gdG9OUiRqME8X2/QAqS/jcAerCmoW7k/wOBTQiIW+ymwwXnhwn0b1
         DrzTyPkT41bjL4pjNmrIHhmQYCv7VOkoV7T6dsX1nMYCVqE2IS2KdfUxhIrjOF/loyqH
         4QpYXAm5tOLeE7jwCt8D9lQWh0BQP3HCvEZY8vAkbtc+SDDFoKX+r2mrhibrh/v5+n6H
         ffkA==
X-Received: by 10.66.142.202 with SMTP id ry10mr14467832pab.86.1442260178167;
        Mon, 14 Sep 2015 12:49:38 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:611e:bac9:b978:992c])
        by smtp.gmail.com with ESMTPSA id fe8sm17816014pab.40.2015.09.14.12.49.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 14 Sep 2015 12:49:37 -0700 (PDT)
In-Reply-To: <1442129035-31386-6-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Sun, 13 Sep 2015 12:53:52 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277862>

Karthik Nayak <karthik.188@gmail.com> writes:

> Remove the error reporting variable to make the code easier to port
> over to using ref-filter APIs. This variable is not required as in
> ref-filter we already check for possible errors and report them.

Hmmmm.  What do you exactly mean "possible errors" here?

Unlike generic refs that can point at anything, refs/heads/* refs
must point at a commit [*1*], and that is why the error message says
'does not point at a commit'.

Does ref-filter API have corresponding check to treat the local and
remote branch hierarchies differently from tags and others?

[Footnote]

*1* Strictly speaking, use of lookup_commit_reference_gently() in
    the existing code allows a committish to be there and does not
    limit the tip objects to be commits, but I think it is a bug.
    At least, even with deref_tag(), we reject non committish found
    at the tip of branch refs and explain with the error message
    this patch removes.

> Based-on-patch-by: Jeff King <peff@peff.net>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  builtin/branch.c | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 4d9e4d0..8b9da60 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -313,7 +313,6 @@ static char *resolve_symref(const char *src, const char *prefix)
>  struct append_ref_cb {
>  	struct ref_list *ref_list;
>  	const char **pattern;
> -	int ret;
>  };
>  
>  static int match_patterns(const char **pattern, const char *refname)
> @@ -370,10 +369,8 @@ static int append_ref(const char *refname, const struct object_id *oid, int flag
>  	commit = NULL;
>  	if (ref_list->verbose || ref_list->with_commit || merge_filter != NO_FILTER) {
>  		commit = lookup_commit_reference_gently(oid->hash, 1);
> -		if (!commit) {
> -			cb->ret = error(_("branch '%s' does not point at a commit"), refname);
> +		if (!commit)
>  			return 0;
> -		}
>  
>  		/* Filter with with_commit if specified */
>  		if (!is_descendant_of(commit, ref_list->with_commit))
> @@ -617,7 +614,7 @@ static int calc_maxwidth(struct ref_list *refs, int remote_bonus)
>  	return max;
>  }
>  
> -static int print_ref_list(int kinds, int detached, int verbose, int abbrev, struct commit_list *with_commit, const char **pattern)
> +static void print_ref_list(int kinds, int detached, int verbose, int abbrev, struct commit_list *with_commit, const char **pattern)
>  {
>  	int i, index;
>  	struct append_ref_cb cb;
> @@ -642,7 +639,6 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
>  		init_revisions(&ref_list.revs, NULL);
>  	cb.ref_list = &ref_list;
>  	cb.pattern = pattern;
> -	cb.ret = 0;
>  	/*
>  	 * First we obtain all regular branch refs and if the HEAD is
>  	 * detached then we insert that ref to the end of the ref_fist
> @@ -702,11 +698,6 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
>  			       abbrev, detached, remote_prefix);
>  
>  	free_ref_list(&ref_list);
> -
> -	if (cb.ret)
> -		error(_("some refs could not be read"));
> -
> -	return cb.ret;
>  }
>  
>  static void rename_branch(const char *oldname, const char *newname, int force)
> @@ -922,15 +913,14 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  			die(_("branch name required"));
>  		return delete_branches(argc, argv, delete > 1, kinds, quiet);
>  	} else if (list) {
> -		int ret;
>  		/*  git branch --local also shows HEAD when it is detached */
>  		if (kinds & REF_LOCAL_BRANCH)
>  			kinds |= REF_DETACHED_HEAD;
> -		ret = print_ref_list(kinds, detached, verbose, abbrev,
> +		print_ref_list(kinds, detached, verbose, abbrev,
>  					 with_commit, argv);
>  		print_columns(&output, colopts, NULL);
>  		string_list_clear(&output, 0);
> -		return ret;
> +		return 0;
>  	}
>  	else if (edit_description) {
>  		const char *branch_name;
