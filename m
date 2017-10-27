Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7A4A1FAED
	for <e@80x24.org>; Fri, 27 Oct 2017 17:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932384AbdJ0Rkj (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 13:40:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52948 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932370AbdJ0Rki (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 13:40:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8FA1CB907C;
        Fri, 27 Oct 2017 13:40:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mB3CfTZppsl3yTuuYX4HbtWCWbU=; b=lx5Nqg
        T2WJwRHSddtnmd+/5FCGSojLZuakAm3D4pNmfDiVPfgVMxFmjj4h166O/4KnIU6/
        eEWJ5/06+iE7yOIADxRfWa/BrqTTTpssNtWRdZXYSeU94AOcp4Vj+5S7MqW9c7Dn
        Os7q8kxMZ2l1xIbPzqtLaad2wZLy7JVA9qGvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=p0B8aR7d3oJvsUEDYy+jLOPh+YoJo7r9
        +P8A56EI7+44zWuiO9/RrpLAfJdGQ0TxmcVVnVzHpeI+vCIdN83Cp9ZAKKNloCde
        efVK5vwKL3mWZlZYPoYmDd81HXBh1Cqpxgl/6p84Bo9ssPJdGDdT9Gwwzkt9poRE
        Icd9tX/rR8U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 873F8B907A;
        Fri, 27 Oct 2017 13:40:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0E62BB9079;
        Fri, 27 Oct 2017 13:40:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v16 Part II 1/8] bisect--helper: `bisect_reset` shell function in C
References: <0102015ecc65d695-22151d3b-752b-4c10-a3a3-b8ef52491664-000000@eu-west-1.amazonses.com>
        <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
Date:   Sat, 28 Oct 2017 02:40:35 +0900
In-Reply-To: <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
        (Pranit Bauva's message of "Fri, 27 Oct 2017 15:06:37 +0000")
Message-ID: <xmqqshe4bib0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F11D2E2C-BB3D-11E7-8B9B-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

> +static int bisect_reset(const char *commit)
> +{
> +	struct strbuf branch = STRBUF_INIT;
> +
> +	if (!commit) {
> +		if (strbuf_read_file(&branch, git_path_bisect_start(), 0) < 1)
> +			return !printf(_("We are not bisecting.\n"));
> +		strbuf_rtrim(&branch);
> +	} else {
> +		struct object_id oid;
> +
> +		if (get_oid_commit(commit, &oid))
> +			return error(_("'%s' is not a valid commit"), commit);
> +		strbuf_addstr(&branch, commit);

The original checks "test -s BISECT_START" and complains, even when
an explicit commit is given.  With this change, when the user is not
bisecting, giving "git bisect reset master" goes ahead---it is
likely that BISECT_HEAD does not exist and we may hit "Could not
check out" error, but if BISECT_HEAD is left behind from a previous
run (which is likely completely unrelated to whatever the user
currently is doing), we'd end up doing quite a random thing, no?

> +	}
> +
> +	if (!file_exists(git_path_bisect_head())) {
> +		struct argv_array argv = ARGV_ARRAY_INIT;
> +
> +		argv_array_pushl(&argv, "checkout", branch.buf, "--", NULL);
> +		if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
> +			error(_("Could not check out original HEAD '%s'. Try "
> +				"'git bisect reset <commit>'."), branch.buf);
> +			strbuf_release(&branch);
> +			argv_array_clear(&argv);
> +			return -1;

How does this return value affect the value eventually given to
exit(3), called by somewhere in git.c that called this function?

The call graph would be

    common-main.c::main()
    -> git.c::cmd_main()
       -> handle_builtin()
          . exit(run_builtin())
          -> run_builtin()
             . status = p->fn()
             -> cmd_bisect__helper()
                . return bisect_reset()
                -> bisect_reset()
                   . return -1
             . if (status) return status;

So the -1 is returned throughout the callchain and exit(3) ends up
getting it---which is not quite right.  We shouldn't be giving
negative value to exit(3).  bisect_clean_state() and other helper
functions may already share the same issue.

> +		}
> +		argv_array_clear(&argv);
> +	}
> +
> +	strbuf_release(&branch);
> +	return bisect_clean_state();
> +}
