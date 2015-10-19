From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/5] run-command: Fix early shutdown
Date: Mon, 19 Oct 2015 11:24:42 -0700
Message-ID: <1445279086-31066-2-git-send-email-sbeller@google.com>
References: <1445279086-31066-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Oct 19 20:25:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoF7J-0007Vr-7D
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 20:25:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754391AbbJSSY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 14:24:58 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35219 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754048AbbJSSYz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 14:24:55 -0400
Received: by pasz6 with SMTP id z6so37162815pas.2
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 11:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J5O7tWXmTx2qjw2Xp9AFFTYD0Swz+SHiV3Pv/b01o3M=;
        b=bptX5+9mB01qBvblMG3R/vRd6glyZ6ZhLUscsphZu7n6hJWqyErXFp9miLrNRTQMrz
         FL2F2AGbFtf60nd4Z10MUg7BIKgRQa2B+fjlYNefbU8QfkLf9pxxZZ7paM4Jm9jms7UF
         VAuC6rSQkPWwSiwk2iJ7syopTDH+ZsG7x0gLYjSILWob3gMTT5wBsOGHlskp5bTvL0iy
         loIfPZ9r/ovQlS26JGKaV2dxwLXXnirWlQrgoUBosRe4TRp1wmo3v0h8V0+ars7GE7By
         1hVNbUt6WdDbmhe6fuA7e31pxoTRPACuiyF9Hx6OUl0DtT8ITi5/KpnMa8fIFJFdjFyp
         wqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J5O7tWXmTx2qjw2Xp9AFFTYD0Swz+SHiV3Pv/b01o3M=;
        b=abqGIUuqXUo5uKkz9PomJRtSrlPEb0aCUsrBb3mCb2jcC9dVnM+jB6qIQ6eHfzP0Vv
         WLsQjXHc/6LYDUy0BVA+LQcGf39cwgpd0foU8ZyT05iVIKCAkwI4os7pMsqYnzQ+TRvM
         KOd2uVv0rYHFMDZB0djoyDpoDIgWcouwm98914gv98ZD4NyY3yoPon0GfDKpucGZrDtW
         CF4zvwwxQhnbvQK3MdJRYaJ6Fnspw0EIBErW5ODUPxINBe5rySRsuPIzgo5ZxaTZuMgk
         plAqYsOqf56rkMvOR9llaNsqo4WQ2DgFgL5ENM6gAQ+6EuB5L7ixV3YgXUNS6sBS/Vsk
         aDcQ==
X-Gm-Message-State: ALoCoQnHnJiSclZgfFT1EW57+wK8hvk8cvEXfaCJBKbZvq1GtLJTixgrZoRVP4B3lFceZJ9RIsOu
X-Received: by 10.68.183.5 with SMTP id ei5mr36608642pbc.124.1445279094294;
        Mon, 19 Oct 2015 11:24:54 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:e1e6:ddb6:de02:325])
        by smtp.gmail.com with ESMTPSA id dg2sm37547270pbb.9.2015.10.19.11.24.53
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 19 Oct 2015 11:24:53 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.285.g8fe9b61.dirty
In-Reply-To: <1445279086-31066-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279880>

The return value of `pp_collect_finished` indicates if we want to shutdown
the parallel processing early. Both returns from that function should
return any accumulated results.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 run-command.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index ef3da27..8f47c6e 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1077,7 +1077,7 @@ static int pp_collect_finished(struct parallel_processes *pp)
 	while (pp->nr_processes > 0) {
 		pid = waitpid(-1, &wait_status, WNOHANG);
 		if (pid == 0)
-			return 0;
+			return result;
 
 		if (pid < 0)
 			die_errno("wait");
-- 
2.5.0.285.g8fe9b61.dirty
