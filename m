From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cherry-pick: don't forget -s on failure
Date: Wed, 12 Sep 2012 15:32:08 -0700
Message-ID: <7vd31qc1p3.fsf@alter.siamese.dyndns.org>
References: <20120912195732.GB4722@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Robin Stocker <robin@nibor.org>
To: Miklos Vajna <vmiklos@suse.cz>
X-From: git-owner@vger.kernel.org Thu Sep 13 00:32:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBvTz-00033I-1x
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 00:32:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754900Ab2ILWcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 18:32:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51997 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754805Ab2ILWcM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 18:32:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 065BA88DE;
	Wed, 12 Sep 2012 18:32:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uXUaWXKAsrrKqE1YzBNODeBNeP8=; b=U1yzJ3
	h2DLgdeLmzd9fAH/nRiWD1rTfFlNsQG6fs+WWkzNU6KVV+7TfxnDDxLSye+MHX9h
	6g1Jfogbya+93BqT/3qqGP3nltarQXi2Xfmhj1ht5fAjWRDYES2P6YNDmOmcFpOb
	91KckuwB6wNDlG9t/aR7ep05Iynipz0trNRXU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NrMHBJylwroeDSowvUZJOsSnnVtmJVHg
	biyA7iNmCKyBpo8RnCitEL52eusW8lxi8lyyNVm+pWFHvQIZsbBrH1u5Rdr9ASva
	q/+hRICiZojZLc1scduz6VHcal+WmH31YpxGZB5iwe+gdQiFzlFHOeWt0s8r+3gh
	wq97eAQF3T4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E77FB88DD;
	Wed, 12 Sep 2012 18:32:11 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EC77C88DA; Wed, 12 Sep 2012
 18:32:10 -0400 (EDT)
In-Reply-To: <20120912195732.GB4722@suse.cz> (Miklos Vajna's message of "Wed,
 12 Sep 2012 21:57:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B1690224-FD29-11E1-9E33-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205346>

Miklos Vajna <vmiklos@suse.cz> writes:

> In case 'git cherry-pick -s <commit>' failed, the user had to use 'git
> commit -s' (i.e. state the -s option again), which is easy to forget
> about.  Instead, write the signed-off-by line early, so plain 'git
> commit' will have the same result.
>
> Signed-off-by: Miklos Vajna <vmiklos@suse.cz>
> ---
>
> Hi,
>
> See
> http://article.gmane.org/gmane.comp.documentfoundation.libreoffice.devel/36103
> for motivation. :-)
>
> Given that I needed sign_off_header / ends_rfc2822_footer and some code
> from builtin/commit.c in sequencer.c, I moved them there, let me know if
> there is a place better than sequencer.c for them.

I think we had a separate topic around cherry-pick that needs the
footer thing accessible from cherry-pick recently ($gmane/204755).

I think the code movement in this patch is a good one.

Thanks.

>
> Thanks,
>
> Miklos
>
>  builtin/commit.c                |   63 ++------------------------------------
>  sequencer.c                     |   65 +++++++++++++++++++++++++++++++++++++++
>  sequencer.h                     |    4 ++
>  t/t3507-cherry-pick-conflict.sh |    6 +++
>  4 files changed, 78 insertions(+), 60 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 778cf16..7d0df9a 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -28,6 +28,7 @@
>  #include "submodule.h"
>  #include "gpg-interface.h"
>  #include "column.h"
> +#include "sequencer.h"
>  
>  static const char * const builtin_commit_usage[] = {
>  	N_("git commit [options] [--] <filepattern>..."),
> @@ -466,8 +467,6 @@ static int is_a_merge(const struct commit *current_head)
>  	return !!(current_head->parents && current_head->parents->next);
>  }
>  
> -static const char sign_off_header[] = "Signed-off-by: ";
> -
>  static void export_one(const char *var, const char *s, const char *e, int hack)
>  {
>  	struct strbuf buf = STRBUF_INIT;
> @@ -552,47 +551,6 @@ static void determine_author_info(struct strbuf *author_ident)
>  	}
>  }
>  
> -static int ends_rfc2822_footer(struct strbuf *sb)
> -{
> -	int ch;
> -	int hit = 0;
> -	int i, j, k;
> -	int len = sb->len;
> -	int first = 1;
> -	const char *buf = sb->buf;
> -
> -	for (i = len - 1; i > 0; i--) {
> -		if (hit && buf[i] == '\n')
> -			break;
> -		hit = (buf[i] == '\n');
> -	}
> -
> -	while (i < len - 1 && buf[i] == '\n')
> -		i++;
> -
> -	for (; i < len; i = k) {
> -		for (k = i; k < len && buf[k] != '\n'; k++)
> -			; /* do nothing */
> -		k++;
> -
> -		if ((buf[k] == ' ' || buf[k] == '\t') && !first)
> -			continue;
> -
> -		first = 0;
> -
> -		for (j = 0; i + j < len; j++) {
> -			ch = buf[i + j];
> -			if (ch == ':')
> -				break;
> -			if (isalnum(ch) ||
> -			    (ch == '-'))
> -				continue;
> -			return 0;
> -		}
> -	}
> -	return 1;
> -}
> -
>  static char *cut_ident_timestamp_part(char *string)
>  {
>  	char *ket = strrchr(string, '>');
> @@ -716,23 +674,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  	if (clean_message_contents)
>  		stripspace(&sb, 0);
>  
> -	if (signoff) {
> -		struct strbuf sob = STRBUF_INIT;
> -		int i;
> -
> -		strbuf_addstr(&sob, sign_off_header);
> -		strbuf_addstr(&sob, fmt_name(getenv("GIT_COMMITTER_NAME"),
> -					     getenv("GIT_COMMITTER_EMAIL")));
> -		strbuf_addch(&sob, '\n');
> -		for (i = sb.len - 1; i > 0 && sb.buf[i - 1] != '\n'; i--)
> -			; /* do nothing */
> -		if (prefixcmp(sb.buf + i, sob.buf)) {
> -			if (!i || !ends_rfc2822_footer(&sb))
> -				strbuf_addch(&sb, '\n');
> -			strbuf_addbuf(&sb, &sob);
> -		}
> -		strbuf_release(&sob);
> -	}
> +	if (signoff)
> +		append_signoff(&sb);
>  
>  	if (fwrite(sb.buf, 1, sb.len, s->fp) < sb.len)
>  		die_errno(_("could not write commit template"));
> diff --git a/sequencer.c b/sequencer.c
> index f86f116..402dcd6 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -17,6 +17,8 @@
>  
>  #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
>  
> +const char sign_off_header[] = "Signed-off-by: ";
> +
>  void remove_sequencer_state(void)
>  {
>  	struct strbuf seq_dir = STRBUF_INIT;
> @@ -249,6 +251,9 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
>  		}
>  	}
>  
> +	if (opts->signoff)
> +		append_signoff(msgbuf);
> +
>  	return !clean;
>  }
>  
> @@ -1011,3 +1016,63 @@ int sequencer_pick_revisions(struct replay_opts *opts)
>  	save_opts(opts);
>  	return pick_commits(todo_list, opts);
>  }
> +
> +static int ends_rfc2822_footer(struct strbuf *sb)
> +{
> +	int ch;
> +	int hit = 0;
> +	int i, j, k;
> +	int len = sb->len;
> +	int first = 1;
> +	const char *buf = sb->buf;
> +
> +	for (i = len - 1; i > 0; i--) {
> +		if (hit && buf[i] == '\n')
> +			break;
> +		hit = (buf[i] == '\n');
> +	}
> +
> +	while (i < len - 1 && buf[i] == '\n')
> +		i++;
> +
> +	for (; i < len; i = k) {
> +		for (k = i; k < len && buf[k] != '\n'; k++)
> +			; /* do nothing */
> +		k++;
> +
> +		if ((buf[k] == ' ' || buf[k] == '\t') && !first)
> +			continue;
> +
> +		first = 0;
> +
> +		for (j = 0; i + j < len; j++) {
> +			ch = buf[i + j];
> +			if (ch == ':')
> +				break;
> +			if (isalnum(ch) ||
> +			    (ch == '-'))
> +				continue;
> +			return 0;
> +		}
> +	}
> +	return 1;
> +}
> +
> +void append_signoff(struct strbuf *msgbuf)
> +{
> +	struct strbuf sob = STRBUF_INIT;
> +	int i;
> +
> +	strbuf_addstr(&sob, sign_off_header);
> +	strbuf_addstr(&sob, fmt_name(getenv("GIT_COMMITTER_NAME"),
> +				getenv("GIT_COMMITTER_EMAIL")));
> +	strbuf_addch(&sob, '\n');
> +	for (i = msgbuf->len - 1; i > 0 && msgbuf->buf[i - 1] != '\n'; i--)
> +		; /* do nothing */
> +	if (prefixcmp(msgbuf->buf + i, sob.buf)) {
> +		if (!i || !ends_rfc2822_footer(msgbuf))
> +			strbuf_addch(msgbuf, '\n');
> +		strbuf_addbuf(msgbuf, &sob);
> +	}
> +	strbuf_release(&sob);
> +}
> diff --git a/sequencer.h b/sequencer.h
> index d849420..440b0c9 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -49,4 +49,8 @@ extern void remove_sequencer_state(void);
>  
>  int sequencer_pick_revisions(struct replay_opts *opts);
>  
> +extern const char sign_off_header[];
> +
> +void append_signoff(struct strbuf *msgbuf);
> +
>  #endif
> diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
> index 0c81b3c..eb52f1e 100755
> --- a/t/t3507-cherry-pick-conflict.sh
> +++ b/t/t3507-cherry-pick-conflict.sh
> @@ -340,4 +340,10 @@ test_expect_success 'revert conflict, diff3 -m style' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'failed cherry-pick does not forget -s' '
> +	pristine_detach initial &&
> +	test_must_fail git cherry-pick -s picked &&
> +	test_i18ngrep -e "Signed-off-by" .git/MERGE_MSG
> +'
> +
>  test_done
