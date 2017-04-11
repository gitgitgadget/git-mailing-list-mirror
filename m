Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF62020960
	for <e@80x24.org>; Tue, 11 Apr 2017 00:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753271AbdDKAf6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 20:35:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:59570 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752022AbdDKAf5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 20:35:57 -0400
Received: (qmail 6121 invoked by uid 109); 11 Apr 2017 00:35:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 00:35:57 +0000
Received: (qmail 30437 invoked by uid 111); 11 Apr 2017 00:36:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Apr 2017 20:36:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Apr 2017 20:35:54 -0400
Date:   Mon, 10 Apr 2017 20:35:54 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Joachim Durchholz <jo@durchholz.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] connect.c: handle errors from split_cmdline
Message-ID: <20170411003554.2tjnn65vfco376kj@sigill.intra.peff.net>
References: <20170409191117.25175-1-avarab@gmail.com>
 <20170409191117.25175-3-avarab@gmail.com>
 <CACBZZX7OfM-zivJAQMXdNarHDjAhzQhqGNZNs2QqDUyOo3AA0g@mail.gmail.com>
 <20170411003023.ynzc76yzdmomxthp@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170411003023.ynzc76yzdmomxthp@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 10, 2017 at 08:30:23PM -0400, Jeff King wrote:

> On Tue, Apr 11, 2017 at 01:23:32AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> > There's one segfault in there:
> > 
> > $ ./t5601-clone.sh --root="xtmp.$(perl -e 'print chr 39')" -v -i -d
> > [...]
> > Cloning into 'ssh-bracket-clone-plink-4'...
> > Segmentation fault
> > not ok 45 - single quoted plink.exe in GIT_SSH_COMMAND
> 
> Here's a fix for that one. I think there are a few other memory
> irregularities in that function, too. I'll send another patch in a
> minute, but I wanted to get this out in case you were working on it,
> too.

Actually, nevermind. I thought there was an issue with freeing via the
results of basename(), but there isn't. There is a minor memory leak,
but it's best squashed into my original patch, like so:

-- >8 --
Subject: [PATCH] connect.c: handle errors from split_cmdline

Commit e9d9a8a4d (connect: handle putty/plink also in
GIT_SSH_COMMAND, 2017-01-02) added a call to
split_cmdline(), but checks only for a non-zero return to
see if we got any output. Since the function returns
negative values (and a NULL argv) on error, we end up
dereferencing NULL and segfaulting.

Arguably we could report on the parsing error here, but it's
probably not worth it. This is a best-effort attempt to see
if we are using plink. So we can simply return here with
"no, it wasn't plink" and let the shell actually complain
about the bogus quoting.

While we're here, let's also fix the leak when our split
fails (as it turns out, split_cmdline can never return 0, so
this leak wasn't actually triggerable before).

Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 connect.c        | 6 ++++--
 t/t5601-clone.sh | 6 ++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/connect.c b/connect.c
index 7d65c1c73..380997afd 100644
--- a/connect.c
+++ b/connect.c
@@ -729,18 +729,20 @@ static void handle_ssh_variant(const char *ssh_command, int is_cmdline,
 	} else {
 		const char **ssh_argv;
 
 		p = xstrdup(ssh_command);
-		if (split_cmdline(p, &ssh_argv)) {
+		if (split_cmdline(p, &ssh_argv) > 0) {
 			variant = basename((char *)ssh_argv[0]);
 			/*
 			 * At this point, variant points into the buffer
 			 * referenced by p, hence we do not need ssh_argv
 			 * any longer.
 			 */
 			free(ssh_argv);
-		} else
+		} else {
+			free(p);
 			return;
+		}
 	}
 
 	if (!strcasecmp(variant, "plink") ||
 	    !strcasecmp(variant, "plink.exe"))
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index b52b8acf9..9c56f771b 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -426,8 +426,14 @@ test_expect_success 'GIT_SSH_VARIANT overrides plink to tortoiseplink' '
 	git clone "[myhost:123]:src" ssh-bracket-clone-variant-4 &&
 	expect_ssh "-batch -P 123" myhost src
 '
 
+test_expect_success 'clean failure on broken quoting' '
+	test_must_fail \
+		env GIT_SSH_COMMAND="${SQ}plink.exe -v" \
+		git clone "[myhost:123]:src" sq-failure
+'
+
 # Reset the GIT_SSH environment variable for clone tests.
 setup_ssh_wrapper
 
 counter=0
-- 
2.12.2.952.g759391acc

