Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA24C433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E1DB60D43
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhJ2VvU convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 29 Oct 2021 17:51:20 -0400
Received: from elephants.elehost.com ([216.66.27.132]:38258 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbhJ2VvT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 17:51:19 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 19TLmlJv075855
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 29 Oct 2021 17:48:48 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Carlo Arenas'" <carenas@gmail.com>
Cc:     <git@vger.kernel.org>, <avarab@gmail.com>
References: <20211029212705.31721-1-carenas@gmail.com> <014301d7cd0d$3019b8e0$904d2aa0$@nexbridge.com> <CAPUEspht5wFnsLMxzaq5JNJV2eh_YRB5PZ4UWXNMTJpG3gOf8w@mail.gmail.com>
In-Reply-To: <CAPUEspht5wFnsLMxzaq5JNJV2eh_YRB5PZ4UWXNMTJpG3gOf8w@mail.gmail.com>
Subject: RE: [PATCH] wrapper: remove xunsetenv()
Date:   Fri, 29 Oct 2021 17:48:41 -0400
Organization: Nexbridge Inc.
Message-ID: <015401d7cd0e$c05b63d0$41122b70$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQD1p6jrNojDT2nQCeA0hV5rmPbfSQIZLXowAkAUx42tjANGEA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On October 29, 2021 5:43 PM, Carlo Arenas wrote:
> On Fri, Oct 29, 2021 at 2:37 PM <rsbecker@nexbridge.com> wrote:
> >
> > I will be submitting a separate patch to turn off NO_SETENV and
> NO_UNSETENV for the NonStop x86 platform, where the calls have been
> supported since October 2020. The ia64 platform will have to continue to use
> the compat layer.
> 
> The right place to add that logic is most likely in config.mak.uname; see all the
> other conditions that match based on version as a guideline.

Already there. I just want to make sure everything is fine on the older box. This will be it, but I'm looking at whether I can get rid of any other switches at the same time:

diff --git a/config.mak.uname b/config.mak.uname
index 3236a491..fdcc4690 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -569,8 +569,11 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
        NO_STRCASESTR = YesPlease
        NO_MEMMEM = YesPlease
        NO_STRLCPY = YesPlease
-       NO_SETENV = YesPlease
-       NO_UNSETENV = YesPlease
+       ifeq ($(uname_R),J06)
+               # setenv and unsetenv are not supported on J-series
+               NO_SETENV = YesPlease
+               NO_UNSETENV = YesPlease
+       endif
        NO_MKDTEMP = YesPlease
        # Currently libiconv-1.9.1.
        OLD_ICONV = UnfortunatelyYes

