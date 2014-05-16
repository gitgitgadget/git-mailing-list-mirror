From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v3 24/31] disp no longer processes backslashes.
Date: Fri, 16 May 2014 16:46:11 +0200
Message-ID: <1400251578-17221-25-git-send-email-cederp@opera.com>
References: <1400251578-17221-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri May 16 16:55:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlJY8-0001UE-3C
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 16:55:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbaEPOzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 10:55:48 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:46325 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932296AbaEPOzr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 10:55:47 -0400
Received: by mail-lb0-f170.google.com with SMTP id w7so2035977lbi.29
        for <git@vger.kernel.org>; Fri, 16 May 2014 07:55:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lAbEUY8+er2z65kn+kcKC8txHNfZEMD9CG+VNH1V4NY=;
        b=WYwVjy8OPdhSFgCvvPcKvlMr+PMJq8PfrgeHEReCz3YoaP2SRrNueP6C97Hn41xzcC
         TNXalv96dpD+bpFgOx477RcgMHLl1v6onXjjHAFt95DomPXD7M+lB/ofKjSySPOyAKgS
         /pwOClJSs/ldZvFuoVFxJXNyVgD/b46FDZBpUJfLHXFGpO1Jv06vOvPSSgSNyjOP5qsB
         xJKJh90a6k+VNmc9KVr/XLecIUgOBJCDRZCz5Moc8q2IztIBWeUz9gyj/CFiONY90fFH
         YZFHjgrr/d2WqjANluuCOGUAJXDjHIq3lB+pqrB+7jaJAUP0vYU873jde9tp6FW8rUrx
         8ChQ==
X-Gm-Message-State: ALoCoQnFplW5Xc0cLRyfrBvE7G/T6GtaAVcueCf+aJVnZSE+lxjARx6ROQ5JQPYSuSOStJHAI8BZ
X-Received: by 10.112.77.166 with SMTP id t6mr2200707lbw.53.1400252145901;
        Fri, 16 May 2014 07:55:45 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id o1sm8684320lbw.27.2014.05.16.07.55.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 16 May 2014 07:55:45 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400251578-17221-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249333>

Only one invocation of "disp" or "_disp" actually needed backslash
processing.  In quite a few instances, it was wrong to do backslash
processing, as the message contained data derived from the user.

Created the new function "disp_e" that should be used when backslash
processing is required, and changed "disp" and "_disp" to use printf
code "%s" instead of "%b".

Signed-off-by: Per Cederqvist <cederp@opera.com>
Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
---
 guilt | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/guilt b/guilt
index 23cc2da..9947acc 100755
--- a/guilt
+++ b/guilt
@@ -36,15 +36,24 @@ usage()
 	exit 1
 }
 
-# echo -n is a bashism, use printf instead
+# Print arguments, but no trailing newline.
+# (echo -n is a bashism, use printf instead)
 _disp()
 {
-	printf "%b" "$*"
+	printf "%s" "$*"
 }
 
-# echo -e is a bashism, use printf instead
+# Print arguments.
+# (echo -E is a bashism, use printf instead)
 disp()
 {
+	printf "%s\n" "$*"
+}
+
+# Print arguments, processing backslash sequences.
+# (echo -e is a bashism, use printf instead)
+disp_e()
+{
 	printf "%b\n" "$*"
 }
 
@@ -117,7 +126,7 @@ else
 
 	disp ""
 	disp "Example:"
-	disp "\tguilt push"
+	disp_e "\tguilt push"
 
 	# now, let's exit
 	exit 1
-- 
1.8.3.1
