Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C43C20401
	for <e@80x24.org>; Wed, 14 Jun 2017 10:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752167AbdFNKyl (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 06:54:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:39959 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750728AbdFNKyk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 06:54:40 -0400
Received: (qmail 20564 invoked by uid 109); 14 Jun 2017 10:54:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jun 2017 10:54:39 +0000
Received: (qmail 11136 invoked by uid 111); 14 Jun 2017 10:54:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jun 2017 06:54:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Jun 2017 06:54:37 -0400
Date:   Wed, 14 Jun 2017 06:54:37 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH v2 0/2] warn when adding an embedded repository
Message-ID: <20170614105437.cgdlykmtocdj5vzw@sigill.intra.peff.net>
References: <20170613091452.ew2rwx5r6axxo65p@sigill.intra.peff.net>
 <20170613092408.db22ygki6wg2t23d@sigill.intra.peff.net>
 <CAGZ79kbbTwQicVkRs51fV91R_7ZhDtC+FR8Z-SQzRpF2cjFfag@mail.gmail.com>
 <20170614063614.a34ovimjpz2g24qe@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170614063614.a34ovimjpz2g24qe@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 14, 2017 at 02:36:14AM -0400, Jeff King wrote:

> > This patch looks good to me, apart from the perceived wording nits.
> 
> Thanks. I'll re-roll with a few tweaks based on your feedback.

Here it is. It just changes the wording and fixes the test as you
suggested.

  [1/2]: add: warn when adding an embedded repository
  [2/2]: t: move "git add submodule" into test blocks

I had some thoughts on adding a third patch to cover the case where
.gitmodules has already been updated. But I couldn't figure out how to
make it work. The patch I came up with is below:

diff --git a/builtin/add.c b/builtin/add.c
index d7cab1bd8..d20052462 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -322,6 +322,8 @@ static void check_embedded_repo(const char *path)
 		return;
 	if (!ends_with(path, "/"))
 		return;
+	if (is_submodule_initialized(path))
+		return;
 
 	/* Drop trailing slash for aesthetics */
 	strbuf_addstr(&name, path);
diff --git a/t/t7414-submodule-mistakes.sh b/t/t7414-submodule-mistakes.sh
index f2e7df59c..aee52b218 100755
--- a/t/t7414-submodule-mistakes.sh
+++ b/t/t7414-submodule-mistakes.sh
@@ -34,4 +34,14 @@ test_expect_success 'submodule add does not warn' '
 	test_i18ngrep ! warning stderr
 '
 
+test_expect_success 'making your own submodule does not warn' '
+	test_when_finished "git rm --cached -f embed &&
+			    git rm -f .gitmodules" &&
+	git config -f .gitmodules submodule.embed.path embed &&
+	git config -f .gitmodules submodule.embed.url \
+				  git://example.com/embed.git &&
+	git add embed 2>stderr &&
+	test_i18ngrep ! warning stderr
+'
+
 test_done

But that doesn't quite work. Because the submodule data is just in
.gitmodules, it's not actually "initialized". I think that might work if
instead it was:

  git config submodule.embed.url ...

but I'm not clear on whether that should work, or if it's even something
somebody would want to do. So I decided to punt on the whole thing and
let somebody work on it who a) knows more about how submodules work or
b) has some not-quite-submodule use case for gitlinks that they want to
have work (without a warning).

-Peff
