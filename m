Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB8991F858
	for <e@80x24.org>; Sat, 30 Jul 2016 09:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbcG3JuR (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 05:50:17 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:12924 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750826AbcG3JuP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 05:50:15 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3s1gnK1vn0z5tlJ;
	Sat, 30 Jul 2016 11:50:13 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 70D5352D7;
	Sat, 30 Jul 2016 11:50:12 +0200 (CEST)
Subject: Re: [PATCH v3 06/10] run-command: add clean_on_exit_handler
To:	larsxschneider@gmail.com
References: <20160727000605.49982-1-larsxschneider%40gmail.com/>
 <20160729233801.82844-1-larsxschneider@gmail.com>
 <20160729233801.82844-7-larsxschneider@gmail.com>
Cc:	git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com,
	tboegi@web.de, mlbright@gmail.com, e@80x24.org, peff@peff.net
From:	Johannes Sixt <j6t@kdbg.org>
Message-ID: <ef6c6152-a720-6bd5-22bb-6ebf375ca919@kdbg.org>
Date:	Sat, 30 Jul 2016 11:50:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2
MIME-Version: 1.0
In-Reply-To: <20160729233801.82844-7-larsxschneider@gmail.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 30.07.2016 um 01:37 schrieb larsxschneider@gmail.com:
> Some commands might need to perform cleanup tasks on exit. Let's give
> them an interface for doing this.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  run-command.c | 12 ++++++++----
>  run-command.h |  1 +
>  2 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/run-command.c b/run-command.c
> index 33bc63a..197b534 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -21,6 +21,7 @@ void child_process_clear(struct child_process *child)
>
>  struct child_to_clean {
>  	pid_t pid;
> +	void (*clean_on_exit_handler)(pid_t);
>  	struct child_to_clean *next;
>  };
>  static struct child_to_clean *children_to_clean;
> @@ -30,6 +31,8 @@ static void cleanup_children(int sig, int in_signal)
>  {
>  	while (children_to_clean) {
>  		struct child_to_clean *p = children_to_clean;
> +		if (p->clean_on_exit_handler)
> +			p->clean_on_exit_handler(p->pid);

This summons demons. cleanup_children() is invoked from a signal 
handler. In this case, it can call only async-signal-safe functions. It 
does not look like the handler that you are going to install later will 
take note of this caveat!

>  		children_to_clean = p->next;
>  		kill(p->pid, sig);
>  		if (!in_signal)

The condition that we see here in the context protects free(p) (which is 
not async-signal-safe). Perhaps the invocation of the new callback 
should be skipped in the same manner when this is called from a signal 
handler? 507d7804 (pager: don't use unsafe functions in signal handlers) 
may be worth a look.

-- Hannes

