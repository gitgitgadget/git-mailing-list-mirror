Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4BCF1FEB3
	for <e@80x24.org>; Thu, 12 Jan 2017 19:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750805AbdALTAT (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 14:00:19 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53757 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750707AbdALTAS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 14:00:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1FA675F7BF;
        Thu, 12 Jan 2017 14:00:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Bl3Joodl0HSll15XLXVJGnqVO0U=; b=sCCVGl
        yZl9TEAVVLVWNik9ZTZr1RULQhqCmygwHe1nZLQU9hPr2j5hUCpmN7Hhlw0zrGGS
        fjInV3fMSiPBeVRNBqgrGTYx5kC114zaA+cucZseUc3ecLIwVuB//yP2PDso1rZF
        ocwca5U7X+bfMvq1UxhFZ6KcOBHwQbU+emZLw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Meg0j6NMmWtt0UBR4ldyXB5Oz1YllvWR
        M9Z5ikUUGClYsdUnvavzHIboj9pRzfU3tkFd1J7Gk+Irgj5afB4ZOzrlomW30nH9
        8eiWCQdgOuOQ1BPB3AycmP2UTsQLbDRsl2lgpwQvrMfB81d/2aOGfwzyBgUv2ZYc
        lxydRWns0j0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0A90D5F7BE;
        Thu, 12 Jan 2017 14:00:17 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 03A035F7BD;
        Thu, 12 Jan 2017 14:00:16 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 06/38] sequencer (rebase -i): implement the 'edit' command
References: <cover.1481642927.git.johannes.schindelin@gmx.de>
        <cover.1483370556.git.johannes.schindelin@gmx.de>
        <736f100f4c219ee5c81e1e7b664128785df80521.1483370556.git.johannes.schindelin@gmx.de>
Date:   Thu, 12 Jan 2017 11:00:14 -0800
In-Reply-To: <736f100f4c219ee5c81e1e7b664128785df80521.1483370556.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Mon, 2 Jan 2017 16:26:43 +0100
        (CET)")
Message-ID: <xmqq7f60kssh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5AAA43E8-D8F9-11E6-B677-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> +static int make_patch(struct commit *commit, struct replay_opts *opts)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	struct rev_info log_tree_opt;
> +	const char *subject, *p;
> +	int res = 0;
> +
> +	p = short_commit_name(commit);
> +	if (write_message(p, strlen(p), rebase_path_stopped_sha(), 1) < 0)
> +		return -1;
> +
> +	strbuf_addf(&buf, "%s/patch", get_dir(opts));
> +	memset(&log_tree_opt, 0, sizeof(log_tree_opt));
> +	init_revisions(&log_tree_opt, NULL);
> +	log_tree_opt.abbrev = 0;
> +	log_tree_opt.diff = 1;
> +	log_tree_opt.diffopt.output_format = DIFF_FORMAT_PATCH;
> +	log_tree_opt.disable_stdin = 1;
> +	log_tree_opt.no_commit_id = 1;
> +	log_tree_opt.diffopt.file = fopen(buf.buf, "w");
> +	log_tree_opt.diffopt.use_color = GIT_COLOR_NEVER;
> +	if (!log_tree_opt.diffopt.file)
> +		res |= error_errno(_("could not open '%s'"), buf.buf);
> +	else {
> +		res |= log_tree_commit(&log_tree_opt, commit);
> +		fclose(log_tree_opt.diffopt.file);
> +	}
> +	strbuf_reset(&buf);
> +
> +	strbuf_addf(&buf, "%s/message", get_dir(opts));
> +	if (!file_exists(buf.buf)) {
> +		const char *commit_buffer = get_commit_buffer(commit, NULL);
> +		find_commit_subject(commit_buffer, &subject);
> +		res |= write_message(subject, strlen(subject), buf.buf, 1);
> +		unuse_commit_buffer(commit, commit_buffer);
> +	}
> +	strbuf_release(&buf);
> +
> +	return res;
> +}

Unlike the scripted version, where a merge is shown with "diff --cc"
and a root commit is shown as "Root commit", this only deals with a
single-parent commit.  Is this because this helper, at least in its
current form, will not be used by "rebase -m" and not with "--root"?

If that is the case, that is perfectly fine, perhaps that deserves a
mention in the log message and in-code comment before the function.

