From: Tom Grennan <tmgrennan@gmail.com>
Subject: [RFC/PATCH] tag: make list exclude !<pattern>
Date: Thu,  9 Feb 2012 11:43:36 -0800
Message-ID: <1328816616-18124-2-git-send-email-tmgrennan@gmail.com>
References: <1328816616-18124-1-git-send-email-tmgrennan@gmail.com>
Cc: gitster@pobox.com, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 20:43:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvZuO-0006Ep-5B
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 20:43:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758400Ab2BITnw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 14:43:52 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:37867 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754479Ab2BITnv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 14:43:51 -0500
Received: by qadc10 with SMTP id c10so4542443qad.19
        for <git@vger.kernel.org>; Thu, 09 Feb 2012 11:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=NOKxKTPXu+fdTi9s67fdXYyO62oJVj3hUmEmzhtdsDI=;
        b=b8kW97GpJsT/UsZTnlNGwHv8ztEXnfPSa/NWNBxNgX1Cbb8peI5YWiKIj1z2fetGhd
         xAKyX7qpdq5oCqcJHeQLRfV5n0MMk6UaIo7YFWHOUxUnfkOyKlXXW/UESUGczq9DY/ap
         L4UvMovbeyBrOej3CKMYypWGzs+Xp/72/CT4I=
Received: by 10.229.106.221 with SMTP id y29mr2012043qco.88.1328816630667;
        Thu, 09 Feb 2012 11:43:50 -0800 (PST)
Received: from tgrennan-laptop.lab.redback.com ([129.192.185.163])
        by mx.google.com with ESMTPS id c2sm7648970qao.15.2012.02.09.11.43.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 09 Feb 2012 11:43:50 -0800 (PST)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1328816616-18124-1-git-send-email-tmgrennan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190313>

Use the "!" prefix to ignore tags of the given pattern.
This has precedence over other matching patterns.
For example,

  $ git tag -l \!*-rc? v1.7.8*
  v1.7.8
  v1.7.8.1
  v1.7.8.2
  v1.7.8.3
  v1.7.8.4
  $ git tag -l v1.7.8* \!*-rc?
  v1.7.8
  v1.7.8.1
  v1.7.8.2
  v1.7.8.3
  v1.7.8.4

This is equivalent to,

  $ git tag -l v1.7.8* | grep -v '\-rc.'
  v1.7.8
  v1.7.8.1
  v1.7.8.2
  v1.7.8.3
  v1.7.8.4

Signed-off-by: Tom Grennan <tmgrennan@gmail.com>
---
 builtin/tag.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 31f02e8..b9ef718 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -32,13 +32,18 @@ struct tag_filter {
 
 static int match_pattern(const char **patterns, const char *ref)
 {
+	int ret;
+
 	/* no pattern means match everything */
 	if (!*patterns)
 		return 1;
-	for (; *patterns; patterns++)
-		if (!fnmatch(*patterns, ref, 0))
-			return 1;
-	return 0;
+	for (ret = 0; *patterns; patterns++)
+		if (**patterns == '!') {
+		    if (!fnmatch(*patterns+1, ref, 0))
+			    return 0;
+		} else if (!fnmatch(*patterns, ref, 0))
+			ret = 1;
+	return ret;
 }
 
 static int in_commit_list(const struct commit_list *want, struct commit *c)
-- 
1.7.8
