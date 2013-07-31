From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 6/6] config: "git config --get-urlmatch" parses
 section.<url>.key
Date: Wed, 31 Jul 2013 15:45:13 -0700
Message-ID: <20130731224511.GA25882@sigill.intra.peff.net>
References: <1375298768-7740-1-git-send-email-gitster@pobox.com>
 <1375298768-7740-7-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Kyle J. McKay" <mackyle@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 01 00:45:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4f91-0001cg-Bv
	for gcvg-git-2@plane.gmane.org; Thu, 01 Aug 2013 00:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760851Ab3GaWpS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 18:45:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:51203 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757727Ab3GaWpR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 18:45:17 -0400
Received: (qmail 31514 invoked by uid 102); 31 Jul 2013 22:45:17 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (107.226.235.221)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 31 Jul 2013 17:45:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Jul 2013 15:45:13 -0700
Content-Disposition: inline
In-Reply-To: <1375298768-7740-7-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231474>

On Wed, Jul 31, 2013 at 12:26:08PM -0700, Junio C Hamano wrote:

> Using the same urlmatch_config_entry() infrastructure, add a new
> mode "--get-urlmatch" to the "git config" command, to learn values
> for the "virtual" two-level variables customized for the specific
> URL.
> 
>     git config [--<type>] --get-urlmatch <section>[.<key>] <url>

Do we want something like this on top, to convert the third form of
test-url-normalize into git-config calls?

It would be nicer squashed in, but we the tests are added earlier in the
series than "--get-urlmatch", so we would have to rip the tests out of
the earlier patches and have a "[PATCH 7/6] add tests for url
normalizing".

Two things to note about my test conversion:

  1. Git-config expects pre-canonicalized variable names (so http.noepsv
     instead of "http.noEPSV"). I think the "git config --get" code path
     does this for the caller, so we should probably do the same for
     "--get-urlmatch". And it is even easier here, because we know that
     "http.noEPSV" does not contain a case-sensitive middle part. :)

  2. I turned the many 'test "$(git foo)" = "bar"' invocations into a
     wrapper function that uses test_cmp. This helped immensely with
     debugging (1).

     The wrapper is a little ugly. I do wonder if we actually need all
     of these tests (i.e., it is not clear to me what different things
     each is testing, and if it is not simply trying to exercise the
     different variable names, which now all follow the same code path,
     because git-config does not care about the particular names).

---
 t/t5200-url-normalize.sh | 40 ++++++++-------
 test-url-normalize.c     | 93 ++---------------------------------
 2 files changed, 27 insertions(+), 106 deletions(-)

diff --git a/t/t5200-url-normalize.sh b/t/t5200-url-normalize.sh
index f79bb0f..a5190f7 100755
--- a/t/t5200-url-normalize.sh
+++ b/t/t5200-url-normalize.sh
@@ -3,11 +3,6 @@ test_description='url normalization'
 test_description='url normalization'
 . ./test-lib.sh
 
-if test -n "$NO_CURL"; then
-	skip_all='skipping test, git built without http support'
-	test_done
-fi
-
 # The base name of the test url files
 tu="$TEST_DIRECTORY/t5200/url"
 
@@ -182,18 +177,27 @@ test_expect_success 'url equivalents' '
 	test-url-normalize "https://@x.y/^/.." "httpS://@x.y:0443/"
 '
 
-test_expect_success 'url config normalization matching' '
-	test "$(test-url-normalize -c "$tc-1" "useragent" "https://other.example.com/")" = "other-agent" &&
-	test "$(test-url-normalize -c "$tc-1" "useragent" "https://example.com/")" = "example-agent" &&
-	test "$(test-url-normalize -c "$tc-1" "sslVerify" "https://example.com/")" = "false" &&
-	test "$(test-url-normalize -c "$tc-1" "useragent" "https://example.com/path/sub")" = "path-agent" &&
-	test "$(test-url-normalize -c "$tc-1" "sslVerify" "https://example.com/path/sub")" = "false" &&
-	test "$(test-url-normalize -c "$tc-1" "noEPSV" "https://elsewhere.com/")" = "true" &&
-	test "$(test-url-normalize -c "$tc-1" "noEPSV" "https://example.com")" = "true" &&
-	test "$(test-url-normalize -c "$tc-1" "noEPSV" "https://example.com/path")" = "true" &&
-	test "$(test-url-normalize -c "$tc-2" "useragent" "HTTPS://example.COM/p%61th")" = "example-agent" &&
-	test "$(test-url-normalize -c "$tc-2" "sslVerify" "HTTPS://example.COM/p%61th")" = "false" &&
-	test "$(test-url-normalize -c "$tc-3" "sslcainfo" "https://user@example.com/path/name/here")" = "file-1"
-'
+check_url_config() {
+	config=$1; shift
+	expect=$1; shift
+
+	test_expect_success "config normalization ($*)" "
+		echo '$expect' >expect &&
+		git config --file="\$config" --get-urlmatch $* >actual &&
+		test_cmp expect actual
+	"
+}
+
+check_url_config "$tc-1" other-agent http.useragent https://other.example.com/
+check_url_config "$tc-1" example-agent http.useragent https://example.com/
+check_url_config "$tc-1" false --bool http.sslverify https://example.com/
+check_url_config "$tc-1" path-agent http.useragent https://example.com/path/sub
+check_url_config "$tc-1" false --bool http.sslverify https://example.com/path/sub
+check_url_config "$tc-1" true --bool http.noepsv https://elsewhere.com/
+check_url_config "$tc-1" true --bool http.noepsv https://example.com
+check_url_config "$tc-1" true --bool http.noepsv https://example.com/path
+check_url_config "$tc-2" example-agent http.useragent HTTPS://example.COM/p%61th
+check_url_config "$tc-2" false --bool http.sslverify HTTPS://example.COM/p%61th
+check_url_config "$tc-3" file-1 http.sslcainfo https://user@example.com/path/name/here
 
 test_done
diff --git a/test-url-normalize.c b/test-url-normalize.c
index 81d3da9..34a1a67 100644
--- a/test-url-normalize.c
+++ b/test-url-normalize.c
@@ -1,84 +1,11 @@ int main(int argc, char **argv)
-#ifdef NO_CURL
-
-int main()
-{
-	return 125;
-}
-
-#else /* !NO_CURL */
-
-#include "http.c"
-
-static int run_http_options(const char *file,
-			    const char *opt,
-			    const struct url_info *info)
-{
-	struct strbuf opt_lc;
-	size_t i, len;
-	struct urlmatch_config config = { STRING_LIST_INIT_DUP };
-
-	memcpy(&config.url, info, sizeof(*info));
-	config.section = "http";
-	config.collect_fn = http_options;
-	config.cascade_fn = git_default_config;
-	config.cb = NULL;
-
-	if (git_config_with_options(urlmatch_config_entry, &config, file, 0))
-		return 1;
-
-	len = strlen(opt);
-	strbuf_init(&opt_lc, len);
-	for (i = 0; i < len; ++i) {
-		strbuf_addch(&opt_lc, tolower(opt[i]));
-	}
-
-	if (!strcmp("sslverify", opt_lc.buf))
-		printf("%s\n", curl_ssl_verify ? "true" : "false");
-	else if (!strcmp("sslcert", opt_lc.buf))
-		printf("%s\n", ssl_cert);
-#if LIBCURL_VERSION_NUM >= 0x070903
-	else if (!strcmp("sslkey", opt_lc.buf))
-		printf("%s\n", ssl_key);
-#endif
-#if LIBCURL_VERSION_NUM >= 0x070908
-	else if (!strcmp("sslcapath", opt_lc.buf))
-		printf("%s\n", ssl_capath);
-#endif
-	else if (!strcmp("sslcainfo", opt_lc.buf))
-		printf("%s\n", ssl_cainfo);
-	else if (!strcmp("sslcertpasswordprotected", opt_lc.buf))
-		printf("%s\n", ssl_cert_password_required ? "true" : "false");
-	else if (!strcmp("ssltry", opt_lc.buf))
-		printf("%s\n", curl_ssl_try ? "true" : "false");
-	else if (!strcmp("minsessions", opt_lc.buf))
-		printf("%d\n", min_curl_sessions);
-	else if (!strcmp("maxrequests", opt_lc.buf))
-		printf("%d\n", max_requests);
-	else if (!strcmp("lowspeedlimit", opt_lc.buf))
-		printf("%ld\n", curl_low_speed_limit);
-	else if (!strcmp("lowspeedtime", opt_lc.buf))
-		printf("%ld\n", curl_low_speed_time);
-	else if (!strcmp("noepsv", opt_lc.buf))
-		printf("%s\n", curl_ftp_no_epsv ? "true" : "false");
-	else if (!strcmp("proxy", opt_lc.buf))
-		printf("%s\n", curl_http_proxy);
-	else if (!strcmp("cookiefile", opt_lc.buf))
-		printf("%s\n", curl_cookie_file);
-	else if (!strcmp("postbuffer", opt_lc.buf))
-		printf("%u\n", (unsigned)http_post_buffer);
-	else if (!strcmp("useragent", opt_lc.buf))
-		printf("%s\n", user_agent);
-
-	return 0;
-}
+#include "git-compat-util.h"
+#include "urlmatch.h"
 
 int main(int argc, char **argv)
 {
-	const char *usage = "test-url-normalize [-p | -l] <url1> | <url1> <url2>"
-		" | -c file option <url1>";
+	const char *usage = "test-url-normalize [-p | -l] <url1> | <url1> <url2>";
 	char *url1, *url2;
-	int opt_p = 0, opt_l = 0, opt_c = 0;
-	char *file = NULL, *optname = NULL;
+	int opt_p = 0, opt_l = 0;
 
 	/*
 	 * For one url, succeed if url_normalize succeeds on it, fail otherwise.
@@ -101,12 +28,6 @@ int main(int argc, char **argv)
 		opt_l = 1;
 		argc--;
 		argv++;
-	} else if (argc > 3 && !strcmp(argv[1], "-c")) {
-		opt_c = 1;
-		file = argv[2];
-		optname = argv[3];
-		argc -= 3;
-		argv += 3;
 	}
 
 	if (argc < 2 || argc > 3)
@@ -121,17 +42,13 @@ int main(int argc, char **argv)
 			printf("%s\n", url1);
 		if (opt_l)
 			printf("%u\n", (unsigned)info.url_len);
-		if (opt_c)
-			return run_http_options(file, optname, &info);
 		return 0;
 	}
 
-	if (opt_p || opt_l || opt_c)
+	if (opt_p || opt_l)
 		die(usage);
 
 	url1 = url_normalize(argv[1], NULL);
 	url2 = url_normalize(argv[2], NULL);
 	return (url1 && url2 && !strcmp(url1, url2)) ? 0 : 1;
 }
-
-#endif /* !NO_CURL */
