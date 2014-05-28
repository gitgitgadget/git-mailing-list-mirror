From: Pasha Bolokhov <pasha.bolokhov@gmail.com>
Subject: [PATCH] Improve function dir.c:trim_trailing_spaces()
Date: Wed, 28 May 2014 16:45:57 -0700
Message-ID: <1401320757-9360-1-git-send-email-pasha.bolokhov@gmail.com>
Cc: pclouds@gmail.com, Pasha Bolokhov <pasha.bolokhov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 29 01:46:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpnXz-0004St-93
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 01:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043AbaE1XqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 19:46:11 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:46722 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932AbaE1XqL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 19:46:11 -0400
Received: by mail-pa0-f47.google.com with SMTP id lf10so11845898pab.20
        for <git@vger.kernel.org>; Wed, 28 May 2014 16:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=gYHdCPnXxgKaYhmqoPExpvOCNnA+jucuDEiTXOdapX8=;
        b=r6DoJktyos4myNnp+EuN1id8zzTXo63yJdwc+BJAu2A6sBm8al+i88m+w75wFyfT47
         07Sqi8hEK1pKTvN9YIyFW5TglIyex4K4DFeYNqBmFC4PJYsswT1NmAuJq5eBO2YUYE4f
         SfuXaIe3Yj5pTlqB2U1A/RTfq/5/rYAz87hP0ijkf04byLq6+T9DUa7784+CBYzh11N7
         CjmFUCteGwsabQwpR9cbxgBaAlsbzSnDqyDsq2hyLXuHznOZj1cgSjD1LTY1x7kWpRD1
         dhHPHI0XHmKPU86uaIUMCshpY2E4I03qYAaPScbPb1/Mgo/ev3keWDZ9cNsYWJ8Cakzq
         QC5A==
X-Received: by 10.68.132.9 with SMTP id oq9mr3531405pbb.103.1401320770346;
        Wed, 28 May 2014 16:46:10 -0700 (PDT)
Received: from ani.gv.shawcable.net (S0106586d8f8ca92a.gv.shawcable.net. [96.54.196.148])
        by mx.google.com with ESMTPSA id se3sm30218009pbb.80.2014.05.28.16.46.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 May 2014 16:46:09 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250346>

Move backwards from the end of the string (more efficient for
lines which do not have trailing spaces or have just a couple).
Slightly more rare occurrences of 'text  \    ' with a backslash
in between spaces are handled correctly.
Namely, the code in 8ba87adad6 does not reset 'last_space' when
a backslash is encountered and the above line stays intact as
a result
---
How about trailing tabs?

 dir.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/dir.c b/dir.c
index eb6f581..3315eea 100644
--- a/dir.c
+++ b/dir.c
@@ -508,21 +508,18 @@ void clear_exclude_list(struct exclude_list *el)
 
 static void trim_trailing_spaces(char *buf)
 {
-	int i, last_space = -1, nr_spaces, len = strlen(buf);
-	for (i = 0; i < len; i++)
-		if (buf[i] == '\\')
-			i++;
-		else if (buf[i] == ' ') {
-			if (last_space == -1) {
-				last_space = i;
-				nr_spaces = 1;
-			} else
-				nr_spaces++;
-		} else
-			last_space = -1;
-
-	if (last_space != -1 && last_space + nr_spaces == len)
+	int i, last_space, bslash = 0, len = strlen(buf);
+
+	if (len == 0 || buf[len - 1] != ' ')
+		return;
+	for (i = len - 2; i >= 0 && buf[i] == ' '; i--) ;
+	last_space = i + 1;
+	for ( ; i >=0 && buf[i] == '\\'; i--) bslash ^= 1;
+
+	if (!bslash)
 		buf[last_space] = '\0';
+	else if (bslash && last_space < len - 1)
+		buf[last_space + 1] = '\0';
 }
 
 int add_excludes_from_file_to_list(const char *fname,
-- 
1.9.1
