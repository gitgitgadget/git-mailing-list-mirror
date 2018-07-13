Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA28E1F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 19:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731387AbeGMT4A (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 15:56:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:58846 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730149AbeGMT4A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 15:56:00 -0400
Received: (qmail 565 invoked by uid 109); 13 Jul 2018 19:40:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Jul 2018 19:40:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6620 invoked by uid 111); 13 Jul 2018 19:40:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 13 Jul 2018 15:40:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jul 2018 15:39:58 -0400
Date:   Fri, 13 Jul 2018 15:39:58 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jason@zx2c4.com,
        GIT Mailing-list <git@vger.kernel.org>
Subject: [PATCH 2/2] fsck: downgrade gitmodulesParse default to "info"
Message-ID: <20180713193958.GB12162@sigill.intra.peff.net>
References: <20180713193759.GB10354@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180713193759.GB10354@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We added an fsck check in ed8b10f631 (fsck: check
.gitmodules content, 2018-05-02) as a defense against the
vulnerability from 0383bbb901 (submodule-config: verify
submodule names as paths, 2018-04-30). With the idea that
up-to-date hosting sites could protect downstream unpatched
clients that fetch from them.

As part of that defense, we reject any ".gitmodules" entry
that is not syntactically valid. The theory is that if we
cannot even parse the file, we cannot accurately check it
for vulnerabilities. And anybody with a broken .gitmodules
file would eventually want to know anyway.

But there are a few reasons this is a bad tradeoff in
practice:

 - for this particular vulnerability, the client has to be
   able to parse the file. So you cannot sneak an attack
   through using a broken file, assuming the config parsers
   for the process running fsck and the eventual victim are
   functionally equivalent.

 - a broken .gitmodules file is not necessarily a problem.
   Our fsck check detects .gitmodules in _any_ tree, not
   just at the root. And the presence of a .gitmodules file
   does not necessarily mean it will be used; you'd have to
   also have gitlinks in the tree. The cgit repository, for
   example, has a file named .gitmodules from a
   pre-submodule attempt at sharing code, but does not
   actually have any gitlinks.

 - when the fsck check is used to reject a push, it's often
   hard to work around. The pusher may not have full control
   over the destination repository (e.g., if it's on a
   hosting server, they may need to contact the hosting
   site's support). And the broken .gitmodules may be too
   far back in history for rewriting to be feasible (again,
   this is an issue for cgit).

So we're being unnecessarily restrictive without actually
improving the security in a meaningful way. It would be more
convenient to downgrade this check to "info", which means
we'd still comment on it, but not reject a push. Site admins
can already do this via config, but we should ship sensible
defaults.

There are a few counterpoints to consider in favor of
keeping the check as an error:

 - the first point above assumes that the config parsers for
   the victim and the fsck process are equivalent. This is
   pretty true now, but as time goes on will become less so.
   Hosting sites are likely to upgrade their version of Git,
   whereas vulnerable clients will be stagnant (if they did
   upgrade, they'd cease to be vulnerable!). So in theory we
   may see drift over time between what two config parsers
   will accept.

   In practice, this is probably OK. The config format is
   pretty established at this point and shouldn't change a
   lot. And the farther we get from the announcement of the
   vulnerability, the less interesting this extra layer of
   protection becomes. I.e., it was _most_ valuable on day
   0, when everybody's client was still vulnerable and
   hosting sites could protect people. But as time goes on
   and people upgrade, the population of vulnerable clients
   becomes smaller and smaller.

 - In theory this could protect us from other
   vulnerabilities in the future. E.g., .gitmodules are the
   only way for a malicious repository to feed data to the
   config parser, so this check could similarly protect
   clients from a future (to-be-found) bug there.

   But that's trading a hypothetical case for real-world
   pain today. If we do find such a bug, the hosting site
   would need to be updated to fix it, too. At which point
   we could figure out whether it's possible to detect
   _just_ the malicious case without hurting existing
   broken-but-not-evil cases.

 - Until recently, we hadn't made any restrictions on
   .gitmodules content. So now in tightening that we're
   hitting cases where certain things used to work, but
   don't anymore. There's some moderate pain now. But as
   time goes on, we'll see more (and more varied) cases that
   will make tightening harder in the future. So there's
   some argument for putting rules in place _now_, before
   users grow more cases that violate them.

   Again, this is trading pain now for hypothetical benefit
   in the future. And if we try hard in the future to keep
   our tightening to a minimum (i.e., rejecting true
   maliciousness without hurting broken-but-not-evil repos),
   then that reduces even the hypothetical benefit.

Considering both sets of arguments, it makes sense to loosen
this check for now.

Note that we have to tweak the test in t7415 since fsck will
no longer consider this a fatal error. But we still check
that it reports the warning, and that we don't get the
spurious error from the config code.

Signed-off-by: Jeff King <peff@peff.net>
---
 fsck.c                     | 2 +-
 t/t7415-submodule-names.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fsck.c b/fsck.c
index 4129935d86..69ea8d5321 100644
--- a/fsck.c
+++ b/fsck.c
@@ -62,7 +62,6 @@ static struct oidset gitmodules_done = OIDSET_INIT;
 	FUNC(ZERO_PADDED_DATE, ERROR) \
 	FUNC(GITMODULES_MISSING, ERROR) \
 	FUNC(GITMODULES_BLOB, ERROR) \
-	FUNC(GITMODULES_PARSE, ERROR) \
 	FUNC(GITMODULES_LARGE, ERROR) \
 	FUNC(GITMODULES_NAME, ERROR) \
 	FUNC(GITMODULES_SYMLINK, ERROR) \
@@ -77,6 +76,7 @@ static struct oidset gitmodules_done = OIDSET_INIT;
 	FUNC(ZERO_PADDED_FILEMODE, WARN) \
 	FUNC(NUL_IN_COMMIT, WARN) \
 	/* infos (reported as warnings, but ignored by default) */ \
+	FUNC(GITMODULES_PARSE, INFO) \
 	FUNC(BAD_TAG_NAME, INFO) \
 	FUNC(MISSING_TAGGER_ENTRY, INFO)
 
diff --git a/t/t7415-submodule-names.sh b/t/t7415-submodule-names.sh
index ba8af785a5..293e2e1963 100755
--- a/t/t7415-submodule-names.sh
+++ b/t/t7415-submodule-names.sh
@@ -185,7 +185,7 @@ test_expect_success 'fsck detects corrupt .gitmodules' '
 		git add .gitmodules &&
 		git commit -m "broken gitmodules" &&
 
-		test_must_fail git fsck 2>output &&
+		git fsck 2>output &&
 		grep gitmodulesParse output &&
 		test_i18ngrep ! "bad config" output
 	)
-- 
2.18.0.433.gb9621797ee
