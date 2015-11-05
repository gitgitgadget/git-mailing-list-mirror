From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] run-command: Remove set_nonblocking
Date: Thu,  5 Nov 2015 10:17:18 -0800
Message-ID: <1446747439-30349-2-git-send-email-sbeller@google.com>
References: <1446747439-30349-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, gitster@pobox.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com, tboegi@web.de,
	j6t@kdbg.org, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 05 19:17:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuP6K-0004qf-K5
	for gcvg-git-2@plane.gmane.org; Thu, 05 Nov 2015 19:17:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162275AbbKESRZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 13:17:25 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35900 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162183AbbKESRY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2015 13:17:24 -0500
Received: by pacdm15 with SMTP id dm15so70033592pac.3
        for <git@vger.kernel.org>; Thu, 05 Nov 2015 10:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h5yKSUktgZfOTRwiSPq9oi4IkYxkF5gmvrxDFzM5tQI=;
        b=bNekfPTTSc5TwNdMk1MtmaF6OqMLQ48e44N5b4muXebt02oulpPzC+WX+66IxiNQy/
         UYhBxHIx4h5t5ycMW2LMASF3b5SdT9wyandLbtqunH6Q6d5MYALgdH5MPXiLmaPJj1sg
         mcyBCw7PLaRvZ0Eem4ShZMafqA2rzybvtBXaxFMKOQhLwTp/SThiKKIukngkEOTC9K1p
         wwnyUbeVdImwHaNolsISkV6BMm3tay2TFceYcJIRbEK8TmowZFnlKCG7oKK2G1+3iGmI
         mmLuPEOk4TjSeQIIQyGRGcYoNK/YQBb0M6fGdhlBWfVXCSlvbveF6CVXRB+VmJzly3DG
         +ykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h5yKSUktgZfOTRwiSPq9oi4IkYxkF5gmvrxDFzM5tQI=;
        b=OCXG4runq7uY3+4ie5q8WwSn4yqnHH2qEGVCtM29GgIakBnV3g8I8Tj1f7S1Utwki9
         xEv1sSoSOHWbJGIP6wKDefXVxzfa7ZkDpLdTYlTrHdfFgu5rj+JfMAajRGu+7rdY8Qn/
         4BXEFthi0bi7wYeHqfFudpjmv6qZuZigk3AnRv5NdJ8P5152ubbwoZf8owUOqf4GwfTB
         rd4E1dlpPydtCfl7z0sM9AdnYJY0ksKZ2H9QY/U9IPtODV4mY+mPEQCa0FvZvS9DJjr+
         kt3agG+644tYguoLYq6osgYrRZaqMwaEE1JVuLapT4NfnehsUC9ZY/6FhlmD2U6q3auL
         GL4Q==
X-Gm-Message-State: ALoCoQlQdlcCfEHMjaKw6KGnjLInAnUPJzRRZ9PpaTkfOSpKsczcq+MpEuU8byf6Ls2iWRnV9ZQc
X-Received: by 10.67.4.38 with SMTP id cb6mr10876018pad.34.1446747443506;
        Thu, 05 Nov 2015 10:17:23 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:8805:9922:277f:8125])
        by smtp.gmail.com with ESMTPSA id hz4sm7057775pbc.12.2015.11.05.10.17.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 05 Nov 2015 10:17:23 -0800 (PST)
X-Mailer: git-send-email 2.6.1.247.ge8f2a41.dirty
In-Reply-To: <1446747439-30349-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280929>

strbuf_read_once can also operate on blocking file descriptors if we are
sure they are ready. The poll (2) command however makes sure this is the
case.

Reading the manual for poll (2), there may be spurious returns indicating
readiness but that is for network sockets only. Pipes should be unaffected.
By having this patch, we rely on the correctness of poll to return
only pipes ready to read.

This fixes compilation in Windows.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 run-command.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/run-command.c b/run-command.c
index 0a3c24e..51d078c 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1006,17 +1006,6 @@ static void pp_cleanup(struct parallel_processes *pp)
 	sigchain_pop_common();
 }
 
-static void set_nonblocking(int fd)
-{
-	int flags = fcntl(fd, F_GETFL);
-	if (flags < 0)
-		warning("Could not get file status flags, "
-			"output will be degraded");
-	else if (fcntl(fd, F_SETFL, flags | O_NONBLOCK))
-		warning("Could not set file status flags, "
-			"output will be degraded");
-}
-
 /* returns
  *  0 if a new task was started.
  *  1 if no new jobs was started (get_next_task ran out of work, non critical
@@ -1052,8 +1041,6 @@ static int pp_start_one(struct parallel_processes *pp)
 		return code ? -1 : 1;
 	}
 
-	set_nonblocking(pp->children[i].process.err);
-
 	pp->nr_processes++;
 	pp->children[i].in_use = 1;
 	pp->pfd[i].fd = pp->children[i].process.err;
-- 
2.6.1.247.ge8f2a41.dirty
