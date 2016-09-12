Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2281520984
	for <e@80x24.org>; Mon, 12 Sep 2016 08:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756464AbcILIf1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 04:35:27 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:53694 "EHLO bsmtp4.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756309AbcILIf0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 04:35:26 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp4.bon.at (Postfix) with ESMTPSA id 3sXh2h1MYCz5tmD;
        Mon, 12 Sep 2016 10:35:23 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 8153452E4;
        Mon, 12 Sep 2016 10:35:23 +0200 (CEST)
Subject: Re: [PATCH v2 21/25] sequencer: refactor write_message()
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
 <cover.1473590966.git.johannes.schindelin@gmx.de>
 <da2293aee439da2274e30304e2d1f097b9644e64.1473590966.git.johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <e21e3391-bfc3-68b8-8eaf-0e15e5a436c5@kdbg.org>
Date:   Mon, 12 Sep 2016 10:35:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <da2293aee439da2274e30304e2d1f097b9644e64.1473590966.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.09.2016 um 12:55 schrieb Johannes Schindelin:
> -static int write_message(struct strbuf *msgbuf, const char *filename)
> +static int write_with_lock_file(const char *filename,
> +				const void *buf, size_t len, int append_eol)
>  {
>  	static struct lock_file msg_file;
>
>  	int msg_fd = hold_lock_file_for_update(&msg_file, filename, 0);
>  	if (msg_fd < 0)
>  		return error_errno(_("Could not lock '%s'"), filename);
> -	if (write_in_full(msg_fd, msgbuf->buf, msgbuf->len) < 0)
> -		return error_errno(_("Could not write to %s"), filename);
> -	strbuf_release(msgbuf);
> +	if (write_in_full(msg_fd, buf, len) < 0)
> +		return error_errno(_("Could not write to '%s'"), filename);
> +	if (append_eol && write(msg_fd, "\n", 1) < 0)
> +		return error_errno(_("Could not write eol to '%s"), filename);
>  	if (commit_lock_file(&msg_file) < 0)
>  		return error(_("Error wrapping up %s."), filename);
>
>  	return 0;
>  }

The two error paths in the added lines should both

		rollback_lock_file(&msg_file);

, I think. But I do notice that this is not exactly new, so...

-- Hannes

