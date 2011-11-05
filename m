From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 2/3] fast-export: do not refer to non-existing marks
Date: Sun,  6 Nov 2011 00:23:26 +0100
Message-ID: <1320535407-4933-3-git-send-email-srabbelier@gmail.com>
References: <1320535407-4933-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sun Nov 06 00:25:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMpcT-0001pt-AY
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 00:25:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570Ab1KEXZe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Nov 2011 19:25:34 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:51987 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954Ab1KEXZd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 19:25:33 -0400
Received: by mail-ey0-f174.google.com with SMTP id 27so2888126eye.19
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 16:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=4SpL3qUWJBKtI4YgCZHQh7nA1ExiHj/itxbIYVNWOew=;
        b=gHIt5/ck8P7dM3SaQfz32NjE8tzFvQVeNB70aewmerqjGliEAskIen+swLDMuYs0OS
         qZ8g85fCsqBDbI1ueoeWIRczc6V65i7M0t1g2ixTTT+MFGyq6kHMwGFaklY2r1mWbDYZ
         gfe1ikduFTLZOaOspJRB0YknrH3Kds77sIyHo=
Received: by 10.213.12.212 with SMTP id y20mr1982010eby.90.1320535532523;
        Sat, 05 Nov 2011 16:25:32 -0700 (PDT)
Received: from laptop-sverre.lijbrandt.nl ([188.142.63.148])
        by mx.google.com with ESMTPS id v3sm37271459eej.7.2011.11.05.16.25.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Nov 2011 16:25:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.rc0.36.g67522.dirty
In-Reply-To: <1320535407-4933-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184875>

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>

When calling `git fast-export a..a b` when a and b refer to the same
commit, nothing would be exported, and an incorrect reset line would
be printed for b ('from :0').

Extract a handle_reset function that deals with this, which can then
be re-used in a later commit.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---
 builtin/fast-export.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 9836e6b..c4c4391 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -529,9 +529,20 @@ static void get_tags_and_duplicates(struct object_array *pending,
 	}
 }
 
+static void handle_reset(const char *name, struct object *object)
+{
+	int mark = get_object_mark(object);
+
+	if (mark)
+		printf("reset %s\nfrom :%d\n\n", name,
+		       get_object_mark(object));
+	else
+		printf("reset %s\nfrom %s\n\n", name,
+		       sha1_to_hex(object->sha1));
+}
+
 static void handle_tags_and_duplicates(struct string_list *extra_refs)
 {
-	struct commit *commit;
 	int i;
 
 	for (i = extra_refs->nr - 1; i >= 0; i--) {
@@ -543,9 +554,7 @@ static void handle_tags_and_duplicates(struct string_list *extra_refs)
 			break;
 		case OBJ_COMMIT:
 			/* create refs pointing to already seen commits */
-			commit = (struct commit *)object;
-			printf("reset %s\nfrom :%d\n\n", name,
-			       get_object_mark(&commit->object));
+			handle_reset(name, object);
 			show_progress();
 			break;
 		}
-- 
1.7.8.rc0.36.g67522.dirty
