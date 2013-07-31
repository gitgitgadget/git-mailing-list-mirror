From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 6/6] config: "git config --get-urlmatch" parses
 section.<url>.key
Date: Wed, 31 Jul 2013 16:44:48 -0700
Message-ID: <20130731234448.GA8764@sigill.intra.peff.net>
References: <1375298768-7740-1-git-send-email-gitster@pobox.com>
 <1375298768-7740-7-git-send-email-gitster@pobox.com>
 <20130731224511.GA25882@sigill.intra.peff.net>
 <62E17EDB-B24D-4F37-95F8-E2E26118E5E9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 01 01:44:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4g4h-0001JA-76
	for gcvg-git-2@plane.gmane.org; Thu, 01 Aug 2013 01:44:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218Ab3GaXoz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 19:44:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:51591 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750856Ab3GaXoy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 19:44:54 -0400
Received: (qmail 1973 invoked by uid 102); 31 Jul 2013 23:44:54 -0000
Received: from host-199-115-243-177.moscone.com (HELO sigill.intra.peff.net) (199.115.243.177)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 31 Jul 2013 18:44:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Jul 2013 16:44:48 -0700
Content-Disposition: inline
In-Reply-To: <62E17EDB-B24D-4F37-95F8-E2E26118E5E9@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231480>

On Wed, Jul 31, 2013 at 04:03:01PM -0700, Kyle J. McKay wrote:

> > 1. Git-config expects pre-canonicalized variable names (so
> >http.noepsv
> >    instead of "http.noEPSV"). I think the "git config --get" code
> >path
> >    does this for the caller, so we should probably do the same for
> >    "--get-urlmatch". And it is even easier here, because we know that
> >    "http.noEPSV" does not contain a case-sensitive middle part. :)
> 
> The test was testing that too, which I think is a good thing.  Your
> replacement does not test that.  With a fix for --get-urlmatch as you
> mention above, the tests can check that again.

I do not think the existing tests were checking anything interesting in
that respect. The url-matching code does not do the canonicalization,
and nor should it (the internal callbacks for all variables should use
the canonical lowercase version). So we were only testing that
test-url-normalize lowercased them, which is not something we actually
care about (nobody but the test script should ever call it).

That being said, git-config _should_ be lowercasing to match the normal
--get code path. I think the fix (squashable on top of 6/6 + my earlier
patch) is just:

diff --git a/builtin/config.c b/builtin/config.c
index c35c5be..9328a90 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -589,7 +589,9 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	}
 	else if (actions == ACTION_GET_URLMATCH) {
 		check_argc(argc, 2, 2);
-		return get_urlmatch(argv[0], argv[1]);
+		if (git_config_parse_key(argv[0], &key, NULL))
+			return CONFIG_INVALID_KEY;
+		return get_urlmatch(key, argv[1]);
 	}
 	else if (actions == ACTION_UNSET) {
 		check_argc(argc, 1, 2);
diff --git a/t/t5200-url-normalize.sh b/t/t5200-url-normalize.sh
index a5190f7..7284dc6 100755
--- a/t/t5200-url-normalize.sh
+++ b/t/t5200-url-normalize.sh
@@ -190,14 +190,14 @@ check_url_config "$tc-2" example-agent http.useragent HTTPS://example.COM/p%61th
 
 check_url_config "$tc-1" other-agent http.useragent https://other.example.com/
 check_url_config "$tc-1" example-agent http.useragent https://example.com/
-check_url_config "$tc-1" false --bool http.sslverify https://example.com/
+check_url_config "$tc-1" false --bool http.sslVerify https://example.com/
 check_url_config "$tc-1" path-agent http.useragent https://example.com/path/sub
-check_url_config "$tc-1" false --bool http.sslverify https://example.com/path/sub
-check_url_config "$tc-1" true --bool http.noepsv https://elsewhere.com/
-check_url_config "$tc-1" true --bool http.noepsv https://example.com
-check_url_config "$tc-1" true --bool http.noepsv https://example.com/path
+check_url_config "$tc-1" false --bool http.sslVerify https://example.com/path/sub
+check_url_config "$tc-1" true --bool http.noEPSV https://elsewhere.com/
+check_url_config "$tc-1" true --bool http.noEPSV https://example.com
+check_url_config "$tc-1" true --bool http.noEPSV https://example.com/path
 check_url_config "$tc-2" example-agent http.useragent HTTPS://example.COM/p%61th
-check_url_config "$tc-2" false --bool http.sslverify HTTPS://example.COM/p%61th
+check_url_config "$tc-2" false --bool http.sslVerify HTTPS://example.COM/p%61th
 check_url_config "$tc-3" file-1 http.sslcainfo https://user@example.com/path/name/here
 
 test_done

> >    The wrapper is a little ugly. I do wonder if we actually need all
> >    of these tests (i.e., it is not clear to me what different things
> >    each is testing, and if it is not simply trying to exercise the
> >    different variable names, which now all follow the same code path,
> >    because git-config does not care about the particular names).
> 
> Each one tests a different item from the "$tc-n" config file to make
> sure that everything that's in each config file actually behaves as
> expected.

I guess I don't understand why we have so many items in each file. That
is, we have:

	"$tc-1" "useragent" "https://other.example.com/" = "other-agent"
	"$tc-1" "useragent" "https://example.com/" = "example-agent"

The first checks that we do not apply within a sub-domain (but fall back
to http.useragent), and the second checks that we do properly apply the
full domain.

	"$tc-1" "sslVerify" "https://example.com/" = "false"

This check seems redundant with the second one above.

	"$tc-1" "useragent" "https://example.com/path/sub" = "path-agent"
	"$tc-1" "sslVerify" "https://example.com/path/sub" = "false"

Here we make sure paths are preferred over non-paths (the first one),
but that config keys with non-paths are still used (the second).

	"$tc-1" "noEPSV" "https://elsewhere.com/" = "true"

This seems redundant with the first test (check that we do not match and
fallback to http.noepsv).

	"$tc-1" "noEPSV" "https://example.com" = "true"

Not sure what we are testing here; there is no variable besides the
one in http.noepsv. Somewhat redundant with the first test.

	"$tc-1" "noEPSV" "https://example.com/path" = "true"

Ditto.

	"$tc-2" "useragent" "HTTPS://example.COM/p%61th" = "example-agent"
	"$tc-2" "sslVerify" "HTTPS://example.COM/p%61th" = "false"

Testing normalization, though they seem redundant with each other.

	"$tc-3" "sslcainfo" "https://user@example.com/path/name/here" = "file-1"

Testing specific pathnames preferred to usernames, which is useful.

I don't mean to nitpick. It was just hard as a reader to figure out what
specifically each one was interested in checking, which means it may be
similarly hard if one of the tests is later broken for the investigator
to figure out what was happening. I don't know if it is worth putting
each in its own test and annotating what each is looking for (it may
also help show gaps; e.g., we check that longer pathnames trump
usernames, but we do not check that the same pathname prefers the
version with the username).

> If we do this (and I don't really have any objection except for the
> point noted above), then the tests really need to move out from t5200
> [...]
> But the best choice does not immediately jump out at me.  However,
> looking at the other tests that are there, I think perhaps
> 1307-config-url might be a reasonable choice.

Yes, that makes sense to me; all of the other config is in the t1300
series.

-Peff
