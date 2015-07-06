From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 20/23] worktree: extract basename computation to new function
Date: Mon,  6 Jul 2015 13:30:57 -0400
Message-ID: <1436203860-846-21-git-send-email-sunshine@sunshineco.com>
References: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 19:32:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCAFf-00083I-FC
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 19:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753626AbbGFRcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 13:32:15 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:34588 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754069AbbGFRbt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 13:31:49 -0400
Received: by igcsj18 with SMTP id sj18so240293801igc.1
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 10:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tbSQARcAT/D1rqZn4E0XltjBtfoOpbaZpa6cAcKB1ug=;
        b=aFrDA3UlSjdrqJOxlH3FvkXXcDF8j5FJFI00UNciVnDfbwXHXlPOdY2pfqSfIkvZ6b
         FQglOZVjBAnWEXfi7PsvnJJSy2QshzmiRmUHzGb5Vaa1mLUMLSu9ALankAypboZpmAk1
         b404Ow41tiPomrh7WuvUiNnhOf2L+dhb/1vIZ78J0Vf9+8zWIhZ7SITWX1Dhk+PCMwOl
         otLcDPB/5077Loa9KkIIzX1NwwTFRzDL5ZXgGUIlOPZoNCkxPQ9gcUliAw90gBT9bY7O
         oxlOyr9WzvQCThEnUGQdpx6cjdZJEvCSe7es718DSHmjxYmTB0DPve4H7q5yZG25R+vG
         LZgA==
X-Received: by 10.107.16.223 with SMTP id 92mr33802ioq.14.1436203908763;
        Mon, 06 Jul 2015 10:31:48 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id g18sm12861567iod.5.2015.07.06.10.31.47
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Jul 2015 10:31:48 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.197.g417e668
In-Reply-To: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273425>

A subsequent patch will also need to compute the basename of the new
worktree, so factor out this logic into a new function.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/worktree.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 04e6d0f..25fe25b 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -152,6 +152,25 @@ static void remove_junk_on_signal(int signo)
 	raise(signo);
 }
 
+static const char *worktree_basename(const char *path, int *olen)
+{
+	const char *name;
+	int len;
+
+	len = strlen(path);
+	while (len && is_dir_sep(path[len - 1]))
+		len--;
+
+	for (name = path + len - 1; name > path; name--)
+		if (is_dir_sep(*name)) {
+			name++;
+			break;
+		}
+
+	*olen = len;
+	return name;
+}
+
 static int add_worktree(const char *path, const char **child_argv)
 {
 	struct strbuf sb_git = STRBUF_INIT, sb_repo = STRBUF_INIT;
@@ -165,15 +184,7 @@ static int add_worktree(const char *path, const char **child_argv)
 	if (file_exists(path) && !is_empty_dir(path))
 		die(_("'%s' already exists"), path);
 
-	len = strlen(path);
-	while (len && is_dir_sep(path[len - 1]))
-		len--;
-
-	for (name = path + len - 1; name > path; name--)
-		if (is_dir_sep(*name)) {
-			name++;
-			break;
-		}
+	name = worktree_basename(path, &len);
 	strbuf_addstr(&sb_repo,
 		      git_path("worktrees/%.*s", (int)(path + len - name), name));
 	len = sb_repo.len;
-- 
2.5.0.rc1.197.g417e668
