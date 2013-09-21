From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] remote: fix trivial memory leak
Date: Sat, 21 Sep 2013 09:09:23 -0500
Message-ID: <1379772563-11000-3-git-send-email-felipe.contreras@gmail.com>
References: <1379772563-11000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 21 16:15:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNNxx-00011Z-Bn
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 16:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752395Ab3IUOPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Sep 2013 10:15:13 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:49341 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173Ab3IUOOy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 10:14:54 -0400
Received: by mail-ob0-f178.google.com with SMTP id uy5so1982198obc.9
        for <git@vger.kernel.org>; Sat, 21 Sep 2013 07:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PNSaGxy/OC2GligOEdt0H8MC+t89w3mG6mvyk0mfJEA=;
        b=EgCahDsb+izzlA5lv8Su/CApwvnFKQW8OM8MpGXROuWs1iraFAKqaC3GwwWEJxHGFe
         oKrnvU+qPV+IDgCRGMNi9wjHWgY46uLTjSxLLoGpuJWzp7Q0ZRXWGcFic66hwkqc6QRP
         h+0VvmLT6YrSvGeFD8C/Ovi/Q5xgY2sqkTj0Xc2x0SzItwRrGOjjHRpWYqAyCdOPw6zR
         cflNWp62pLZIBs2NuKWOqvLvgIjMOluFY/wwhpvnmu8vcq6UdPRB8pUDOmG3gI3tmfk6
         9fbuUTZrAcmAx0rnqKvB6CMFfNGrFEvSz1DqmYl37Gep7ixYx3KAtxMh1iWseyzStiV8
         hlgA==
X-Received: by 10.60.118.41 with SMTP id kj9mr1990962oeb.31.1379772893470;
        Sat, 21 Sep 2013 07:14:53 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id d3sm7500295oek.5.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 21 Sep 2013 07:14:52 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.2.gac946cf.dirty
In-Reply-To: <1379772563-11000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235121>

There's no need to set the default remote name beforehand, only to be
overridden later on, and causing a memory leak, we can do it after the
configuration has been handled.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 remote.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index efcba93..654e7f5 100644
--- a/remote.c
+++ b/remote.c
@@ -480,7 +480,6 @@ static void read_config(void)
 	int flag;
 	if (default_remote_name) /* did this already */
 		return;
-	default_remote_name = xstrdup("origin");
 	current_branch = NULL;
 	head_ref = resolve_ref_unsafe("HEAD", sha1, 0, &flag);
 	if (head_ref && (flag & REF_ISSYMREF) &&
@@ -489,6 +488,8 @@ static void read_config(void)
 			make_branch(head_ref + strlen("refs/heads/"), 0);
 	}
 	git_config(handle_config, NULL);
+	if (!default_remote_name)
+		default_remote_name = xstrdup("origin");
 	alias_all_urls();
 }
 
-- 
1.8.4.2.gac946cf.dirty
