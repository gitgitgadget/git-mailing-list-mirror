From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 05/20] remote: fix trivial memory leak
Date: Sat, 12 Oct 2013 02:07:07 -0500
Message-ID: <1381561636-20717-12-git-send-email-felipe.contreras@gmail.com>
References: <1381561636-20717-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:13:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtOY-0005ob-TE
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754728Ab3JLHNq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:13:46 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:38311 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754630Ab3JLHNp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:13:45 -0400
Received: by mail-ob0-f171.google.com with SMTP id uy5so3458376obc.2
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yqg02RfK7mGNwJUsMf29A6dek/C1fbLy8Zbdfz9Evq4=;
        b=CsQCKU2Lcbw71rQxrVIzGlKCv3X8bzSloQz+6FW7nsi/rr4gGCFV/xbN86LVNgxitU
         rTUHjE7qC803yVWJRSob1jCJw8Z/opxEn5z5zkiQTULQgdySiDgFaN/XkBy1uuqnwARS
         ekIIwbTgAG6tr9mtVtOUFobYu/9stmB04Wp6G6cNoUZebMYeGYOcNKHRRqapaDqdNyvH
         fJkGyY8w41F7g4qLPMU9lNi0B/GbOU9z+ZGkfTA0VRS7KQUh/P8h8sRjfgkDtYl+bOxA
         9gTP1fIOW/fM++YK6UELfUOxc9wayUhy3cd/2Y0a2cEEQ1BWfQV6RKOMZxmh5zzuCfcA
         O4gw==
X-Received: by 10.182.34.194 with SMTP id b2mr963455obj.41.1381562024933;
        Sat, 12 Oct 2013 00:13:44 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id ru3sm28639422obc.2.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:13:44 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561636-20717-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236018>

There's no need to set the default remote name beforehand, only to be
overridden later on, and causing a memory leak, we can do it after the
configuration has been handled.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 remote.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index e9fedfa..ce9d82a 100644
--- a/remote.c
+++ b/remote.c
@@ -483,7 +483,6 @@ static void read_config(void)
 	int flag;
 	if (default_remote_name) /* did this already */
 		return;
-	default_remote_name = xstrdup("origin");
 	current_branch = NULL;
 	head_ref = resolve_ref_unsafe("HEAD", sha1, 0, &flag);
 	if (head_ref && (flag & REF_ISSYMREF) &&
@@ -492,6 +491,8 @@ static void read_config(void)
 			make_branch(head_ref + strlen("refs/heads/"), 0);
 	}
 	git_config(handle_config, NULL);
+	if (!default_remote_name)
+		default_remote_name = xstrdup("origin");
 	alias_all_urls();
 }
 
-- 
1.8.4-fc
