Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 882682018C
	for <e@80x24.org>; Tue, 21 Jun 2016 19:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbcFUTBP (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 15:01:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57653 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751434AbcFUTBM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 15:01:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C78C125FC8;
	Tue, 21 Jun 2016 15:00:09 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2nPmajecRigUPGnxuIRGDX65h9Q=; b=N8Vtk6
	HX6900HqRMpuNngBgV82KtNbPwZZkn63Nw16nljS0M+c7KTWR/ZpBsWoZNSZIUbZ
	Tt4cpKLIA7+O49o8AszNzJPS3UcpqVanizS+i9/+Vcpa78NQtI15R+huPUssJAVg
	YNauIr588ewHuoAqatiZNgSlOcbWLkMAtpLF0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q9k3vUCt3lo5wcYwi3G0U/uMuERHKc1t
	wJa98XS0fCC2DhVspI2osbvBSuUWi2JS5EpUXjUP7dD5Wld86+Jli6/Swj0y3qvr
	8Ps3c7tBPD2LBt9bTH1AIpW18V7ahzUlFO0o030bu4zNqzkXVCpsL2YkISKOkDgg
	L0c+kE3/AJA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BF2E725FC7;
	Tue, 21 Jun 2016 15:00:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B77BC25FC1;
	Tue, 21 Jun 2016 15:00:05 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v3 1/9] am: stop ignoring errors reported by log_tree_diff()
References: <cover.1466420060.git.johannes.schindelin@gmx.de>
	<cover.1466505222.git.johannes.schindelin@gmx.de>
	<e1d68fa14e7938f7e3a07bb85db28aa84017710d.1466505222.git.johannes.schindelin@gmx.de>
Date:	Tue, 21 Jun 2016 11:59:59 -0700
In-Reply-To: <e1d68fa14e7938f7e3a07bb85db28aa84017710d.1466505222.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Tue, 21 Jun 2016 12:34:50 +0200
	(CEST)")
Message-ID: <xmqqporapdu8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5DD34AF0-37E2-11E6-94DD-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Note: there are more places in the builtin am code that ignore
> errors returned from library functions. Fixing those is outside the
> purview of the current patch series, though.

The caller of parse_mail() and parse_mail_rebase() is not prepared
to see an error code in the returned value from these function,
which are to return a boolean telling the caller to skip or use the
patch file.  At least the caller needs to notice negative return and
made to die/exit(128), instead of silently skipping a corrupt or
unopenable patch, no?  Otherwise this will change the behaviour.

> Cc: Paul Tan <pyokagan@gmail.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/am.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/am.c b/builtin/am.c
> index 3dfe70b..0e28a62 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -1433,12 +1433,15 @@ static void get_commit_info(struct am_state *state, struct commit *commit)
>  /**
>   * Writes `commit` as a patch to the state directory's "patch" file.
>   */
> -static void write_commit_patch(const struct am_state *state, struct commit *commit)
> +static int write_commit_patch(const struct am_state *state, struct commit *commit)
>  {
>  	struct rev_info rev_info;
>  	FILE *fp;
>  
> -	fp = xfopen(am_path(state, "patch"), "w");
> +	fp = fopen(am_path(state, "patch"), "w");
> +	if (!fp)
> +		return error(_("Could not open %s for writing"),
> +			am_path(state, "patch"));
>  	init_revisions(&rev_info, NULL);
>  	rev_info.diff = 1;
>  	rev_info.abbrev = 0;
> @@ -1453,7 +1456,7 @@ static void write_commit_patch(const struct am_state *state, struct commit *comm
>  	rev_info.diffopt.close_file = 1;
>  	add_pending_object(&rev_info, &commit->object, "");
>  	diff_setup_done(&rev_info.diffopt);
> -	log_tree_commit(&rev_info, commit);
> +	return log_tree_commit(&rev_info, commit);
>  }
>  
>  /**
> @@ -1501,13 +1504,14 @@ static int parse_mail_rebase(struct am_state *state, const char *mail)
>  	unsigned char commit_sha1[GIT_SHA1_RAWSZ];
>  
>  	if (get_mail_commit_sha1(commit_sha1, mail) < 0)
> -		die(_("could not parse %s"), mail);
> +		return error(_("could not parse %s"), mail);
>  
>  	commit = lookup_commit_or_die(commit_sha1, mail);
>  
>  	get_commit_info(state, commit);
>  
> -	write_commit_patch(state, commit);
> +	if (write_commit_patch(state, commit) < 0)
> +		return -1;
>  
>  	hashcpy(state->orig_commit, commit_sha1);
>  	write_state_text(state, "original-commit", sha1_to_hex(commit_sha1));
