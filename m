From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 15/19] pull: teach git pull about --rebase
Date: Tue, 09 Jun 2015 18:56:11 -0700
Message-ID: <xmqqk2vcuy10.fsf@gitster.dls.corp.google.com>
References: <1433314143-4478-1-git-send-email-pyokagan@gmail.com>
	<1433314143-4478-16-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 03:56:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2VFa-0004Hx-RQ
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 03:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933042AbbFJB4P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 21:56:15 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:33308 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932982AbbFJB4N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 21:56:13 -0400
Received: by igbpi8 with SMTP id pi8so25534073igb.0
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 18:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=uFYD9ggGw+T74zSqC9sGclVyQck+52EXOYKNpBBu2Ks=;
        b=CaaCs4jLXRKOSMf8VGdh9QhlUawT2JV+nUfVT6xuBZ7Gyk5m3ll0Pv/2DaOFPod+Tk
         yJSwbQRiQ6i2xQUifhTW1j2kMQVJgiqQ3Xi+GKjNxuM2x50PwqXh3AvflXgMNztUNJEd
         GiJ+nchQj21ExwAKntZeECe04QFAcnPb7psXDAkN/irwHdS8/2cw+AA6uFioZypVWdQA
         mLFugQnDzCGQ84Mcn/r4eDtTxTkhG3l1cYHLmKUiK7L5FADoywUs5HJ68vA/NSE17sQ8
         TVWJ4tx8ALo7TuTEYhCDp5n1bKqI9EP0ofP18CMEiwcIDAUUC9E92uZmZHuYrP/VQ8Gq
         b9gw==
X-Received: by 10.43.133.137 with SMTP id hy9mr1999778icc.74.1433901373306;
        Tue, 09 Jun 2015 18:56:13 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b116:bf29:c748:758b])
        by mx.google.com with ESMTPSA id rp7sm2427039igb.21.2015.06.09.18.56.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Jun 2015 18:56:12 -0700 (PDT)
In-Reply-To: <1433314143-4478-16-git-send-email-pyokagan@gmail.com> (Paul
	Tan's message of "Wed, 3 Jun 2015 14:48:59 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271251>

Paul Tan <pyokagan@gmail.com> writes:

> +enum rebase_type {
> +	REBASE_INVALID = -1,
> +	REBASE_FALSE = 0,
> +	REBASE_TRUE,
> +	REBASE_PRESERVE
> +};
> +
> +/**
> + * Parses the value of --rebase, branch.*.rebase or pull.rebase. If value is a
> + * false value, returns REBASE_FALSE. If value is a true value, returns
> + * REBASE_TRUE. If value is "preserve", returns REBASE_PRESERVE. Otherwise,
> + * returns -1 to signify an invalid value.
> + */
> +static enum rebase_type parse_config_rebase(const char *value)
> +{
> +	int v = git_config_maybe_bool("pull.rebase", value);
> +	if (!v)
> +		return REBASE_FALSE;
> +	else if (v >= 0)
> +		return REBASE_TRUE;

It is somewhat misleading to say "v >= 0" when you already use !v to
signal something else.  Perhaps "else if (v > 0)" is better?

> +/**
> + * Returns remote's upstream branch for the current branch. If remote is NULL,
> + * the current branch's configured default remote is used. Returns NULL if
> + * `remote` does not name a valid remote, HEAD does not point to a branch,
> + * remote is not the branch's configured remote or the branch does not have any
> + * configured upstream branch.
> + */
> +static char *get_upstream_branch(const char *remote)
> +{
> +	struct remote *rm;
> +	struct branch *curr_branch;
> +
> +	rm = remote_get(remote);
> +	if (!rm)
> +		return NULL;
> +
> +	curr_branch = branch_get("HEAD");
> +	if (!curr_branch)
> +		return NULL;
> +
> +	if (curr_branch->remote != rm)
> +		return NULL;
> +
> +	if (!curr_branch->merge_nr)
> +		return NULL;
> +
> +	return xstrdup(curr_branch->merge[0]->dst);
> +}

Hmph, it is somewhat surprising that we do not have such a helper
already. Wouldn't we need this logic to implement $branch@{upstream}
syntax?

> +/**
> + * Derives the remote tracking branch from the remote and refspec.
> + *
> + * FIXME: The current implementation assumes the default mapping of
> + * refs/heads/<branch_name> to refs/remotes/<remote_name>/<branch_name>.
> + */
> +static char *get_tracking_branch(const char *remote, const char *refspec)
> +{

This does smell like an incomplete reimplementation of what
get_fetch_map() knows how to do.

> +/**
> + * Given the repo and refspecs, sets fork_point to the point at which the
> + * current branch forked from its remote tracking branch. Returns 0 on success,
> + * -1 on failure.
> + */
> +static int get_rebase_fork_point(unsigned char fork_point[GIT_SHA1_RAWSZ],
> +		const char *repo, const char *refspec)
> +{
> +...
> +}

This function looks OK (the two get_*_branch() helpers it uses I am
not sure about though).

Same comment on "fork_point[]" parameter's type applies here,
though.  While I do not mind if you used "struct object_id" to
represent these object names, if you are sticking to the traditional
"unsigned char [20]", then these should be "unsigned char *" to be
consistent with others.

> +/**
> + * Sets merge_base to the octopus merge base of curr_head, merge_head and
> + * fork_point. Returns 0 if a merge base is found, 1 otherwise.
> + */
> +static int get_octopus_merge_base(unsigned char merge_base[GIT_SHA1_HEXSZ],
> +		unsigned char curr_head[GIT_SHA1_RAWSZ],
> +		unsigned char merge_head[GIT_SHA1_RAWSZ],
> +		unsigned char fork_point[GIT_SHA1_RAWSZ])
> +{
> +...
> +}

OK (and everything after this point looks good).
