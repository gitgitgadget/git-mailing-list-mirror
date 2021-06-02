Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74BAC4708F
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 20:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3B5360C3F
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 20:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhFBUgx convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 2 Jun 2021 16:36:53 -0400
Received: from elephants.elehost.com ([216.66.27.132]:54622 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFBUgw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 16:36:52 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 152KYvUw044326
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 2 Jun 2021 16:34:58 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>, "'Eric Wong'" <e@80x24.org>
Cc:     "'Taylor Blau'" <me@ttaylorr.com>,
        "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <002701d757d8$1a8d9dc0$4fa8d940$@nexbridge.com> <YLfc2+Te7Y3UY+Sm@nand.local> <YLfgy94sbmStC0mR@coredump.intra.peff.net> <20210602201150.GA29388@dcvr> <YLfmo8kl0URnGgp5@coredump.intra.peff.net>
In-Reply-To: <YLfmo8kl0URnGgp5@coredump.intra.peff.net>
Subject: RE: [ANNOUNCE] Git v2.32.0-rc3 - t5300 Still Broken on NonStop ia64/x86
Date:   Wed, 2 Jun 2021 16:34:51 -0400
Message-ID: <003c01d757ee$c0664600$4132d200$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJ7fmH3rhE7hkXT/heyzvk47BFclgE1aUB7AUaXbccCdnI+uAIP+0KbqYDK+OA=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On June 2, 2021 4:14 PM, Peff wrote:
>Subject: Re: [ANNOUNCE] Git v2.32.0-rc3 - t5300 Still Broken on NonStop ia64/x86
>On Wed, Jun 02, 2021 at 08:11:50PM +0000, Eric Wong wrote:
>
>> Jeff King <peff@peff.net> wrote:
>> > And so when he gets this error:
>> >
>> >   fatal: fsync error on '.git/objects/pack/tmp_pack_NkPgqN':
>> > Interrupted system call
>> >
>> > presumably we were in fsync() when the signal arrived, and unlike
>> > most other platforms, the call needs to be restarted manually (even
>> > though we set up the signal with SA_RESTART). I'm not sure if this
>> > violates POSIX or not (I couldn't find a definitive answer to the
>> > set of interruptible functions in the standard). But either way, the
>> > workaround is probably something like:
>>
>> "man 3posix fsync" says EINTR is allowed ("manpages-posix-dev"
>> package in Debian non-free).
>
>Ah, thanks. Linux's fsync(3) doesn't mention it, and nor does it appear in the discussion of interruptible calls in signals(7). So I was looking
>for a POSIX equivalent of that signals manpage but couldn't find one. :)
>
>> >   #ifdef FSYNC_NEEDS_RESTART
>>
>> The wrapper should apply to all platforms.  NFS (and presumably other
>> network FSes) can be mounted with interrupts enabled.
>
>I don't mind that, as the wrapper is pretty low-cost (and one less Makefile knob is nice). If it's widespread, though, I find it curious that
>nobody has run into it before now.

I suspect this is because of the way the file system on NonStop behaves. It is a multi-processor platform, with multi-cores, so anything can happen. If the file system is delayed for any reason, like a signal coming from a different core (EINTR has high priority), then fsync() will be interrupted. EINTR is allowed on NonStop for fsync(). So it would be really great if the patch included a modification to config.mak.uname to include that. This would be a timing-only issue on most other systems, probably something that would hit NFS.

The patch for the config is:
diff --git a/config.mak.uname b/config.mak.uname
index cb443b4e02..ac3e3ca2c5 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -566,6 +566,7 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
        NO_REGEX = NeedsStartEnd
        NO_PTHREADS = UnfortunatelyYes
        FREAD_READS_DIRECTORIES = UnfortunatelyYes
+       FSYNC_NEEDS_RESTART = YesPlease

        # Not detected (nor checked for) by './configure'.



