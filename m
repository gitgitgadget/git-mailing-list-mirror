From: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] blame: display a more helpful error message if the file was deleted
Date: Thu, 28 Jan 2016 20:09:31 -0700
Message-ID: <1454036971-26287-1-git-send-email-alexhenrie24@gmail.com>
Cc: Alex Henrie <alexhenrie24@gmail.com>
To: tklauser@distanz.ch, gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 29 04:10:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOzRp-0000LI-2Y
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 04:10:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbcA2DJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 22:09:39 -0500
Received: from mail-ob0-f170.google.com ([209.85.214.170]:35369 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbcA2DJi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 22:09:38 -0500
Received: by mail-ob0-f170.google.com with SMTP id ny8so31290345obc.2
        for <git@vger.kernel.org>; Thu, 28 Jan 2016 19:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=UVr2m1GD191nIB2NXCrAprinYvuTbNHKEMZZyt6Mr+o=;
        b=VfL2986ZIcx7RpuPMAJviZjKlCCOdYo0UcqJpzOrrM75gIBhqvV209rKVcyzcKzI/S
         gnZKUtay+iZApJ80UGUG5I6IZ7qI4QFLTUQiMbApVcFzil/GINXHV4YcGiygXq8sP4q1
         3nI7TgWyjs8dYpGkG7LKlpfod6Ii+zgdgoRLC/G3o5xC5WGn12wiRAedDiHoCUKY76qj
         aNiAfiuccvUhaJ3FeGxyHxqjZDbOmLEisnFzDYg8u/Fm+DLzmIm1OFOnZGY4ZzYRyGCm
         fHnSE5Lcjt0WjvAiOq2/aE8IUoDgtTMBJBposHc5JJT7kPKOloAAJiLhM4GF+hdEUhY/
         NDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UVr2m1GD191nIB2NXCrAprinYvuTbNHKEMZZyt6Mr+o=;
        b=DjWQurpNquGPWkv/LaEC1VD3uN/ykgB4AzZX0B7o/13MScnG5vLwFc2Bj3d2YTu3b5
         YG0PwI8zhvoMXH0CQiY5frY4sGuOlZq/E0nSdIQ+P5CY02KC6+T8HWltNsR70mzn6ZVS
         si4mvwjwprAfdO7DP/uQ7EIdGB1/ss6rqtV2UpAq2tD8RtnNCcOwl/yM38zwjgyqxncm
         QEcrMAMYgV7eKTUKZdKjBzCDTkue6+QAZw7JpEutz5L+lYP/I2LaqW7FCwT6svXfzgKa
         EsoEJsmnWQwRvxSPEzx1bRyn3MKWD55416kIL9w9hj7g2r0GHzVGakpRI6U57n7dbAx4
         GyeQ==
X-Gm-Message-State: AG10YORGtG83BIEuLejXrJQnE7t3mQnpIn/M7+CRDYbmN5iY82lbg4KxjV3xJT2A1BQoRQ==
X-Received: by 10.60.134.202 with SMTP id pm10mr4782045oeb.50.1454036978123;
        Thu, 28 Jan 2016 19:09:38 -0800 (PST)
Received: from alex-wolverine.localdomain ([50.141.67.5])
        by smtp.gmail.com with ESMTPSA id px4sm7069527oec.7.2016.01.28.19.09.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Jan 2016 19:09:37 -0800 (PST)
X-Mailer: git-send-email 2.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285055>

`git blame 22414770 generate-cmdlist.perl` currently results in:
    fatal: cannot stat path '22414770': No such file or directory

This patch changes the error message to:
    fatal: ambiguous argument 'generate-cmdlist.perl': unknown revision
    or path not in the working tree.
    Use '--' to separate paths from revisions, like this:
    'git <command> [<revision>...] -- [<file>...]'"

That way, the user knows to rewrite the command as
`git blame 22414770 -- generate-cmdlist.perl`.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 builtin/blame.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 55bf5fa..9461a73 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2704,8 +2704,6 @@ parse_done:
 		argv[argc - 1] = "--";
 
 		setup_work_tree();
-		if (!file_exists(path))
-			die_errno("cannot stat path '%s'", path);
 	}
 
 	revs.disable_stdin = 1;
-- 
2.7.0
