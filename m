Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4062C433EF
	for <git@archiver.kernel.org>; Sat, 20 Nov 2021 03:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236695AbhKTDJ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 22:09:29 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:49284 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhKTDJ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 22:09:28 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E14861FD3C;
        Sat, 20 Nov 2021 03:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637377584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lPprfHYZrOXseqkFw1FpXHOO9ZncL/je0Qta+veKQuc=;
        b=I0dHQLGd5l7rnvd5BcDEg/c8N1xVEYLfKXx/mQgxxNP1vSDhyMVl56OEoqCNKU4yQZ8Si6
        +f9NAs3dXGO6/fx61wf5Gd42c8QB20dCvTBIuFJL80qD3P2EHGrqjpSb+M+Uo9Cn4wHEfS
        Rp/7Lbe6fNPpQ+ljDrN5KjJugsfLQTE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637377584;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lPprfHYZrOXseqkFw1FpXHOO9ZncL/je0Qta+veKQuc=;
        b=aaAWss8zjYOpRulYw6r+WSXRMNX0hPKjaY89k3XJkzC1orEy607Yh5yA9etwemr/3ILGkF
        KoeVubwbfBuj7GDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 61C0C13B73;
        Sat, 20 Nov 2021 03:06:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mIJACTBmmGHHfwAAMHmgww
        (envelope-from <ematsumiya@suse.de>); Sat, 20 Nov 2021 03:06:24 +0000
Date:   Sat, 20 Nov 2021 00:06:21 -0300
From:   Enzo Matsumiya <ematsumiya@suse.de>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] pager: fix crash when pager program doesn't exist
Message-ID: <20211120030621.2xbcz5usaqkh2ald@cyberdelia>
References: <20211119234745.26605-1-ematsumiya@suse.de>
 <YZhVA8DOjHu90gzs@coredump.intra.peff.net>
 <20211120023246.7ynehp5v3iypfr6w@cyberdelia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20211120023246.7ynehp5v3iypfr6w@cyberdelia>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/19, Enzo Matsumiya wrote:
>>When pager setup succeeds, the second run is a noop, because isatty(1)
>>is no longer true. But for the case you're interested in, the first one
>>fails, so we do try again. And I can reproduce your problem with:
>
>No, it's not a noop such as that it's clear that things are different on
>the second call.

Here I meant that setup_pager() is effectivelly called from 2 different places:

First backtrace:
setup_pager()
commit_pager_choice()
run_builtin()
handle_builtin()
run_argv()
cmd_main()

Second backtrace:
setup_pager()
cmd_log_init_finish()
cmd_log_init()
cmd_show()
run_builtin()
handle_builtin()
run_argv()
cmd_main()

Also, isatty(1) is not false in neither of the calls. Otherwise I
wouldn't hit this bug (pager would be NULL and setup_pager() a noop as
you said).


Cheers,

Enzo
