Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD696208E4
	for <e@80x24.org>; Tue,  5 Sep 2017 19:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753325AbdIETCR (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 15:02:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:57708 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753409AbdIETCP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 15:02:15 -0400
Received: (qmail 27928 invoked by uid 109); 5 Sep 2017 19:02:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 19:02:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15842 invoked by uid 111); 5 Sep 2017 19:02:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 15:02:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Sep 2017 15:02:12 -0400
Date:   Tue, 5 Sep 2017 15:02:12 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/10] towards clean leak-checker output
Message-ID: <20170905190212.4xx4xukx2bbtudij@sigill.intra.peff.net>
References: <20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net>
 <CAN0heSrVzRPc+iVqU02qzk=DB0WT6Fscn6X-hZPFkM1TikMPVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSrVzRPc+iVqU02qzk=DB0WT6Fscn6X-hZPFkM1TikMPVQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 05, 2017 at 07:50:10PM +0200, Martin Ågren wrote:

> >     That line is the setting of argv0_path, which is a global (and thus
> >     shouldn't be marked as leaking). Interestingly, it only happens with
> >     -O2. Compiling with -O0 works fine. I'm not sure if it's a bug or
> >     what.
> >
> >     I did most of my testing with clang-6.0, which gets this case right.
> 
> Hmmm, I got the same wrong results (IMHO) from Valgrind, which
> classified this as "definitely lost". Like you I found that -O0 helped.
> And yes, that was with gcc. Maybe gcc with optimization somehow manages
> to hide the pointers from these tools. I know too little about the
> technical details to have any real ideas, though. My searches did not
> bring up anything useful. (gcc 5.4.0)

Yeah, I think it is just optimizing out the variable entirely. If
RUNTIME_PREFIX isn't defined (and it's not for non-Windows platforms)
then we never look at the variable at all, and it's a dead assignment.
And the compiler can see that easily because it's got static linkage. So
it drops the variable completely, but it can't drop the call to
xstrdup() with the information in exec_cmd.c. It has to call the
function and throw away the result, resulting in the leak.

In fact, the whole extract_argv0_path thing is pointless without
RUNTIME_PREFIX. So I think one reasonable fix is just:

diff --git a/exec_cmd.c b/exec_cmd.c
index fb94aeba9c..09f05c3bc3 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -5,7 +5,10 @@
 #define MAX_ARGS	32
 
 static const char *argv_exec_path;
+
+#ifdef RUNTIME_PREFIX
 static const char *argv0_path;
+#endif
 
 char *system_path(const char *path)
 {
@@ -40,6 +43,7 @@ char *system_path(const char *path)
 
 void git_extract_argv0_path(const char *argv0)
 {
+#ifdef RUNTIME_PREFIX
 	const char *slash;
 
 	if (!argv0 || !*argv0)
@@ -49,6 +53,7 @@ void git_extract_argv0_path(const char *argv0)
 
 	if (slash)
 		argv0_path = xstrndup(argv0, slash - argv0);
+#endif
 }
 
 void git_set_argv_exec_path(const char *exec_path)

-Peff
