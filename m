From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 5/6] wt-status.c: fix a memleak
Date: Fri, 27 Mar 2015 15:09:09 -0700
Message-ID: <1427494150-8085-10-git-send-email-sbeller@google.com>
References: <1427494150-8085-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 27 23:10:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbcSU-0005EL-7E
	for gcvg-git-2@plane.gmane.org; Fri, 27 Mar 2015 23:10:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752894AbbC0WKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2015 18:10:22 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:35511 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866AbbC0WKS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2015 18:10:18 -0400
Received: by igcau2 with SMTP id au2so32658562igc.0
        for <git@vger.kernel.org>; Fri, 27 Mar 2015 15:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z0EBYVzr5/cNP9hRNtXv7hsjtGJVHTxt4LSXLon8vJo=;
        b=nCO53ENADXfavMasLjW2/H+95tWQ01LsP36vY6SBS46W6rOrXxHlD1MHXT37XZRaQo
         0Cgl0zwYiU18OilH9gdMSAoRmvxpO5x0c0/6fiK5Y5/bhXF9HH2EG/oj+aH/p8hh0GuS
         jJnzyMqPJAtt8AgHOe7GWJvbb+Gq9mpVbKy2KhjN/9C+y7FinHmk+ozqHKzEXPWdojgP
         on8D2gjKbjz1vm6egZW4bXLG83FfIzVrvZUa9HHqOpLsb159DuWNmMhhrZeVo7Lju7WZ
         140JOmZBJR/NYeXA2C5D2Qk5OX/dD4owBEABlmCyX6MXQSeUP/ezpLvlbOJ8g4HAyI/Z
         5GQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z0EBYVzr5/cNP9hRNtXv7hsjtGJVHTxt4LSXLon8vJo=;
        b=TN7f8Ok81q50rPkCwHApfwdM5eVKX5BbriVoc13OtvUb7dBPW7codUAfwest7ShxNs
         sQUEjQeN84G5/3OL2g6aRk5IXt1VdOoS0YguLeA3Ux1SlM+mCbANFFJ3YtjcWN2cs6pz
         hBwDNLKXYLFRacGzTtvWaHQmQ9oStlxNMiUYYsRqs5PsqQThWZopnfUbeDDos3nY705V
         sPIqC7uOZSkX+t3a+YgpRGYm8D58cYr/F+YTRMdPI6TqKSZEOgbc3Z+qzjfAjHm8DGKZ
         sbrOB3hJZzRE9GglDqo4C+AMldh2XSsmRoAFoc+QurrYyhLyYa05bXn60ufdq5W78cwU
         u+Tw==
X-Gm-Message-State: ALoCoQms3tpdI/wzGFEI/rA1R5d0g0nz6+e3KXHnPRbmqIKWy/NAMQ49P4vriRdDZckPUs/Q9gS0
X-Received: by 10.107.17.74 with SMTP id z71mr7109406ioi.28.1427494217336;
        Fri, 27 Mar 2015 15:10:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:7174:4672:de72:7789])
        by mx.google.com with ESMTPSA id 3sm2164191iom.4.2015.03.27.15.10.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 27 Mar 2015 15:10:17 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1427494150-8085-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266385>

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
