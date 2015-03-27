From: Stefan Beller <sbeller@google.com>
Subject: [PATCH V2 2/6] line-log.c: fix a memleak
Date: Fri, 27 Mar 2015 15:32:45 -0700
Message-ID: <1427495569-10863-3-git-send-email-sbeller@google.com>
References: <1427495569-10863-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>, tr@thomasrast.ch
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 27 23:33:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ybcoa-0005f7-2p
	for gcvg-git-2@plane.gmane.org; Fri, 27 Mar 2015 23:33:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514AbbC0WdN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2015 18:33:13 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:37586 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284AbbC0WdH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2015 18:33:07 -0400
Received: by igcxg11 with SMTP id xg11so32508427igc.0
        for <git@vger.kernel.org>; Fri, 27 Mar 2015 15:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I80pIwJdZ2HgbPlXHsUfoYYQb+vgBtcdIRIeBVJ2PLs=;
        b=mMrLUM7zDkNJlawALbHPogd3J0Dc85jDF7FRe9caOEBFVf8JqibhUZ8+lE7sJVEln9
         x/tlm0CIkxk2ZrJ0mEnr75jIxx/m0qKrOuy0a+DAHVb42HTP+knQn4Js6r4CrnaI3B/h
         uWyJqzdSt8m1UffB8+5e7VX9m99XOECKgqhBTzcEvJot8lGQSAWTby8fKdS/UBajXdly
         4POrxEbfZhaGlhWVtO62JXKjQ0ZeUBMBG0gZPv2jPQKN9KyeR3rif5BKTaZl+KGsl8sH
         eGRbdacWdwW5YtXp/xPg8l74fADE/cCUsitIJ/xG1shcy0/h/ENYXAfLGOxxcbmxD7nt
         qKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I80pIwJdZ2HgbPlXHsUfoYYQb+vgBtcdIRIeBVJ2PLs=;
        b=VNeIA7Aknt/tyWxfJGK/o2qbWOzBJA4qrAT2yn2h1B8V/KfQaq6BIMyw5pvvc565cv
         LqRTJhVRTMO+1Nkz4zKtt6bMSpLqD5C4vpVU2wS+xRBAue8tWw6Ykh8zTui+Ionu6uM+
         2U++0pm53WdpAL5coQTvTJ5TENT98l4t6eqw7sqQw86ONQKaf18j4t2/Jx7g+/2J2vnk
         tTJ6oWnviIZkrUv2KPx5EopqZODjzIUW5/yVlyoyt3msCNIyRdrd0Ifp0KMNk4dmZ5Zu
         lGXxazGAGO97nY7klEPq2OF2FVxw9LKk1rZWSFZrvKQk1F1pa0Lh6WhuD6B6KEUvSVXr
         8oXQ==
X-Gm-Message-State: ALoCoQk2GwisdZYuU0JEXiHdLoONdMAbr/W64p4lX9Qau1Ewp9VpIFSC3+MAmyAOqctsLHLfJHs/
X-Received: by 10.42.14.131 with SMTP id h3mr46920402ica.7.1427495586449;
        Fri, 27 Mar 2015 15:33:06 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:7174:4672:de72:7789])
        by mx.google.com with ESMTPSA id h19sm2548442igq.10.2015.03.27.15.33.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 27 Mar 2015 15:33:06 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1427495569-10863-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266395>

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
