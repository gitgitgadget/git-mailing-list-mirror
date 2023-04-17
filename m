Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB60C77B72
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 07:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjDQH7I (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 03:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjDQH6p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 03:58:45 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFD33AA1
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 00:58:44 -0700 (PDT)
Received: (qmail 21756 invoked by uid 109); 17 Apr 2023 07:38:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 17 Apr 2023 07:38:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22150 invoked by uid 111); 17 Apr 2023 07:38:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Apr 2023 03:38:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 Apr 2023 03:38:27 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Michael J Gruber <git@grubix.eu>, git@vger.kernel.org,
        Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH/RFD] fix connection via git protocol
Message-ID: <20230417073827.GA39931@coredump.intra.peff.net>
References: <5d4e0ce10f537b4bb795a70dd51db12ecaf0206d.1681556597.git.git@grubix.eu>
 <20230416054735.3386065-1-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230416054735.3386065-1-newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 15, 2023 at 10:47:35PM -0700, Elijah Newren wrote:

> On Sat, Apr 15, 2023 at 4:06 AM Michael J Gruber <git@grubix.eu> wrote:
> >
> > 5579f44d2f ("treewide: remove unnecessary cache.h inclusion", 2023-04-11)
> > broke connections via git protocol because it removed the inclusion of
> > the default port macro. While some may consider this transport to be
> > deprecated, it still serves some purpose.
> 
> In particular the problem is that
> 
> 	const char *port = STR(DEFAULT_GIT_PORT);
> 
> translates now to
> 
> 	const char *port = "DEFAULT_GIT_PORT";
> 
> instead of
> 
> 	const char *port = "9418";
> 
> Since both compile and nothing in the testsuite tests this, I just
> missed this problem when making the other changes.

Your fix looks obviously correct, but the much more interesting thing to
me is how surprising it is that neither the compiler nor tests caught
it.  The tests don't catch it because we never use the default port for
our daemon tests, since we don't want two scripts running in parallel to
conflict. And your example above shows what the compiler sees, but root
issue is this funky string-ification macro:

  #define STR_(s) # s
  #define STR(s) STR_(s)

The preprocessor doesn't know that we'll be confused if "s" isn't
resolved, and by the time the compiler sees it, it's a string already.

Obviously we could add a test that catches this at run-time, but we
should be able to do better (catch it earlier, and with less code).

My first thought was: why can't we just treat the port as an "int" in
the first place? The answer is mostly that getaddrinfo() expects it as a
string. It could even be a non-numeric service like "http" in theory
(and looked up in /etc/services; Debian's even has "git" in it!), but
our get_host_and_port() refuses to allow that. But even if we didn't
want to ever support non-numeric service names, it makes the code more
awkward (we have to format the port into an extra buffer).

This would work:

diff --git a/connect.c b/connect.c
index fd3179e545..1eba71e34c 100644
--- a/connect.c
+++ b/connect.c
@@ -753,7 +753,7 @@ static char *host_end(char **hoststart, int removebrackets)
 }
 
 #define STR_(s)	# s
-#define STR(s)	STR_(s)
+#define STR(s) (STR_(s) + BUILD_ASSERT_OR_ZERO(s))
 
 static void get_host_and_port(char **host, const char **port)
 {

The error message is a bit verbose, but it starts with:

  connect.c: In function ‘git_tcp_connect_sock’:
  connect.c:801:32: error: ‘DEFAULT_GIT_PORT’ undeclared (first use in this function)
  801 |         const char *port = STR(DEFAULT_GIT_PORT);
      |                                ^~~~~~~~~~~~~~~~

which seems OK in practice.

Another alternative is to just declare this STR() thing too clever, and
put:

  #define DEFAULT_GIT_PORT_STR "9418"

next to the int declaration. It's not like its going to change. But the
BUILD_ASSERT doesn't seem too bad to me.

-Peff
