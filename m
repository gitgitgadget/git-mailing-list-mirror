Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F33920960
	for <e@80x24.org>; Thu, 13 Apr 2017 19:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755136AbdDMT3a (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 15:29:30 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:51918 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752145AbdDMT33 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 15:29:29 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 8807220960;
        Thu, 13 Apr 2017 19:29:28 +0000 (UTC)
Date:   Thu, 13 Apr 2017 19:29:28 +0000
From:   Eric Wong <e@80x24.org>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH v2 4/6] run-command: don't die in child when duping
 /dev/null
Message-ID: <20170413192928.GA6129@whir>
References: <20170410234919.34586-1-bmwill@google.com>
 <20170413183252.4713-1-bmwill@google.com>
 <20170413183252.4713-5-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170413183252.4713-5-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> wrote:
> @@ -487,7 +483,7 @@ int start_command(struct child_process *cmd)
>  		atexit(notify_parent);
>  
>  		if (cmd->no_stdin)
> -			dup_devnull(0);
> +			dup2(null_fd, 0);

I prefer we keep error checking for dup2 failures,
and also add more error checking for unchecked dup2 calls.
Can be a separate patch, I suppose.

Ditto for other dup2 changes

> @@ -558,6 +554,8 @@ int start_command(struct child_process *cmd)
>  	}
>  	close(notify_pipe[0]);
>  
> +	if (null_fd > 0)
> +		close(null_fd);

I would prefer:

	if (null_fd >= 0)

here, even if we currently do not release stdin.

>  	argv_array_clear(&argv);
>  	free(childenv);
