Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8758B1FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 22:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756694AbcH2WVV (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 18:21:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62263 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755886AbcH2WVU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 18:21:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 32A3D38B0B;
        Mon, 29 Aug 2016 18:21:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7FmOqJXQ8Ba9jcMJUwazoEbrcWg=; b=OMYeve
        LGl28z9GVWL2ekfnqhP9oBUI3rVHcgE6mKsIjjzr2hiUeNVV6/PvNl4K0ZPZ7C0U
        2hsi/Pq7v6K+yYsLQyLxepH6TFfNEalIh+a+r4uyLqDpfEnPi5zgvLLC7jTBQqKc
        ylmSuHNydDOCFIQZPocNrm/pkeSfY59GbJMg0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ts8KDE3QaD4jsb1KCQA3LMyTVksX7Ilx
        mwM9oMIYke5b+O9wtklxWuuMhbtfOMQM0li4crq5VurtivQVg75tut2yAX/n1e3K
        dAWYGbJPZ3bJHb1eZOFs3IcNbXnP3hj8Exlh1q/iNH4lASIpj0558NsMKHS6DwZV
        x8n8PmR4gyk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2B49838B0A;
        Mon, 29 Aug 2016 18:21:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A1B4538B09;
        Mon, 29 Aug 2016 18:21:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     larsxschneider@gmail.com
Cc:     git@vger.kernel.org, peff@peff.net, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com
Subject: Re: [PATCH v6 12/13] convert: add filter.<driver>.process option
References: <20160825110752.31581-1-larsxschneider@gmail.com>
        <20160825110752.31581-13-larsxschneider@gmail.com>
Date:   Mon, 29 Aug 2016 15:21:15 -0700
In-Reply-To: <20160825110752.31581-13-larsxschneider@gmail.com>
        (larsxschneider@gmail.com's message of "Thu, 25 Aug 2016 13:07:51
        +0200")
Message-ID: <xmqqzinv6wtg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E7C96994-6E36-11E6-B8DB-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

larsxschneider@gmail.com writes:

> +In case the filter cannot or does not want to process the content,
> +it is expected to respond with an "error" status. Depending on the
> +`filter.<driver>.required` flag Git will interpret that as error
> +but it will not stop or restart the filter process.
> +------------------------
> +packet:          git< status=error\n
> +packet:          git< 0000
> +------------------------
> +
> +In case the filter cannot or does not want to process the content
> +as well as any future content for the lifetime of the Git process,
> +it is expected to respond with an "error-all" status. Depending on
> +the `filter.<driver>.required` flag Git will interpret that as error
> +but it will not stop or restart the filter process.
> +------------------------
> +packet:          git< status=error-all\n
> +packet:          git< 0000
> +------------------------

This part of the document is well-written to help filter-writers.

One thing that was unclear from the above to me, when read as a
potential filter-writer, is when I am supposed to exit(2).  After I
tell Git with error-all (I would have called it "abort", but that's
OK) that I desire no further communication, am I free to go?  Or do
I wait until Git somehow disconnects (perhaps by closing the packet
stream I have been reading)?

> +If the filter dies during the communication or does not adhere to
> +the protocol then Git will stop the filter process and restart it
> +with the next file that needs to be processed.

Hmph, is there a reason not to retry a half-converted-and-failed
blob with the fresh process?  Note that this is not "you must do it
that way", and it is not even "I think doing so may be a better
idea".  I merely want to know the reason behind this decision.

> +After the filter has processed a blob it is expected to wait for
> +the next "key=value" list containing a command. When the Git process
> +terminates, it will send a kill signal to the filter in that stage.

The "kill" may not be very nice.  As Git side _knows_ that the
filter is waiting for the next command, having an explicit
"shutdown" command would give the filter a chance to implement a
clean exit--it may have some housekeeping tasks it wants to perform
once it is done.  The "explicit shutdown" could just be "the pipe
gets closed", so from the implementation point of view there may not
be anything you need to further add to this patch (after all, when
we exit, the pipes to them would be closed), but the shutdown
protocol and the expectation on the behaviour of filter processes
would need to be documented.

> +If a `filter.<driver>.clean` or `filter.<driver>.smudge` command
> +is configured then these commands always take precedence over
> +a configured `filter.<driver>.process` command.

It may make more sense to give precedence to the .process (which is
a late-comer) if defined, ignoring .clean and .smudge, than the
other way around.

> +Please note that you cannot use an existing `filter.<driver>.clean`
> +or `filter.<driver>.smudge` command with `filter.<driver>.process`
> +because the former two use a different inter process communication
> +protocol than the latter one.

Would it be a useful sample program we can ship in contrib/ if you
created a "filter adapter" that reads these two configuration
variables and act as a filter.<driver>.process?

During an imaginary session of "git add .", I think I found where
you start THE filter process upon the first path that needs to be
filtered with one for the configured <driver>, and I think the same
place is where you reuse THE filter process, but I am not sure where
you are cleaning up by killing the filter once all paths are added.
Wouldn't you need some hooks at strategic places after such bulk
operation to tell the multi-file-filter machinery to walk all the
entries in cmd_process_map and tell the remaining filter processes
that they have no more tasks, or something?  Are you relying on
these processes to exit upon a read failure after we exit and the
pipe going to the filter is severed?

Thanks.
