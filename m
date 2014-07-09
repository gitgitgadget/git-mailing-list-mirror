From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] dir: remove PATH_MAX limitation
Date: Wed, 09 Jul 2014 09:33:30 -0700
Message-ID: <xmqqa98i7aqt.fsf@gitster.dls.corp.google.com>
References: <53B72DAA.5050007@gmail.com> <53B72DD5.6020603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 18:33:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4uoS-0008GS-0i
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 18:33:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755665AbaGIQdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 12:33:40 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64310 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755199AbaGIQdj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 12:33:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7C0A827ADA;
	Wed,  9 Jul 2014 12:33:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mo+HcwZUJfuARcU6QWc4VkzfqG0=; b=wlx2rm
	HyvMo8vtKe7WhDAE5QTSlJ4qWtLat6YfG13XCAUFThUVmj4eVsBlEnGXtuyTaZf5
	ApMHnTZtN1D9Oj98d5ackTT0pjZBJmmKAA/2erptApZVBD2i06hfqfg8M1g2W/mj
	aUfNt5cQnaj7Z3kVDrdW+kiQBxhwpNSBOAwxU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WcMywAerIl6Dbqmz+6NRiHVb6JC/3Ham
	+D4UfN/pSytS1RdXUMoF8lssyeaDhd/RzNxLjJ5iui+aH8VFKHQ1Pyd+ur0R/CzM
	3+J7oWZZGy+0O0Ap5o1mXUIWbKvUNcayd7SEL4OsF1D0K/TQ3BRaGof/XuR6Swk2
	LcI+le2+Q0g=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6DFC327AD9;
	Wed,  9 Jul 2014 12:33:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E0D0527ACF;
	Wed,  9 Jul 2014 12:33:17 -0400 (EDT)
In-Reply-To: <53B72DD5.6020603@gmail.com> (Karsten Blees's message of "Sat, 05
	Jul 2014 00:42:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BB6B8210-0786-11E4-AE50-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253134>

Karsten Blees <karsten.blees@gmail.com> writes:

> 'git status' segfaults if a directory is longer than PATH_MAX, because
> processing .gitignore files in prep_exclude() writes past the end of a
> PATH_MAX-bounded buffer.
>
> Remove the limitation by using strbuf instead.
>
> Note: this fix just 'abuses' strbuf as string allocator, len is always 0.
> prep_exclude() can probably be simplified using more strbuf APIs.

In addition to what Jeff already said, I am afraid that this may
make things a lot worse for normal case.  By sizing the strbuf to
absolute minimum as you dig deeper at each level, wouldn't you copy
and reallocate the buffer a lot more, compared to the case where
everything fits in the original buffer?


> Signed-off-by: Karsten Blees <blees@dcon.de>
> ---
>  dir.c | 35 +++++++++++++++++++----------------
>  dir.h |  4 ++--
>  2 files changed, 21 insertions(+), 18 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index e65888d..8d4d83c 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -798,7 +798,7 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
>  	 * path being checked. */
>  	while ((stk = dir->exclude_stack) != NULL) {
>  		if (stk->baselen <= baselen &&
> -		    !strncmp(dir->basebuf, base, stk->baselen))
> +		    !strncmp(dir->base.buf, base, stk->baselen))
>  			break;
>  		el = &group->el[dir->exclude_stack->exclude_ix];
>  		dir->exclude_stack = stk->prev;
> @@ -833,48 +833,50 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
>  		stk->baselen = cp - base;
>  		stk->exclude_ix = group->nr;
>  		el = add_exclude_list(dir, EXC_DIRS, NULL);
> -		memcpy(dir->basebuf + current, base + current,
> +		strbuf_grow(&dir->base, stk->baselen);
> +		memcpy(dir->base.buf + current, base + current,
>  		       stk->baselen - current);
>  
>  		/* Abort if the directory is excluded */
>  		if (stk->baselen) {
>  			int dt = DT_DIR;
> -			dir->basebuf[stk->baselen - 1] = 0;
> +			dir->base.buf[stk->baselen - 1] = 0;
>  			dir->exclude = last_exclude_matching_from_lists(dir,
> -				dir->basebuf, stk->baselen - 1,
> -				dir->basebuf + current, &dt);
> -			dir->basebuf[stk->baselen - 1] = '/';
> +				dir->base.buf, stk->baselen - 1,
> +				dir->base.buf + current, &dt);
> +			dir->base.buf[stk->baselen - 1] = '/';
>  			if (dir->exclude &&
>  			    dir->exclude->flags & EXC_FLAG_NEGATIVE)
>  				dir->exclude = NULL;
>  			if (dir->exclude) {
> -				dir->basebuf[stk->baselen] = 0;
> +				dir->base.buf[stk->baselen] = 0;
>  				dir->exclude_stack = stk;
>  				return;
>  			}
>  		}
>  
> -		/* Try to read per-directory file unless path is too long */
> -		if (dir->exclude_per_dir &&
> -		    stk->baselen + strlen(dir->exclude_per_dir) < PATH_MAX) {
> -			strcpy(dir->basebuf + stk->baselen,
> +		/* Try to read per-directory file */
> +		if (dir->exclude_per_dir) {
> +			strbuf_grow(&dir->base, stk->baselen +
> +				    strlen(dir->exclude_per_dir));
> +			strcpy(dir->base.buf + stk->baselen,
>  					dir->exclude_per_dir);
>  			/*
> -			 * dir->basebuf gets reused by the traversal, but we
> +			 * dir->base gets reused by the traversal, but we
>  			 * need fname to remain unchanged to ensure the src
>  			 * member of each struct exclude correctly
>  			 * back-references its source file.  Other invocations
>  			 * of add_exclude_list provide stable strings, so we
>  			 * strdup() and free() here in the caller.
>  			 */
> -			el->src = strdup(dir->basebuf);
> -			add_excludes_from_file_to_list(dir->basebuf,
> -					dir->basebuf, stk->baselen, el, 1);
> +			el->src = strdup(dir->base.buf);
> +			add_excludes_from_file_to_list(dir->base.buf,
> +					dir->base.buf, stk->baselen, el, 1);
>  		}
>  		dir->exclude_stack = stk;
>  		current = stk->baselen;
>  	}
> -	dir->basebuf[baselen] = '\0';
> +	dir->base.buf[baselen] = '\0';
>  }
>  
>  /*
> @@ -1671,4 +1673,5 @@ void clear_directory(struct dir_struct *dir)
>  		free(stk);
>  		stk = prev;
>  	}
> +	strbuf_release(&dir->base);
>  }
> diff --git a/dir.h b/dir.h
> index 55e5345..e870fb6 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -111,13 +111,13 @@ struct dir_struct {
>  	 * per-directory exclude lists.
>  	 *
>  	 * exclude_stack points to the top of the exclude_stack, and
> -	 * basebuf contains the full path to the current
> +	 * base contains the full path to the current
>  	 * (sub)directory in the traversal. Exclude points to the
>  	 * matching exclude struct if the directory is excluded.
>  	 */
>  	struct exclude_stack *exclude_stack;
>  	struct exclude *exclude;
> -	char basebuf[PATH_MAX];
> +	struct strbuf base;
>  };
>  
>  /*
> -- 
> 1.9.4.msysgit.0.5.g1471ac1
>
> -- 
