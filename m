Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A33A1FADF
	for <e@80x24.org>; Thu, 11 Jan 2018 20:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932505AbeAKUsO (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jan 2018 15:48:14 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52962 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932290AbeAKUsN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jan 2018 15:48:13 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 207C9C473C;
        Thu, 11 Jan 2018 15:48:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JmCm2rXlq6AVfEifQZ0xossdJjo=; b=E6I2kt
        IfBLMilY5PwzGPwNX56bTjb3AXMOVdlGNkbjzj8cUPc8RwluQS5Y3irWDEn3mAtC
        a0JMhryC0Zusuqf1PcfnhLFCzxBKQkCGiSxGxp9W1UwJaOmrPNolGjUrTd724SO4
        lImuKM9tc6Vpb70pEfK0oe+18/REU9ZIexXec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cyAXeyQadHqXvck49eH2NpL0YEuEiEM1
        ZkxiFA9IoWZeiu6ufg7UaLaEzMVKW7a1O0Gv8ei2YMIKKvLzhUj1BdDgkWbhU7fL
        GYnalGLFykMMdQW6thrwgBzcuANUWb5E8DR9c+LRtUitcuyrUt/Q0XJN1zlXP0Mv
        gPyw+F65cnk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1829BC473B;
        Thu, 11 Jan 2018 15:48:13 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8B8BEC473A;
        Thu, 11 Jan 2018 15:48:12 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com, sbeller@google.com
Subject: Re: [PATCH v2 2/2] submodule: port submodule subcommand 'deinit' from shell to C
References: <20180109175703.4793-1-pc44800@gmail.com>
        <20180111201721.25930-1-pc44800@gmail.com>
        <20180111201721.25930-3-pc44800@gmail.com>
Date:   Thu, 11 Jan 2018 12:48:11 -0800
In-Reply-To: <20180111201721.25930-3-pc44800@gmail.com> (Prathamesh Chavan's
        message of "Fri, 12 Jan 2018 01:47:21 +0530")
Message-ID: <xmqqh8rsxgtw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BD5185F2-F710-11E7-8AA4-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prathamesh Chavan <pc44800@gmail.com> writes:

> +	/* remove the submodule work tree (unless the user already did it) */
> +	if (is_directory(path)) {
> +		struct strbuf sb_rm = STRBUF_INIT;
> +		const char *format;
> +
> +		/*
> +		 * protect submodules containing a .git directory
> +		 * NEEDSWORK: instead of dying, automatically call
> +		 * absorbgitdirs and (possibly) warn.
> +		 */
> +		if (is_directory(sub_git_dir))
> +			die(_("Submodule work tree '%s' contains a .git "
> +			      "directory (use 'rm -rf' if you really want "
> +			      "to remove it including all of its history)"),
> +			    displaypath);
> +
> +		if (!(flags & OPT_FORCE)) {
> +			struct child_process cp_rm = CHILD_PROCESS_INIT;
> +			cp_rm.git_cmd = 1;
> +			argv_array_pushl(&cp_rm.args, "rm", "-qn",
> +					 path, NULL);
> +
> +			if (run_command(&cp_rm))
> +				die(_("Submodule work tree '%s' contains local "
> +				      "modifications; use '-f' to discard them"),
> +				      displaypath);
> +		}
> +
> +		strbuf_addstr(&sb_rm, path);
> +
> +		if (!remove_dir_recursively(&sb_rm, 0))
> +			format = _("Cleared directory '%s'\n");
> +		else
> +			format = _("Could not remove submodule work tree '%s'\n");
> +
> +		if (!(flags & OPT_QUIET))
> +			printf(format, displaypath);
> +
> +		strbuf_release(&sb_rm);
> +	}
> +
> +	if (mkdir(path, 0777))
> +		die_errno(_("could not create empty submodule directory %s"),
> +		      displaypath);

If path was a directory (which presumably is the normal case) and
recursive removal fails (i.e. when the code says "Could not remove"),
this mkdir() would also fail with EEXIST.

In such a case, the original code did not die and instead continued
to remove the entries for the submodule from the configuration.
This "rewritten" version dies, leaving the stale configuration for
the submodule we failed to get rid of from the working tree.

I offhand do not know which one of these error case behaviours is
more useful; the user needs to do something (e.g. loosening the perm
in some paths in the submodule that prevented "rm -rf" from working
with "chmod u+w sub/some/path" and removing it manually) to recover
in either case, and cleaning as much as possible by removing the
configuration entries even when this mkdir() fails would probably be
a better behaviour, as long as the command as a whole exits with non
zero status to signal an error.
