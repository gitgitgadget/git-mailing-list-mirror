From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/5] run-command: Call get_next_task with a clean child process.
Date: Mon, 19 Oct 2015 11:24:43 -0700
Message-ID: <1445279086-31066-3-git-send-email-sbeller@google.com>
References: <1445279086-31066-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Oct 19 20:25:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoF7P-0007aB-Oj
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 20:25:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754343AbbJSSY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 14:24:57 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36325 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753488AbbJSSYz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 14:24:55 -0400
Received: by pacfv9 with SMTP id fv9so102542861pac.3
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 11:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lmlUUlSD5zq1poBsFkaRPYeSJ8t4wnTHK1sNQEnt16g=;
        b=DtX68fUIix0qtG+WfBAL1S2EznOfHULJdMo4Dj2C0Q1Oo4uDBWEo6UckbLp/rcLEev
         83J7yPCumS6uITlYN53rC+NYNi10XcVA+uaL6DTdNu35H3tdq39c45JD29uFn4+MX12v
         kgDvvmWc7wQIZly29pnz4s+pzFTnIkRUVFuaDq2Cbo52R0de2V0RHo29diSeEo+N238k
         4Ejul0NjJeUMR7mSyUUcyXvtKa9wUtXIdEIk4AC2/P4/R574NnkZ/Q+thTAKUeppzXdC
         72g5KVi7409yUAUUsKbtteRZA53TqoNVLwuIwJsi1Y94JhVUaw1uIrNmH5sLOdZHC7Rm
         N+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lmlUUlSD5zq1poBsFkaRPYeSJ8t4wnTHK1sNQEnt16g=;
        b=mpTe3gUdPWtiMHSxVKBn9aTxXBihCRKtS1vYXh7HxLmsIp5Bz54NiQHjnYT+7x3UfN
         0CK6hBtfsL6jLv5HYfQ2sP8hphHh9vkUdyALrqcFNs5ngptx/VwXZfJLJH74+sM2lvJr
         okCLwbF7lLxG7SAm70Y94N+H4fg5B/l0ibZV+o+TZ2MQIBqujRSJC2qdWxDTZLohVXAB
         W6s/4YOSKAvHrGdMlcWu7foF4OpnHH0TIZXvngUp4ephMsloGhQPEMGmHk0wdKJzECMl
         1Ps6/Bc0Qwe53TiK0HVjXx0MaUOti8bxt8RYx7rIukGnfSyQoLhqFoQxMTeSk0u9kAbH
         MnyQ==
X-Gm-Message-State: ALoCoQm91R/hBu7x1W6DrpQvMcrqEy2+blzseXnMlSrnz3MENTDolfbR1Cab9yOoqMHM1XdlwgeV
X-Received: by 10.68.65.37 with SMTP id u5mr36171041pbs.76.1445279095377;
        Mon, 19 Oct 2015 11:24:55 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:e1e6:ddb6:de02:325])
        by smtp.gmail.com with ESMTPSA id ve8sm15042095pbc.48.2015.10.19.11.24.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 19 Oct 2015 11:24:55 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.285.g8fe9b61.dirty
In-Reply-To: <1445279086-31066-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279882>

If the `get_next_task` did not explicitly called child_process_init
and only filled in some fields, there may have been some stale data
in the child process. This is hard to debug and also adds a review
burden for each new user of that API. To improve the situation, we
pass only cleanly initialized child structs to the get_next_task.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 run-command.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/run-command.c b/run-command.c
index 8f47c6e..b8b5747 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1010,6 +1010,8 @@ static int pp_start_one(struct parallel_processes *pp)
 	if (i == pp->max_processes)
 		die("BUG: bookkeeping is hard");
 
+	child_process_init(&pp->children[i].process);
+
 	if (!pp->get_next_task(&pp->children[i].data,
 			       &pp->children[i].process,
 			       &pp->children[i].err,
-- 
2.5.0.285.g8fe9b61.dirty
