From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 03/11] run-command: omit setting file descriptors to non blocking in Windows
Date: Tue,  3 Nov 2015 16:37:06 -0800
Message-ID: <1446597434-1740-4-git-send-email-sbeller@google.com>
References: <1446597434-1740-1-git-send-email-sbeller@google.com>
Cc: ramsay@ramsayjones.plus.com, jacob.keller@gmail.com, peff@peff.net,
	gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com, j6t@kdbg.org,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 04 01:37:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ztm4y-0002iH-2g
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 01:37:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756115AbbKDAhZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 19:37:25 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36203 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756047AbbKDAhW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 19:37:22 -0500
Received: by pacdm15 with SMTP id dm15so9423725pac.3
        for <git@vger.kernel.org>; Tue, 03 Nov 2015 16:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SBGXYhT1zbx8puQPyAhXVnKQYtcaFIN/y7WlWSmFyMY=;
        b=RPHKzXk/oyfKjdj+2gtjZ0SkDUTvif+x2ZP+6pjhCClllIFtvF5/RXlrBYlRI5OGVh
         8484omXOgbDQjIHBgzgDnogGMCrkii7D00S76f7BynkO0GjS1biCnXKK6uCo2xRD3q7W
         wOCF4/I/OvlT4fDNsH0mr5tr6PNqFlVBpoSBYNh6ktKEpvW8/gSCkw7KfOMXl4Zd9LBi
         CbUjQac53+qr6NXi7yW78DCqLQtHRqqrF1lH67vgfivjrKbrviUxkQoxfaSvZtszlMgM
         YhLz6rEhQ5DnhQJjQzE3sfweu0RGQSxAhiDKp3vSA5GXZfFr9oe0Ze8CbkY4AE1w6jL7
         pJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SBGXYhT1zbx8puQPyAhXVnKQYtcaFIN/y7WlWSmFyMY=;
        b=Gh3pjUz1Rst0sk/7Q1RXy/fLFVFYSNrqkSvazTvCClgbXjYvd8TXsBIQx+J8V0KIcq
         f6qLXYH8oNgmMlgNAa4VM4SM52CPsWH2nZ/sB0HT9FxKsDJ6xN6qtOAo4MEZYJnSf9h+
         Qp/6Yp65pXKQQweIjo++FS6llBvYmM5yHzaofgObmjWoAI8SZ3ZsYKNn4+P3ac0JK7b4
         0XTFpyOhcXG6yIJX1rb4pAro2Z4eUr5V341KW4fbmFOTWbocYWA8XHk/omEzms/FKFox
         +8uHWvFKzkJQuQSKzI9SG63J6Got2Zy6Q/fNMVMBgAaeHYpFrLaWlLhUuvf4ZpLYM7Bc
         4Slw==
X-Gm-Message-State: ALoCoQlO9ky+7y0CG+vdF4LpFUGq5I3o9vgDmkMK8L7hUUILH7r5w6B28c5nXVvLauaUz8CkDHPS
X-Received: by 10.69.1.9 with SMTP id bc9mr35733217pbd.128.1446597441870;
        Tue, 03 Nov 2015 16:37:21 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:799e:c67e:2702:f55])
        by smtp.gmail.com with ESMTPSA id by6sm31764214pab.25.2015.11.03.16.37.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 03 Nov 2015 16:37:21 -0800 (PST)
X-Mailer: git-send-email 2.6.1.247.ge8f2a41.dirty
In-Reply-To: <1446597434-1740-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280831>

In Windows there is no fcntl apparently and as it only affects output
slightly we can just run with degraded output in Windows.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 run-command.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/run-command.c b/run-command.c
index 3ae563f..8db7df8 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1012,6 +1012,7 @@ static void pp_cleanup(struct parallel_processes *pp)
 
 static void set_nonblocking(int fd)
 {
+#ifndef GIT_WINDOWS_NATIVE
 	static int reported_degrade = 0;
 	int flags = fcntl(fd, F_GETFL);
 	if (flags < 0) {
@@ -1027,6 +1028,7 @@ static void set_nonblocking(int fd)
 			reported_degrade = 1;
 		}
 	}
+#endif
 }
 
 /* returns
-- 
2.6.1.247.ge8f2a41.dirty
