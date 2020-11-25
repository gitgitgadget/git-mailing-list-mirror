Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928A5C56201
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 21:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D8DE2075A
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 21:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732000AbgKYVXg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 16:23:36 -0500
Received: from elephants.elehost.com ([216.66.27.132]:65328 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730091AbgKYVXg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 16:23:36 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.189.82])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 0APLNSxB067620
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Nov 2020 16:23:29 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'Han-Wen Nienhuys via GitGitGadget'" <gitgitgadget@gmail.com>,
        <git@vger.kernel.org>, "'Han-Wen Nienhuys'" <hanwenn@gmail.com>,
        "'Han-Wen Nienhuys'" <hanwen@google.com>
References: <pull.922.git.git.1606245012068.gitgitgadget@gmail.com>        <xmqq8saqifu3.fsf@gitster.c.googlers.com>        <011801d6c2ae$dcdbaad0$96930070$@nexbridge.com> <xmqqy2iqf7uf.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqy2iqf7uf.fsf@gitster.c.googlers.com>
Subject: RE: [PATCH] move sleep_millisec to git-compat-util.h
Date:   Wed, 25 Nov 2020 16:23:22 -0500
Message-ID: <018301d6c371$37bf6820$a73e3860$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEpHIVxAVOitwfeyhjFK9k+F6/XHgE9K7xpAiYyalMBxrAu5KsLV56w
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On November 24, 2020 10:12 PM, Junio C Hamano wrote:
> "Randall S. Becker" <rsbecker@nexbridge.com> writes:
> > I have a platform fix that I'd like to apply once this makes it into
> > the main code. The sleep_millisec uses poll(), which is rather
> > heavy-weight on the NonStop platform. We have a much more efficient
> > sleep function available (with microsecond resolution), which would be
> > more useful unless there is a poll side-effect on which git depends.
> > Would this be acceptable? I could push this at any time really.
> 
> We strongly prefer not to contaminate generic part of source with platform
> specific conditional compilation.
> 
> If this were a much larger helper function, it might make sense to perform
> the compat/*.c dance, but in this case:
> 
>  * [PATCH 1/2] that implements sleep_millisec() in git-compat-util.h
>    as a static inline function; and then
> 
>  * [PATCH 2/2] that does the equivalent of your patch below, but in
>    git-compat-util.h
> 
> might be the cleanest.
> 
> > index bcda41e374..972ecd67bf 100644
> > --- a/wrapper.c
> > +++ b/wrapper.c
> > @@ -4,6 +4,10 @@
> >  #include "cache.h"
> >  #include "config.h"
> >
> > +#ifdef __TANDEM
> > +#include <cextdecs> /* for PROCESS_DELAY_ */ #endif
> > +
> >  static int memory_limit_check(size_t size, int gentle)  {
> >         static size_t limit = 0;
> > @@ -650,7 +654,11 @@ void write_file(const char *path, const char
> > *fmt, ...)
> >
> >  void sleep_millisec(int millisec)
> >  {
> > +#ifdef __TANDEM
> > +       PROCESS_DELAY_(millisec * 1000LL); #else
> >         poll(NULL, 0, millisec);
> > +#endif
> >  }
> >
> >  int xgethostname(char *buf, size_t len)

I just chatted with my team and we think that sticking with the existing
poll call is probably better in the long term. We are planning to try to get
git to work using PUT threads - but that is a longer project for a whole
slew of reasons. It involves pulling all or most of the FLOSS stuff out, or
making that configurable to use FLOSS when not using threads and not using
FLOSS when using threads. It might be useful, however, to use usleep()
instead of poll(NULL) when threading is used on most platforms as it is a
more effective way of context switching between threads than select().

Regards,
Randall

