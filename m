From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 01/11] run_processes_parallel: delimit intermixed task output
Date: Tue,  3 Nov 2015 16:37:04 -0800
Message-ID: <1446597434-1740-2-git-send-email-sbeller@google.com>
References: <1446597434-1740-1-git-send-email-sbeller@google.com>
Cc: ramsay@ramsayjones.plus.com, jacob.keller@gmail.com, peff@peff.net,
	gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com, j6t@kdbg.org,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 04 01:37:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ztm5D-0002wf-Am
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 01:37:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756092AbbKDAhY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 19:37:24 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36162 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755984AbbKDAhU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 19:37:20 -0500
Received: by pacdm15 with SMTP id dm15so9422691pac.3
        for <git@vger.kernel.org>; Tue, 03 Nov 2015 16:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Wmc0Oqpin6VG2GVscX/whmlJW/mOXVMnLS9uQhqrsNc=;
        b=ic9yzsIsqy9BC1CQRLz72VBGd0tgV1b71uj5nSBdQ8sy1f4NcGs64jUCD5MoOIliHS
         4KFTCskYOROxXkUUTKkqfO5sa3wfxu3TmLlhgFGPva7lyFoqE/SGpjEGKVblGu8tHpQN
         aAZu5RDqpAzDxpvd7EBGcjOECUSXxSsWMx+7PHFDTs366qd67FLuqAV0Sy3/k6Ah5zTH
         5ycOnVpGr8ST5SQsSyamCd+s1qrkouG4GZtY8H6cZvGA0JJ91+MMOJ5JP3lNQxclFicN
         oD0uWItdecN1Jyw9qU3jPf3/VZF+UsSuZtQI0Vy5sZ/cRCB5dxNIe9NjsC49CYS18VaA
         0pbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Wmc0Oqpin6VG2GVscX/whmlJW/mOXVMnLS9uQhqrsNc=;
        b=Vqbu4YQ4NqmQP94KuuadIkNTrRyMslYBnpOOb8X+Hyp+5sMdd5LzqzQ0XcWIsBBUsH
         Iub31t39yYUbOAZ3gETEYA5MMjxpCLzGhkbZGgkO0mqZiXD8KWt60tJtK/EsDfGB3LZC
         k2r/8pjC07t4h0e8ddpcohAlwcFYgl8Fs99m0Js2cwtxyM+PLfApfhGRYIiKa5su5Kr5
         umkrToKdv6GU9Cw4gjlplb6DSIbQTEHMltr6Fq+goWYQj/pG57Cbe1UED43G1Vo3a0PN
         3tOk8wP1GALGvyM9T8vTkYAMnH2Z35sOjxZLSR+ZUmjJIb0f/BdSQRMyjCMVkNCfzYyC
         fPNQ==
X-Gm-Message-State: ALoCoQnzpBnGsPCvi7FiVBW0cNH3X9LhekWKQY2iFwlvggcMSOv1OEw8Q5OOo9dBefEP7eZ8oO7/
X-Received: by 10.68.68.205 with SMTP id y13mr37354407pbt.46.1446597439443;
        Tue, 03 Nov 2015 16:37:19 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:799e:c67e:2702:f55])
        by smtp.gmail.com with ESMTPSA id ez1sm31735955pab.6.2015.11.03.16.37.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 03 Nov 2015 16:37:18 -0800 (PST)
X-Mailer: git-send-email 2.6.1.247.ge8f2a41.dirty
In-Reply-To: <1446597434-1740-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280836>

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
index 0a3c24e..7c00c21 100644
--- a/run-command.c
+++ b/run-command.c
@@ -959,6 +959,9 @@ static struct parallel_processes *pp_init(int n,
 		n = online_cpus();
 
 	pp->max_processes = n;
+
+	trace_printf("run_processes_parallel: preparing to run up to %d tasks", n);
+
 	pp->data = data;
 	if (!get_next_task)
 		die("BUG: you need to specify a get_next_task function");
@@ -988,6 +991,7 @@ static void pp_cleanup(struct parallel_processes *pp)
 {
 	int i;
 
+	trace_printf("run_processes_parallel: done");
 	for (i = 0; i < pp->max_processes; i++) {
 		strbuf_release(&pp->children[i].err);
 		child_process_clear(&pp->children[i].process);
-- 
2.6.1.247.ge8f2a41.dirty
