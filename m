From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 4/9] mailmap: do not downcase mailmap entries
Date: Mon, 15 Jul 2013 02:54:08 -0400
Message-ID: <1373871253-96480-5-git-send-email-sunshine@sunshineco.com>
References: <1373871253-96480-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 15 08:54:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UycgL-0003xn-OZ
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 08:54:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754127Ab3GOGyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 02:54:46 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:64021 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753Ab3GOGyp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 02:54:45 -0400
Received: by mail-ie0-f170.google.com with SMTP id e11so25424024iej.1
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 23:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=ZiIdIaDsdQ8PIJeMRCC7LDkSUhwqvSIjRjR/WUfi8cs=;
        b=pnQApAqnzVMKJ+a4Tv3gDBHvwD4ZydH37Y5Rmv0E62CVnEswy34qYJMXgiz8FX0sMM
         6DTCt3Tm9mHkJ4WOUF5XwPVR+aSWZsAVlfSjWJ66A26gm2iqRs3lZFMVXhRGQ4UYZNeP
         F8W9n4dQUu9wDRDq41xDPDUZPHkOeMb+YTa1k2rENjOaoxZIafuk8Ugskjb2YjcUbZ7e
         0TCVMbN6g6rtVWysyngbSHWD1lGA/JN+pUY7QvQT+djtiERswsxklEqA5+sc+Qqml+Tc
         MRXC+7vW62z05GtAjMt1z7465gX+2JeoM7EeOpjfew47cbWFpy/1eQSWGuhKMm4CGRNm
         INCg==
X-Received: by 10.50.176.131 with SMTP id ci3mr6291623igc.18.1373871285336;
        Sun, 14 Jul 2013 23:54:45 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id y9sm16781487iga.9.2013.07.14.23.54.43
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 23:54:44 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.804.g0da7a53
In-Reply-To: <1373871253-96480-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230429>

From: Junio C Hamano <gitster@pobox.com>

The email addresses in the records read from the .mailmap file are
downcased very early, and then used to match against e-mail
addresses in the input.  Because we do use case insensitive version
of string list to manage these entries, there is no need to do this,
and worse yet, downcasing the rewritten/canonical e-mail read from
the .mailmap file loses information.

Stop doing that, and also make the string list used to keep multiple
names for an mailmap entry case insensitive (the code that uses the
list, lookup_prefix(), expects a case insensitive match).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 mailmap.c          | 20 ++++++++------------
 t/t4203-mailmap.sh |  2 +-
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/mailmap.c b/mailmap.c
index 418081e..a7e92db 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -51,14 +51,6 @@ static void add_mapping(struct string_list *map,
 {
 	struct mailmap_entry *me;
 	int index;
-	char *p;
-
-	if (old_email)
-		for (p = old_email; *p; p++)
-			*p = tolower(*p);
-	if (new_email)
-		for (p = new_email; *p; p++)
-			*p = tolower(*p);
 
 	if (old_email == NULL) {
 		old_email = new_email;
@@ -68,13 +60,17 @@ static void add_mapping(struct string_list *map,
 	if ((index = string_list_find_insert_index(map, old_email, 1)) < 0) {
 		/* mailmap entry exists, invert index value */
 		index = -1 - index;
+		me = (struct mailmap_entry *)map->items[index].util;
 	} else {
 		/* create mailmap entry */
-		struct string_list_item *item = string_list_insert_at_index(map, index, old_email);
-		item->util = xcalloc(1, sizeof(struct mailmap_entry));
-		((struct mailmap_entry *)item->util)->namemap.strdup_strings = 1;
+		struct string_list_item *item;
+
+		item = string_list_insert_at_index(map, index, old_email);
+		me = xcalloc(1, sizeof(struct mailmap_entry));
+		me->namemap.strdup_strings = 1;
+		me->namemap.cmp = strcasecmp;
+		item->util = me;
 	}
-	me = (struct mailmap_entry *)map->items[index].util;
 
 	if (old_name == NULL) {
 		debug_mm("mailmap: adding (simple) entry for %s at index %d\n", old_email, index);
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index ffe6a11..c32df80 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -256,7 +256,7 @@ test_expect_success 'single-character name' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'preserve canonical email case' '
+test_expect_success 'preserve canonical email case' '
 	echo "     1	A U Thor <AUTHOR@example.com>" >expect &&
 	echo "     1	nick1 <bugs@company.xx>" >>expect &&
 	echo "<AUTHOR@example.com> <author@example.com>" >.mailmap &&
-- 
1.8.3.2.804.g0da7a53
