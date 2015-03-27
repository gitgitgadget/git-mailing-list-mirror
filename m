From: Stefan Beller <sbeller@google.com>
Subject: [PATCH V2 4/6] wt-status.c: fix a memleak
Date: Fri, 27 Mar 2015 15:32:47 -0700
Message-ID: <1427495569-10863-5-git-send-email-sbeller@google.com>
References: <1427495569-10863-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>, knittl89+git@googlemail.com,
	worldhello.net@gmail.com
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 27 23:33:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ybcob-0005f7-E8
	for gcvg-git-2@plane.gmane.org; Fri, 27 Mar 2015 23:33:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752605AbbC0WdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2015 18:33:18 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37609 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423AbbC0WdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2015 18:33:09 -0400
Received: by igcxg11 with SMTP id xg11so32509094igc.0
        for <git@vger.kernel.org>; Fri, 27 Mar 2015 15:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z0EBYVzr5/cNP9hRNtXv7hsjtGJVHTxt4LSXLon8vJo=;
        b=eu2fs3pDmfCY70AZnRiwn8up+dy5D4W3IM8ST0rCKXbio4U9rlO6h/i18awfXHGBJ5
         SVC/fr311rtK+kiD0GcQR8+XuqZwAKC9o388FhvcGNCXbHCoGSCXf8/0czARnKRfTuTn
         fUk07En/wx7k2aELFmO/OtS9UBdiDPzOe2ZtI4gUBpYuD4j9OO31oXoyXoPye4CkneB5
         BFE9w9Z1IeVrAb1YzDyTnC9g1MAMHQnMry9BUu8/wzDhsVbFUL/0F7uOEKMIGouF15j9
         8MDEWM+lDCErG6FAPXxKd/PJXbP8TcVH7qefVzHaxIj7J4UUD1QWfySK+jNKn6fUJMJD
         dLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z0EBYVzr5/cNP9hRNtXv7hsjtGJVHTxt4LSXLon8vJo=;
        b=UhF1IrOJBbn0yYDQOQ8v2uCezDBo6BAjeFkGt9t7U+3/zjOJHRpJopEnyp+/n5LaVi
         v9g1ehHHUL0sCqPxuuzRTGgELEgr96FEbLgieDFvFnXVi2sqSr2bENlRWrEWZMk4dwaI
         bEdRnnVb5GwxyeDSJURjWR82BkcWsCWS0uyBoJvdvZl8Uk+e8U21V98S6d8kOClLyKHh
         etLln9VC9mm8K3VPH9p7kkNjgKRl4L3QCj53Ebn4S/ZkZcIktxSUx7/xmAJhD+dYg+1w
         QSvpnsMnSjQGgiIeybdc6PpsZ4hZdAqNfzCIljktlyHWNNJh7gPaKjsa4Du5Y4LlRbkx
         PuLw==
X-Gm-Message-State: ALoCoQnG01q7PNDskBTewaU8HRJd+odKiQ6j1Q5i+1+ivsYW2mSQ404OeUxuH4/A6WibjdJ0G9Ud
X-Received: by 10.50.43.227 with SMTP id z3mr1669860igl.6.1427495588888;
        Fri, 27 Mar 2015 15:33:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:7174:4672:de72:7789])
        by mx.google.com with ESMTPSA id qs3sm2255850igb.8.2015.03.27.15.33.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 27 Mar 2015 15:33:08 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1427495569-10863-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266399>

In any code path of shorten_unambiguous_ref the return value is a
xstrdup(some string), so it is safe to free the variable `base`
in any codepath.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 wt-status.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/wt-status.c b/wt-status.c
index 853419f..9d2a349 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1576,6 +1576,8 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 
 	color_fprintf(s->fp, header_color, "]");
 	fputc(s->null_termination ? '\0' : '\n', s->fp);
+
+	free((char *)base);
 }
 
 void wt_shortstatus_print(struct wt_status *s)
-- 
2.3.0.81.gc37f363
