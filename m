From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/4] mailmap: do not downcase mailmap entries
Date: Fri, 12 Jul 2013 14:38:53 -0700
Message-ID: <1373665135-32484-3-git-send-email-gitster@pobox.com>
References: <1373665135-32484-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 23:39:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uxl3r-0003ju-7K
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 23:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965491Ab3GLVjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 17:39:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55968 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965446Ab3GLVjB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 17:39:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F99630321
	for <git@vger.kernel.org>; Fri, 12 Jul 2013 21:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=QlMl
	dUA7Mt9qMlAivmvrfYxzHbU=; b=c1RNVK6fFX/7uIoWHTMsQeFxm5J+5IDkWGsk
	9ODWmOjlml80zj/Jq9hczfYCOl1+LSzzXenRgJFwnKt/c9dxlbAy4zFH5BYlazmG
	Txf+I8YoozYbgKlyWW/1sGjDD/a6MmcbRwho3U9DqbxgdA0+0nWCvxujC3gep1yi
	OTa4hT8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=QbwqsV
	nfPharZG2Lcr9Sk5+B/+gVdsDxhQRgdrkx6kzSlsgFZTLanT14FbYZuqZIeewy4s
	wrP/X6CrTaaZC+malRizj+1mP1y6OR+qSAs9UbejgDuk8dy+BOX3jq7Hm54bIgVD
	e5STH3Nb+wW2+KJz08GSWXX385J4LswQP3ZrU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74AFF30320
	for <git@vger.kernel.org>; Fri, 12 Jul 2013 21:39:01 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A6E3B3031E
	for <git@vger.kernel.org>; Fri, 12 Jul 2013 21:39:00 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.2-941-gda9c3c8
In-Reply-To: <1373665135-32484-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 77049F66-EB3B-11E2-8F64-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230262>

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
---
 mailmap.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

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
-- 
1.8.3.2-941-gda9c3c8
