From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 03/10] mailmap: remove email copy and length limitation
Date: Mon,  7 Jan 2013 16:10:14 -0800
Message-ID: <1357603821-8647-4-git-send-email-gitster@pobox.com>
References: <1357603821-8647-1-git-send-email-gitster@pobox.com>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 08 01:11:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsMmS-0006Eh-IM
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 01:11:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756164Ab3AHAKf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2013 19:10:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50254 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754756Ab3AHAKb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2013 19:10:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D50C5B7AA;
	Mon,  7 Jan 2013 19:10:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=xifL
	1Kjl34dJ7gwJRS2oaHwr97Q=; b=Z4THoVMwI5EPll2pMjc0TeS1HBBGJoHwYZ0z
	VPKDPyJRaM5JJwbLmxncvj0UecmaojnT2X918635/meVPDl+YmtibAVIROZER1SA
	YpmAZbNuF8FDJFezBRAtCurPhHpC4jgFaQh/cRv8MvK357aJSAoEYCjZWrCd2Sg4
	VR2qaME=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	ULz5TcZbfMRIOeEr51erVZyFSvLj/b7siztywt/NCAibmROE4SDCWdgULQ7nEqxl
	GZ0ZUqQNiuR76qaoeejsLd+Sxv0Ik4o7GbICU8mH5NYWzMqLS75CHftjLDtoh6O6
	0v2dzL0ePE2qy8sVGRlwDYO7TUWhuQdnWrd+jw+WFgs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C755BB7A9;
	Mon,  7 Jan 2013 19:10:30 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C8B5AB7A8; Mon,  7 Jan 2013
 19:10:29 -0500 (EST)
X-Mailer: git-send-email 1.8.1.304.gf036638
In-Reply-To: <1357603821-8647-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: CFBB4868-5927-11E2-B117-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212924>

In map_user(), we have email pointer that points at the beginning of
an e-mail address, but the buffer is not terminated with a NUL after
the e-mail address.  It typically has ">" after the address, and it
could have even more if it comes from author/committer line in a
commit object.  Or it may not have ">" after it.

We used to copy the e-mail address proper into a temporary buffer
before asking the string-list API to find the e-mail address in the
mailmap, because string_list_lookup() function only takes a NUL
terminated full string.

Introduce a helper function lookup_prefix that takes the email
pointer and the length, and finds a matching entry in the string
list used for the mailmap, by doing the following:

 - First ask string_list_find_insert_index() where in its sorted
   list the e-mail address we have (including the possible trailing
   junk ">...") would be inserted.

 - It could find an exact match (e.g. we had a clean e-mail address
   without any trailing junk).  We can return the item in that case.

 - Or it could return the index of an item that sorts after the
   e-mail address we have.

 - If we did not find an exact match against a clean e-mail address,
   then the record we are looking for in the mailmap has to exist
   before the index returned by the function (i.e. "email>junk"
   always sorts later than "email").  Iterate, starting from that
   index, down the map->items[] array until we find the exact record
   we are looking for, or we see a record with a key that definitely
   sorts earlier than the e-mail we are looking for (i.e. when we
   are looking for "email" in "email>junk", a record in the mailmap
   that begins with "emaik" strictly sorts before "email", if such a
   key existed in the mailmap).

This, together with the earlier enhancement to support
case-insensitive sorting, allow us to remove an extra copy of email
buffer to downcase it.

A part of this is based on Antoine Pelisse's previous work.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 mailmap.c | 61 +++++++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 16 deletions(-)

diff --git a/mailmap.c b/mailmap.c
index ea4b471..1a0b769 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -174,6 +174,7 @@ static int read_single_mailmap(struct string_list *map, const char *filename, ch
 int read_mailmap(struct string_list *map, char **repo_abbrev)
 {
 	map->strdup_strings = 1;
+	map->cmp = strcasecmp;
 	/* each failure returns 1, so >1 means both calls failed */
 	return read_single_mailmap(map, ".mailmap", repo_abbrev) +
 	       read_single_mailmap(map, git_mailmap_file, repo_abbrev) > 1;
@@ -187,14 +188,50 @@ void clear_mailmap(struct string_list *map)
 	debug_mm("mailmap: cleared\n");
 }
 
+static struct string_list_item *lookup_prefix(struct string_list *map,
+					      const char *string, size_t len)
+{
+	int i = string_list_find_insert_index(map, string, 1);
+	if (i < 0) {
+		/* exact match */
+		i = -1 - i;
+		/* does it match exactly? */
+		if (!map->items[i].string[len])
+			return &map->items[i];
+	}
+
+	/*
+	 * i is at the exact match to an overlong key, or
+	 * location the possibly overlong key would be inserted,
+	 * which must be after the real location of the key.
+	 */
+	while (0 <= --i && i < map->nr) {
+		int cmp = strncasecmp(map->items[i].string, string, len);
+		if (cmp < 0)
+			/*
+			 * "i" points at a key definitely below the prefix;
+			 * the map does not have string[0:len] in it.
+			 */
+			break;
+		else if (!cmp && !map->items[i].string[len])
+			/* found it */
+			return &map->items[i];
+		/*
+		 * otherwise, the string at "i" may be string[0:len]
+		 * followed by a string that sorts later than string[len:];
+		 * keep trying.
+		 */
+	}
+	return NULL;
+}
+
 int map_user(struct string_list *map,
 	     char *email, int maxlen_email, char *name, int maxlen_name)
 {
 	char *end_of_email;
 	struct string_list_item *item;
 	struct mailmap_entry *me;
-	char buf[1024], *mailbuf;
-	int i;
+	size_t maillen;
 
 	/* figure out space requirement for email */
 	end_of_email = strchr(email, '>');
@@ -204,18 +241,12 @@ int map_user(struct string_list *map,
 		if (!end_of_email)
 			return 0;
 	}
-	if (end_of_email - email + 1 < sizeof(buf))
-		mailbuf = buf;
-	else
-		mailbuf = xmalloc(end_of_email - email + 1);
-
-	/* downcase the email address */
-	for (i = 0; i < end_of_email - email; i++)
-		mailbuf[i] = tolower(email[i]);
-	mailbuf[i] = 0;
-
-	debug_mm("map_user: map '%s' <%s>\n", name, mailbuf);
-	item = string_list_lookup(map, mailbuf);
+
+	maillen = end_of_email - email;
+
+	debug_mm("map_user: map '%s' <%.*s>\n", name, maillen, email);
+
+	item = lookup_prefix(map, email, maillen);
 	if (item != NULL) {
 		me = (struct mailmap_entry *)item->util;
 		if (me->namemap.nr) {
@@ -226,8 +257,6 @@ int map_user(struct string_list *map,
 				item = subitem;
 		}
 	}
-	if (mailbuf != buf)
-		free(mailbuf);
 	if (item != NULL) {
 		struct mailmap_info *mi = (struct mailmap_info *)item->util;
 		if (mi->name == NULL && (mi->email == NULL || maxlen_email == 0)) {
-- 
1.8.1.304.gf036638
