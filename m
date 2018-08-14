Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A916D1F428
	for <e@80x24.org>; Tue, 14 Aug 2018 18:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbeHNVdk (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 17:33:40 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:33952 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727755AbeHNVdk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 17:33:40 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id C38C71F404;
        Tue, 14 Aug 2018 18:45:09 +0000 (UTC)
Date:   Tue, 14 Aug 2018 18:45:09 +0000
From:   Eric Wong <e@80x24.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] send-email: add an option to impose delay sent E-Mails
Message-ID: <20180814184509.GA16659@dcvr>
References: <20180325182803.30036-1-avarab@gmail.com>
 <20180814181534.21234-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180814181534.21234-1-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> Add a --send-delay option with a corresponding sendemail.smtpSendDelay
> configuration variable. When set to e.g. 2, this causes send-email to
> sleep 2 seconds before sending the next E-Mail. We'll only sleep
> between sends, not before the first send, or after the last.
> 
> This option has two uses. Firstly, to be able to Ctrl+C a long send
> with "all" if you have a change of heart. Secondly, as a hack in some
> mail setups to, with a sufficiently high delay, force the receiving
> client to sort the E-Mails correctly.
> 
> Some popular E-Mail clients completely ignore the "Date" header, which
> format-patch is careful to set such that the patches will be displayed
> in order, and instead sort by the time the E-mail was received.
> 
> Google's GMail is a good example of such a client. It ostensibly sorts
> by some approximation of received time (although not by any "Received"
> header). It's more usual than not to see patches showing out of order
> in GMail. To take a few examples of orders seen on patches on the Git
> mailing list:
> 
>     1 -> 3 -> 4 -> 2 -> 8 -> 7 (completion by Nguyễn Thái Ngọc Duy)
>     2 -> 0 -> 1 -> 3 (pack search by Derrick Stolee)
>     3 -> 2 -> 1 (fast-import by Jameson Miller)
>     2 -> 3 -> 1 -> 5 -> 4 -> 6 (diff-highlight by Jeff King)
> 
> The reason to add the new "X-Mailer-Send-Delay" header is to make it
> easy to tell what the imposed delay was, if any. This allows for
> gathering some data on how the transfer of E-Mails with & without this
> option behaves. This may not be workable without really long delays,
> see [1] and [2].

Aside from the new header, I think this is better implemented
using the existing $relogin_delay and $batch_size=1.

Disconnecting during the delay might be more sympathetic to
existing mail servers (which aren't C10K-optimized).  If the
client sleeps, the server may disconnect the client anyways
to save resources.

> @@ -1741,6 +1747,10 @@ sub process_file {
>  		$message, $xfer_encoding, $target_xfer_encoding);
>  	push @xh, "Content-Transfer-Encoding: $xfer_encoding";
>  	unshift @xh, 'MIME-Version: 1.0' unless $has_mime_version;
> +	if ($send_delay && $i > 0) {
> +		push @xh, "X-Mailer-Send-Delay: $send_delay";
> +		sleep $send_delay;
> +	}

We can add this header for relogin_delay + batch_size

But maybe --send-delay can be a shortcut for
--relogin-delay and --batch-size=1
