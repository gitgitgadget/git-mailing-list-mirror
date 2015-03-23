From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] read-cache.c: fix a memleak in add_to_index
Date: Mon, 23 Mar 2015 10:57:12 -0700
Message-ID: <1427133432-26703-2-git-send-email-sbeller@google.com>
References: <CAGZ79kY=b3=ppmB+eJOAgcUec7hq+ycJiCvBzkTc7U78Mgog_g@mail.gmail.com>
 <1427133432-26703-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 23 18:57:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ya6bV-0005wu-AJ
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 18:57:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896AbbCWR50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2015 13:57:26 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:35686 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752862AbbCWR5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2015 13:57:16 -0400
Received: by igcau2 with SMTP id au2so49752623igc.0
        for <git@vger.kernel.org>; Mon, 23 Mar 2015 10:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IWxqsXu+IJ59aDsZ/34OGG2cpOhDL+5VLW9Eqe9qsQM=;
        b=hSMqhFwK3IjVohGAQIf/IqmF8nhg0O0Ek487T+gekWC/yeC5TeNSPjDotllwB+pCrl
         bmfZTdo9U/ZhFQ1ozCVxgG6tclCRscL/TWDSTMbZay+eXBlqy99wkLuyZfZz7wJVVqsN
         O6jTf4cytnWTZASsem4eF4eWrtqV+8oOWFmHEGx27Hnm6uj/KJz+Q6IKLCAtHbNnC0HH
         7n/L5orXNKJngMLVHN5eo6jnnSBWDoSGaKKsMOvRjLwcbBYZ09dNN8dYSa1I8OnAElAs
         LurhRar30ltCRWhdpvgFj/xWkrcKngAyYUF48o7UWrK5i5dX67pXXiqEnSTr9EnjJiZd
         yZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IWxqsXu+IJ59aDsZ/34OGG2cpOhDL+5VLW9Eqe9qsQM=;
        b=PcVcCdjnqIg6MwjKWEudzczzXckMp4oPnDEd1b9pWE0NSYmP4RiJtTLR+Nctfiv9V0
         OsfhHjxUMXYfjnQdn3MfuN/OnJQKzs9YZNLH/r0SVw/vIliTXet5hSH+cyl7PFj6f7XM
         yKWqCWAWY7hvt56znWQ0ZBsr04w2rTcORJPCUxpLfVprzmcOTPp3gByLVF28Htu+GWFa
         CfMueEFSEjlZJp/SRf/Lk7FI2Lst8ktcpb4UYOUOmLrX3rTbIE/m9rmGwUtUoD/6yYz5
         CYaelpviDZfK8fTPeQUGlQ90cn3GpdRZvInkgcfHQElzJNeZv+2RDXHMwFutEo+x/MLF
         P6WA==
X-Gm-Message-State: ALoCoQmai7XJgqKYY1IcMblWBzLDvdqPAk1r4e1DrD6GdSckVwZOZjTd83DFAAnuJ3nHGJdo0T5q
X-Received: by 10.50.39.65 with SMTP id n1mr16244240igk.37.1427133435823;
        Mon, 23 Mar 2015 10:57:15 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:4d5:daa7:294c:bc0b])
        by mx.google.com with ESMTPSA id o35sm1038030ioi.17.2015.03.23.10.57.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 23 Mar 2015 10:57:15 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1427133432-26703-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266153>

Signed-off-by: Stefan Beller <sbeller@google.com>
---

 I have reread your remarks from the weekend, and I agree
 this looks more intuitive. Thanks for pointing out the subtle details
 to make programming an art!
 
 read-cache.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index a102565..f837212 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -706,10 +706,14 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 		    !hashcmp(alias->sha1, ce->sha1) &&
 		    ce->ce_mode == alias->ce_mode);
 
-	if (pretend)
-		;
-	else if (add_index_entry(istate, ce, add_option))
-		return error("unable to add %s to index",path);
+	if (!pretend) {
+		if (add_index_entry(istate, ce, add_option)) {
+			free(ce);
+			return error("unable to add %s to index",path);
+		}
+	} else {
+		free(ce);
+	}
 	if (verbose && !was_same)
 		printf("add '%s'\n", path);
 	return 0;
-- 
2.3.0.81.gc37f363
