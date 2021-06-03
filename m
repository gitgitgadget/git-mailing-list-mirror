Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1689C47096
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 20:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C293C61168
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 20:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbhFCUeI convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 3 Jun 2021 16:34:08 -0400
Received: from elephants.elehost.com ([216.66.27.132]:41164 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbhFCUeF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 16:34:05 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 153KW88b051400
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 3 Jun 2021 16:32:09 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Bryan Turner'" <bturner@atlassian.com>,
        "'Jeff King'" <peff@peff.net>
Cc:     "'Eric Wong'" <e@80x24.org>, "'Taylor Blau'" <me@ttaylorr.com>,
        "'Junio C Hamano'" <gitster@pobox.com>,
        "'Git Users'" <git@vger.kernel.org>
References: <002701d757d8$1a8d9dc0$4fa8d940$@nexbridge.com> <YLfc2+Te7Y3UY+Sm@nand.local> <YLfgy94sbmStC0mR@coredump.intra.peff.net> <20210602201150.GA29388@dcvr> <YLfmo8kl0URnGgp5@coredump.intra.peff.net> <CAGyf7-G=B+S6m9mifjOCFKGfEx69zzdOoCr03ckK7fJZrNEGtg@mail.gmail.com>
In-Reply-To: <CAGyf7-G=B+S6m9mifjOCFKGfEx69zzdOoCr03ckK7fJZrNEGtg@mail.gmail.com>
Subject: RE: [ANNOUNCE] Git v2.32.0-rc3 - t5300 Still Broken on NonStop ia64/x86
Date:   Thu, 3 Jun 2021 16:32:03 -0400
Message-ID: <009c01d758b7$86e12340$94a369c0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJ7fmH3rhE7hkXT/heyzvk47BFclgE1aUB7AUaXbccCdnI+uAIP+0KbAvZgxwapaqpAUA==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On June 3, 2021 4:22 PM, Bryan Turner wrote:
>On Wed, Jun 2, 2021 at 1:14 PM Jeff King <peff@peff.net> wrote:
>>
>> On Wed, Jun 02, 2021 at 08:11:50PM +0000, Eric Wong wrote:
>>
>> > Jeff King <peff@peff.net> wrote:
>> > > And so when he gets this error:
>> > >
>> > >   fatal: fsync error on '.git/objects/pack/tmp_pack_NkPgqN':
>> > > Interrupted system call
>> > >
>> > > presumably we were in fsync() when the signal arrived, and unlike
>> > > most other platforms, the call needs to be restarted manually
>> > > (even though we set up the signal with SA_RESTART). I'm not sure
>> > > if this violates POSIX or not (I couldn't find a definitive answer
>> > > to the set of interruptible functions in the standard). But either
>> > > way, the workaround is probably something like:
>> >
>> > "man 3posix fsync" says EINTR is allowed ("manpages-posix-dev"
>> > package in Debian non-free).
>>
>> Ah, thanks. Linux's fsync(3) doesn't mention it, and nor does it
>> appear in the discussion of interruptible calls in signals(7). So I
>> was looking for a POSIX equivalent of that signals manpage but
>> couldn't find one. :)
>>
>> > >   #ifdef FSYNC_NEEDS_RESTART
>> >
>> > The wrapper should apply to all platforms.  NFS (and presumably
>> > other network FSes) can be mounted with interrupts enabled.
>>
>> I don't mind that, as the wrapper is pretty low-cost (and one less
>> Makefile knob is nice). If it's widespread, though, I find it curious
>> that nobody has run into it before now.
>
>I was dealing with a similar issue[1] recently, albeit not in the Git codebase but rather with Java. My issue was with epoll_wait, rather
>than fsync, which is documented on signal(7) as not restartable even with SA_RESTART. That led me to this[2] little bit of code inside the
>JVM:
>#define RESTARTABLE(_cmd, _result) do { \
>  do { \
>    _result = _cmd; \
>  } while((_result == -1) && (errno == EINTR)); \ } while(0)
>
>which they use like this[3]:
>RESTARTABLE(epoll_wait(epfd, events, numfds, -1), res);
>
>Not sure what the Git maintainers' view on macros is, but if there wasn't going to be a Makefile knob perhaps something similar might
>make sense as a reusable construct. Of course, it's unclear how often Git might _need_ such a thing; given this doesn't seem to come up
>much, perhaps that's a sign such a macro would end up a waste of effort. Anyway, just thought I'd share because I was looking at
>something similar.
>
>[1] https://github.com/brettwooldridge/NuProcess/issues/124
>[2]
>https://github.com/JetBrains/jdk8u_jdk/blob/94318f9185757cc33d2b8d527d36be26ac6b7582/src/solaris/native/sun/nio/ch/nio_util.h#L33
>-L37
>[3]
>https://github.com/JetBrains/jdk8u_jdk/blob/94318f9185757cc33d2b8d527d36be26ac6b7582/src/solaris/native/sun/nio/ch/EPoll.c#L92

I can only suggest, from other OpenSource projects I'm on, that make extensive use of macros, that they are very difficult to debug and sometimes harder to integrate with platform-specific compatibility layers.  I would rather have something explicit in compat.c that gdb could make sense of during a debug session if necessary. Trying to debug macros is harsh, rather like debugging -O2 without -g.

I used to be a big fan of macros, but grew out of it 😉. Just my take on it.

-Randall

