From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] commit -v: strip diffs and submodule shortlogs from the commit message
Date: Thu, 05 Dec 2013 12:05:52 -0800
Message-ID: <xmqqk3fj3vxb.fsf@gitster.dls.corp.google.com>
References: <528D385F.2070906@web.de>
	<xmqqpppu65fs.fsf@gitster.dls.corp.google.com>
	<528E7A6E.8080603@web.de>
	<xmqqsiup2y3u.fsf@gitster.dls.corp.google.com>
	<52A0D78E.4030509@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>, Ari Pollak <ari@debian.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Dec 05 21:06:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VofBQ-0006wg-Ik
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 21:06:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753699Ab3LEUF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Dec 2013 15:05:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49521 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751817Ab3LEUFz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 15:05:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F17AC58837;
	Thu,  5 Dec 2013 15:05:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xf3t50c/zj8MvoeS1kxr8mq5PpQ=; b=LxTK36
	lQsKs49zQWTVETd840CO0UkkhFpo5evcnZ6feU8e/oXHPOa7vcTuWIsydHqxqvPi
	zp1aO2Pgp8qJRv2L4NPJo3olulp0N0k8NlqMlqXQAcywhy+QeaR+07u5nd2tMz+6
	Sfg2KDSLu3sjfDO2diRipJzC3N8o9tlvaFyeg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XQPhQrVQgBrgFvLEuQ8knKS0+fBdd83r
	xpkRpdsY9DgmEmR1nxUlfQj2gRfpwWsRy3twOd14eO9lb8Z8EqKfrgnQOWTbBk9p
	fmDmR/gdKR5HOm/VZ/wHgGkgDgid3rsEzbiAepRim2XLXLHEPufLf6nKys9911UL
	OTRcTsD9cEE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD02D58836;
	Thu,  5 Dec 2013 15:05:54 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 19FF758830;
	Thu,  5 Dec 2013 15:05:54 -0500 (EST)
In-Reply-To: <52A0D78E.4030509@web.de> (Jens Lehmann's message of "Thu, 05 Dec
	2013 20:44:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A57865CE-5DE8-11E3-9EAC-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238907>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> When using the '-v' option of "git commit" the diff added to the commit
> message temporarily for editing is stripped off after the user exited the
> editor by searching for "\ndiff --git " and truncating the commmit message
> there if it is found.
>
> But this approach has two problems:
>
> - when the commit message itself contains a line starting with
>   "diff --git" it will be truncated there prematurely; and
>
> - when the "diff.submodule" setting is set to "log", the diff may
>   start with "Submodule <hash1>..<hash2>", which will be left in
>   the commit message while it shouldn't.
>
> Fix that by introducing a special scissor separator line starting with the
> comment character ('#' or the core.commentChar config if set) followed by
> two lines describing what it is for. The scissor line - which will not be
> translated - is used to reliably detect the start of the diff so it can be
> chopped off from the commit message, no matter what the user enters there.
>
> Turn a known test failure fixed by this change into a successful test;
> also add one for a diff starting with a submodule log and another one for
> proper handling of the comment char.
>
> Reported-by: Ari Pollak <ari@debian.org>
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> ---
>
> Changes to v3:
>
> - separating comment_line_char from the cut_line
>
> - using strbuf_add_commented_lines() for the comment
>
> All issues raised should be addressed with this version.

Nicely done.

Thanks, will replace and queue.

>  builtin/commit.c          |  9 +++------
>  t/t7507-commit-verbose.sh | 28 +++++++++++++++++++++++++++-
>  wt-status.c               | 29 +++++++++++++++++++++++++++--
>  wt-status.h               |  1 +
>  4 files changed, 58 insertions(+), 9 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 6ab4605..fedb45a 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1505,7 +1505,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  	struct strbuf sb = STRBUF_INIT;
>  	struct strbuf author_ident = STRBUF_INIT;
>  	const char *index_file, *reflog_msg;
> -	char *nl, *p;
> +	char *nl;
>  	unsigned char sha1[20];
>  	struct ref_lock *ref_lock;
>  	struct commit_list *parents = NULL, **pptr = &parents;
> @@ -1601,11 +1601,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  	}
>
>  	/* Truncate the message just before the diff, if any. */
> -	if (verbose) {
> -		p = strstr(sb.buf, "\ndiff --git ");
> -		if (p != NULL)
> -			strbuf_setlen(&sb, p - sb.buf + 1);
> -	}
> +	if (verbose)
> +		wt_status_truncate_message_at_cut_line(&sb);
>
>  	if (cleanup_mode != CLEANUP_NONE)
>  		stripspace(&sb, cleanup_mode == CLEANUP_ALL);
> diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
> index da5bd3b..2ddf28c 100755
> --- a/t/t7507-commit-verbose.sh
> +++ b/t/t7507-commit-verbose.sh
> @@ -65,9 +65,35 @@ test_expect_success 'diff in message is retained without -v' '
>  	check_message diff
>  '
>
> -test_expect_failure 'diff in message is retained with -v' '
> +test_expect_success 'diff in message is retained with -v' '
>  	git commit --amend -F diff -v &&
>  	check_message diff
>  '
>
> +test_expect_success 'submodule log is stripped out too with -v' '
> +	git config diff.submodule log &&
> +	git submodule add ./. sub &&
> +	git commit -m "sub added" &&
> +	(
> +		cd sub &&
> +		echo "more" >>file &&
> +		git commit -a -m "submodule commit"
> +	) &&
> +	(
> +		GIT_EDITOR=cat &&
> +		export GIT_EDITOR &&
> +		test_must_fail git commit -a -v 2>err
> +	) &&
> +	test_i18ngrep "Aborting commit due to empty commit message." err
> +'
> +
> +test_expect_success 'verbose diff is stripped out with set core.commentChar' '
> +	(
> +		GIT_EDITOR=cat &&
> +		export GIT_EDITOR &&
> +		test_must_fail git -c core.commentchar=";" commit -a -v 2>err
> +	) &&
> +	test_i18ngrep "Aborting commit due to empty commit message." err
> +'
> +
>  test_done
> diff --git a/wt-status.c b/wt-status.c
> index b4e44ba..99c3d1c 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -16,6 +16,9 @@
>  #include "column.h"
>  #include "strbuf.h"
>
> +static char cut_line[] =
> +"------------------------ >8 ------------------------\n";
> +
>  static char default_wt_status_colors[][COLOR_MAXLEN] = {
>  	GIT_COLOR_NORMAL, /* WT_STATUS_HEADER */
>  	GIT_COLOR_GREEN,  /* WT_STATUS_UPDATED */
> @@ -767,6 +770,18 @@ conclude:
>  	status_printf_ln(s, GIT_COLOR_NORMAL, "");
>  }
>
> +void wt_status_truncate_message_at_cut_line(struct strbuf *buf)
> +{
> +	const char *p;
> +	struct strbuf pattern = STRBUF_INIT;
> +
> +	strbuf_addf(&pattern, "%c %s", comment_line_char, cut_line);
> +	p = strstr(buf->buf, pattern.buf);
> +	if (p && (p == buf->buf || p[-1] == '\n'))
> +		strbuf_setlen(buf, p - buf->buf);
> +	strbuf_release(&pattern);
> +}
> +
>  static void wt_status_print_verbose(struct wt_status *s)
>  {
>  	struct rev_info rev;
> @@ -787,10 +802,20 @@ static void wt_status_print_verbose(struct wt_status *s)
>  	 * If we're not going to stdout, then we definitely don't
>  	 * want color, since we are going to the commit message
>  	 * file (and even the "auto" setting won't work, since it
> -	 * will have checked isatty on stdout).
> +	 * will have checked isatty on stdout). But we then do want
> +	 * to insert the scissor line here to reliably remove the
> +	 * diff before committing.
>  	 */
> -	if (s->fp != stdout)
> +	if (s->fp != stdout) {
> +		const char *explanation = _("Do not touch the line above.\nEverything below will be removed.");
> +		struct strbuf buf = STRBUF_INIT;
> +
>  		rev.diffopt.use_color = 0;
> +		fprintf(s->fp, "%c %s", comment_line_char, cut_line);
> +		strbuf_add_commented_lines(&buf, explanation, strlen(explanation));
> +		fprintf(s->fp, buf.buf);
> +		strbuf_release(&buf);
> +	}
>  	run_diff_index(&rev, 1);
>  }
>
> diff --git a/wt-status.h b/wt-status.h
> index 6c29e6f..30a4812 100644
> --- a/wt-status.h
> +++ b/wt-status.h
> @@ -91,6 +91,7 @@ struct wt_status_state {
>  	unsigned char cherry_pick_head_sha1[20];
>  };
>
> +void wt_status_truncate_message_at_cut_line(struct strbuf *);
>  void wt_status_prepare(struct wt_status *s);
>  void wt_status_print(struct wt_status *s);
>  void wt_status_collect(struct wt_status *s);
