From: Vasily Makarov <einmalfel@gmail.com>
Subject: [PATCH] get_octopus_merge_bases(): cleanup redundant variable
Date: Fri,  3 Jan 2014 18:45:46 +0400
Message-ID: <1388760346-19515-1-git-send-email-einmalfel@gmail.com>
Cc: vmiklos@frugalware.org, Vasily Makarov <einmalfel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 03 15:46:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vz60n-0008OK-NT
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jan 2014 15:46:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490AbaACOqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jan 2014 09:46:04 -0500
Received: from mail-la0-f54.google.com ([209.85.215.54]:41496 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861AbaACOqD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jan 2014 09:46:03 -0500
Received: by mail-la0-f54.google.com with SMTP id b8so8298466lan.27
        for <git@vger.kernel.org>; Fri, 03 Jan 2014 06:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=JVsBVbQrAxP4hWf/kUvi7/7+khwFHx7j3TX8ZWaM8kw=;
        b=zE1O42Tgax/f/XUSms07vACEQoMy4KHOykRF+xKjX6X2iSVbb/zWxmHgW4mEaC3PQl
         sT8Hi2Xo8jyXjmbV/SaVs8zB84kq8ZFw/eNLBo4QdnmJrFqNLSFxfy2WtsmvgnMgXsQZ
         ygZPiHV2ZdC1ZneJZI0F0OuMMjGhXLXiYZtqz5gH/KsmwpW9jHKC7y/GIUW2HFj3VSoc
         9PPBiRjaczf+rpreztQcZ4kligqzMLbqI2yiTOFsWQcPByZrh5f0NRcK0/qA7XHEgeJ2
         ZZnhtA+92VhVnbkA1lggP+uRv497T51ZhXJHzaMUXWW9UBotcl+saf3ecLDGApMyhfGp
         zRRA==
X-Received: by 10.112.128.226 with SMTP id nr2mr34531577lbb.17.1388760361550;
        Fri, 03 Jan 2014 06:46:01 -0800 (PST)
Received: from Ubuntu13.10Home ([176.195.187.45])
        by mx.google.com with ESMTPSA id np10sm36651794lbb.7.2014.01.03.06.46.00
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 03 Jan 2014 06:46:01 -0800 (PST)
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239913>

pptr is needless. Some related code got cleaned as well

Signed-off-by: Vasily Makarov <einmalfel@gmail.com>
---
 commit.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/commit.c b/commit.c
index de16a3c..4a7a192 100644
--- a/commit.c
+++ b/commit.c
@@ -834,26 +834,23 @@ static struct commit_list *merge_bases_many(struct commit *one, int n, struct co
 struct commit_list *get_octopus_merge_bases(struct commit_list *in)
 {
 	struct commit_list *i, *j, *k, *ret = NULL;
-	struct commit_list **pptr = &ret;
 
-	for (i = in; i; i = i->next) {
-		if (!ret)
-			pptr = &commit_list_insert(i->item, pptr)->next;
-		else {
-			struct commit_list *new = NULL, *end = NULL;
-
-			for (j = ret; j; j = j->next) {
-				struct commit_list *bases;
-				bases = get_merge_bases(i->item, j->item, 1);
-				if (!new)
-					new = bases;
-				else
-					end->next = bases;
-				for (k = bases; k; k = k->next)
-					end = k;
-			}
-			ret = new;
+	commit_list_insert(in->item, &ret);
+
+	for (i = in->next; i; i = i->next) {
+		struct commit_list *new = NULL, *end = NULL;
+
+		for (j = ret; j; j = j->next) {
+			struct commit_list *bases;
+			bases = get_merge_bases(i->item, j->item, 1);
+			if (!new)
+				new = bases;
+			else
+				end->next = bases;
+			for (k = bases; k; k = k->next)
+				end = k;
 		}
+		ret = new;
 	}
 	return ret;
 }
-- 
1.8.3.2
