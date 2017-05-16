Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B744201A4
	for <e@80x24.org>; Tue, 16 May 2017 19:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751017AbdEPTf7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 15:35:59 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:57232 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750785AbdEPTf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 15:35:58 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id CED6B1FAA8;
        Tue, 16 May 2017 19:35:57 +0000 (UTC)
Date:   Tue, 16 May 2017 19:35:57 +0000
From:   Eric Wong <e@80x24.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jeff King <peff@peff.net>, Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Rannaud <eric.rannaud@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeremy Serror <jeremy.serror@gmail.com>
Subject: [TANGENT] run-command: use vfork instead of fork
Message-ID: <20170516193557.GA14257@dcvr>
References: <CA+zRj8X3OoejQVhUHD9wvv60jpTEZy06qa0y7TtodfBa1q5bnA@mail.gmail.com>
 <20170516032503.bzkxmtqpmppxgi75@sigill.intra.peff.net>
 <20170516033736.23cfkouus3p67vhc@sigill.intra.peff.net>
 <20170516164124.GO27400@aiede.svl.corp.google.com>
 <20170516164750.3tw6xlbcbyuu5t72@sigill.intra.peff.net>
 <20170516171540.GG79147@google.com>
 <20170516172307.36hyshwypomlsubx@sigill.intra.peff.net>
 <CA+55aFwB-MWASj7dZWkXWhgd4gvEfoOhL6Fo7kXeJSm9dht4Jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwB-MWASj7dZWkXWhgd4gvEfoOhL6Fo7kXeJSm9dht4Jg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> Also, if people really want to optimize the code that executes an
> external program (whether in shell or directly), I think it might be
> worth it to look at replacing the "fork()" with a "vfork()".
> 
> Something like this
> 
> -       cmd->pid = fork();
> +       cmd->pid = (cmd->git_cmd || cmd->env) ? fork() : vfork();
> 
> might work (the native git_cmd case needs a real fork, and if we
> change the environment variables we need it too, but the other cases
> look like they might work with vfork()).
> 
> Using vfork() can be hugely more efficient, because you don't have the
> extra page table copies and teardown, but also avoid a lot of possible
> copy-on-write faults.

Fwiw, most of the vfork preparation was already done by Brandon
and myself a few weeks ago, and cooking in pu.

I think only the patch below would be needed to enable vfork
(along with any build-time detection)

However, I haven't noticed enough forking in git to make a
difference (but maybe others do).  I think it would make a
bigger difference if such changes were made to bash, dash,
make, and perl5.

--------8<------------
Subject: [PATCH] run-command: use vfork instead of fork

To enable vfork, we merely have to avoid modifying memory we
share with the parent, so the guard functions
`child_(error|warn|die)_fn` can now be disabled.

FIXME: still missing autoconf + Makefile portability tweaks.

Signed-off-by: Eric Wong <e@80x24.org>
---
 run-command.c | 28 +---------------------------
 1 file changed, 1 insertion(+), 27 deletions(-)

diff --git a/run-command.c b/run-command.c
index 9e36151bf9..0292dd94b6 100644
--- a/run-command.c
+++ b/run-command.c
@@ -324,25 +324,6 @@ static void fake_fatal(const char *err, va_list params)
 	vreportf("fatal: ", err, params);
 }
 
-static void child_error_fn(const char *err, va_list params)
-{
-	const char msg[] = "error() should not be called in child\n";
-	xwrite(2, msg, sizeof(msg) - 1);
-}
-
-static void child_warn_fn(const char *err, va_list params)
-{
-	const char msg[] = "warn() should not be called in child\n";
-	xwrite(2, msg, sizeof(msg) - 1);
-}
-
-static void NORETURN child_die_fn(const char *err, va_list params)
-{
-	const char msg[] = "die() should not be called in child\n";
-	xwrite(2, msg, sizeof(msg) - 1);
-	_exit(2);
-}
-
 /* this runs in the parent process */
 static void child_err_spew(struct child_process *cmd, struct child_err *cerr)
 {
@@ -658,17 +639,10 @@ int start_command(struct child_process *cmd)
 	 * never be released in the child process.  This means only
 	 * Async-Signal-Safe functions are permitted in the child.
 	 */
-	cmd->pid = fork();
+	cmd->pid = vfork();
 	failed_errno = errno;
 	if (!cmd->pid) {
 		int sig;
-		/*
-		 * Ensure the default die/error/warn routines do not get
-		 * called, they can take stdio locks and malloc.
-		 */
-		set_die_routine(child_die_fn);
-		set_error_routine(child_error_fn);
-		set_warn_routine(child_warn_fn);
 
 		close(notify_pipe[0]);
 		set_cloexec(notify_pipe[1]);
-- 
Also fetchable:  git://bogomips.org/git-svn vfork-test
commit 5f88d79182aaabc5ea467d1d29e13e45bd2b99bf
