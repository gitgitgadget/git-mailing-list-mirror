From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/3] for-each-ref: introduce %(HEAD) asterisk marker
Date: Thu, 31 Oct 2013 15:16:13 +0530
Message-ID: <1383212774-5232-3-git-send-email-artagnon@gmail.com>
References: <1383212774-5232-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 31 10:54:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vboxd-0007tT-EF
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 10:54:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753050Ab3JaJya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 05:54:30 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:41115 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807Ab3JaJy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 05:54:29 -0400
Received: by mail-pd0-f178.google.com with SMTP id x10so2133141pdj.23
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 02:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=lHnugcrcn8dyw+k70i5Fm5T6E3gDk+bO4nI22scamdc=;
        b=e/jEt6VYPvbdbpHHhj1BSmUv2AdWhZQd4rYQR+NlBXhlu2gCnVkJzXu98pP6DImkNM
         AdGRWbtGx3bigJ1yU3mXA0z3xZUy5M8bOIkDVOcgRCVhr1EX467fp617zspMwIEUrXah
         1hOk0qqDCIdWdL85+OO9FNuylQIJv6jCwp7m92S0ah5JuO/OENgHJAb7r5PqjCzkLjSE
         O0jFseARS8V70b/ZtYVZF+th6PmPohqw39kMYYJ4QYNbObwKxQUZ9Q2iM6erDMaue9wd
         Jff810Qv9aHe5E9YG6Vyp1WRJ1bxmGFplGBMGUE3GbiPHPvdJHusBNJsZ6SJNGxp2f6i
         ybWw==
X-Received: by 10.66.136.71 with SMTP id py7mr2924270pab.2.1383213268549;
        Thu, 31 Oct 2013 02:54:28 -0700 (PDT)
Received: from localhost.localdomain ([122.164.233.197])
        by mx.google.com with ESMTPSA id i10sm4106533pat.11.2013.10.31.02.54.26
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2013 02:54:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.5.rc0.3.gb488857
In-Reply-To: <1383212774-5232-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237116>

'git branch' shows which branch you are currently on with an '*', but
'git for-each-ref' misses this feature.  So, extend its format with
%(HEAD) for the same effect.

Now you can use the following format in for-each-ref:

  %C(red)%(HEAD)%C(reset) %(refname:short)

to display a red asterisk next to the current ref.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-for-each-ref.txt |  4 ++++
 builtin/for-each-ref.c             | 13 +++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 6fa4464..bb9c4c1 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -95,6 +95,10 @@ upstream::
 	from the displayed ref. Respects `:short` in the same way as
 	`refname` above.
 
+HEAD::
+	Used to indicate the currently checked out branch.  Is '*' if
+	HEAD points to the current ref, and ' ' otherwise.
+
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
 be used to specify the value in the header field.
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 6da2903..b841545 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -76,6 +76,7 @@ static struct {
 	{ "upstream" },
 	{ "symref" },
 	{ "flag" },
+	{ "HEAD" },
 };
 
 /*
@@ -682,8 +683,16 @@ static void populate_value(struct refinfo *ref)
 				v->s = xstrdup(buf + 1);
 			}
 			continue;
-		}
-		else
+		} else if (!strcmp(name, "HEAD")) {
+			const char *head;
+			unsigned char sha1[20];
+			head = resolve_ref_unsafe("HEAD", sha1, 1, NULL);
+			if (!strcmp(ref->refname, head))
+				v->s = "*";
+			else
+				v->s = " ";
+			continue;
+		} else
 			continue;
 
 		formatp = strchr(name, ':');
-- 
1.8.5.rc0.3.gb488857
