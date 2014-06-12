From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/17] provide a helper to free commit buffer
Date: Thu, 12 Jun 2014 11:22:31 -0700
Message-ID: <xmqqzjhi56oo.fsf@gitster.dls.corp.google.com>
References: <20140610213509.GA26979@sigill.intra.peff.net>
	<20140610214005.GH19147@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 12 20:22:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv9e6-0002CU-PB
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 20:22:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbaFLSWj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 14:22:39 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57833 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751074AbaFLSWi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 14:22:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EC0CC1DDAB;
	Thu, 12 Jun 2014 14:22:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=DOwpRK+nfCcanZp/92bN/YJOi4A=; b=M3pkpvL+7XMp1Vab2r1o
	6h233dUZ7fN8BAa5a66tcfWV4Y1YdGzEvetG/KiJsPzBQ1LGi6wWf+bGIg/QTmor
	lh74wPhg0qoRNs47oeDNP1xfHGwqA7m4+HFcHoGOmJRJSvA+M6NiMz8b/QG3RdNs
	Zpl2PHSvgbQuoXYqEBo6WOU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=IO8KdZvyIiBsnceZDrn14q6t3ly+amAamou4QeCuQwlLsf
	PHGVlckKQ24O6yG15T2xYE9KVYG64XvcF+gVzwvkcF/W5c3w9m4wNlFpRFxNkLem
	1UGUj3FuXk2ScuZ++1Re6nLpe7KKaJxaDjkY+YGcgHMGvUl3Qj+rF759xBob8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E0CD51DDAA;
	Thu, 12 Jun 2014 14:22:37 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9D4581DDA8;
	Thu, 12 Jun 2014 14:22:33 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 85C7D754-F25E-11E3-A647-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251472>

Jeff King <peff@peff.net> writes:

> This converts two lines into one at each caller. But more
> importantly, it abstracts the concept of freeing the buffer,
> which will make it easier to change later.
>
> Note that we also need to provide a "detach" mechanism for
> the weird case in fsck which passes the buffer back to be
> freed.

I find that last sentence a bit of white lie ;-).

The sole caller of "detach" is in index-pack, and discards the
return value, which is not wrong per-se because it still has the
pointer to the piece of memory it fed to parse_object_buffer(),
knows and/or assumes that the return value must be the same as the
one it already has, and it handles the freeing of that memory
without relying on the object layer at all.

But that is an even more weird special case than the white-lie
version.  As an API, "detach" that returns the buffer to be freed
looks much less weird than what is really going on in the current
caller.

I however have to wonder if

	if (detach_commit_buffer(commit) != data)
        	die("BUG");

might want to be there.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/fsck.c       |  3 +--
>  builtin/index-pack.c |  2 +-
>  builtin/log.c        |  6 ++----
>  builtin/rev-list.c   |  3 +--
>  commit.c             | 13 +++++++++++++
>  commit.h             | 11 +++++++++++
>  6 files changed, 29 insertions(+), 9 deletions(-)
>
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index fc150c8..8aadca1 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -310,8 +310,7 @@ static int fsck_obj(struct object *obj)
>  	if (obj->type == OBJ_COMMIT) {
>  		struct commit *commit = (struct commit *) obj;
>  
> -		free(commit->buffer);
> -		commit->buffer = NULL;
> +		free_commit_buffer(commit);
>  
>  		if (!commit->parents && show_root)
>  			printf("root %s\n", sha1_to_hex(commit->object.sha1));
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 18f57de..995df39 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -786,7 +786,7 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
>  			}
>  			if (obj->type == OBJ_COMMIT) {
>  				struct commit *commit = (struct commit *) obj;
> -				commit->buffer = NULL;
> +				detach_commit_buffer(commit);
>  			}
>  			obj->flags |= FLAG_CHECKED;
>  		}
> diff --git a/builtin/log.c b/builtin/log.c
> index 39e8836..226f8f2 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -349,8 +349,7 @@ static int cmd_log_walk(struct rev_info *rev)
>  			rev->max_count++;
>  		if (!rev->reflog_info) {
>  			/* we allow cycles in reflog ancestry */
> -			free(commit->buffer);
> -			commit->buffer = NULL;
> +			free_commit_buffer(commit);
>  		}
>  		free_commit_list(commit->parents);
>  		commit->parents = NULL;
> @@ -1508,8 +1507,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  		    reopen_stdout(rev.numbered_files ? NULL : commit, NULL, &rev, quiet))
>  			die(_("Failed to create output files"));
>  		shown = log_tree_commit(&rev, commit);
> -		free(commit->buffer);
> -		commit->buffer = NULL;
> +		free_commit_buffer(commit);
>  
>  		/* We put one extra blank line between formatted
>  		 * patches and this flag is used by log-tree code
> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index 9f92905..e012ebe 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -173,8 +173,7 @@ static void finish_commit(struct commit *commit, void *data)
>  		free_commit_list(commit->parents);
>  		commit->parents = NULL;
>  	}
> -	free(commit->buffer);
> -	commit->buffer = NULL;
> +	free_commit_buffer(commit);
>  }
>  
>  static void finish_object(struct object *obj,
> diff --git a/commit.c b/commit.c
> index fbdc480..11a05c1 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -245,6 +245,19 @@ int unregister_shallow(const unsigned char *sha1)
>  	return 0;
>  }
>  
> +void free_commit_buffer(struct commit *commit)
> +{
> +	free(commit->buffer);
> +	commit->buffer = NULL;
> +}
> +
> +const void *detach_commit_buffer(struct commit *commit)
> +{
> +	void *ret = commit->buffer;
> +	commit->buffer = NULL;
> +	return ret;
> +}
> +
>  int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long size)
>  {
>  	const char *tail = buffer;
> diff --git a/commit.h b/commit.h
> index 4df48cb..d72ed43 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -51,6 +51,17 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
>  int parse_commit(struct commit *item);
>  void parse_commit_or_die(struct commit *item);
>  
> +/*
> + * Free any cached object buffer associated with the commit.
> + */
> +void free_commit_buffer(struct commit *);
> +
> +/*
> + * Disassociate any cached object buffer from the commit, but do not free it.
> + * The buffer (or NULL, if none) is returned.
> + */
> +const void *detach_commit_buffer(struct commit *);
> +
>  /* Find beginning and length of commit subject. */
>  int find_commit_subject(const char *commit_buffer, const char **subject);
