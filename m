From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/6] wt-status.c: fix a memleak
Date: Fri, 27 Mar 2015 15:09:07 -0700
Message-ID: <1427494150-8085-8-git-send-email-sbeller@google.com>
References: <1427494150-8085-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 27 23:10:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbcSd-0005M6-1n
	for gcvg-git-2@plane.gmane.org; Fri, 27 Mar 2015 23:10:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753007AbbC0WKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2015 18:10:34 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:33489 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752848AbbC0WKP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2015 18:10:15 -0400
Received: by iecvj10 with SMTP id vj10so81260835iec.0
        for <git@vger.kernel.org>; Fri, 27 Mar 2015 15:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z0EBYVzr5/cNP9hRNtXv7hsjtGJVHTxt4LSXLon8vJo=;
        b=cSUjiy8ucTZxsoJp1gC+fvgxcectkoACJB0pAvZ00mhPMdXrvGEgCs6JIR3ALu7Sar
         p9SK8UFIhUv7UHGQ1sEl61ezlGGsiWBrQEe4FiRrtZu2GSABp9JO9j9kqLOduzwEKAwt
         jMu/qUHm0GxH8RALYZiGDYkjTGo7YRfRn2KgsFdJcz3IClbe8d+rXm68qg+uHqmr3kpU
         HkAWM/VAPBUG2NpgsFJf8HLXpk+8jfBYTWbmrGGznsxjZtQ+nt6jX2SvDI5wE5QeqOAC
         XZ3jAvJkKS9bHHcLgwcr1UDZ1OolaTxfkfcrCPDmXkwbxJhpJKunme28u6k8VGAV/9zd
         7fUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z0EBYVzr5/cNP9hRNtXv7hsjtGJVHTxt4LSXLon8vJo=;
        b=IiSd3rDZFvQX7WErpgvv/rgVuNqCRztRjihjTtlBy8+mPc/D0SqbcCtRnjhT9/DWO4
         fk1EKJPF8bD1bkYEz6mD4DbLCDKIfmXBdaf7l5AHoitWzyXJe16LMwL6072MDsrqSgXh
         GxLSt80z/ZJXucr4pZL6mnyjFd87uEUUP/yu95VHtN8vfSBl3O8AR/S3GmQboMTEcW5z
         wh9/bA4o6jQ3gM4XNiPHb/43rb73JwdVVp+B7QSVORi22bHW60Fj9VOV1eN8sjqr1bnG
         XwNPkdWT7EqiDVqjwUdbBZYDaTQ1+mXBnyN+qOEQkj3anB5IDjIOJ1wo9JOb+CPcKm4T
         Tw7g==
X-Gm-Message-State: ALoCoQkhFhVky4tMYwvtm9SxYWRb1jCm2eA74/W05u45GkfdWvmVsPdHtfNNGl087GTuezS6jfvT
X-Received: by 10.50.254.4 with SMTP id ae4mr1551373igd.10.1427494215097;
        Fri, 27 Mar 2015 15:10:15 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:7174:4672:de72:7789])
        by mx.google.com with ESMTPSA id k9sm2216406ige.6.2015.03.27.15.10.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 27 Mar 2015 15:10:14 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1427494150-8085-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266388>

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
