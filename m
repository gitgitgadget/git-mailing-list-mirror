Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D1CD20286
	for <e@80x24.org>; Fri, 15 Sep 2017 11:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751433AbdIOLaO (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 07:30:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:39948 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751198AbdIOLaN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 07:30:13 -0400
Received: (qmail 12472 invoked by uid 109); 15 Sep 2017 11:30:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Sep 2017 11:30:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6679 invoked by uid 111); 15 Sep 2017 11:30:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Sep 2017 07:30:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Sep 2017 07:30:11 -0400
Date:   Fri, 15 Sep 2017 07:30:11 -0400
From:   Jeff King <peff@peff.net>
To:     Kevin Daudt <me@ikke.info>
Cc:     "A. Wilcox" <awilfox@adelielinux.org>, git@vger.kernel.org
Subject: Re: Git 2.14.1: t6500: error during test on musl libc
Message-ID: <20170915113011.emko6q5utb7x4bvu@sigill.intra.peff.net>
References: <59BB3E40.7020804@adelielinux.org>
 <20170915063740.GB21499@alpha.vpn.ikke.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170915063740.GB21499@alpha.vpn.ikke.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 15, 2017 at 08:37:40AM +0200, Kevin Daudt wrote:

> On Thu, Sep 14, 2017 at 09:43:12PM -0500, A. Wilcox wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA256
> > 
> > Hi there,
> > 
> > While bumping Git's version for our Linux distribution to 2.14.1, I've
> > run in to a new test failure in t6500-gc.sh.  This is the output of
> > the failing test with debug=t verbose=t:
> 
> This is a new test introduced by c45af94db 
> (gc: run pre-detach operations under lock, 2017-07-11) which was
> included in v2.14.0.
> 
> So it might be that this was already a problem for a longer time, only
> just recently uncovered.

The code change there is not all that big. Mostly we're just checking
that the lock is actually respected. The lock code doesn't exercise libc
all that much. It does use fscanf, which I guess is a little exotic for
us. It's also possible that hostname() doesn't behave quite as we
expect.

If you instrument gc like the patch below, what does it report when you
run:

  GIT_TRACE=1 ./t6500-gc.sh --verbose-only=8

I get:

  [...]
  trace: built-in: git 'gc' '--auto'
  Auto packing the repository in background for optimum performance.
  See "git help gc" for manual housekeeping.
  debug: gc lock already held by $my_hostname
  [...]

If you get "acquired gc lock", then the problem is in
lock_repo_for_gc(), and I'd suspect some problem with fscanf or
hostname.

-Peff

---
diff --git a/builtin/gc.c b/builtin/gc.c
index c22787ac72..a7450a0058 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -242,9 +242,11 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 	int fd;
 	char *pidfile_path;
 
-	if (is_tempfile_active(pidfile))
+	if (is_tempfile_active(pidfile)) {
 		/* already locked */
+		trace_printf("debug: we already hold the gc lock");
 		return NULL;
+	}
 
 	if (xgethostname(my_host, sizeof(my_host)))
 		xsnprintf(my_host, sizeof(my_host), "unknown");
@@ -284,6 +286,7 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 				rollback_lock_file(&lock);
 			*ret_pid = pid;
 			free(pidfile_path);
+			trace_printf("debug: gc lock already held by %s", locking_host);
 			return locking_host;
 		}
 	}
@@ -295,6 +298,7 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 	commit_lock_file(&lock);
 	pidfile = register_tempfile(pidfile_path);
 	free(pidfile_path);
+	trace_printf("debug: we have acquired the gc lock");
 	return NULL;
 }
 
