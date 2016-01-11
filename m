From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] Teach cherry-pick to skip redundant commits if asked
Date: Mon, 11 Jan 2016 11:28:37 -0800
Message-ID: <xmqqr3hnx6e2.fsf@gitster.mtv.corp.google.com>
References: <1452488421-26823-1-git-send-email-greened@obbligato.org>
	<1452488421-26823-2-git-send-email-greened@obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, peff@peff.net, chris@arachsys.com,
	nhorman@tuxdriver.com
To: David Greene <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Mon Jan 11 20:28:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIi94-0004aG-Cf
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 20:28:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934570AbcAKT2o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 14:28:44 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:65344 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934567AbcAKT2k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 14:28:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E46EE3A113;
	Mon, 11 Jan 2016 14:28:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tp03U0zqRCqvN9eqPpAuHLHSrRM=; b=mJ1KEp
	zmYV0WUvdomSZQoAoR2PcUszaylBMxX3er9tdS0rYBSJfG62UEUo2xDxQH6+b4tJ
	UcezNizfEgCCt/MPx567u4/kaVyfQuCOCTcBIPCe6G5jP/wSbn2k6VuFskHZEu49
	HMvB1XYjJTSdO5sMD897Plud+wQtbMSs6Ee7c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XQYm+fDm1U8qNtgaz335X4V2qD5Y49oc
	zXMFggT+6Z6a8FBArmm6fPf+tptROk6+zSdrChdBNM//w3slWufq59xJ2/wSyzVJ
	waLu/IQ1pjhGk6Mjyot87o3ktwDdYI8OdPQD1FRCcm5PHuEKmqKHDkNCUNxg3PcE
	Tazki9IpnCM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D9FA73A112;
	Mon, 11 Jan 2016 14:28:39 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 29F4A3A111;
	Mon, 11 Jan 2016 14:28:39 -0500 (EST)
In-Reply-To: <1452488421-26823-2-git-send-email-greened@obbligato.org> (David
	Greene's message of "Sun, 10 Jan 2016 23:00:17 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8439B9B8-B899-11E5-93C1-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283700>

David Greene <greened@obbligato.org> writes:

> From: "David A. Greene" <greened@obbligato.org>
>
> Add a "--skip-redundant-commits" option to cherry-pick to avoid
> aborting if the cherry-picked commit becomes empty due to
> conflict resolution.
>
> Signed-off-by: David A. Greene <greened@obbligato.org>
> ---
>  builtin/revert.c |  7 +++++++
>  sequencer.c      | 23 +++++++++++++++++++++++
>  sequencer.h      |  1 +
>  3 files changed, 31 insertions(+)
>
> diff --git a/builtin/revert.c b/builtin/revert.c
> index 56a2c36..befd3ce 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -91,6 +91,12 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
>  			N_("option for merge strategy"), option_parse_x),
>  		{ OPTION_STRING, 'S', "gpg-sign", &opts->gpg_sign, N_("key-id"),
>  		  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
> +		/*
> +		 * There must be enough OPT_END() here to match the
> +		 * size of cp_extra below so that parse_options_concat
> +		 * will work.
> +		 */

Good ;-)

> +		OPT_END(),
>  		OPT_END(),
>  		OPT_END(),
>  		OPT_END(),
> @@ -106,6 +112,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
>  			OPT_BOOL(0, "allow-empty", &opts->allow_empty, N_("preserve initially empty commits")),
>  			OPT_BOOL(0, "allow-empty-message", &opts->allow_empty_message, N_("allow commits with empty messages")),
>  			OPT_BOOL(0, "keep-redundant-commits", &opts->keep_redundant_commits, N_("keep redundant, empty commits")),
> +			OPT_BOOL(0, "skip-redundant-commits", &opts->skip_redundant_commits, N_("skip redundant, empty commits")),
>  			OPT_END(),
>  		};

This however makes me wonder what should happen when both are
specified.  Shouldn't this patch change the keep_redundant_commits
field from a bool to a tristate that tells us what to do with
redundant ones?  int/enum opts.redundant_commit can take 0 (fail,
which would be the default), 1 (keep) or 2 (skip), or something
like that.



> diff --git a/sequencer.c b/sequencer.c
> index 8c58fa2..12361e7 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -185,6 +185,7 @@ static void print_advice(int show_hint, struct replay_opts *opts)
>  		else
>  			advise(_("after resolving the conflicts, mark the corrected paths\n"
>  				 "with 'git add <paths>' or 'git rm <paths>'\n"
> +

???

>  				 "and commit the result with 'git commit'"));
>  	}
>  }
> @@ -614,6 +615,28 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
>  		res = allow;
>  		goto leave;
>  	}
> +
> +	// If told, do not try to commit things that don't make any
> +	// changes.

No C++/C99 comments, please.

> +	if (opts->skip_redundant_commits) {
> +		int index_unchanged = is_index_unchanged();
> +		if (index_unchanged < 0) {
> +			// Something bad happened readhing HEAD or the
> +			// index.  Abort.
> +			res = index_unchanged;
> +			goto leave;
> +		}
> +		if (index_unchanged) {
> +			fputs(_("Skipping redundant commit "), stderr);
> +			fputs(find_unique_abbrev(commit->object.oid.hash,
> +						 GIT_SHA1_HEXSZ),
> +			      stderr);
> +			fputs("\n", stderr);

This is a bad i18n; we do not know the sentence "Skipping commit X"
is translated to have X at the end of the sentence in all languages.

	fprintf(stderr, _("Skipping ... %s\n"), find_unique_abbrev(...));

would allow it to be tranlated to "Commit X is getting skipped", for
example.

> +			res = 0;
> +			goto leave;
> +		}
> +	}
> +
>  	if (!opts->no_commit)
>  		res = run_git_commit(git_path_merge_msg(), opts, allow);
>  
> diff --git a/sequencer.h b/sequencer.h
> index 5ed5cb1..ad6145d 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -34,6 +34,7 @@ struct replay_opts {
>  	int allow_empty;
>  	int allow_empty_message;
>  	int keep_redundant_commits;
> +	int skip_redundant_commits;

Continuing from the top-part of the comments, this may be better to
be:

	enum {
            REPLAY_REDUNDANT_FAIL = 0,
            REPLAY_REDUNDANT_KEEP,
            REPLAY_REDUNDANT_SKIP
	} redundant_commits;

or something like that.

>  
>  	int mainline;
