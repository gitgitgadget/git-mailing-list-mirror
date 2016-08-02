Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD1061F71B
	for <e@80x24.org>; Tue,  2 Aug 2016 16:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935048AbcHBQfy (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 12:35:54 -0400
Received: from us-hpatc-esg-02.alcatel-lucent.com ([135.245.18.28]:43993 "EHLO
	smtp-us.alcatel-lucent.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935199AbcHBQfp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Aug 2016 12:35:45 -0400
X-Greylist: delayed 1301 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Aug 2016 12:35:44 EDT
Received: from us70tumx2.dmz.alcatel-lucent.com (unknown [135.245.18.14])
	by Websense Email Security Gateway with ESMTPS id CC2112EBFDCB9;
	Tue,  2 Aug 2016 16:02:28 +0000 (GMT)
Received: from us70tusmtp2.zam.alcatel-lucent.com (us70tusmtp2.zam.alcatel-lucent.com [135.5.2.64])
	by us70tumx2.dmz.alcatel-lucent.com (GMO) with ESMTP id u72G2TGN016096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 2 Aug 2016 16:02:30 GMT
Received: from US70TWXCHHUB03.zam.alcatel-lucent.com (us70twxchhub03.zam.alcatel-lucent.com [135.5.2.35])
	by us70tusmtp2.zam.alcatel-lucent.com (GMO) with ESMTP id u72G2MiI032311
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 2 Aug 2016 16:02:29 GMT
Received: from [135.121.197.20] (135.5.27.16) by
 US70TWXCHHUB03.zam.alcatel-lucent.com (135.5.2.35) with Microsoft SMTP Server
 (TLS) id 14.3.195.1; Tue, 2 Aug 2016 12:01:56 -0400
Subject: Re: Client exit whilst running pre-receive hook : commit accepted but
 no post-receive hook ran
To:	Jeff King <peff@peff.net>, Jan Smets <jan.smets@nokia.com>
References: <5795EB1C.1080102@nokia.com>
 <20160725222201.GC13589@sigill.intra.peff.net>
CC:	<git@vger.kernel.org>
From:	Stephen Morton <stephen.morton@nokia.com>
Organization: Nokia ION
Message-ID: <a3f64a09-3094-eee1-0050-9960f0674036@nokia.com>
Date:	Tue, 2 Aug 2016 12:01:57 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <20160725222201.GC13589@sigill.intra.peff.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [135.5.27.16]
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 2016-07-25 6:22 PM, Jeff King wrote:
> On Mon, Jul 25, 2016 at 12:34:04PM +0200, Jan Smets wrote:
>
>> I have always assumed the post-receive hook to be executed whenever a commit
>> is "accepted" by the (gitolite) server. That does not seem to be true any
>> more.
> Generally, yeah, I would expect that to be the case, too.
>
>> Since 9658846 is appears that, when a client bails out, the pre-receive hook
>> continues to run and the commit is written to the repository, but no
>> post-receive hook is executed. No signal of any kind is received in the
>> hook, not even a sig pipe when the post- hook is writing to stdout whilst
>> the client has disconnected.
> I see. The problem is that cmd_receive_pack() does this:
>
>          execute_commands(commands, unpack_status, &si);
>          if (pack_lockfile)
>                  unlink_or_warn(pack_lockfile);
>          if (report_status)
>                  report(commands, unpack_status);
>          run_receive_hook(commands, "post-receive", 1);
>          run_update_post_hook(commands);
>
> It reports the status to the client, and _then_ runs the post-receive
> hook. But if that reporting fails (either because of an error, or if we
> just get SIGPIPE because the client hung up), then we don't actually run
> the hooks.
>
> Leaving 9658846 out of it entirely, it is always going to be racy
> whether we notice that the client hung up during the pre-receive step.
> E.g.:
>
>    - your pre-receive might not write any output, so the muxer has
>      nothing to write to the other side, and we never notice that the
>      connection closed until we write the status out in report()
>
>    - if NO_PTHREADS is set, the sideband muxer runs in a sub-process, not
>      a sub-thread. And thus we don't know of a hangup except by checking
>      the result of finish_async(), which we never do.
>
>    - the client could hang up just _after_ we've written the pre-receive
>      output, but before report() is called, so there's nothing to notice
>      until we're in report()
>
> So I think 9658846 just made that race a bit longer, because it means
> that a write error in the sideband muxer during the pre-receive hook
> means we return an error via finish_async() rather than unceremoniously
> calling exit() from a sub-thread. So we have a longer period during
> which we might actually finish off execute_commands() but not make it
> out of report().
>
> And the real solution is to make cmd_receive_pack() more robust, and try
> harder to run the hooks even when the client hangs up or we have some
> other reporting error (because getting data back to the user is only one
> use of post-receive hooks; they are also used to queue jobs or do
> maintenance).
>
> But that's a bit tricky, as it requires report() to ignore SIGPIPE, and
> to stop using write_or_die() or any other functions that can exit (some
> of which happen at a lower level). Plus if a client does hangup, we
> don't want our hook to die with SIGPIPE either, so we'd want to proxy
> the data into /dev/null.
>
> -Peff

Sounds tricky. I do think it's important, almost a 'data integrity' 
issue, that IF a commit is received, THEN the post-receive hook must be 
run. Too much mission-critical stuff is based on post-receive hooks.

The alternatives, as I see them --either document that the post-receive 
hook cannot be fully trusted and that all such uses must change to 
asynchronous polling, or otherwise just say that nobody should hit 
Ctrl-C during a push (not even reflexively when their lizard-brain says 
"Woops, no!") and hope that network issues don't cause the same thing-- 
are simply not realistic.

Stephen



