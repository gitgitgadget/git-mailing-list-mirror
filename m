From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 06/14] run-command: add an asynchronous parallel child processor
Date: Wed, 23 Sep 2015 10:54:48 -0700
Message-ID: <xmqqpp19xbpz.fsf@gitster.mtv.corp.google.com>
References: <1442972732-12118-1-git-send-email-sbeller@google.com>
	<1442972732-12118-7-git-send-email-sbeller@google.com>
	<xmqqa8sdzl6a.fsf@gitster.mtv.corp.google.com>
	<xmqq6131yyef.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, ramsay@ramsayjones.plus.com,
	jacob.keller@gmail.com, peff@peff.net, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	vlovich@gmail.com, sunshine@sunshineco.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Sep 23 19:55:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeoFs-0000BL-79
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 19:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753085AbbIWRyw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2015 13:54:52 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35434 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710AbbIWRyv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2015 13:54:51 -0400
Received: by pacfv12 with SMTP id fv12so47335984pac.2
        for <git@vger.kernel.org>; Wed, 23 Sep 2015 10:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=1XxacHM8f39rOmei4UXxDkasRm8YSgBNuT5L2QgZavI=;
        b=A0upoQ0HlGKYTB6Vj0P10Ivpn9MUypdXq+8UpjMYCD1H4YmqrfOZWPUuhGYLx8C3A3
         VJFIaQX5/HXVqiBLrtP+mLcMoa0U0O60rZoVdxZuaTLSGQIsOYF/zSl4HUMz2Ytzioc2
         hop0V77V1bglQlgIhPBxf4DCki5VVjjOtydeaENJ8VuTLATa6OW5aZqyyNljnf2uwquj
         euy35UAWntzl3EVzTRQUseV37k16H7//cZguJU2zaZY4lck0IiJ2cwAt6wTUXu3PctZ3
         wpm8lR0scojhwGXWet+iIbCaSEcEoJpZm3+4e1P1j4smF1StuzK1G+R0zJu3AjrtBXol
         4XvQ==
X-Received: by 10.68.231.5 with SMTP id tc5mr38785448pbc.54.1443030890570;
        Wed, 23 Sep 2015 10:54:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:a07c:76d3:22e9:4d3d])
        by smtp.gmail.com with ESMTPSA id iy1sm9071260pbb.85.2015.09.23.10.54.49
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Wed, 23 Sep 2015 10:54:49 -0700 (PDT)
In-Reply-To: <xmqq6131yyef.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 23 Sep 2015 07:59:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278491>

Junio C Hamano <gitster@pobox.com> writes:

> Just to make sure there is no misunderstanding, just like I prefer
> "start one" over "start as many as possible" in order to give
> scheduling decision to the calling loop, I would expect that...

To sum up, what I anticipate would happen over time on top of 06/14
is something like this:

 * pp_start_one() stuffed unborn child to the list of children when
   start_command() failed and start_failure() did not die(); return
   to the caller without corrupting children[] list in this case.

 * update the semantics of the value returned from pp_start_one()
   and adjust the scheduling loop for it.

 * allow slow-start of the whole process, so that we do not spawn
   tons of processes before starting to read from any of them, to
   give a better first-byte latency.  This is parameterized and
   in this squash, it is set not to do a slow-start.
    
 * make poll(2) timeout used in pp_buffer_stderr() configurable by
   the scheduing loop.  Raise the timeout when we are already running
   as many children as we would at the same time, and lower it when
   we are still ramping up.

This squash itself is a mixed bag of things.  The first point is to
fix a real issue, while the rest are merely envisioning possible
future.  The "envisioning possible future" parts may be illustrative
when deciding what design we want in the basic structure.

An imaginary alternative version would have the top-level loop that
is a mere "these are the things we do" bullet-list that runs "spawn
processes", "slurp in their output with some timeout", "output if
foreground process is ready", and "cull finished children" in order,
which was your original.  I would imagine that we would teach "spawn
processes" part to slow-start, "slurp" part to adjust timeout
depending on the fullness of children[] and if the slow-start logic
is still ramping up, etc., in such a code structure by keeping
fields in *pp that corresponds to 'cnt' and 'no_more_task' variables
and have these four steps in the bullet-list communiate and
coordinate among themselves using those fields.

Compared to code that is structured that way, I think the top-level
loop that owns 'cnt' and 'child_timeout' variables to make the
scheduling decisions on its own, and drives "dumb" helper functions
to drive the whole system, which is what this squash attempts to
create, makes the overall logic and structure much clearer to see.

Thanks.

diff --git a/run-command.c b/run-command.c
index 494e1f8..b6d8b39 100644
--- a/run-command.c
+++ b/run-command.c
@@ -977,7 +977,7 @@ static void set_nonblocking(int fd)
 			"output will be degraded");
 }
 
-/* returns 1 if a process was started, 0 otherwise */
+/* return 0 if get_next_task() ran out of things to do, non-zero otherwise */
 static int pp_start_one(struct parallel_processes *pp)
 {
 	int i;
@@ -991,26 +991,28 @@ static int pp_start_one(struct parallel_processes *pp)
 	if (!pp->get_next_task(pp->data,
 			       &pp->children[i].process,
 			       &pp->children[i].err))
-		return 1;
+		return 0;
 
-	if (start_command(&pp->children[i].process))
+	if (start_command(&pp->children[i].process)) {
 		pp->start_failure(pp->data,
 				  &pp->children[i].process,
 				  &pp->children[i].err);
+		return -1;
+	}
 
 	set_nonblocking(pp->children[i].process.err);
 
 	pp->nr_processes++;
 	pp->children[i].in_use = 1;
 	pp->pfd[i].fd = pp->children[i].process.err;
-	return 0;
+	return 1;
 }
 
-static void pp_buffer_stderr(struct parallel_processes *pp)
+static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
 {
 	int i;
 
-	while ((i = poll(pp->pfd, pp->max_processes, 100)) < 0) {
+	while ((i = poll(pp->pfd, pp->max_processes, output_timeout)) < 0) {
 		if (errno == EINTR)
 			continue;
 		pp_cleanup(pp);
@@ -1105,6 +1107,9 @@ static void pp_collect_finished(struct parallel_processes *pp)
 	}
 }
 
+
+#define SPAWN_CAP (pp.max_processes + 1) /* spawn as many as possible */
+
 int run_processes_parallel(int n, void *data,
 			   get_next_task_fn get_next_task,
 			   start_failure_fn start_failure,
@@ -1114,12 +1119,27 @@ int run_processes_parallel(int n, void *data,
 	pp_init(&pp, n, data, get_next_task, start_failure, return_value);
 
 	while (1) {
-		while (pp.nr_processes < pp.max_processes &&
-		       !pp_start_one(&pp))
-			; /* nothing */
-		if (!pp.nr_processes)
+		int no_more_task, cnt, output_timeout;
+
+		for (cnt = SPAWN_CAP, no_more_task = 0;
+		     cnt && pp.nr_processes < pp.max_processes;
+		     cnt--) {
+			if (!pp_start_one(&pp)) {
+				no_more_task = 1;
+				break;
+			}
+		}
+
+		if (no_more_task && !pp.nr_processes)
 			break;
-		pp_buffer_stderr(&pp);
+		if (!cnt)
+			output_timeout = 50;
+		else if (pp.nr_processes < pp.max_processes)
+			output_timeout = 100;
+		else
+			output_timeout = 1000;
+		pp_buffer_stderr(&pp, output_timeout);
+
 		pp_output(&pp);
 		pp_collect_finished(&pp);
 	}
