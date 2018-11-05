Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 413B51F453
	for <e@80x24.org>; Mon,  5 Nov 2018 06:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbeKEQCh (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 11:02:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:40420 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728955AbeKEQCh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 11:02:37 -0500
Received: (qmail 21973 invoked by uid 109); 5 Nov 2018 06:44:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 05 Nov 2018 06:44:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17260 invoked by uid 111); 5 Nov 2018 06:43:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 05 Nov 2018 01:43:47 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Nov 2018 01:44:27 -0500
Date:   Mon, 5 Nov 2018 01:44:27 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 12/13] parse-options: drop OPT_DATE()
Message-ID: <20181105064427.GL25864@sigill.intra.peff.net>
References: <20181105063718.GA24877@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181105063718.GA24877@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are no users of OPT_DATE except for test-parse-options; its
only caller went away in 27ec394a97 (prune: introduce OPT_EXPIRY_DATE()
and use it, 2013-04-25).

It also has a bug: it does not specify PARSE_OPT_NONEG, but its callback
does not respect the "unset" flag, and will feed NULL to approxidate()
and segfault. Probably this should be marked with NONEG, or the callback
should set the timestamp to some sentinel value (e.g,. "0", or
"(time_t)-1").

But since there are no callers, deleting it means we don't even have to
think about what the right behavior should be.

Signed-off-by: Jeff King <peff@peff.net>
---
 parse-options-cb.c            |  7 -------
 parse-options.h               |  4 ----
 t/helper/test-parse-options.c |  1 -
 t/t0040-parse-options.sh      | 22 ----------------------
 4 files changed, 34 deletions(-)

diff --git a/parse-options-cb.c b/parse-options-cb.c
index e8236534ac..6a61166b26 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -28,13 +28,6 @@ int parse_opt_abbrev_cb(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
-int parse_opt_approxidate_cb(const struct option *opt, const char *arg,
-			     int unset)
-{
-	*(timestamp_t *)(opt->value) = approxidate(arg);
-	return 0;
-}
-
 int parse_opt_expiry_date_cb(const struct option *opt, const char *arg,
 			     int unset)
 {
diff --git a/parse-options.h b/parse-options.h
index dd14911a29..c3f2d2eceb 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -150,9 +150,6 @@ struct option {
 				      (h), 0, &parse_opt_string_list }
 #define OPT_UYN(s, l, v, h)         { OPTION_CALLBACK, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG, &parse_opt_tertiary }
-#define OPT_DATE(s, l, v, h) \
-	{ OPTION_CALLBACK, (s), (l), (v), N_("time"),(h), 0,	\
-	  parse_opt_approxidate_cb }
 #define OPT_EXPIRY_DATE(s, l, v, h) \
 	{ OPTION_CALLBACK, (s), (l), (v), N_("expiry-date"),(h), 0,	\
 	  parse_opt_expiry_date_cb }
@@ -232,7 +229,6 @@ extern struct option *parse_options_concat(struct option *a, struct option *b);
 
 /*----- some often used options -----*/
 extern int parse_opt_abbrev_cb(const struct option *, const char *, int);
-extern int parse_opt_approxidate_cb(const struct option *, const char *, int);
 extern int parse_opt_expiry_date_cb(const struct option *, const char *, int);
 extern int parse_opt_color_flag_cb(const struct option *, const char *, int);
 extern int parse_opt_verbosity_cb(const struct option *, const char *, int);
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index 9cb8a0ea0f..f0623bb42b 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -119,7 +119,6 @@ int cmd__parse_options(int argc, const char **argv)
 		OPT_INTEGER('j', NULL, &integer, "get a integer, too"),
 		OPT_MAGNITUDE('m', "magnitude", &magnitude, "get a magnitude"),
 		OPT_SET_INT(0, "set23", &integer, "set integer to 23", 23),
-		OPT_DATE('t', NULL, &timestamp, "get timestamp of <time>"),
 		OPT_CALLBACK('L', "length", &integer, "str",
 			"get length of <str>", length_callback),
 		OPT_FILENAME('F', "file", &file, "set file to <file>"),
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 17d0c18feb..f5b10861c4 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -23,7 +23,6 @@ usage: test-tool parse-options <options>
     -j <n>                get a integer, too
     -m, --magnitude <n>   get a magnitude
     --set23               set integer to 23
-    -t <time>             get timestamp of <time>
     -L, --length <str>    get length of <str>
     -F, --file <file>     set file to <file>
 
@@ -245,27 +244,6 @@ test_expect_success 'keep some options as arguments' '
 	test-tool parse-options --expect="arg 00: --quux" --quux
 '
 
-cat >expect <<\EOF
-boolean: 0
-integer: 0
-magnitude: 0
-timestamp: 1
-string: (not set)
-abbrev: 7
-verbose: -1
-quiet: 1
-dry run: no
-file: (not set)
-arg 00: foo
-EOF
-
-test_expect_success 'OPT_DATE() works' '
-	test-tool parse-options -t "1970-01-01 00:00:01 +0000" \
-		foo -q >output 2>output.err &&
-	test_must_be_empty output.err &&
-	test_cmp expect output
-'
-
 cat >expect <<\EOF
 Callback: "four", 0
 boolean: 5
-- 
2.19.1.1505.g9cd28186cf

