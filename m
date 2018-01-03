Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7D831F404
	for <e@80x24.org>; Wed,  3 Jan 2018 08:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751145AbeACIby (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 03:31:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:51710 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750748AbeACIbx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 03:31:53 -0500
Received: (qmail 12240 invoked by uid 109); 3 Jan 2018 08:31:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 03 Jan 2018 08:31:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25071 invoked by uid 111); 3 Jan 2018 08:32:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Wed, 03 Jan 2018 03:32:18 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Jan 2018 03:31:46 -0500
Date:   Wed, 3 Jan 2018 03:31:46 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Damien =?utf-8?B?TWFyacOp?= <damien@dam.io>
Subject: Re: [PATCH v3] run-command: add hint when a hook is ignored
Message-ID: <20180103083145.GA7049@sigill.intra.peff.net>
References: <xmqqh8vcx1nh.fsf@gitster.mtv.corp.google.com>
 <0102015ef0ba0273-ed29c030-7cdc-4535-a411-6cc443bd5f43-000000@eu-west-1.amazonses.com>
 <xmqqy3ojpr9f.fsf@gitster.mtv.corp.google.com>
 <xmqqmv4ymc7w.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmv4ymc7w.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 11, 2017 at 03:26:43PM +0900, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Quite honestly, I do not particulary think this is confusing, and I
> > expect that this change will irritate many people by forcing them to
> > either set the advise config or move the ones that they deliberately
> > left unexecutable by renaming them by adding ".disabled" at the end.
> >
> > But these remedies are easy enough, so let's see how well it works
> > by merging it to 'next' and cooking it there for a while.
> 
> Well, it turns out that I am among those who are irritated, as all
> the repositories I work with were rather old, dating back to 2005,
> back when it was a norm to have these sample files installed without
> executable bit, to make it easy for those who choose to use them
> as-is to enable them by flipping the executable bit.
> [...]
> Anyway, I am not merging this topic to the upcoming release, so
> hopefully we'll hear from others who try 'next'.

This bit me today in a funny way: t5523 started failing.

The problem is that I was bisecting an unrelated change in old code, and
I built a commit which predates f98f8cbac0 (Ship sample hooks with .sample
suffix, 2008-06-24). That wrote a bare "update" file into templates/blt
(without the ".sample" suffix). After that, the cruft is forever in my
build directory until I "git clean -x".

The t5523 script tries to run "git push --quiet" and make sure that it
produces no output, but with this setup it produces a round of "hint"
lines (actually, they come from receive-pack on the remote end but still
end up on stderr).

So that raises a few interesting questions to me:

  1. Should receive-pack generate these hints? They get propagated by
     the client, but there's a reasonable chance that the user can't
     actually fix the situation.

  2. Should these hints be suppressed with --quiet? I can see an
     argument that "--quiet" only applies to non-errors. And while these
     are not fatal errors, they're outside the realm of the usual
     chattiness.

  3. Should our tests be more careful about not looking at the
     template hooks? I think test_create_repo already disables the hooks
     directory manually, but many repos will be created by "git clone"
     during the tests.

  4. Should our build system be more clever about dropping non-existent
     files from templates/blt?

I started down the road of saying "--quiet should disable all advice",
and that patch is below. But I'm having second thoughts on it. It fixes
the case in receive-pack, but what should "commit --quiet" do? It's
documented only to suppress the status output after commit. Should it
cover this case? For that matter, the "quiet" protocol extension which
is passed to receive-pack is generally used only for progress reporting,
and is sent automatically when stderr isn't a tty (which is why the
tests below must go through some contortions with test_terminal). I'm
not sure if it should actually apply to advice.

---
 advice.c                        |  8 ++++++++
 advice.h                        |  6 ++++++
 builtin/receive-pack.c          |  4 +++-
 t/t7520-ignored-hook-warning.sh | 15 +++++++++++++++
 4 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/advice.c b/advice.c
index 406efc183b..f754af8abe 100644
--- a/advice.c
+++ b/advice.c
@@ -137,3 +137,11 @@ void detach_advice(const char *new_name)
 
 	fprintf(stderr, fmt, new_name);
 }
+
+void disable_advice(void)
+{
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(advice_config); i++)
+		*advice_config[i].preference = 0;
+}
diff --git a/advice.h b/advice.h
index 70568fa792..4895554ef3 100644
--- a/advice.h
+++ b/advice.h
@@ -30,4 +30,10 @@ extern void NORETURN die_resolve_conflict(const char *me);
 void NORETURN die_conclude_merge(void);
 void detach_advice(const char *new_name);
 
+/*
+ * Turn off all advice flags; this can be used to centrally enforce a --quiet
+ * option.
+ */
+void disable_advice(void);
+
 #endif /* ADVICE_H */
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index b7ce7c7f52..f257c16776 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1601,8 +1601,10 @@ static struct command *read_head_info(struct oid_array *shallow)
 				report_status = 1;
 			if (parse_feature_request(feature_list, "side-band-64k"))
 				use_sideband = LARGE_PACKET_MAX;
-			if (parse_feature_request(feature_list, "quiet"))
+			if (parse_feature_request(feature_list, "quiet")) {
 				quiet = 1;
+				disable_advice();
+			}
 			if (advertise_atomic_push
 			    && parse_feature_request(feature_list, "atomic"))
 				use_atomic = 1;
diff --git a/t/t7520-ignored-hook-warning.sh b/t/t7520-ignored-hook-warning.sh
index 634fb7f23a..1d27d3e3f0 100755
--- a/t/t7520-ignored-hook-warning.sh
+++ b/t/t7520-ignored-hook-warning.sh
@@ -3,6 +3,7 @@
 test_description='ignored hook warning'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-terminal.sh
 
 test_expect_success setup '
 	hookdir="$(git rev-parse --git-dir)/hooks" &&
@@ -38,4 +39,18 @@ test_expect_success 'no warning if unset advice.ignoredHook and hook removed' '
 	test_i18ngrep ! -e "hook was ignored" message
 '
 
+test_expect_success TTY,POSIXPERM 'push --quiet silences remote hook warnings' '
+	git init --bare dst.git &&
+	echo "exit 0" >dst.git/hooks/update &&
+	chmod -x dst.git/hooks/update &&
+
+	git commit --allow-empty -m one &&
+	test_terminal git push dst.git HEAD 2>message &&
+	test_i18ngrep -e "hook was ignored" message &&
+
+	git commit --allow-empty -m two &&
+	test_terminal git push --quiet dst.git HEAD 2>message &&
+	test_i18ngrep ! -e "hook was ignored" message
+'
+
 test_done
-- 
2.16.0.rc0.384.gc477e89267

