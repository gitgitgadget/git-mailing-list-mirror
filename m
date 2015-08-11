From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH v2 1/2] refs: refs/worktree/* become per-worktree
Date: Tue, 11 Aug 2015 14:10:58 -0700
Message-ID: <xmqqvbclpm3h.fsf@gitster.dls.corp.google.com>
References: <1439268979-10456-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com, mhagger@alum.mit.edu,
	Christian Couder <chriscool@tuxfamily.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 23:11:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPGp9-0000T6-9d
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 23:11:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270AbbHKVLB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 17:11:01 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33316 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684AbbHKVLA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 17:11:00 -0400
Received: by pabyb7 with SMTP id yb7so137892713pab.0
        for <git@vger.kernel.org>; Tue, 11 Aug 2015 14:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=diVnI86v9QxENcoIRClpAaGp6xwfJAkvwNwoEarGQFo=;
        b=0Fwqz8Or4OhWA0hM/m3FdQM6iwwpoxmwBGmz400yHnMLmKKXt8OniQgz5p4mkJuvLs
         vt8dgR8Vt0nsOJnYi76sxsJbgWrMpXnVc4iBziClbVGBS/Q+BXI+VHuchkv/eSdd6Auk
         Ddfbnr1VlTIrFB2kZWyb6InZy/KIX+il3EbtkBFPnWOqQbRmqfkqRzHKsImH+XvHWL8j
         2cz8Jq5Z+f7LieCszOqGr2JIx5bjSjrTmBC+NtdolgSo4CFi/BHKEn0zgQB1HIPz/7m7
         hcxLabCEUO4nNv35gkxG7x3w3/lNNp6K9c/1tCaxf23q2lTyGo7krueLENXRka9tPr4M
         CkjA==
X-Received: by 10.66.121.163 with SMTP id ll3mr61984834pab.100.1439327459498;
        Tue, 11 Aug 2015 14:10:59 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:894d:5945:d51a:995b])
        by smtp.gmail.com with ESMTPSA id rg6sm3795438pdb.40.2015.08.11.14.10.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 11 Aug 2015 14:10:58 -0700 (PDT)
In-Reply-To: <1439268979-10456-1-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Tue, 11 Aug 2015 00:56:18 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275730>

David Turner <dturner@twopensource.com> writes:

> We need a place to stick refs for bisects in progress that is not
> shared between worktrees.  So we use the refs/worktree/ hierarchy.

This is by itself OK, but to help existing Porcelains, most notably
"gitk", I think refs/bisect/ hierarchy should be treated the same
way.  Moving them out of refs/bisect/ to refs/worktree/bisect/ would
not be a good idea.

Because refs/worktree/ hierarchy is not needed right now, I think we
can even live with just special casing refs/bisect/ the way this
patch does, without adding refs/worktree/ support at this point.

> Note that git for-each-ref may have inconsistent behavior (I think; I
> haven't confirmed this), sometimes showing refs/worktree/* and sometimes
> not.  In the long run, we should fix this, but right now, I don't know
> that it matters, since the only refs affected are these bisect refs.

We should fix that before this hits 'master', preferrably before
this hits 'next', especially if we add support for the more generic
refs/worktree/.  If it is only for refs/bisect/, we might be OK, but
I didn't think things through.

> diff --git a/path.c b/path.c
> index 10f4cbf..da0f767 100644
> --- a/path.c
> +++ b/path.c
> @@ -92,8 +92,9 @@ static void replace_dir(struct strbuf *buf, int len, const char *newdir)
>  }
>  
>  static const char *common_list[] = {
> +	"/refs", /* special case, since refs/worktree/ is per-worktree */
>  	"/branches", "/hooks", "/info", "!/logs", "/lost-found",
> -	"/objects", "/refs", "/remotes", "/worktrees", "/rr-cache", "/svn",
> +	"/objects", "/remotes", "/worktrees", "/rr-cache", "/svn",
>  	"config", "!gc.pid", "packed-refs", "shallow",
>  	NULL
>  };

This is not a new problem, but we probably should use a data
structure that is more performant than a linear list for this.

Also "!gc.pid" hack should be cleaned up.  It does not make much
sense to force all the calls to git_path() pay the price of checking
if each element in common-list begins with '!' and skip, even though
that '!' hack is only used in count-objects and nowhere else.

> diff --git a/refs.c b/refs.c
> index e6fc3fe..d43bfe1 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2656,6 +2656,10 @@ static int pack_if_possible_fn(struct ref_entry *entry, void *cb_data)
>  	struct ref_entry *packed_entry;
>  	int is_tag_ref = starts_with(entry->name, "refs/tags/");
>  
> +	/* Do not pack per-worktree refs: */
> +	if (starts_with(entry->name, "refs/worktree/"))
> +		return 0;

This should use is_per_worktree_ref(), no?

> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index 9d21c19..c9fd1ca 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -1131,4 +1131,20 @@ test_expect_success ULIMIT_FILE_DESCRIPTORS 'large transaction deleting branches
>  )
>  '
>  
> +test_expect_success 'handle per-worktree refs in refs/worktree' '
> +	git commit --allow-empty -m "initial commit" &&
> +	git worktree add -b branch worktree &&
> +	(
> +		cd worktree &&
> +		git commit --allow-empty -m "test commit"  &&
> +		git update-ref refs/worktree/something HEAD &&
> +		git rev-parse refs/worktree/something > ../worktree-head

Redirection '>', '>>', '<' etc. sticks to the pathname that comes
after it.

> +	) &&
> +	! test -e .git/refs/worktree &&
> +	test_must_fail git rev-parse refs/worktree/something &&
> +	git update-ref refs/worktree/something HEAD &&
> +	git rev-parse refs/worktree/something > main-head &&

Ditto.

Thanks.
