Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69D7C433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 05:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76BE26108C
	for <git@archiver.kernel.org>; Tue, 18 May 2021 05:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238151AbhERFvr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 01:51:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:57300 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230328AbhERFvq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 01:51:46 -0400
Received: (qmail 10270 invoked by uid 109); 18 May 2021 05:50:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 May 2021 05:50:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4815 invoked by uid 111); 18 May 2021 05:50:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 May 2021 01:50:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 May 2021 01:50:26 -0400
From:   Jeff King <peff@peff.net>
To:     Ben Humphreys <behumphreys@atlassian.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christopher Schenk <christopher@cschenk.net>,
        git@vger.kernel.org
Subject: Re: Git 2.23.0-rc0 HTTP authentication failure - error message change
Message-ID: <YKNVop80H8xSTCjz@coredump.intra.peff.net>
References: <YKMvePOPqjwiXeQ+@C02WD045HTDG>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YKMvePOPqjwiXeQ+@C02WD045HTDG>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 18, 2021 at 01:07:36PM +1000, Ben Humphreys wrote:

> I've run 2.32.0-rc0 through the Bitbucket Server test matrix and it picked up a
> change in error message that perhaps is unintentional.
> 
> On 2.31.1:
>   $ git ls-remote http://notauser@localhost:7990/bitbucket/scm/project_1/rep_1.git
>   Password for 'http://notauser@localhost:7990':
>   fatal: Authentication failed for 'http://localhost:7990/bitbucket/scm/project_1/rep_1.git/'
> 
> and on 2.32.0-rc0:
>   $ git ls-remote http://notauser@localhost:7990/bitbucket/scm/project_1/rep_1.git
>   Password for 'http://notauser@localhost:7990':
>   fatal: unable to access 'http://localhost:7990/bitbucket/scm/project_1/rep_1.git/': The requested URL returned error: 401
> 
> This appears to be a side effect of 1b0d9545bb8, if I revert that commit the old
> behavior returns. Certainly we can update our pattern matching to match the new message,
> but I wonder if the old message is preferred for folks who are not familiar with HTTP
> status codes.

Thanks for reporting; I've added the author of that commit to the cc.

I think this is definitely a regression in the output we're giving, but
it also points to a bug in the behavior (we fail to forget about bad
credentials; see below).

The motivation from the commit is:

    When the username and password are supplied in a url like this
    https://myuser:secret@git.exampe/myrepo.git and the server supports the
    negotiate authenticaten method, git does not fall back to basic auth and
    libcurl hardly tries to authenticate with the negotiate method.

    Stop using the Negotiate authentication method after the first failure
    because if it fails on the first try it will never succeed.

So it is focused on the case when the credentials came in the URL,
before the first contact with the server (where we'd get an HTTP 401).
And the diff moves the negotiate check earlier in the function, before
we see if we already have credentials:

diff --git a/http.c b/http.c
index 0e31fc21bc..19c203d0ca 100644
--- a/http.c
+++ b/http.c
@@ -1641,17 +1641,18 @@ static int handle_curl_result(struct slot_results *results)
 	} else if (missing_target(results))
 		return HTTP_MISSING_TARGET;
 	else if (results->http_code == 401) {
+#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
+		http_auth_methods &= ~CURLAUTH_GSSNEGOTIATE;
+		if (results->auth_avail) {
+			http_auth_methods &= results->auth_avail;
+			http_auth_methods_restricted = 1;
+			return HTTP_REAUTH;
+		}
+#endif
 		if (http_auth.username && http_auth.password) {
 			credential_reject(&http_auth);
 			return HTTP_NOAUTH;
 		} else {
-#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
-			http_auth_methods &= ~CURLAUTH_GSSNEGOTIATE;
-			if (results->auth_avail) {
-				http_auth_methods &= results->auth_avail;
-				http_auth_methods_restricted = 1;
-			}
-#endif
 			return HTTP_REAUTH;
 		}
 	} else {

So in that case, we'd clear the GSSNEGOTIATE bit and return HTTP_REAUTH,
and the caller will try again. Makes sense for the use case described.

But imagine we didn't get a username/password in the URL. The first
request will return REAUTH because of this moved code path (just as it
would have before, because http.auth.{username,password} are not set).
And then we'll get a credential from the user or from a helper and try
again. But this time, if we fail, we'll return HTTP_REAUTH again! We
never hit the "if (http_auth.username && http_auth.password)" check at
all. And hence we never return HTTP_NOAUTH (which gives us the more
useful "authentication failed" message), nor the credential_reject()
line (which informs helpers to stop caching a known-bad password).

We can see it like this. First, seed the cache with a bad password (in
this case a bogus token to elicit a 401 response from GitHub). In real
life, this would be a password stored from a previous successful
attempt, but which was invalidated in the meantime. Note the empty value
for credential.helper clears the list of any regular helpers you'd use
for github.com.

  echo url=https://peff:ghp_000000000000000000000000000000000000@github.com |
  git -c credential.helper= \
      -c credential.helper=cache \
      credential approve

Now make a request that requires auth; we expect it to fail since our
credential is bad.

  git -c credential.helper= \
        -c credential.helper=cache \
        ls-remote https://github.com/peff/foo

which yields:

  remote: Invalid username or password.
  fatal: unable to access 'https://github.com/peff/foo/': The requested URL returned error: 401

as expected (except for the error message). But we also expect it to
clear the bogus credential from the helper, so that if we run ls-remote
again, it will prompt us. But it doesn't! With git v2.32.0-rc0, you can
run that ls-remote as many times as you want, and it will always fail.

Whereas if you switch to 1b0d9545bb8^, on the second run it will
correctly prompt you for an updated password.

I think for this to work, we would need to figure out from libcurl's
response that GSSNEGOTIATE was the problem for our particular request,
and only trigger the bit-clearing and HTTP_REAUTH if that was true. I'm
not sure if that's possible, though.

I suspect we could hack around it by pessimistically guessing that
GSSNEGOTIATE was the problem. But I'm worried that making that work
would require up to three requests (one to find out we need auth, one to
remove the GSSNEGOTIATE bit, and one to retry with a username/password).
That seems like punishing people with servers that don't even care about
Negotiate for no reason.

So perhaps somebody can come up with something clever, but I suspect we
may need to just revert this for the v2.32 release, and re-break the
case that 1b0d9545bb8 was trying to solve.

We probably should beef up the tests around http's credential-rejection,
too, to catch this regression.

-Peff
