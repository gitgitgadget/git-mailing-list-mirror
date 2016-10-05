Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FFA21F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 20:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754590AbcJEUTp (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 16:19:45 -0400
Received: from avasout02.plus.net ([212.159.14.17]:33433 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754214AbcJEUTo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 16:19:44 -0400
Received: from [10.0.2.15] ([194.75.29.46])
        by avasout02 with smtp
        id rwKd1t0050zhorE01wKec8; Wed, 05 Oct 2016 21:19:41 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=G/5eKJs5 c=1 sm=1 tr=0
 a=g54qAj+LxVGqXy9pVcJ+0w==:117 a=g54qAj+LxVGqXy9pVcJ+0w==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=MexTJ5CZRX1aDdCAtFMA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] run-command: fix build on cygwin (stdin is a macro)
Message-ID: <f9b6abf6-8305-4a32-29af-765f08fee94b@ramsayjones.plus.com>
Date:   Wed, 5 Oct 2016 21:19:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Lars,

Commit 6007c69e ("run-command: add wait_on_exit", 04-10-2016), which
is part of your 'ls/filter-process' branch, causes the build to fail
on cygwin, since 'stdin' is defined as a macro thus:

    #define stdin   (_REENT->_stdin)

(you can probably guess what stdout and stderr look like!) where _REENT
in turn expands to a function call (__getreent()) which returns a pointer
to a 'struct _reent', etc., ...

I am not suggesting that you apply this exact patch (stdin_ is not a good
choice), but I wanted to show the exact patch I used to get the build to
complete on cygwin.

ATB,
Ramsay Jones

 run-command.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/run-command.c b/run-command.c
index 96c54fe..a9dd91a 100644
--- a/run-command.c
+++ b/run-command.c
@@ -22,7 +22,7 @@ void child_process_clear(struct child_process *child)
 struct child_to_clean {
 	pid_t pid;
 	char *name;
-	int stdin;
+	int stdin_;
 	int wait;
 	struct child_to_clean *next;
 };
@@ -37,8 +37,8 @@ static void cleanup_children(int sig, int in_signal)
 	/* Close the the child's stdin as indicator that Git will exit soon */
 	while (p) {
 		if (p->wait)
-			if (p->stdin > 0)
-				close(p->stdin);
+			if (p->stdin_ > 0)
+				close(p->stdin_);
 		p = p->next;
 	}
 
@@ -73,12 +73,12 @@ static void cleanup_children_on_exit(void)
 	cleanup_children(SIGTERM, 0);
 }
 
-static void mark_child_for_cleanup(pid_t pid, const char *name, int stdin, int wait)
+static void mark_child_for_cleanup(pid_t pid, const char *name, int stdin_, int wait)
 {
 	struct child_to_clean *p = xmalloc(sizeof(*p));
 	p->pid = pid;
 	p->wait = wait;
-	p->stdin = stdin;
+	p->stdin_ = stdin_;
 	if (name)
 		p->name = xstrdup(name);
 	else
@@ -94,7 +94,7 @@ static void mark_child_for_cleanup(pid_t pid, const char *name, int stdin, int w
 }
 
 #ifdef NO_PTHREADS
-static void mark_child_for_cleanup_no_wait(pid_t pid, const char *name, int timeout, int stdin)
+static void mark_child_for_cleanup_no_wait(pid_t pid, const char *name, int timeout, int stdin_)
 {
 	mark_child_for_cleanup(pid, NULL, 0, 0);
 }
-- 
2.10.0
