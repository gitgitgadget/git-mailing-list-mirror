Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,STOX_REPLY_TYPE,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EE8E202F2
	for <e@80x24.org>; Tue, 21 Nov 2017 00:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751714AbdKUAHb (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 19:07:31 -0500
Received: from e1i183.smtp2go.com ([103.36.108.183]:60863 "EHLO
        e1i183.smtp2go.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751275AbdKUAHb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 19:07:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=smtpservice.net; s=m1fbw0.a1-4.dyn; x=1511223751; h=Feedback-ID:
        X-Smtpcorp-Track:Date:Subject:To:From:Reply-To:Message-ID:Sender:
        List-Unsubscribe; bh=z4I6mZJOSFPvlLazsNDv2jD3FG7Gmb3dS6BJF3us3nc=; b=eaC7Fkaj
        tXPqnceqbmooSMXUHKVFekJzhn4/WAVdftxLXUnk0Iz9NXoVQ3j898FlpUHv9YrpPfAWZUVIFK4Z7
        c+XPQid7kdyLZ68xTfwxYUhXrIY+x76Vh5DUqe67JIyu78qfkWCah9gTw7ZVd//b9bGVIA+Mkbpez
        PSEcbVrhxdEGsPUJ0opnR+SN6yEF4Cgyt8NOJ6kAFM/cqoxqr2mEvXq//201UbaB4J/UGisWvYFE9
        LeAZURRajk8RTzDMDq96tZKBtLLpGfkJbmwir2fsGecl9p5fF1M68HkbB+kXFRPmB++8BRgGf7PaE
        40q8qbjqf3nPVayAvLTD0yNRoA==;
Message-ID: <D810DA8B202742B38343EBB44BD54A1D@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Eric Sunshine" <sunshine@sunshineco.com>,
        =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc:     "Git List" <git@vger.kernel.org>
References: <20171116154814.23785-1-alex.bennee@linaro.org> <CAPig+cSh0tVVkh0xF9FwCfM4gngAWMSN_FXd2zhzHcy2trYXfw@mail.gmail.com> <CAPig+cSbRrGnyDkunMFiFXbWRMAsGyuAL-0FpP1QTtjSUSY2Hg@mail.gmail.com>
Subject: Re: [PATCH] git-send-email: fix get_maintainer.pl regression
Date:   Tue, 21 Nov 2017 00:07:24 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Smtpcorp-Track: 1-Gw5z9EFSahuh.E044gOVrh
Feedback-ID: 66524m:66524aMf6O2Y:66524sDmFiOrcIT:SMTPCORP
X-Report-Abuse: Please forward a copy of this message, including all
 headers, to <abuse-contact@smtp2go.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Eric Sunshine" <sunshine@sunshineco.com>
On Sat, Nov 18, 2017 at 9:54 PM, Eric Sunshine <sunshine@sunshineco.com>
wrote:
> On Thu, Nov 16, 2017 at 10:48 AM, Alex Bennée <alex.bennee@linaro.org>
> wrote:
>> +test_expect_success $PREREQ 'cc trailer with get_maintainer output' '
>> +       [...]
>> +       git send-email -1 --to=recipient@example.com \
>> +               --cc-cmd="$(pwd)/expected-cc-script.sh" \
>> +       [...]
>> +'
>> OK I'm afraid I don't fully understand the test harness as this breaks a
>> bunch of other tests. If anyone can offer some pointers on how to fix
>> I'd be grateful.
>
> There are several problems:
> [...]
> * The directory in which the expected-cc-script.sh is created contains
> a space; this is intentional to catch bugs in tests and Git itself. In
> this case, your test is exposing what might be considered a bug in
> git-send-email itself, in which it invokes the --cc-cmd as "/path/with
> space/expected-cc-script.sh", which is interpreted as trying to invoke
> program "/path/with" with argument "space/expected-cc-script.sh". One
> > fix (which you could submit as a preparatory patch, making this a
> > 2-patch series) would be this:
> >
> > --- 8< ---
> > diff --git a/git-send-email.perl b/git-send-email.perl
> > @@ -1724,7 +1724,7 @@ sub recipients_cmd {
> > -    open my $fh, "-|", "$cmd \Q$file\E"
> > +   open my $fh, "-|", "\Q$cmd\E \Q$file\E"
> > --- 8< ---
> >
> > However, it's possible that might break existing users who rely on
> > --cc-cmd="myscript --option arg" working. It's not clear which
> > behavior is correct.
>
> The more I think about this, the less I consider this a bug in
> git-send-email. As noted, people might legitimately use a complex
> command (--cc-cmd="myscript--option arg"), so changing git-send-email
> to treat cc-cmd as an atomic string seems like a bad idea.

A while back I proposed some documentation updates
https://public-inbox.org/git/1437416790-5792-1-git-send-email-philipoakley@iee.org/
regarding what is (should be) allowed in the cc-cmd etc., and at the time
Junio suggested that possible existing uses of the current code would be
abuses. I didn't pursue it further, but it may be useful guidance here as to
potential real world command lines..

>
> Assuming no changes to git-send-email, to get your test working, you
> could try to figure out how to quote the script's path you're
> specifying with --cc-cmd, however, even easier would be to drop $(pwd)
> altogether. That is, instead of:
>
>     --cc-cmd="$(pwd)/expected-cc-script.sh"
>
> just use:
>
>     --cc-cmd=./expected-cc-script.sh

