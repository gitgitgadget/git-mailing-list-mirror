From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 2/6] line-log.c: fix a memleak
Date: Mon, 30 Mar 2015 18:22:07 -0700
Message-ID: <1427764931-27745-3-git-send-email-sbeller@google.com>
References: <1427764931-27745-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>, sunshine@sunshineco.com,
	tr@thomasrast.ch
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 03:22:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ycksx-0008LB-Sr
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 03:22:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754133AbbCaBWZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 21:22:25 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:36789 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753915AbbCaBWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 21:22:16 -0400
Received: by iedm5 with SMTP id m5so4396286ied.3
        for <git@vger.kernel.org>; Mon, 30 Mar 2015 18:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I80pIwJdZ2HgbPlXHsUfoYYQb+vgBtcdIRIeBVJ2PLs=;
        b=kmpkETiHKH7iYmUkF7TA/bHWFDWWZnZRBvCrib969NLbk940jMvSeuX/KGQvPkNNSW
         aAVVWjvdVY4HxsXQZKqDhbjwbn+GN3NKryLN/y5QBBOoqXjKNSRjtglQOSnKp+V5NfP0
         zuzn62jUoadlqdA4Kp8YCATU6NrAIM2iGHa6zhYC4L9Pi8DpYU/tYzr9xjOFtmLmLUeF
         zaE6Norm0c3Bmbcooz1AGxiXcGPV1m/+ghDMp7FAZnNKiokKXmrJmLFm7EMj22IPAjZB
         vRqB9aXl4020M7UlIJEfUTjGkkaTxAsqMWn/g76phieszBbRYxnwTp22syKxZ1dlEi9H
         5Fog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I80pIwJdZ2HgbPlXHsUfoYYQb+vgBtcdIRIeBVJ2PLs=;
        b=jE6zrcK+BGZOFvDo4bvoiRHQBUNkBEuRPuvh1gDbnoO0omrTdmNocj8RAfDKsiXyxR
         u4fZ6SOKBz/rev7UcYBezfeZArkLP882j+Dz4UKav+a659JG3JZ8rEG9b/nQbSU9vS0H
         k7R7MXanHfyzYfi17itHKmonituOuJXyRUVHMc/xUOUZM5jxlY8ox8p5SiW+dGGeQCU/
         3iSdbj/6Pr5tmwr+O3CKby+zBWw6OIokMz3lOBmY7X+W8GfV1phKrP/JhieB7KSxOY4V
         xjlzTuy/OThR6e9Oa8ILfMOreRDATKrUDhiWJ4LzIekLyUpBYkgWnBGK7aabl4KfhqVf
         tD1A==
X-Gm-Message-State: ALoCoQnFylgd/NSlYX11j50MEMmiFvGtqPt/LXdS+AZ/XqbK747JQW9OBOIyzFKyvl72Q41JtyVU
X-Received: by 10.42.89.72 with SMTP id f8mr64771160icm.24.1427764936205;
        Mon, 30 Mar 2015 18:22:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:3c88:d48a:4382:4b5])
        by mx.google.com with ESMTPSA id hh9sm9055235igb.1.2015.03.30.18.22.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 30 Mar 2015 18:22:15 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1427764931-27745-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266501>

The `filepair` is assigned new memory with any iteration via
process_diff_filepair, so free it before the current iteration ends.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 line-log.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/line-log.c b/line-log.c
index a490efe..b43ac58 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1099,6 +1099,7 @@ static int process_all_files(struct line_log_data **range_out,
 			rg->pair = diff_filepair_dup(queue->queue[i]);
 			memcpy(&rg->diff, pairdiff, sizeof(struct diff_ranges));
 		}
+		free(pairdiff);
 	}
 
 	return changed;
-- 
2.3.0.81.gc37f363
