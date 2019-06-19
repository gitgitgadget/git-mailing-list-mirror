Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC8B41F462
	for <e@80x24.org>; Wed, 19 Jun 2019 03:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbfFSDhb (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 23:37:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:59180 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726037AbfFSDhb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 23:37:31 -0400
Received: (qmail 23513 invoked by uid 109); 19 Jun 2019 03:37:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 19 Jun 2019 03:37:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20518 invoked by uid 111); 19 Jun 2019 03:38:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 18 Jun 2019 23:38:18 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Jun 2019 23:37:28 -0400
Date:   Tue, 18 Jun 2019 23:37:28 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        git <git@vger.kernel.org>, masahiroy@kernel.org
Subject: [PATCH] interpret-trailers: load default config
Message-ID: <20190619033728.GA29027@sigill.intra.peff.net>
References: <CAK7LNAR=KhTZRFFXTbcZwe-+65fGnVB7NbmVbQ7ymbmChDuhAg@mail.gmail.com>
 <20190614150758.GA22984@sigill.intra.peff.net>
 <CAP8UFD2dhGqOxXJMTZhNSM5G4sp6PvKF+0R5KVk6YjAQi3Sccw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD2dhGqOxXJMTZhNSM5G4sp6PvKF+0R5KVk6YjAQi3Sccw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 15, 2019 at 10:41:44AM +0200, Christian Couder wrote:

> On Fri, Jun 14, 2019 at 5:10 PM Jeff King <peff@peff.net> wrote:
> >
> > On Fri, Jun 14, 2019 at 08:35:04PM +0900, Masahiro Yamada wrote:
> >
> > > Perhaps, 'git interpret-trailers' should be changed
> > > to recognize core.commentChar ?
> >
> > It looks like the trailer code does respect it, but the
> > interpret-trailers program never loads the config. Does the patch below
> > make your problem go away?
> 
> It seems to me to be the right analysis and the right fix too.

Thanks. Here it is (below) with a commit message and a test. I tried to
build on the existing comment test, but the resulting diff is hard to
read due to the indent change; try it with "-w".

> > I do wonder if the trailer code is correct to always respect it, though.
> > For example, in "git log" output we'd expect to see commit messages from
> > people with all sorts of config. I suppose the point is that their
> > comment characters wouldn't make it into the commit object at all, so
> > the right answer there is probably not to look for comment characters at
> > all.
> 
> Would you suggest an option, maybe called `--ignore-comments` to ignore them?

Yeah, though I think most callers of interpret-trailers would probably
want the existing behavior. I'd be more concerned about the internal
callers to the trailer code, like "git log --format=%(trailers)". I
doubt it's that big a deal in practice, though. As I said above, the
idea is that comments would be removed before making it into commit
objects anyway. So we shouldn't be seeing comments, and so the code to
recognize them is not likely to trigger (and I think it would be
reasonably hard to trigger a false positive accidentally).

If you or somebody else wants to dig into it, be my guest, but I don't
think I'd prioritize it.

-- >8 --
Subject: [PATCH] interpret-trailers: load default config

The interpret-trailers program does not do the usual loading of config
via git_default_config(), and thus does not respect many of the usual
options. In particular, we will not load core.commentChar, even though
the underlying trailer code tries to do so.

This can be seen in the accompanying test, where setting
core.commentChar to anything besides "#" results in a failure to treat
the comments correctly.

Reported-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/interpret-trailers.c  |  3 ++
 t/t7513-interpret-trailers.sh | 70 +++++++++++++++++++++--------------
 2 files changed, 46 insertions(+), 27 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 8ae40dec47..f101d092b8 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -10,6 +10,7 @@
 #include "parse-options.h"
 #include "string-list.h"
 #include "trailer.h"
+#include "config.h"
 
 static const char * const git_interpret_trailers_usage[] = {
 	N_("git interpret-trailers [--in-place] [--trim-empty] [(--trailer <token>[(=|:)<value>])...] [<file>...]"),
@@ -112,6 +113,8 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	git_config(git_default_config, NULL);
+
 	argc = parse_options(argc, argv, prefix, options,
 			     git_interpret_trailers_usage, 0);
 
diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index c441861331..1da194e527 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -538,33 +538,49 @@ test_expect_success 'with 2 files arguments' '
 	test_cmp expected actual
 '
 
-test_expect_success 'with message that has comments' '
-	cat basic_message >message_with_comments &&
-	sed -e "s/ Z\$/ /" >>message_with_comments <<-\EOF &&
-		# comment
-
-		# other comment
-		Cc: Z
-		# yet another comment
-		Reviewed-by: Johan
-		Reviewed-by: Z
-		# last comment
-
-	EOF
-	cat basic_patch >>message_with_comments &&
-	cat basic_message >expected &&
-	cat >>expected <<-\EOF &&
-		# comment
-
-		Reviewed-by: Johan
-		Cc: Peff
-		# last comment
-
-	EOF
-	cat basic_patch >>expected &&
-	git interpret-trailers --trim-empty --trailer "Cc: Peff" message_with_comments >actual &&
-	test_cmp expected actual
-'
+# Cover multiple comment characters with the same test input.
+for char in "#" ";"; do
+	case "$char" in
+	"#")
+		# This is the default, so let's explicitly _not_
+		# set any config to make sure it behaves as we expect.
+		;;
+	*)
+		config="-c core.commentChar=$char"
+		;;
+	esac
+
+	test_expect_success "with message that has comments ($char)" '
+		cat basic_message >message_with_comments &&
+		sed -e "s/ Z\$/ /" \
+		    -e "s/#/$char/g" >>message_with_comments <<-EOF &&
+			# comment
+
+			# other comment
+			Cc: Z
+			# yet another comment
+			Reviewed-by: Johan
+			Reviewed-by: Z
+			# last comment
+
+		EOF
+		cat basic_patch >>message_with_comments &&
+		cat basic_message >expected &&
+		sed -e "s/#/$char/g" >>expected <<-\EOF &&
+			# comment
+
+			Reviewed-by: Johan
+			Cc: Peff
+			# last comment
+
+		EOF
+		cat basic_patch >>expected &&
+		git $config interpret-trailers \
+			--trim-empty --trailer "Cc: Peff" \
+			message_with_comments >actual &&
+		test_cmp expected actual
+	'
+done
 
 test_expect_success 'with message that has an old style conflict block' '
 	cat basic_message >message_with_comments &&
-- 
2.22.0.rc3.685.g5185838c9a

