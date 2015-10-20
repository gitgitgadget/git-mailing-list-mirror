From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/8] run-command: Call get_next_task with a clean child process.
Date: Tue, 20 Oct 2015 15:43:44 -0700
Message-ID: <1445381030-23912-3-git-send-email-sbeller@google.com>
References: <1445381030-23912-1-git-send-email-sbeller@google.com>
Cc: ramsay@ramsayjones.plus.com, jacob.keller@gmail.com, peff@peff.net,
	gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 21 00:44:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zofdd-0001oW-RN
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 00:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754502AbbJTWoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 18:44:05 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36073 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932094AbbJTWn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 18:43:59 -0400
Received: by pacfv9 with SMTP id fv9so35145488pac.3
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 15:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UJczN9z696AIuF0q/mHb2HsSFNxb9SUhZGAPTj5JhUs=;
        b=gFJu5ksv9pQed2Rb1r9/gTEwpQ6fr+uz/hRfrd2xm7QSFa41lZL1BYXac0ONG8KkbJ
         W0JGUolzU7zAbafa9YGC4FCFiK/J/5ZvZfxxJ6kUL0zB8tbnM3LuMWlk72PysD9lpkYa
         femdsIl1B0pDaX6RmLq3idmu3DaLP5mGktfYztmbWdQ3AT1IU3pIiemaVvjAgrgyVbmb
         PGGP8JGwCmMoNQ2QIBUferSM0XliIcFxmw1RqP78raI71fQVRK0tgtEciSG03Di3E01H
         0wlVu/vOJCgBZVB4MRfSgxzElnimNWaSuBJsPCxpT3DeuPlOHrOGcdCvC55/UTei7B9W
         oQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UJczN9z696AIuF0q/mHb2HsSFNxb9SUhZGAPTj5JhUs=;
        b=NGnwNk4bV1vxZVcoCuk7gHa9O/USeauX+fWDmGNzeD8OBTziClROcBH8gcqWAk5mQB
         ds/avOOyS0xo6xKt0QvpThsAPGCI6o/rcH33SId5N5uziGxcdNKyS8k85DVZ4yBTfI48
         N9VG9q1w1bEXSR8JWWjfv9qsvGXtv0E7wx2wcYgFXXE0Mnnw7BFYC45gUwIJTXmT3QPA
         r2+fUXziy9fed2TYUPXZOfMR/6sG+a3CTjeep91YvNtPYK/x5vlFyKMWRFck/V/WbCVG
         vDSk9W5dreAVPj8e1NXZiAuJ+0VkaHSGtIpnvPl39DGJB6FVjJ7SvsXUX2IWPf+WYVIB
         pksQ==
X-Gm-Message-State: ALoCoQkczV10ChkhXWsvlOYlo8N2/+p5pJAhT1Fazhf3fT+tTSIz6/kQQFWvH19GlD5rNK5Uzrlj
X-Received: by 10.66.155.231 with SMTP id vz7mr6512735pab.58.1445381039113;
        Tue, 20 Oct 2015 15:43:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:95b6:4bcd:ddcd:b6a3])
        by smtp.gmail.com with ESMTPSA id bn1sm5618768pad.17.2015.10.20.15.43.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 20 Oct 2015 15:43:58 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.275.gbfc1651.dirty
In-Reply-To: <1445381030-23912-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279947>

If the `get_next_task` did not explicitly called child_process_init
and only filled in some fields, there may have been some stale data
in the child process. This is hard to debug and also adds a review
burden for each new user of that API. To improve the situation, we
pass only cleanly initialized child structs to the get_next_task.

As an invariant you can now assume any child not in use is
cleaned up and ready for its next reuse.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 run-command.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index b9363da..a5ef874 100644
--- a/run-command.c
+++ b/run-command.c
@@ -13,6 +13,12 @@ void child_process_init(struct child_process *child)
 	argv_array_init(&child->env_array);
 }
 
+void child_process_deinit(struct child_process *child)
+{
+	argv_array_clear(&child->args);
+	argv_array_clear(&child->env_array);
+}
+
 struct child_to_clean {
 	pid_t pid;
 	struct child_to_clean *next;
@@ -962,6 +968,7 @@ static struct parallel_processes *pp_init(int n,
 
 	for (i = 0; i < n; i++) {
 		strbuf_init(&pp->children[i].err, 0);
+		child_process_init(&pp->children[i].process);
 		pp->pfd[i].events = POLLIN;
 		pp->pfd[i].fd = -1;
 	}
@@ -973,8 +980,10 @@ static void pp_cleanup(struct parallel_processes *pp)
 {
 	int i;
 
-	for (i = 0; i < pp->max_processes; i++)
+	for (i = 0; i < pp->max_processes; i++) {
 		strbuf_release(&pp->children[i].err);
+		child_process_deinit(&pp->children[i].process);
+	}
 
 	free(pp->children);
 	free(pp->pfd);
@@ -1134,6 +1143,8 @@ static int pp_collect_finished(struct parallel_processes *pp)
 		pp->nr_processes--;
 		pp->children[i].in_use = 0;
 		pp->pfd[i].fd = -1;
+		child_process_deinit(&pp->children[i].process);
+		child_process_init(&pp->children[i].process);
 
 		if (i != pp->output_owner) {
 			strbuf_addbuf(&pp->buffered_output, &pp->children[i].err);
-- 
2.5.0.275.gbfc1651.dirty
