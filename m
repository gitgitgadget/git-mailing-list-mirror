Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948C3C05027
	for <git@archiver.kernel.org>; Thu, 26 Jan 2023 09:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236038AbjAZJhe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Jan 2023 04:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjAZJhd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2023 04:37:33 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374EF1AF
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 01:37:32 -0800 (PST)
Received: (qmail 19083 invoked by uid 109); 26 Jan 2023 09:37:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 26 Jan 2023 09:37:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21699 invoked by uid 111); 26 Jan 2023 09:37:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Jan 2023 04:37:31 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Jan 2023 04:37:30 -0500
From:   Jeff King <peff@peff.net>
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v7 07/12] test-http-server: pass Git requests to
 http-backend
Message-ID: <Y9JJ2moUulG8gTba@coredump.intra.peff.net>
References: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
 <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
 <ca9c2787248688cd7d8e20043a6ed75d93654e35.1674252531.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ca9c2787248688cd7d8e20043a6ed75d93654e35.1674252531.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 20, 2023 at 10:08:45PM +0000, Matthew John Cheetham via GitGitGadget wrote:

> +static int is_git_request(struct req *req)
> +{
> +	static regex_t *smart_http_regex;
> +	static int initialized;
> +
> +	if (!initialized) {
> +		smart_http_regex = xmalloc(sizeof(*smart_http_regex));
> +		/*
> +		 * This regular expression matches all dumb and smart HTTP
> +		 * requests that are currently in use, and defined in
> +		 * Documentation/gitprotocol-http.txt.
> +		 *
> +		 */
> +		if (regcomp(smart_http_regex, "^/(HEAD|info/refs|"
> +			    "objects/info/[^/]+|git-(upload|receive)-pack)$",
> +			    REG_EXTENDED)) {
> +			warning("could not compile smart HTTP regex");
> +			smart_http_regex = NULL;
> +		}
> +		initialized = 1;
> +	}
> +
> +	return smart_http_regex &&
> +		!regexec(smart_http_regex, req->uri_path.buf, 0, NULL, 0);
> +}

Assigning NULL to smart_http_regex leaks the earlier allocation. You
could free it, but I have to wonder why it is on the heap in the first
place. Yes, you check for NULL and return 0 if it failed to compile,
but...why would it? It's hard-coded. And if it does fail, wouldn't you
want to fail immediately and loudly, because it means all of the tests
are broken?

I.e., something like this is a bit simpler:

diff --git a/t/helper/test-http-server.c b/t/helper/test-http-server.c
index 14d170e640..8048ba1636 100644
--- a/t/helper/test-http-server.c
+++ b/t/helper/test-http-server.c
@@ -327,28 +327,25 @@ static enum worker_result req__read(struct req *req, int fd)
 
 static int is_git_request(struct req *req)
 {
-	static regex_t *smart_http_regex;
+	static regex_t smart_http_regex;
 	static int initialized;
 
 	if (!initialized) {
-		smart_http_regex = xmalloc(sizeof(*smart_http_regex));
 		/*
 		 * This regular expression matches all dumb and smart HTTP
 		 * requests that are currently in use, and defined in
 		 * Documentation/gitprotocol-http.txt.
 		 *
 		 */
-		if (regcomp(smart_http_regex, "^/(HEAD|info/refs|"
+		if (regcomp(&smart_http_regex, "^/(HEAD|info/refs|"
 			    "objects/info/[^/]+|git-(upload|receive)-pack)$",
 			    REG_EXTENDED)) {
-			warning("could not compile smart HTTP regex");
-			smart_http_regex = NULL;
+			die("could not compile smart HTTP regex");
 		}
 		initialized = 1;
 	}
 
-	return smart_http_regex &&
-		!regexec(smart_http_regex, req->uri_path.buf, 0, NULL, 0);
+	return !regexec(&smart_http_regex, req->uri_path.buf, 0, NULL, 0);
 }
 
 static enum worker_result do__git(struct req *req, const char *user)

> +start_http_server () {
> +	#
> +	# Launch our server into the background in repo_dir.
> +	#
> +	(
> +		cd "$REPO_DIR"
> +		test-http-server --verbose \
> +			--listen=127.0.0.1 \
> +			--port=$GIT_TEST_HTTP_PROTOCOL_PORT \
> +			--reuseaddr \
> +			--pid-file="$PID_FILE" \
> +			"$@" \
> +			2>"$SERVER_LOG" &
> +	)
> +	#
> +	# Give it a few seconds to get started.
> +	#
> +	for k in 0 1 2 3 4
> +	do
> +		if test -f "$PID_FILE"
> +		then
> +			return 0
> +		fi
> +		sleep 1
> +	done

Yuck. This makes the test take a long time to run, since it will almost
always "sleep 1" each time (and it looks like you bring the server up
and down in several tests). Worse, it's at risk of failing racily if it
ever takes more than 5 seconds to start up. That should be uncommon, I'd
think, but could happen on a heavily loaded system.

There's a race-less solution using fifos in lib-git-daemon.sh, where we
wait for the "ready to rumble" line. It's kind of horrific, but it does
work and is battle-tested.

-Peff
