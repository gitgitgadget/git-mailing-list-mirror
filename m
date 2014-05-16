From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v3 06/31] Fix the do_get_patch function.
Date: Fri, 16 May 2014 16:45:53 +0200
Message-ID: <1400251578-17221-7-git-send-email-cederp@opera.com>
References: <1400251578-17221-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri May 16 16:48:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlJQZ-0007JL-NX
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 16:48:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757381AbaEPOry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 10:47:54 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:42596 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755806AbaEPOru (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 10:47:50 -0400
Received: by mail-la0-f52.google.com with SMTP id gl10so1996846lab.25
        for <git@vger.kernel.org>; Fri, 16 May 2014 07:47:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E0dOF6Wl/e8iUfL+xziqJ9pwWu0F+7vJxV3PrhFIXzQ=;
        b=Pmd1Kwyt6RYqZLy7O5DdjCGrRGYdLaQjptqu5n4+VIeyVQyxj+XmyQFUXugqT0Dpjr
         eoZQ879QHTKarQ35ibhfjT856BhNDe5klHyI2n5AO39yOcO+JBLEsMakyXDCH9J15wO1
         EQrSHsaTacW3j4A3V1W3IZM7jKuHeUGdN52d448p/TJ2JURI/DobM+JS1bTVWYcrm0DO
         sbXTx0CKbQgpPqfGT1BEmtpbjmdF4oLj1BZPhFLT1St2RfzfriY7HRAFwumYKNjC5m83
         w1qpe7EsrWmPoRlPN9mzfRnXeayusZnYRmwM088R5yKHqXfBRfutCS2jX+msex8UIoch
         svmg==
X-Gm-Message-State: ALoCoQnSCJiVOdfv00fPHvQBbwgQT4FjFfeD944o2Y/iwtJFqzcIkZQVC6UwtndrvlIUiKC9JpGa
X-Received: by 10.152.27.134 with SMTP id t6mr7275040lag.41.1400251669289;
        Fri, 16 May 2014 07:47:49 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id o1sm8684320lbw.27.2014.05.16.07.47.47
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 16 May 2014 07:47:48 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400251578-17221-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249314>

A patch file consists of:

(1) the description
(2) optional diffstat
(3) the patches

When extracting the patch, we only want part 3.  The do_get_patch used
to give us part 2 and part 3.  That made for instance this series of
operations fail if guilt.diffstat is true:

    $ guilt new empty-1
    $ guilt new empty-2
    $ guilt pop
    Now at empty-1
    $ guilt fold empty-2
    $ guilt pop
    All patches popped.
    $ guilt push
    Applying patch..empty-1
    fatal: unrecognized input
    To force apply this patch, use 'guilt push -f'

Signed-off-by: Per Cederqvist <cederp@opera.com>
Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
---
 guilt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/guilt b/guilt
index 8701481..3fc524e 100755
--- a/guilt
+++ b/guilt
@@ -334,7 +334,7 @@ do_get_patch()
 {
 	awk '
 BEGIN{}
-/^(diff |---$|--- )/ {patch = 1}
+/^(diff |--- )/ {patch = 1}
 patch == 1 {print $0}
 END{}
 ' < "$1"
-- 
1.8.3.1
