From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/8] run-command: Fix early shutdown
Date: Tue, 20 Oct 2015 15:43:43 -0700
Message-ID: <1445381030-23912-2-git-send-email-sbeller@google.com>
References: <1445381030-23912-1-git-send-email-sbeller@google.com>
Cc: ramsay@ramsayjones.plus.com, jacob.keller@gmail.com, peff@peff.net,
	gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 21 00:45:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zofec-0002jN-QY
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 00:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275AbbJTWpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 18:45:11 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35084 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754506AbbJTWn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 18:43:58 -0400
Received: by pasz6 with SMTP id z6so33861543pas.2
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 15:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q6AqTKtTKQ781VuuCvaCfqXYQT3nLhnPhNUWbPu4+T0=;
        b=WvZIoID8vYWz2JlUDklRCNDA+jZ3ioOnSt0fBBOn2kzHXyOqMNy/KGPBM9LsVjLE5B
         9ViMoi9DTd+ciMRNjG763blW0QHg+8z0z/Wi+l6CgSH7d0OK8Nsu1YR542zjZdtRbO0e
         tHUg3d4CiIKG+PJTufTiGEssKeBdkmkObAzZ8dUr+2faeanB8wC61FJjW/YXXZagAPfT
         Jm6Qu/mRzm1WdwqZoQlx3FCM7zZSSk/OYjMTvB8yb5IaQlgEcl+eabtvmiAieN0NHg9/
         3t0O7gC7/DzBlIdwyqFdPTFpRGnq1CCnrLm0v+bH/7PMElmotDinpyRAqjFQJXjHQ0Mg
         Rs3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q6AqTKtTKQ781VuuCvaCfqXYQT3nLhnPhNUWbPu4+T0=;
        b=c1VF7WFnoBajvlgrsyfPErQ3Rk3rZ0Y06wIXJcTa3LTuNL6pwDedGYJhRByv9p8wKz
         dMeK9/K1SJtaDlBz0i8npn2P42kzOfhCAhPds6ZKcjwcbN1pC5ZWEET3w7Dgm+Z0LXKS
         2qnRODnoVhrSeMoAIG8JI4VPgrcvdoSsFGJoYWx8wDZaOUSbKHZpsGQ8GFb1to5L12nS
         /ORIZiNNobmWGhp7AmfYqmyo/aqz/8DzXJnLbORPotGoUFEnEMWdLWypUIHQPr33QLH6
         mOyP5OZEOxKrtrKjot8Z8tJZVhBivxbofCthjeD2psr84MFtWVfqEBPrVu4k32g8TbND
         WNpQ==
X-Gm-Message-State: ALoCoQkNUC8OqcCWCQ/D0njW3/M+sNatgdrXmOPEzCrlPJ2DC7dYmdMyrGmBPXK8piHAECjkJq4Z
X-Received: by 10.67.12.166 with SMTP id er6mr6557982pad.40.1445381037953;
        Tue, 20 Oct 2015 15:43:57 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:95b6:4bcd:ddcd:b6a3])
        by smtp.gmail.com with ESMTPSA id ou3sm5596598pbb.44.2015.10.20.15.43.57
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 20 Oct 2015 15:43:57 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.275.gbfc1651.dirty
In-Reply-To: <1445381030-23912-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279954>

The return value of `pp_collect_finished` indicates if we want to shutdown
the parallel processing early. Have just one return path to
return any accumulated results.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 run-command.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index ef3da27..b9363da 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1077,7 +1077,7 @@ static int pp_collect_finished(struct parallel_processes *pp)
 	while (pp->nr_processes > 0) {
 		pid = waitpid(-1, &wait_status, WNOHANG);
 		if (pid == 0)
-			return 0;
+			break;
 
 		if (pid < 0)
 			die_errno("wait");
-- 
2.5.0.275.gbfc1651.dirty
