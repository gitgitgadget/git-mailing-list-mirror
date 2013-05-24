From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/2] sha1_name: fix error message for @{<N>}, @{<date>}
Date: Fri, 24 May 2013 13:12:04 +0530
Message-ID: <1369381324-10206-3-git-send-email-artagnon@gmail.com>
References: <1369381324-10206-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 24 09:40:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ufmc6-0005JZ-Iw
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 09:40:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760005Ab3EXHkb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 03:40:31 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:60158 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759496Ab3EXHka (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 03:40:30 -0400
Received: by mail-pb0-f43.google.com with SMTP id ma3so3925377pbc.30
        for <git@vger.kernel.org>; Fri, 24 May 2013 00:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=qfeQM3B3LHDekg3ZWNvvj2lNiFgmhGNTx0faV4rjCw0=;
        b=fPs+BmjVzosuwWkCQk/m36baJnCspPpvhW036MQDuXUGw8s0zpspg3RF6hJDW7cuKQ
         aHiQJmxCZfkcN/MzS3tot/2xjloMBQ+Bx8Y0uLUJHTQp17lxld/PmdOaGNSYssGnkyQG
         WpmfNZwPgXSNHv6VqqXJCfsOuEBq2sbUMGty1is8x6PNLP1Rmt5OUGuvkWcXkNUkTCQ/
         1HIPR0lRRms5dvwg8Dlq4Na581WECgaSD6q1wt3PoPpEl9YC7Lu/FMfo2sD8lsqJZDgA
         0hFvaW9gXR63oke73CbIYOX/lDOegzpERAJW/ZbBMlHGJDAqu4vXu1KZ5o0l7JTHMq5h
         C7bA==
X-Received: by 10.66.240.70 with SMTP id vy6mr17363489pac.70.1369381228195;
        Fri, 24 May 2013 00:40:28 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id wt5sm15136412pbc.38.2013.05.24.00.40.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 24 May 2013 00:40:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.17.gd95ec6c.dirty
In-Reply-To: <1369381324-10206-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225332>

Currently, when we try to resolve @{<N>} or @{<date>} when the reflog
doesn't go back far enough, we get errors like:

  # on branch master
  $ git show @{10000}
  fatal: Log for '' only has 7 entries.

  $ git show @{10000.days.ago}
  warning: Log for '' only goes back to Tue, 21 May 2013 14:14:45 +0530.
  ...

  # detached HEAD case
  $ git show @{10000}
  fatal: Log for '' only has 2005 entries.

  $ git show master@{10000}
  fatal: Log for 'master' only has 7 entries.

The empty string '' is ugly, inconsistent, and fails to convey
information about whose logs we are inspecting.  Change this so that we
get:

  # on branch master
  $ git show @{10000}
  fatal: Log for 'master' only has 7 entries.

  $ git show @{10000.days.ago}
  warning: Log for 'master' only goes back to Tue, 21 May 2013 14:14:45 +0530.
  ...

  # detached HEAD case
  $ git show @{10000}
  fatal: Log for 'HEAD' only has 2005 entries.

  $ git show master@{10000}
  fatal: Log for 'master' only has 7 entries.

Simple, consistent, and informative; suitable for output even from
plumbing commands like rev-parse.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 sha1_name.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sha1_name.c b/sha1_name.c
index 61f5a34..6928cc7 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -517,6 +517,16 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 		}
 		if (read_ref_at(real_ref, at_time, nth, sha1, NULL,
 				&co_time, &co_tz, &co_cnt)) {
+			if (!len) {
+				if (!prefixcmp(real_ref, "refs/heads/")) {
+					str = real_ref + 11;
+					len = strlen(real_ref + 11);
+				} else {
+					/* detached HEAD */
+					str = "HEAD";
+					len = 4;
+				}
+			}
 			if (at_time)
 				warning("Log for '%.*s' only goes "
 					"back to %s.", len, str,
-- 
1.8.3.rc3.17.gd95ec6c.dirty
