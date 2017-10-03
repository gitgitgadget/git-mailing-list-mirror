Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74C25202A5
	for <e@80x24.org>; Tue,  3 Oct 2017 13:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751882AbdJCNqC (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 09:46:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:59194 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751991AbdJCNpt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 09:45:49 -0400
Received: (qmail 29673 invoked by uid 109); 3 Oct 2017 13:45:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 13:45:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8009 invoked by uid 111); 3 Oct 2017 13:45:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 09:45:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Oct 2017 09:45:47 -0400
Date:   Tue, 3 Oct 2017 09:45:47 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Toni Uebernickel <tuebernickel@gmail.com>, git@vger.kernel.org,
        Tsvi Mostovicz <ttmost@gmail.com>
Subject: [PATCH 11/12] provide --color option for all ref-filter users
Message-ID: <20171003134547.c6o6kmwqhpk2eyq7@sigill.intra.peff.net>
References: <20171003133713.ccxv6clrmuuhhc3u@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171003133713.ccxv6clrmuuhhc3u@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When ref-filter learned about want_color() in 11b087adfd
(ref-filter: consult want_color() before emitting colors,
2017-07-13), it became useful to be able to turn colors off
and on for specific commands. For git-branch, you can do so
with --color/--no-color.

But for git-for-each-ref and git-tag, the other users of
ref-filter, you have no option except to tweak the
"color.ui" config setting. Let's give both of these commands
the usual color command-line options.

This is a bit more obvious as a method for overriding the
config. And it also prepares us for the behavior of "always"
changing (so that we are still left with a way of forcing
color when our output goes to a non-terminal).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-for-each-ref.txt | 5 +++++
 Documentation/git-tag.txt          | 5 +++++
 builtin/for-each-ref.c             | 1 +
 builtin/tag.c                      | 1 +
 t/t6300-for-each-ref.sh            | 4 ++--
 t/t7004-tag.sh                     | 4 ++--
 6 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 66b4e0a405..cbd0a6212a 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -57,6 +57,11 @@ OPTIONS
 	`xx`; for example `%00` interpolates to `\0` (NUL),
 	`%09` to `\t` (TAB) and `%0a` to `\n` (LF).
 
+--color[=<when>]:
+	Respect any colors specified in the `--format` option. The
+	`<when>` field must be one of `always`, `never`, or `auto` (if
+	`<when>` is absent, behave as if `always` was given).
+
 --shell::
 --perl::
 --python::
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 95e9f391d8..956fc019f9 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -115,6 +115,11 @@ options for details.
 	variable if it exists, or lexicographic order otherwise. See
 	linkgit:git-config[1].
 
+--color[=<when>]:
+	Respect any colors specified in the `--format` option. The
+	`<when>` field must be one of `always`, `never`, or `auto` (if
+	`<when>` is absent, behave as if `always` was given).
+
 -i::
 --ignore-case::
 	Sorting and filtering tags are case insensitive.
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 5d7c921a77..e931be9ce4 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -36,6 +36,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		OPT_GROUP(""),
 		OPT_INTEGER( 0 , "count", &maxcount, N_("show only <n> matched refs")),
 		OPT_STRING(  0 , "format", &format.format, N_("format"), N_("format to use for the output")),
+		OPT__COLOR(&format.use_color, N_("respect format colors")),
 		OPT_CALLBACK(0 , "sort", sorting_tail, N_("key"),
 			    N_("field name to sort on"), &parse_opt_ref_sorting),
 		OPT_CALLBACK(0, "points-at", &filter.points_at,
diff --git a/builtin/tag.c b/builtin/tag.c
index c627794181..12dbbc56d9 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -411,6 +411,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		},
 		OPT_STRING(  0 , "format", &format.format, N_("format"),
 			   N_("format to use for the output")),
+		OPT__COLOR(&format.use_color, N_("respect format colors")),
 		OPT_BOOL('i', "ignore-case", &icase, N_("sorting and filtering are case insensitive")),
 		OPT_END()
 	};
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index d6bffe6273..6358134805 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -435,8 +435,8 @@ test_expect_success '%(color) does not show color without tty' '
 	test_cmp expected.bare actual
 '
 
-test_expect_success 'color.ui=always can override tty check' '
-	git -c color.ui=always for-each-ref --format="$color_format" >actual.raw &&
+test_expect_success '--color can override tty check' '
+	git for-each-ref --color --format="$color_format" >actual.raw &&
 	test_decode_color <actual.raw >actual &&
 	test_cmp expected.color actual
 '
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 0a86f8ea39..4e62c505fc 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1912,8 +1912,8 @@ test_expect_success TTY '%(color) present with tty' '
 	test_cmp expect.color actual
 '
 
-test_expect_success 'color.ui=always overrides auto-color' '
-	git -c color.ui=always tag $color_args >actual.raw &&
+test_expect_success '--color overrides auto-color' '
+	git tag --color $color_args >actual.raw &&
 	test_decode_color <actual.raw >actual &&
 	test_cmp expect.color actual
 '
-- 
2.14.2.1079.gce6b466188

