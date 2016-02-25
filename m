From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/7] run_processes_parallel: correctly terminate callbacks with an LF
Date: Wed, 24 Feb 2016 17:42:02 -0800
Message-ID: <1456364525-21190-5-git-send-email-sbeller@google.com>
References: <1456364525-21190-1-git-send-email-sbeller@google.com>
Cc: Jens.Lehmann@web.de, peff@peff.net, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Thu Feb 25 02:42:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYkwc-0000DG-A0
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 02:42:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757625AbcBYBmP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 20:42:15 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34063 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753630AbcBYBmO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 20:42:14 -0500
Received: by mail-pf0-f176.google.com with SMTP id x65so23141115pfb.1
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 17:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BU0ZyGCRBnFfGhbGKKC8UgR1pKVsFIQRY/I9uJF+KdA=;
        b=o0RbHb8PPE9074JRDg6mt388GI5rXXSPGpXDlUQCTnVYfCGVntqF4T84DXsJuoJOJh
         M5UzVEQEA1CS26qjNfbwXe1FzgYrGQVXKSOi06Zx8GN+dfHWifORHPonoOmbBcRTDa5/
         E9T+CwZdhK62EdkJpIzj3k59tweIF01G+zWpVG98TECgoeckhpJURPGoRbUAIzstMioU
         bMEuj4jovVssDT7SxG60cmxxsS29q0pzqlMgcILwVwjhvu8bAg/MVQ++bnjl/QvZJuZK
         0qkhotvKy9OWhXfMg8AWcoHtZ+s/vK6j4trshVYgbkTSde0FiahcwS8Kmlj/i4TXI/ee
         JyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BU0ZyGCRBnFfGhbGKKC8UgR1pKVsFIQRY/I9uJF+KdA=;
        b=IxwjeEzJbYvL8zjjxRoUVuUuBE+TppxcDapGL0kwa9gn9H/XaooyNGRuOywL7+CXm4
         Kkf7F42RhZ5BnNOKb9Yx4WB0t4DMHn5rd0giW4J238ki0FAkKbSIC1SITj3OfyXMjTz0
         Mi571Dhpgv+U7+Nwn2soowcR8M4CoFTSKx8OOI10gHQc+LAf92GhlbgoQD2jVVXh0yaY
         WrTQmoyPIeU/ZxqlOPlmKpUJPI6o1LO+C90vZRFTms4HUnqIP8w0lepr/mcROnZKNvbM
         xkFEyqdLhbuRHBMatI9Xr8r+9wmDLNlPWsSFbRcy7HP+N6se/ukTlqwsRD+69bdTr7mL
         6pkg==
X-Gm-Message-State: AG10YORStHozZ5OOZCqHyDTRNrM+bAq+CIENTADimefLqSw6uKADpKrTXlcxsVdItSR36q4G
X-Received: by 10.98.70.139 with SMTP id o11mr59429744pfi.123.1456364533402;
        Wed, 24 Feb 2016 17:42:13 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:74de:af7a:dfba:15a4])
        by smtp.gmail.com with ESMTPSA id ml5sm7749471pab.2.2016.02.24.17.42.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Feb 2016 17:42:12 -0800 (PST)
X-Mailer: git-send-email 2.7.2.335.g3f96d05
In-Reply-To: <1456364525-21190-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287303>

As the strbufs passed around collect all output to the user, and there
is no post processing involved we need to care about the line ending
ourselves.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 run-command.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/run-command.c b/run-command.c
index 20489c8..8e60812 100644
--- a/run-command.c
+++ b/run-command.c
@@ -912,6 +912,7 @@ int default_start_failure(struct child_process *cp,
 	strbuf_addstr(out, "Starting a child failed:");
 	for (i = 0; cp->argv[i]; i++)
 		strbuf_addf(out, " %s", cp->argv[i]);
+	strbuf_addch(out, '\n');
 
 	return 0;
 }
@@ -930,6 +931,7 @@ int default_task_finished(int result,
 	strbuf_addf(out, "A child failed with return code %d:", result);
 	for (i = 0; cp->argv[i]; i++)
 		strbuf_addf(out, " %s", cp->argv[i]);
+	strbuf_addch(out, '\n');
 
 	return 0;
 }
-- 
2.7.2.335.g3f96d05
