Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CEA71FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 20:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751788AbdBHUbe (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 15:31:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:51724 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751696AbdBHUbW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 15:31:22 -0500
Received: (qmail 26944 invoked by uid 109); 8 Feb 2017 20:31:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Feb 2017 20:31:17 +0000
Received: (qmail 31255 invoked by uid 111); 8 Feb 2017 20:31:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Feb 2017 15:31:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Feb 2017 15:31:15 -0500
Date:   Wed, 8 Feb 2017 15:31:15 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Davide Del Vento <ddvento@ucar.edu>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] diff: print line prefix for --name-only output
Message-ID: <20170208203115.4rrtk2vwixyvhhhl@sigill.intra.peff.net>
References: <CAMh-zaPdSGaDvQSiWx0p7zUmfDAFDWUyHkY4BTs=j85Ue65XnA@mail.gmail.com>
 <CACsJy8BmxpTW5pCLNEQa9sm8teU0O+_Xu+td+uh1K0Bn=yu=yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8BmxpTW5pCLNEQa9sm8teU0O+_Xu+td+uh1K0Bn=yu=yw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 08, 2017 at 01:24:34PM +0700, Duy Nguyen wrote:

> On Wed, Feb 8, 2017 at 6:11 AM, Davide Del Vento <ddvento@ucar.edu> wrote:
> > `git log --graph  --name-only` works fine, but the name is not
> > properly indented as it is for `git log --graph  --name-status`
> >
> > I tested this in git v1.9.1 the only one I have access at the moment
> 
> Confirmed still happens on master. --stat plays nicely with --graph
> though, so it's probably just some small fixes somewhere in diff*.c.

Yep. Looks like every format except --name-only handles this correctly.

-- >8 --
Subject: diff: print line prefix for --name-only output

If you run "git log --graph --name-only", the pathnames are
not indented to go along with their matching commits (unlike
all of the other diff formats). We need to output the line
prefix for each item before writing it.

The tests cover both --name-status and --name-only. The
former actually gets this right already, because it builds
on the --raw format functions. It's only --name-only which
uses its own code (and this fix mirrors the code in
diff_flush_raw()).

Note that the tests don't follow our usual style of setting
up the "expect" output inside the test block. This matches
the surrounding style, but more importantly it is easier to
read: we don't have to worry about embedded single-quotes,
and the leading indentation is more obvious.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c         |  1 +
 t/t4202-log.sh | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/diff.c b/diff.c
index d91a34490..a79f3408d 100644
--- a/diff.c
+++ b/diff.c
@@ -4450,6 +4450,7 @@ static void flush_one_pair(struct diff_filepair *p, struct diff_options *opt)
 		name_a = p->two->path;
 		name_b = NULL;
 		strip_prefix(opt->prefix_length, &name_a, &name_b);
+		fprintf(opt->file, "%s", diff_line_prefix(opt));
 		write_name_quoted(name_a, opt->file, opt->line_termination);
 	}
 }
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 08ea725de..48b55bfd2 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1212,6 +1212,54 @@ test_expect_success 'log --line-prefix="*** " --graph with diff and stats' '
 	test_i18ncmp expect actual.sanitized
 '
 
+cat >expect <<-\EOF
+* reach
+|
+| A	reach.t
+* Merge branch 'tangle'
+*   Merge branch 'side'
+|\
+| * side-2
+|
+|   A	2
+* Second
+|
+| A	one
+* sixth
+
+  D	a/two
+EOF
+
+test_expect_success 'log --graph with --name-status' '
+	git log --graph --format=%s --name-status tangle..reach >actual &&
+	sanitize_output <actual >actual.sanitized &&
+	test_cmp expect actual.sanitized
+'
+
+cat >expect <<-\EOF
+* reach
+|
+| reach.t
+* Merge branch 'tangle'
+*   Merge branch 'side'
+|\
+| * side-2
+|
+|   2
+* Second
+|
+| one
+* sixth
+
+  a/two
+EOF
+
+test_expect_success 'log --graph with --name-only' '
+	git log --graph --format=%s --name-only tangle..reach >actual &&
+	sanitize_output <actual >actual.sanitized &&
+	test_cmp expect actual.sanitized
+'
+
 test_expect_success 'dotdot is a parent directory' '
 	mkdir -p a/b &&
 	( echo sixth && echo fifth ) >expect &&
-- 
2.12.0.rc0.371.ga6cf8653b

