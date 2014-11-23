From: Alex Kuleshov <kuleshovmail@gmail.com>
Subject: Re: [PATCH] exec_cmd: system_path memory leak fix
Date: Mon, 24 Nov 2014 01:19:29 +0600
Message-ID: <87sih9en65.fsf@gmail.com>
References: <1416750981-24446-1-git-send-email-kuleshovmail@gmail.com> <1416750981-24446-2-git-send-email-kuleshovmail@gmail.com> <xmqqioi5ycme.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 23 20:23:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xscl3-0003DX-3i
	for gcvg-git-2@plane.gmane.org; Sun, 23 Nov 2014 20:23:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbaKWTXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Nov 2014 14:23:37 -0500
Received: from mail-lb0-f170.google.com ([209.85.217.170]:34329 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273AbaKWTXg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Nov 2014 14:23:36 -0500
Received: by mail-lb0-f170.google.com with SMTP id w7so6461232lbi.15
        for <git@vger.kernel.org>; Sun, 23 Nov 2014 11:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=references:from:to:cc:subject:date:in-reply-to:message-id
         :mime-version:content-type;
        bh=GLs4UAeS/pzDzQAApafODJfC6+zekxUULO4MM8YpefY=;
        b=pbdZmqML89n1Qxwa0NnB/cqj6Aceb8TamQRyVbTKG/O3grYMkHIYkDIdNs4DmTsKKp
         Ve5rJ9/tIjrH5pq85jr3T54pXnZMK/ZdYO7hi0F0Zu61l4jWuKDeNOpaRlf+o5q9L/pk
         WGNROeqYsOQ4l2yxbwFQWV+j80HTfTvpLWfnJBBu8w66WrF41BDlWmtKrY5DS/ti5Q1E
         Q60YhaCpW/9ebPkpijUmWVi0mAUZ+Kxk0YOWa0wwr4GXmVtgs/QsnAyBBSFR5/faAuyS
         RoF7GOBn+NB44PUdqloBaWG4JHr8PjU/GCAbtaLDtoiQddfVBQOaI47fjxpHQAz8/fbe
         fOaw==
X-Received: by 10.152.204.9 with SMTP id ku9mr16639880lac.55.1416770614657;
        Sun, 23 Nov 2014 11:23:34 -0800 (PST)
Received: from alex-desktop ([92.46.104.67])
        by mx.google.com with ESMTPSA id n6sm2942191laj.16.2014.11.23.11.23.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Nov 2014 11:23:33 -0800 (PST)
In-reply-to: <xmqqioi5ycme.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260099>


Signed-off-by: Alex Kuleshov <kuleshovmail@gmail.com>
---
 exec_cmd.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index 698e752..7ed9bcc 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -13,7 +13,7 @@ const char *system_path(const char *path)
 #else
 	static const char *prefix = PREFIX;
 #endif
-	struct strbuf d = STRBUF_INIT;
+	static struct strbuf d = STRBUF_INIT;

 	if (is_absolute_path(path))
 		return path;
@@ -34,8 +34,7 @@ const char *system_path(const char *path)
 #endif

 	strbuf_addf(&d, "%s/%s", prefix, path);
-	path = strbuf_detach(&d, NULL);
-	return path;
+	return d.buf;
 }

 const char *git_extract_argv0_path(const char *argv0)
@@ -94,7 +93,7 @@ static void add_path(struct strbuf *out, const char *path)
 void setup_path(void)
 {
 	const char *old_path = getenv("PATH");
-	struct strbuf new_path = STRBUF_INIT;
+	static struct strbuf new_path = STRBUF_INIT;

 	add_path(&new_path, git_exec_path());
 	add_path(&new_path, argv0_path);
--
2.2.0.rc3.190.g952f0aa.dirty
