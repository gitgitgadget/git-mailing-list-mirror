Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 573DE2035A
	for <e@80x24.org>; Tue, 11 Jul 2017 09:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755377AbdGKJGj (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 05:06:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:36724 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755242AbdGKJGh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 05:06:37 -0400
Received: (qmail 31857 invoked by uid 109); 11 Jul 2017 09:06:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 09:06:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14264 invoked by uid 111); 11 Jul 2017 09:06:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 05:06:49 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Jul 2017 05:06:35 -0400
Date:   Tue, 11 Jul 2017 05:06:35 -0400
From:   Jeff King <peff@peff.net>
To:     Andreas Krey <a.krey@gmx.de>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: [PATCH] gc: run pre-detach operations under lock
Message-ID: <20170711090635.swowex7yry7kqb7v@sigill.intra.peff.net>
References: <20170704075758.GA22249@inner.h.apk.li>
 <20170705082027.ujddejajjlvto7bp@sigill.intra.peff.net>
 <20170706133124.GB1216@inner.h.apk.li>
 <CAGyf7-FnaWM=XNb_Skb1qR4vu_jAw-5swkgWpEDQqwM0NNq3YQ@mail.gmail.com>
 <20170711044553.GG3786@inner.h.apk.li>
 <20170711072536.ijpldg4uxb5pbtdw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170711072536.ijpldg4uxb5pbtdw@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 11, 2017 at 03:25:36AM -0400, Jeff King wrote:

> Annoyingly, the lock code interacts badly with daemonizing because that
> latter will fork to a new process. So the simple solution like:
> 
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 2ba50a287..79480124a 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -414,6 +414,9 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>  			if (report_last_gc_error())
>  				return -1;
>  
> +			if (lock_repo_for_gc(force, &pid))
> +				return 0;
> +
>  			if (gc_before_repack())
>  				return -1;
>  			/*
> 
> means that anybody looking at the lockfile will report the wrong pid
> (and thus think the lock is invalid). I guess we'd need to update it in
> place after daemonizing.

Updating it in place is a bit tricky. I came up with this hack that
makes it work, but I'm not sure if the reasoning is too gross.

-- >8 --
Subject: [PATCH] gc: run pre-detach operations under lock

We normally try to avoid having two auto-gc operations run
at the same time, because it wastes resources. This was done
long ago in 64a99eb47 (gc: reject if another gc is running,
unless --force is given, 2013-08-08).

When we do a detached auto-gc, we run the ref-related
commands _before_ detaching, to avoid confusing lock
contention. This was done by 62aad1849 (gc --auto: do not
lock refs in the background, 2014-05-25).

These two features do not interact well. The pre-detach
operations are run before we check the gc.pid lock, meaning
that on a busy repository we may run many of them
concurrently. Ideally we'd take the lock before spawning any
operations, and hold it for the duration of the program.

This is tricky, though, with the way the pid-file interacts
with the daemonize() process.  Other processes will check
that the pid recorded in the pid-file still exists. But
detaching causes us to fork and continue running under a
new pid. So if we take the lock before detaching, the
pid-file will have a bogus pid in it. We'd have to go back
and update it with the new pid after detaching. We'd also
have to play some tricks with the tempfile subsystem to
tweak the "owner" field, so that the parent process does not
clean it up on exit, but the child process does.

Instead, we can do something a bit simpler: take the lock
only for the duration of the pre-detach work, then detach,
then take it again for the post-detach work. Technically,
this means that the post-detach lock could lose to another
process doing pre-detach work. But in the long run this
works out.

That second process would then follow-up by doing
post-detach work. Unless it was in turn blocked by a third
process doing pre-detach work, and so on. This could in
theory go on indefinitely, as the pre-detach work does not
repack, and so need_to_gc() will continue to trigger.  But
in each round we are racing between the pre- and post-detach
locks. Eventually, one of the post-detach locks will win the
race and complete the full gc. So in the worst case, we may
racily repeat the pre-detach work, but we would never do so
simultaneously (it would happen via a sequence of serialized
race-wins).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/gc.c  |  4 ++++
 t/t6500-gc.sh | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/builtin/gc.c b/builtin/gc.c
index bd91f136f..5a535040f 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -414,8 +414,12 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			if (report_last_gc_error())
 				return -1;
 
+			if (lock_repo_for_gc(force, &pid))
+				return 0;
 			if (gc_before_repack())
 				return -1;
+			delete_tempfile(&pidfile);
+
 			/*
 			 * failure to daemonize is ok, we'll continue
 			 * in foreground
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index cc7acd101..41b0be575 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -95,6 +95,27 @@ test_expect_success 'background auto gc does not run if gc.log is present and re
 	test_line_count = 1 packs
 '
 
+test_expect_success 'background auto gc respects lock for all operations' '
+	# make sure we run a background auto-gc
+	test_commit make-pack &&
+	git repack &&
+	test_config gc.autopacklimit 1 &&
+	test_config gc.autodetach true &&
+
+	# create a ref whose loose presence we can use to detect a pack-refs run
+	git update-ref refs/heads/should-be-loose HEAD &&
+	test_path_is_file .git/refs/heads/should-be-loose &&
+
+	# now fake a concurrent gc that holds the lock; we can use our
+	# shell pid so that it looks valid.
+	hostname=$(hostname || echo unknown) &&
+	printf "$$ %s" "$hostname" >.git/gc.pid &&
+
+	# our gc should exit zero without doing anything
+	run_and_wait_for_auto_gc &&
+	test_path_is_file .git/refs/heads/should-be-loose
+'
+
 # DO NOT leave a detached auto gc process running near the end of the
 # test script: it can run long enough in the background to racily
 # interfere with the cleanup in 'test_done'.
-- 
2.13.2.1149.g835628f6b

