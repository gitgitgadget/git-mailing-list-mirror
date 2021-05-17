Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1632C433B4
	for <git@archiver.kernel.org>; Mon, 17 May 2021 17:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAA6E6109E
	for <git@archiver.kernel.org>; Mon, 17 May 2021 17:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238135AbhEQRsR convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 17 May 2021 13:48:17 -0400
Received: from elephants.elehost.com ([216.66.27.132]:64364 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235250AbhEQRsP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 13:48:15 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 14HHkqGX062010
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 17 May 2021 13:46:53 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@jeffhostetler.com>, <git@vger.kernel.org>
Cc:     "'Jeff King'" <peff@peff.net>,
        "=?iso-8859-1?Q?'SZEDER_G=E1bor'?=" <szeder.dev@gmail.com>,
        "'Johannes Schindelin via GitGitGadget'" <gitgitgadget@gmail.com>,
        <jeffhost@microsoft.com>
Subject: [BUG] Unix Builds Requires Pthread Support (was [PATCH v4 00/12] Simple IPC Mechanism)
Date:   Mon, 17 May 2021 13:46:46 -0400
Message-ID: <009d01d74b44$9efe8a60$dcfb9f20$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AddLP1yf+x64j5KFRPeDV2IlAYlVyw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 17 Feb 2021 21:48:36, Jeff Hostetler wrote:

>Here is V4 of my "Simple IPC" series. It addresses Gábor's comment WRT
>shutting down the server to make unit tests more predictable on CI servers.
>(https://lore.kernel.org/git/20210213093052.GJ1015009@szeder.dev)

I missed this at the time, but it appears that ipc-unix-socket.c forces a dependency on pthreads for Git under Unix-like platforms.
This is probably not a correct assumption (or likely intended), but causes git to no longer build on NonStop x86 and ia64 as of
2.32.0-rc0. I am not suggesting undoing this, but amending to make the change more sensitive to a lack of pthread support.
pthread_sigmask() showed up as an undefined external:

**** ERROR **** [1210]:
   libgit.a(ipc-unix-socket.o): In function `thread_block_sigpipe':
   ipc-unix-socket.o(.text+0xb87): unresolved reference to pthread_sigmask.

On NonStop, pthread_sigmask is defined in -lput or -lspt, which are not used in our build – and would cause a bunch of other issues
if referenced. The build does define NO_PTHREADS. 

A simple, but probably wrong fix to get the build to work is:

diff --git a/compat/simple-ipc/ipc-unix-socket.c b/compat/simple-ipc/ipc-unix-socket.c
index 38689b278d..07b2c407c1 100644
--- a/compat/simple-ipc/ipc-unix-socket.c
+++ b/compat/simple-ipc/ipc-unix-socket.c
@@ -535,7 +535,9 @@ static void thread_block_sigpipe(sigset_t *old_set)
        sigaddset(&new_set, SIGPIPE);

        sigemptyset(old_set);
+#ifndef NO_PTHREADS
        pthread_sigmask(SIG_BLOCK, &new_set, old_set);
+#endif
 }

But I suspect that this will not perform the desired action associated with blocking the signal, although since we are not in a
threading situation, that might be fine.

Thoughts?

Randall

-- Brief whoami:
NonStop developer since approximately 211288444200000000
UNIX developer since approximately 421664400
IBM developer since "I'm not talking about it"
-- In my real life, I talk too much.



