Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8F1C1F855
	for <e@80x24.org>; Tue,  2 Aug 2016 06:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756121AbcHBGRx (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 02:17:53 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:33623 "EHLO bsmtp5.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751247AbcHBGRv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 02:17:51 -0400
Received: from bsmtp3.bon.at (unknown [192.168.181.101])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 3s3QQ848Nvz5vfR
	for <git@vger.kernel.org>; Tue,  2 Aug 2016 07:54:40 +0200 (CEST)
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3s3QNr5thpz5tlM;
	Tue,  2 Aug 2016 07:53:32 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 2886052D9;
	Tue,  2 Aug 2016 07:53:32 +0200 (CEST)
Subject: Re: [PATCH v3 06/10] run-command: add clean_on_exit_handler
To:	Lars Schneider <larsxschneider@gmail.com>
References: <20160727000605.49982-1-larsxschneider%40gmail.com/>
 <20160729233801.82844-1-larsxschneider@gmail.com>
 <20160729233801.82844-7-larsxschneider@gmail.com>
 <ef6c6152-a720-6bd5-22bb-6ebf375ca919@kdbg.org>
 <EBBE9E5E-1A39-4124-AB0D-D74EE01FA0DA@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>, gitster@pobox.com,
	jnareb@gmail.com, tboegi@web.de, mlbright@gmail.com, e@80x24.org,
	peff@peff.net
From:	Johannes Sixt <j6t@kdbg.org>
Message-ID: <c2a8149b-8a61-81d8-f07b-31b80e565fda@kdbg.org>
Date:	Tue, 2 Aug 2016 07:53:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2
MIME-Version: 1.0
In-Reply-To: <EBBE9E5E-1A39-4124-AB0D-D74EE01FA0DA@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 01.08.2016 um 13:14 schrieb Lars Schneider:
 >> On 30 Jul 2016, at 11:50, Johannes Sixt <j6t@kdbg.org> wrote:
 >> Am 30.07.2016 um 01:37 schrieb larsxschneider@gmail.com:
 >>> static struct child_to_clean *children_to_clean;
 >>> @@ -30,6 +31,8 @@ static void cleanup_children(int sig, int in_signal)
 >>> {
 >>> 	while (children_to_clean) {
 >>> 		struct child_to_clean *p = children_to_clean;
 >>> +		if (p->clean_on_exit_handler)
 >>> +			p->clean_on_exit_handler(p->pid);
 >>
 >> This summons demons. cleanup_children() is invoked from a signal
 >> handler. In this case, it can call only async-signal-safe functions.
 >> It does not look like the handler that you are going to install
 >> later will take note of this caveat!
 >>
 >>> 		children_to_clean = p->next;
 >>> 		kill(p->pid, sig);
 >>> 		if (!in_signal)
 >>
 >> The condition that we see here in the context protects free(p)
 >> (which is not async-signal-safe). Perhaps the invocation of the new
 >> callback should be skipped in the same manner when this is called
 >> from a signal handler? 507d7804 (pager: don't use unsafe functions
 >> in signal handlers) may be worth a look.
 >
 > Thanks a lot of pointing this out to me!
 >
 > Do I get it right that after the signal "SIGTERM" I can do a cleanup
 > and don't need to worry about any function calls but if I get any
 > other signal then I can only perform async-signal-safe calls?

No. SIGTERM is not special.

Perhaps you were misled by the SIGTERM mentioned in 
cleanup_children_on_exit()? This function is invoked on regular exit 
(not from a signal). SIGTERM is used in this case to terminate children 
that are still lingering around.

 > If this is correct, then the following solution would work great:
 >
 > 		if (!in_signal && p->clean_on_exit_handler)
 > 			p->clean_on_exit_handler(p->pid);

This should work nevertheless because in_signal is set when the function 
is invoked from a signal handler (of any signal that is caught) via 
cleanup_children_on_signal().

-- Hannes

