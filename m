From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Revert "http: don't always prompt for password"
Date: Tue, 13 Dec 2011 18:10:41 -0500
Message-ID: <20111213231040.GA12432@sigill.intra.peff.net>
References: <20111213201704.GA12072@sigill.intra.peff.net>
 <20111213202508.GA12187@sigill.intra.peff.net>
 <7v62hkuptt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Naewe <stefan.naewe@gmail.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Eric <eric.advincula@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 14 00:10:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RabUn-0005TG-7k
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 00:10:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755492Ab1LMXKo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 18:10:44 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49810
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751909Ab1LMXKn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 18:10:43 -0500
Received: (qmail 25097 invoked by uid 107); 13 Dec 2011 23:17:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Dec 2011 18:17:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Dec 2011 18:10:41 -0500
Content-Disposition: inline
In-Reply-To: <7v62hkuptt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187072>

On Tue, Dec 13, 2011 at 01:25:18PM -0800, Junio C Hamano wrote:

> > @@ -844,7 +846,7 @@ static int http_request(const char *url, void *result, int target, int options)
> >  		else if (missing_target(&results))
> >  			ret = HTTP_MISSING_TARGET;
> >  		else if (results.http_code == 401) {
> > -			if (user_name && user_pass) {
> > +			if (user_name) {
> >  				ret = HTTP_NOAUTH;
> >  			} else {
> >  				/*
> 
> In the credential series, this is where we declare the given credential is
> to be rejected (if we have both username and password), or ask them to be
> filled by calling credential_fill(), so I think the code in the credential
> series does not need this revert. Right?

Sort of. The point of this conditional is "did we actually send a
credential? If yes, then return HTTP_NOAUTH. Otherwise, ask for the
credential and return HTTP_REAUTH"[1].

Prior to Stefan's patch, if user_name was set, then we sent a credential
(because we always filled in the password if user_name was set). After,
we had to check both (actually, I think checking user_pass would have
been sufficient)).

The situation is the same with credentials, but the variable name is
different. Even though credential_fill will fill in both parts, we may
have set http_auth.username from the URL, but not actually called
credential_fill (and therefore not sent any credentials).

So logically, the revert in the credential series would be:

  -       if (http_auth.username && http_auth.password)
  +       if (http_auth.username)

except that I believe the former is a superset of the latter in both
cases (with or without the credential topic). So leaving it as-is would
be OK. In fact, when reverting Stefan's patch, you could just drop this
hunk entirely, which might be worth it to avoid conflicts with in-flight
topics.

[1] A much saner approach would be to always return HTTP_NOAUTH, and
    then let the caller decide to re-ask for credentials and re-try.
    But we need the magic curl slot object, which the caller doesn't
    have. So doing it that way would have taken some refactoring.

> > @@ -853,8 +855,7 @@ static int http_request(const char *url, void *result, int target, int options)
> >  				 * but that is non-portable.  Using git_getpass() can at least be stubbed
> >  				 * on other platforms with a different implementation if/when necessary.
> >  				 */
> > -				if (!user_name)
> > -					user_name = xstrdup(git_getpass_with_description("Username", description));
> > +				user_name = xstrdup(git_getpass_with_description("Username", description));
> >  				init_curl_http_auth(slot->curl);
> >  				ret = HTTP_REAUTH;
> >  			}
> 
> So is this one.

Yeah, this code just goes away, as credential_fill() does the right
thing.

But again, the "if (!user_name)" version post-986bbc08 handles both the
pre-986bbc08 condition (because it will always be NULL then) and the
post-986bbc08 (because we do need to check then). So I believe you could
drop the hunk entirely.

Here's a re-roll of the revert that touches as little as possible. I
believe it's correct from my analysis above, and it does pass the tests.
I also included the flipping of the "expect_failure" test, which I
forgot to put in my original patch.

-- >8 --
Subject: [PATCH] Revert "http: don't always prompt for password"

This is a partial revert of commit 986bbc0842334f0e07731fa37f2a55d2930a5b8c.

The rationale for that commit relied on the fact that asking
for the password up-front was merely an optimization,
because git will notice an HTTP 401 and prompt for the
password. However, that is only true for smart-http, and for
dumb fetching. Dumb push over DAV does not have this
feature; as a result, authenticated push-over-DAV does not
work at all, as it never prompts the user for a password.

This is a partial revert that just restores the "don't ask
for password bits". There were some other related
adjustments in 986bbc08 to handle the fact that the
user_name field might be set even if we didn't send a
credential on the first try. The new logic introduced by
986bbc08 handles both the old case and the new case, so we
can leave them intact. That will prevent unnecessary
conflicts with other in-flight topics that touch this code.

Signed-off-by: Jeff King <peff@peff.net>
---
 http.c               |    2 ++
 t/t5540-http-push.sh |    2 +-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/http.c b/http.c
index 008ad72..33c63b5 100644
--- a/http.c
+++ b/http.c
@@ -279,6 +279,8 @@ static CURL *get_curl_handle(void)
 	curl_easy_setopt(result, CURLOPT_HTTPAUTH, CURLAUTH_ANY);
 #endif
 
+	init_curl_http_auth(result);
+
 	if (ssl_cert != NULL)
 		curl_easy_setopt(result, CURLOPT_SSLCERT, ssl_cert);
 	if (has_cert_password())
diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index 3300227..1eea647 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -160,7 +160,7 @@ test_expect_success 'PUT and MOVE sends object to URLs with SHA-1 hash suffix' '
 test_http_push_nonff "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git \
 	"$ROOT_PATH"/test_repo_clone master
 
-test_expect_failure 'push to password-protected repository (user in URL)' '
+test_expect_success 'push to password-protected repository (user in URL)' '
 	test_commit pw-user &&
 	git push "$HTTPD_URL_USER/auth/dumb/test_repo.git" HEAD &&
 	git rev-parse --verify HEAD >expect &&
-- 
1.7.8.17.gfd3524
