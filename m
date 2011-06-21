From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 01/13] advice: Introduce error_resolve_conflict
Date: Tue, 21 Jun 2011 13:04:37 +0000
Message-ID: <1308661489-20080-2-git-send-email-artagnon@gmail.com>
References: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 21 15:05:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ0da-0005k6-Dt
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 15:05:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756496Ab1FUNE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 09:04:57 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37268 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755165Ab1FUNEz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 09:04:55 -0400
Received: by vws1 with SMTP id 1so1674206vws.19
        for <git@vger.kernel.org>; Tue, 21 Jun 2011 06:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=c0/vcfPuuDPkeN8qv6ED3h/YfAE0imcBvwhph7Xc/po=;
        b=hdcyLFkqJG2OZ4JS4/rxMA/ObwWS7Z2BtVtnh3olrJh48JooqnznaGvpRXKknokWZU
         d2IQuE1Mwtt67zh6fhjw3CgPs1B8imVOEmYYOQQLDkyagB3Y7jJz04i7k6qI+rtkFg0Y
         21DcwLoQqCddX7cGUwjXb93nyrnUISH8B7JaU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=sx/ePF1JVJhpVEvrTIPEzs8lD3lUpu2llf2kviGbF+fO4Sjpn2fqtWlR5EPp5Ol3gD
         SxHt6vlTgAFTXp6/ZZPQlZXGYBr6/OdO3G9shSdyw5nxG8iZMM9rnkE0jDqTAviNN6d6
         vpvFvO434plCN/yzYs88xPs4a+ISMEXT0n/L0=
Received: by 10.52.117.162 with SMTP id kf2mr2928654vdb.290.1308661494874;
        Tue, 21 Jun 2011 06:04:54 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id k9sm1575853vbn.0.2011.06.21.06.04.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 21 Jun 2011 06:04:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176140>

Introduce error_resolve_conflict corresponding to
die_resolve_conflict, and implement the latter function in terms of
the former.  The only trade-off is that die_resolve_conflict is a
little noisier now.

Inspired-by: Christian Couder <chistian.couder@gmail.com>
Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 advice.c |   19 +++++++++++++------
 advice.h |    1 +
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/advice.c b/advice.c
index 0be4b5f..652680a 100644
--- a/advice.c
+++ b/advice.c
@@ -34,16 +34,23 @@ int git_default_advice_config(const char *var, const char *value)
 	return 0;
 }
 
-void NORETURN die_resolve_conflict(const char *me)
+int error_resolve_conflict(const char *me)
 {
+	error("'%s' is not possible because you have unmerged files.", me);
 	if (advice_resolve_conflict)
 		/*
 		 * Message used both when 'git commit' fails and when
 		 * other commands doing a merge do.
 		 */
-		die("'%s' is not possible because you have unmerged files.\n"
-		    "Please, fix them up in the work tree, and then use 'git add/rm <file>' as\n"
-		    "appropriate to mark resolution and make a commit, or use 'git commit -a'.", me);
-	else
-		die("'%s' is not possible because you have unmerged files.", me);
+		return error("Please, fix them up in the work tree, "
+			"and then use 'git add/rm <file>' as\n"
+			"appropriate to mark resolution and make a commit, "
+			"or use 'git commit -a'.");
+	return -1;
+}
+
+void NORETURN die_resolve_conflict(const char *me)
+{
+	error_resolve_conflict(me);
+	die("Exiting because of an unresolved conflict.");
 }
diff --git a/advice.h b/advice.h
index 3244ebb..f537366 100644
--- a/advice.h
+++ b/advice.h
@@ -12,6 +12,7 @@ extern int advice_detached_head;
 
 int git_default_advice_config(const char *var, const char *value);
 
+int error_resolve_conflict(const char *me);
 extern void NORETURN die_resolve_conflict(const char *me);
 
 #endif /* ADVICE_H */
-- 
1.7.5.GIT
