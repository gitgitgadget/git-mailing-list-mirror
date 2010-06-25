From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [PATCH v2 4/7] string_list: Fix argument order for
	string_list_insert_at_index
Date: Sat, 26 Jun 2010 00:41:36 +0100
Message-ID: <20100625234140.18927.40501.julian@quantumfyre.co.uk>
References: <20100625234110.18927.33169.julian@quantumfyre.co.uk>
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 26 01:55:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSIkF-0004gB-Bo
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 01:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756699Ab0FYXzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jun 2010 19:55:20 -0400
Received: from positron.quantumfyre.co.uk ([213.165.84.138]:39007 "EHLO
	positron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751969Ab0FYXzT (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jun 2010 19:55:19 -0400
X-Greylist: delayed 571 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Jun 2010 19:55:19 EDT
Received: from reaper.quantumfyre.co.uk (reaper.quantumfyre.co.uk [212.159.54.234])
	by positron.quantumfyre.co.uk (Postfix) with ESMTP id D1CDB819E7B0;
	Sat, 26 Jun 2010 01:20:43 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id C2E591EC129;
	Sat, 26 Jun 2010 00:45:45 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id EosoAAO5aRfK; Sat, 26 Jun 2010 00:45:45 +0100 (BST)
Received: from rayne.quantumfyre.co.uk (rayne.quantumfyre.co.uk [192.168.0.18])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 3F6AF1EC124;
	Sat, 26 Jun 2010 00:45:45 +0100 (BST)
X-git-sha1: 10ef82a193f8a099f9b600e41ec222a655de2ac7 
X-Mailer: git-mail-commits v0.5.3
In-Reply-To: <20100625234110.18927.33169.julian@quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149714>

Update the definition and callers of string_list_insert_at_index to
use the string_list as the first argument.  This helps make the
string_list API easier to use by being more consistent.

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---
 mailmap.c     |    2 +-
 string-list.c |    6 +++---
 string-list.h |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/mailmap.c b/mailmap.c
index badf6a4..8b6dc36 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -69,7 +69,7 @@ static void add_mapping(struct string_list *map,
 		index = -1 - index;
 	} else {
 		/* create mailmap entry */
-		struct string_list_item *item = string_list_insert_at_index(index, old_email, map);
+		struct string_list_item *item = string_list_insert_at_index(map, index, old_email);
 		item->util = xmalloc(sizeof(struct mailmap_entry));
 		memset(item->util, 0, sizeof(struct mailmap_entry));
 		((struct mailmap_entry *)item->util)->namemap.strdup_strings = 1;
diff --git a/string-list.c b/string-list.c
index de89efd..84444c2 100644
--- a/string-list.c
+++ b/string-list.c
@@ -53,11 +53,11 @@ static int add_entry(int insert_at, struct string_list *list, const char *string
 
 struct string_list_item *string_list_insert(struct string_list *list, const char *string)
 {
-	return string_list_insert_at_index(-1, string, list);
+	return string_list_insert_at_index(list, -1, string);
 }
 
-struct string_list_item *string_list_insert_at_index(int insert_at,
-						     const char *string, struct string_list *list)
+struct string_list_item *string_list_insert_at_index(struct string_list *list,
+						     int insert_at, const char *string)
 {
 	int index = add_entry(insert_at, list, string);
 
diff --git a/string-list.h b/string-list.h
index 3d5a8de..a4e1919 100644
--- a/string-list.h
+++ b/string-list.h
@@ -30,8 +30,8 @@ int string_list_has_string(const struct string_list *list, const char *string);
 int string_list_find_insert_index(const struct string_list *list, const char *string,
 				  int negative_existing_index);
 struct string_list_item *string_list_insert(struct string_list *list, const char *string);
-struct string_list_item *string_list_insert_at_index(int insert_at,
-						     const char *string, struct string_list *list);
+struct string_list_item *string_list_insert_at_index(struct string_list *list,
+						     int insert_at, const char *string);
 struct string_list_item *string_list_lookup(const char *string, struct string_list *list);
 
 /* Use these functions only on unsorted lists: */
-- 
1.7.0.4
