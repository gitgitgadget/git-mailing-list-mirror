From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 1/9] run_processes_parallel: delimit intermixed task output
Date: Fri, 13 Nov 2015 17:06:54 -0800
Message-ID: <1447463222-12589-2-git-send-email-sbeller@google.com>
References: <1447463222-12589-1-git-send-email-sbeller@google.com>
Cc: ramsay@ramsayjones.plus.com, jacob.keller@gmail.com, peff@peff.net,
	gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com, j6t@kdbg.org,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 14 02:07:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxPJM-0003Hl-Ej
	for gcvg-git-2@plane.gmane.org; Sat, 14 Nov 2015 02:07:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752790AbbKNBHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 20:07:17 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36491 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752721AbbKNBHP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 20:07:15 -0500
Received: by pacdm15 with SMTP id dm15so115486134pac.3
        for <git@vger.kernel.org>; Fri, 13 Nov 2015 17:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oJD3IIqUB4qsJasFuAuptTPMk6NmckAIKxj2vz60vq0=;
        b=drGeXDq4PD5SZFSGcmk5U0FL/+YfPb2JusI6S/ppik48VxyVPW5EEP5mEaTftauozH
         tGjX+fcr8PE2Fkd7BLrDZKa9f/2VrXXbgBm4kRka2jcw7yHtk48g3aUrTfMGdi6XEmvW
         5i0wZEffiOGfnfUJdgXtS2rSLEAyf278moShFFiHPkYfa5RSAMqkiOtw3yqdvlJQsItq
         O5zvLEL0zKRnCZjtRiDypujYvjF9ZnsMH/HSwl1lVhvAJjRCA20UmHKAcftQsXDrdnJS
         qWgw2wgWfy+u03eDwyj81DW5W9snORLS2vtmc8AAFJjhVcRYohhS5l/3rPoYVidM6o+U
         /ukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oJD3IIqUB4qsJasFuAuptTPMk6NmckAIKxj2vz60vq0=;
        b=RTY/WNaks4OCPDlQ3oiwQgBhsVqzN/ZRFpROmRGx90yokSfkZrOsU8H1uFAp+luaZ4
         WTc525ZmlvrUN2XVV4UMcucgvfxAxOUfSmGfO78WlMy9hEuNifXDacVdER+5YDOxfC44
         g5MLEgcEH786TvqpWE08XeyLNVlEa+Z4d0kWjp3efDO1sNdCjlR2SOwnrjWB11sPVkMR
         N6HyugSxuIzTgNKQgBweU+1gMkfZ8PGuehzUrrgOftyYp6bmcbjkjk5IKQ9RKOyMQ1+L
         qVjPun+Q7obcal0VHWwK+p+BNQGthKpoG5ZTOpVHFb0mYjqvfZklA78hKNprxpVIq28S
         wLdg==
X-Gm-Message-State: ALoCoQm5CFMTwgXPdBnvj12rC4NjHFBWayzUqS2elfzanyoCpmmNEXg9rAMPLdh4AA0OrlU1zhJt
X-Received: by 10.68.242.4 with SMTP id wm4mr36204261pbc.25.1447463234822;
        Fri, 13 Nov 2015 17:07:14 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:f5eb:b7b9:3afa:a95c])
        by smtp.gmail.com with ESMTPSA id cs5sm22657702pbc.15.2015.11.13.17.07.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 13 Nov 2015 17:07:14 -0800 (PST)
X-Mailer: git-send-email 2.6.3.369.gea52ac0
In-Reply-To: <1447463222-12589-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281290>

This commit serves 2 purposes. First this may help the user who
tries to diagnose intermixed process calls. Second this may be used
in a later patch for testing. As the output of a command should not
change visibly except for going faster, grepping for the trace output
seems like a viable testing strategy.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 run-command.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/run-command.c b/run-command.c
index 358429f..b246118 100644
--- a/run-command.c
+++ b/run-command.c
@@ -965,6 +965,9 @@ static struct parallel_processes *pp_init(int n,
 		n = online_cpus();
 
 	pp->max_processes = n;
+
+	trace_printf("run_processes_parallel: preparing to run up to %d tasks", n);
+
 	pp->data = data;
 	if (!get_next_task)
 		die("BUG: you need to specify a get_next_task function");
@@ -994,6 +997,7 @@ static void pp_cleanup(struct parallel_processes *pp)
 {
 	int i;
 
+	trace_printf("run_processes_parallel: done");
 	for (i = 0; i < pp->max_processes; i++) {
 		strbuf_release(&pp->children[i].err);
 		child_process_clear(&pp->children[i].process);
-- 
2.6.3.369.gea52ac0
