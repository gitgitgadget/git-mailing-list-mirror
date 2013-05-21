From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/2] sha1_name: fix error message for @{<N>}, @{<date>}
Date: Tue, 21 May 2013 16:11:55 +0530
Message-ID: <1369132915-25657-3-git-send-email-artagnon@gmail.com>
References: <1369132915-25657-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 21 12:40:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uejzj-0008DL-MM
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 12:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752975Ab3EUKk0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 06:40:26 -0400
Received: from mail-da0-f44.google.com ([209.85.210.44]:56556 "EHLO
	mail-da0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945Ab3EUKkS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 06:40:18 -0400
Received: by mail-da0-f44.google.com with SMTP id z8so338606daj.17
        for <git@vger.kernel.org>; Tue, 21 May 2013 03:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=vjFpGPVHc95l68H4nHhNCYuIrsx+Ia6AnvjqCz/14+A=;
        b=GDqZrZ0eW9qKUqZii3KXqeCKs1oi3mgnXq+yM1WFCXyHSrEArsPQChp03UQ9LcezXu
         wUzNVTwPjqT6PBaLIw181/leRqP39iVhVXEjTsrGTfujZXHPbTf6RS1V9tbwdmZKl2x6
         EcyonxZbK4Pzgy/MO+AYD53sThq8qJ8Y29urYD62U/JJvqU1dMNUMIDhVuYA5j5oL3C2
         lxOFodtsSO4Fk7Pt1SiVwVDategiLQ3p2WRSKaCulo8Xr+imwXIfLv+Vz5RbSiekopto
         8i4h6nTcHk4H9CtsS3A+0Df6FotUnwxFarxH0LL3g0y4y3NblY5Dk+1OM+82eSMJLjr5
         kpwg==
X-Received: by 10.66.246.131 with SMTP id xw3mr2485902pac.114.1369132817824;
        Tue, 21 May 2013 03:40:17 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id cp1sm2198426pbc.42.2013.05.21.03.40.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 21 May 2013 03:40:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.6.ga9126d5.dirty
In-Reply-To: <1369132915-25657-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225027>

Currently, when we try to resolve @{<N>} or @{<date>} when the reflog
for the current branch doesn't go back far enough, we get errors like:

  $ git show @{10000}
  fatal: Log for '' only has 7 entries.

  $ git show @{10000.days.ago}
  warning: Log for '' only goes back to Tue, 21 May 2013 14:14:45 +0530.
  ...

The empty string '' looks ugly and inconsistent with the output of
<branch>@{<N>}.  Replace it with the string 'current branch'.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 sha1_name.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sha1_name.c b/sha1_name.c
index 416a673..683b4bd 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -517,6 +517,10 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 		}
 		if (read_ref_at(real_ref, at_time, nth, sha1, NULL,
 				&co_time, &co_tz, &co_cnt)) {
+			if (!len) {
+				str = "current branch";
+				len = strlen("current branch");
+			}
 			if (at_time)
 				warning("Log for '%.*s' only goes "
 					"back to %s.", len, str,
-- 
1.8.3.rc3.6.ga9126d5.dirty
