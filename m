Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6C791F404
	for <e@80x24.org>; Thu,  4 Jan 2018 23:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751172AbeADXsl (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 18:48:41 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51430 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751108AbeADXsk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 18:48:40 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 431A2CC6C0;
        Thu,  4 Jan 2018 18:48:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hHMuzQMXnF2rp52Akv7VVsibXk0=; b=SRY4xN
        lBO8r/ZhliarVWEifO0yQP50SlO81jcii8kvKrxmGGeJm0iZxfsw97+04GeI8GW6
        jQTgukZOjA6algnfowuXHhHgJcPbdCW9DPy+Vg0RM4pj5Li4oc6iltfv4sDacfSo
        BCDJyOwM5EQG0kH/F2V8DNVRnZ5as/oYIFV+0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qCS5rjXCo0blZG6K/DxDH5BO1KC+Rfhh
        h83u32amCgCPh1/GYnhq4dNn7z9pyDMIw7bmBLseNueFC9xJft2W9nAFFac6U7rX
        mqPdAsImHEiIpUBSPShtaO3U6y92ymDSak6L3SQiw0iJNVcUiyLn6mFhIZCMAUYN
        bD/zsBnAySI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3B731CC6BF;
        Thu,  4 Jan 2018 18:48:40 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AC354CC6BE;
        Thu,  4 Jan 2018 18:48:39 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Stephan Janssen <sjanssen@you-get.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 4/4] clone: do not clean up directories we didn't create
References: <20180102210753.GA10430@sigill.intra.peff.net>
        <20180102211139.GD22556@sigill.intra.peff.net>
Date:   Thu, 04 Jan 2018 15:48:38 -0800
In-Reply-To: <20180102211139.GD22556@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 2 Jan 2018 16:11:39 -0500")
Message-ID: <xmqq7esxdw2x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C9E69756-F1A9-11E7-AC7B-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> diff --git a/builtin/clone.c b/builtin/clone.c
> index 04b0d7283f..284651797e 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -502,12 +504,12 @@ static void remove_junk(void)
>  
>  	if (junk_git_dir) {
>  		strbuf_addstr(&sb, junk_git_dir);
> -		remove_dir_recursively(&sb, 0);
> +		remove_dir_recursively(&sb, junk_git_dir_flags);
>  		strbuf_reset(&sb);
>  	}
>  	if (junk_work_tree) {
>  		strbuf_addstr(&sb, junk_work_tree);
> -		remove_dir_recursively(&sb, 0);
> +		remove_dir_recursively(&sb, junk_work_tree_flags);
>  	}
>  	strbuf_release(&sb);
>  }
> @@ -972,14 +974,24 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  		if (safe_create_leading_directories_const(work_tree) < 0)
>  			die_errno(_("could not create leading directories of '%s'"),
>  				  work_tree);
> -		if (!dest_exists && mkdir(work_tree, 0777))
> +		if (dest_exists)
> +			junk_work_tree_flags |= REMOVE_DIR_KEEP_TOPLEVEL;
> +		else if (mkdir(work_tree, 0777))
>  			die_errno(_("could not create work tree dir '%s'"),
>  				  work_tree);
>  		junk_work_tree = work_tree;
>  		set_git_work_tree(work_tree);
>  	}
>  
> -	junk_git_dir = real_git_dir ? real_git_dir : git_dir;
> +	if (real_git_dir) {
> +		if (dir_exists(real_git_dir))
> +			junk_git_dir_flags |= REMOVE_DIR_KEEP_TOPLEVEL;
> +		junk_git_dir = real_git_dir;
> +	} else {
> +		if (dest_exists)
> +			junk_git_dir_flags |= REMOVE_DIR_KEEP_TOPLEVEL;
> +		junk_git_dir = git_dir;
> +	}
>  	if (safe_create_leading_directories_const(git_dir) < 0)
>  		die(_("could not create leading directories of '%s'"), git_dir);

The changes all look reasonable.

Thanks.
