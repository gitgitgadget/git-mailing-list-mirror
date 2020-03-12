Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2EFC10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 21:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B4C206BE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 21:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgCLVQj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 17:16:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:38360 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726442AbgCLVQj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 17:16:39 -0400
Received: (qmail 14579 invoked by uid 109); 12 Mar 2020 21:16:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Mar 2020 21:16:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2279 invoked by uid 111); 12 Mar 2020 21:26:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Mar 2020 17:26:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 12 Mar 2020 17:16:38 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jonathantanmy@google.com, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] connected.c: reprepare packs for corner cases
Message-ID: <20200312211638.GA872402@coredump.intra.peff.net>
References: <pull.579.git.1584027403779.gitgitgadget@gmail.com>
 <xmqqzhcle23x.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzhcle23x.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 12, 2020 at 01:42:58PM -0700, Junio C Hamano wrote:

> > Placing a reprepare_packed_git() call inside chck_connected() before
> > looping through the packed_git list seems like the safest way to
> > avoid this issue in the future.
> 
> Hmmm.  I am not sure if I am convinced that check_connected() is the
> best place to do this.  Do we know the place that adds a new pack to
> the repository, yet forgets to add it to the packed-git list, that
> caused the failure you were observing?  Doing this change, without
> describing the answer to the question in the log message, makes it
> smell rather like a random hack than a designed solution to me.

Thanks, I was just writing a very similar message. :)

> If lazy fetching of objects happen in multiple fetches before a
> single check_connected() sweeps them to check for connectivity, then
> perhaps the lazy fetching codepath needs to remember the fact that
> it added a new pack that is still not known to the packed-git list
> (or just add it immediately, without having to scan at all), and
> check_connected() would need to rescan only when there is at least
> one such new pack?  That way, you do not have to penalize normal
> callers of check_connected() that do not use lazy fetches at all,
> right?

I share your concern that it's not the best place for this. In practice,
I do doubt that callers of check_connected() would notice, as it's a
pretty heavy-weight operation by itself. But I'd be concerned about
going the other way: we know that calling it in check_connected() fixes
_this_ problem, but we don't know if there's other code that would need
a similar fix.

I was able to reproduce easily from Stolee's instructions, but I did
notice one interesting thing: the problem occurs only with the http
protocol, not with git:// or ssh. The obvious difference between them is
that http code is mostly running in the remote-helper program and in a
spawned git-fetch-pack. But the check_connected() we hit is in the
parent git-fetch process. So I _suspect_ that there's some low-level
code which calls reprepare() that happens in-process in most cases, but
not for the http case.

If I instrument Git like this:

diff --git a/common-main.c b/common-main.c
index 71e21dd20a..bf6ffe42b7 100644
--- a/common-main.c
+++ b/common-main.c
@@ -49,6 +49,11 @@ int main(int argc, const char **argv)
 	trace2_cmd_start(argv);
 	trace2_collect_process_info(TRACE2_PROCESS_INFO_STARTUP);
 
+	trace_printf("pid=%d, cmd=%s",
+		     (int)getpid(),
+		     !ends_with(argv[0], "git") ? argv[0] :
+		     argv[1] ? argv[1] : argv[0]);
+
 	result = cmd_main(argc, argv);
 
 	trace2_cmd_exit(result);
diff --git a/packfile.c b/packfile.c
index f4e752996d..832d020e6e 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1004,6 +1004,8 @@ void reprepare_packed_git(struct repository *r)
 {
 	struct object_directory *odb;
 
+	trace_printf("repreparing in pid %d", (int)getpid());
+
 	obj_read_lock();
 	for (odb = r->objects->odb; odb; odb = odb->next)
 		odb_clear_loose_cache(odb);

then running over the git protocol gives me:

  17:13:52.642337 common-main.c:52        pid=882782, cmd=fetch
  17:13:52.642871 git.c:439               trace: built-in: git fetch origin
  17:13:52.725971 packfile.c:1007         repreparing in pid 882782
  remote: Enumerating objects: 49, done.
  17:13:52.793355 run-command.c:663       trace: run_command: git index-pack --stdin -v --fix-thin --promisor --pack_header=2,49
  remote: Total 49 (delta 0), reused 0 (delta 0), pack-reused 49
  17:13:52.796106 common-main.c:52        pid=882784, cmd=index-pack
  17:13:52.796655 git.c:439               trace: built-in: git index-pack --stdin -v --fix-thin --promisor --pack_header=2,49
  Receiving objects: 100% (49/49), 6.87 KiB | 6.87 MiB/s, done.
  Resolving deltas: 100% (17/17), done.
  17:13:52.811302 packfile.c:1007         repreparing in pid 882782
  From git://github.com/derrickstolee/TreeSearch
   * [new branch]      master     -> origin/master
  17:13:52.812955 run-command.c:1616      run_processes_parallel: preparing to run up to 1 tasks
  17:13:52.812986 run-command.c:1648      run_processes_parallel: done
  17:13:52.813034 run-command.c:663       trace: run_command: git gc --auto
  17:13:52.815435 common-main.c:52        pid=882788, cmd=gc
  17:13:52.815941 git.c:439               trace: built-in: git gc --auto

There's an early reprepare, but the one after index-pack finishes
resolving deltas is probably the interesting one. And it happens inside
the fetch process. But if we go back to http, I get:

  17:15:28.234866 common-main.c:52        pid=882836, cmd=fetch
  17:15:28.235403 git.c:439               trace: built-in: git fetch origin
  17:15:28.236329 run-command.c:663       trace: run_command: GIT_DIR=.git git-remote-https origin https://github.com/derrickstolee/TreeSearch
  17:15:28.244049 common-main.c:52        pid=882837, cmd=/home/peff/compile/git/git-remote-https
  17:15:28.382586 packfile.c:1007         repreparing in pid 882836
  17:15:28.382996 run-command.c:663       trace: run_command: git fetch-pack --stateless-rpc --stdin --lock-pack --include-tag --thin --from-promisor --filter=blob:none https://github.com/derrickstolee/TreeSearch/
  17:15:28.386284 common-main.c:52        pid=882839, cmd=fetch-pack
  17:15:28.386807 git.c:439               trace: built-in: git fetch-pack --stateless-rpc --stdin --lock-pack --include-tag --thin --from-promisor --filter=blob:none https://github.com/derrickstolee/TreeSearch/
  remote: Enumerating objects: 49, done.
  remote: Total 49 (delta 0), reused 0 (delta 0), pack-reused 49
  17:15:28.444799 run-command.c:663       trace: run_command: git index-pack --stdin -v --fix-thin --promisor --pack_header=2,49
  17:15:28.447441 common-main.c:52        pid=882841, cmd=index-pack
  17:15:28.447944 git.c:439               trace: built-in: git index-pack --stdin -v --fix-thin --promisor --pack_header=2,49
  Receiving objects: 100% (49/49), 6.87 KiB | 3.44 MiB/s, done.
  Resolving deltas: 100% (17/17), done.
  17:15:28.461871 packfile.c:1007         repreparing in pid 882839
  error: https://github.com/derrickstolee/TreeSearch did not send all necessary objects
  
  17:15:28.463446 run-command.c:663       trace: run_command: git gc --auto
  17:15:28.463949 common-main.c:52        pid=882845, cmd=gc
  17:15:28.464056 git.c:439               trace: built-in: git gc --auto

There we see that same reprepare happen in 882839, which is the child
fetch-pack. The parent fetch probably needs to reprepare itself after
fetch-pack completes.

-Peff
