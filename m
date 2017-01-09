Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 640A6205C9
	for <e@80x24.org>; Mon,  9 Jan 2017 06:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752585AbdAIGAQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 01:00:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:36830 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752268AbdAIGAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 01:00:16 -0500
Received: (qmail 18224 invoked by uid 109); 9 Jan 2017 06:00:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Jan 2017 06:00:16 +0000
Received: (qmail 1442 invoked by uid 111); 9 Jan 2017 06:01:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Jan 2017 01:01:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Jan 2017 01:00:12 -0500
Date:   Mon, 9 Jan 2017 01:00:12 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Paul Sbarra <sbarra.paul@gmail.com>
Subject: Re: [PATCH v4 1/4] Avoid Coverity warning about unfree()d
 git_exec_path()
Message-ID: <20170109060012.nuauxbgllqiicog7@sigill.intra.peff.net>
References: <cover.1480019834.git.johannes.schindelin@gmx.de>
 <cover.1483373635.git.johannes.schindelin@gmx.de>
 <18e9a1009aac2329cb9bf9d12fbac4e8ac19a5bb.1483373635.git.johannes.schindelin@gmx.de>
 <CAGZ79kZ--jp08pK+xwn1N2VQQr8bA5+DveE2HsoY90R1gR6c_A@mail.gmail.com>
 <xmqqy3ylyqhf.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy3ylyqhf.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 08, 2017 at 05:25:00PM -0800, Junio C Hamano wrote:

> > If this patch is only to appease coverity (as the commit message eludes
> > to) I think this may be a bad idea for upstream.  If this patch fixes an
> > actual problem, then the commit message needs to spell that out.
> 
> That is true, and I see Peff pointed out another possible issue
> around getenv(), but I think from the "one step at a time" point of
> view, it is an improvement to call system_path() just once and cache
> it in "static char *". 

Yep, I don't think it's a big deal to do it on top, like this:

-- >8 --
Subject: git_exec_path: do not return the result of getenv()

The result of getenv() is not guaranteed by POSIX to last
beyond another call to getenv(), or setenv(), etc.  We
should duplicate the string before returning to the caller
to avoid any surprises.

We already keep a cached pointer to avoid repeatedly leaking
the result of system_path(). We can use the same pointer
here to avoid allocating and leaking for each call.

Signed-off-by: Jeff King <peff@peff.net>
---

To be honest, I do not know how big a problem this is. I looked at the
code paths that call git_exec_path(), and the most likely problem case
is calling a second getenv() is via the strbuf functions, which call
xmalloc(), which checks $GIT_ALLOC_LIMIT. We do cache that value, but
it would be a potential problem if this is the first xmalloc call in
the program.

But we are not really solving that here, as xstrdup() would have the
same problem.  This _is_ safer, in that we've better contained the
length of time that we expect the result to be valid.

I have no idea what platforms, if any, use a single static buffer for
the getenv() return. I don't know that we've ever gotten a bug report
about it (I only knew about it because somebody pointed it out in one
of my patches a few years ago, so I have it in the back of my mind as
a potential problem).

So I don't mind if this is dropped as "too esoteric" until somebody
actually reports a bug about it.

 exec_cmd.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index 587bd7eb4..fb94aeba9 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -64,20 +64,19 @@ void git_set_argv_exec_path(const char *exec_path)
 /* Returns the highest-priority, location to look for git programs. */
 const char *git_exec_path(void)
 {
-	const char *env;
-	static char *system_exec_path;
+	static char *cached_exec_path;
 
 	if (argv_exec_path)
 		return argv_exec_path;
 
-	env = getenv(EXEC_PATH_ENVIRONMENT);
-	if (env && *env) {
-		return env;
+	if (!cached_exec_path) {
+		const char *env = getenv(EXEC_PATH_ENVIRONMENT);
+		if (env && *env)
+			cached_exec_path = xstrdup(env);
+		else
+			cached_exec_path = system_path(GIT_EXEC_PATH);
 	}
-
-	if (!system_exec_path)
-		system_exec_path = system_path(GIT_EXEC_PATH);
-	return system_exec_path;
+	return cached_exec_path;
 }
 
 static void add_path(struct strbuf *out, const char *path)
-- 
2.11.0.531.ge85397315

