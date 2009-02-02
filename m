From: Marius Storm-Olsen <marius@trolltech.com>
Subject: [PATCH v3 3/4] Add map_user() and clear_mailmap() to mailmap
Date: Mon,  2 Feb 2009 15:32:09 +0100
Message-ID: <53facc1773745ae477f15103718e08ea6a5ae58d.1233584536.git.marius@trolltech.com>
References: <cover.1233584536.git.marius@trolltech.com>
 <36adb0d2cc4c20c4efb3b03a912b27e67c166855.1233584536.git.marius@trolltech.com>
 <76e643ff7e99985ce46b6bf36ec967124d7fc6aa.1233584536.git.marius@trolltech.com>
Cc: gitster@pobox.com, Marius Storm-Olsen <marius@trolltech.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 02 15:35:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTztP-0007I1-Qp
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 15:35:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752732AbZBBOdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 09:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752685AbZBBOde
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 09:33:34 -0500
Received: from hoat.troll.no ([62.70.27.150]:37594 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752637AbZBBOd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 09:33:27 -0500
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 6CEA320F53;
	Mon,  2 Feb 2009 15:33:21 +0100 (CET)
Received: from localhost.localdomain (unknown [172.24.90.96])
	by hoat.troll.no (Postfix) with ESMTP id 5D61920F42;
	Mon,  2 Feb 2009 15:33:21 +0100 (CET)
X-Mailer: git-send-email 1.6.1.2.257.g84fd75
In-Reply-To: <76e643ff7e99985ce46b6bf36ec967124d7fc6aa.1233584536.git.marius@trolltech.com>
In-Reply-To: <cover.1233584536.git.marius@trolltech.com>
References: <cover.1233584536.git.marius@trolltech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108091>

map_user() allows to lookup and replace both email and
name of a user, based on a new style mailmap file.
The possible mailmap definitions now are:
  proper_name <commit_email>                             // Old style
  proper_name <proper_email> <commit_email>              // New style
  proper_name <proper_email> commit_name <commit_email>  // New style

map_email() operates the same as before, with the
exception that it also will to try to match on a name
passed in through the name return buffer.

clear_mailmap() is needed to now clear the more complex
mailmap structure.

Signed-off-by: Marius Storm-Olsen <marius@trolltech.com>
---
 Documentation/git-shortlog.txt |   58 +++++++++---
 mailmap.c                      |  198 ++++++++++++++++++++++++++++++++++++----
 mailmap.h                      |    4 +
 3 files changed, 227 insertions(+), 33 deletions(-)

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index cacbeea..d64dabf 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -50,20 +50,29 @@ FILES
 
 If a file `.mailmap` exists at the toplevel of the repository, or at the
 location pointed to by the log.mailmap configuration option,
-it is used to map an author email address to a canonical real name. This
-can be used to coalesce together commits by the same person where their
-name was spelled differently (whether with the same email address or
-not).
-
-Each line in the file consists, in this order, of the canonical real name
-of an author, whitespace, and an email address (enclosed by '<' and '>')
-to map to the name. Use hash '#' for comments, either on their own line,
-or after the email address.
-
-A canonical name may appear in more than one line, associated with
-different email addresses, but it doesn't make sense for a given address
-to appear more than once (if that happens, a later line overrides the
-earlier ones).
+it is used to map author and committer names and email addresses to
+canonical real names and email addresses.
+This can be used to coalesce together commits by the same person where
+their name and/or email address was spelled differently.
+
+In the simple form, each line in the file consists of the canonical real name
+of an author, whitespace, and an email address used in the commit
+(enclosed by '<' and '>') to map to the name. Thus, looks like this
+--
+	Proper Name <commit@email.xx>
+--
+
+The more complex forms are
+--
+	Proper Name <proper@email.xx> <commit@email.xx>
+--
+which allows mailmap to replace both the name and the email of a commit
+matching the specified commit email address. And
+--
+	Proper Name <proper@email.xx> Commit Name <commit@email.xx>
+--
+which allows mailmap to replace both the name and the email of a commit
+matching the specified commit name and email address.
 
 So, for example, if your history contains commits by two authors, Jane
 and Joe, whose names appear in the repository under several forms:
@@ -86,6 +95,27 @@ Jane Doe <jane@desktop.(none)>
 Joe R. Developer <joe@random.com>
 ------------
 
+Now, suppose your repository contains commits from the following authors:
+
+------------
+nick1 <bugs@company.xx>
+nick2 <bugs@company.xx>
+nick2 <nick2@company.xx>
+santa <me@company.xx>
+claus <me@company.xx>
+------------
+
+Then, you might want a `.mailmap` file looking like:
+------------
+Some Dude <some@dude.xx>         nick1 <bugs@company.xx>
+Other Author <other@author.xx>   nick2 <bugs@company.xx>
+Other Author <other@author.xx>         <nick2@company.xx>
+Santa Claus <santa.claus@northpole.xx> <me@company.xx>
+------------
+
+Use hash '#' for comments, either on their own line, or after the email address.
+
+
 Author
 ------
 Written by Jeff Garzik <jgarzik@pobox.com>
diff --git a/mailmap.c b/mailmap.c
index 5aaee91..f593ff0 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -2,7 +2,87 @@
 #include "string-list.h"
 #include "mailmap.h"
 
+#define DEBUG_MAILMAP 0
+#if DEBUG_MAILMAP
+#define debug_mm(...) fprintf(stderr, __VA_ARGS__)
+#else
+inline void debug_mm(const char *format, ...) {}
+#endif
+
 const char *git_log_mailmap;
+
+struct mailmap_info {
+	char *name;
+	char *email;
+};
+
+struct mailmap_entry {
+	/* name and email for the simple mail-only case */
+	char *name;
+	char *email;
+
+	/* name and email for the complex mail and name matching case */
+	struct string_list namemap;
+};
+
+void free_mailmap_info(void *p, const char *s)
+{
+	struct mailmap_info *mi = (struct mailmap_info *)p;
+	debug_mm("mailmap: -- complex: '%s' -> '%s' <%s>\n", s, mi->name, mi->email);
+	free(mi->name);
+	free(mi->email);
+}
+
+void free_mailmap_entry(void *p, const char *s)
+{
+	struct mailmap_entry *me = (struct mailmap_entry *)p;
+	debug_mm("mailmap: removing entries for <%s>, with %d sub-entries\n", s, me->namemap.nr);
+	debug_mm("mailmap: - simple: '%s' <%s>\n", me->name, me->email);
+	free(me->name);
+	free(me->email);
+
+	me->namemap.strdup_strings = 1;
+	string_list_clear_func(&me->namemap, free_mailmap_info);
+}
+
+void add_mapping(struct string_list *map,
+		 char *name1, char *email1, char *name2, char *email2)
+{
+	struct mailmap_entry *me;
+	int index = string_list_find_insert_index(map, email1, 1);
+	if (index < 0) {
+		/* mailmap entry exists, invert index value */
+		index = -1 - index;
+	} else {
+		/* create mailmap entry */
+		struct string_list_item *item = string_list_insert_at_index(index, email1, map);
+		item->util = xmalloc(sizeof(struct mailmap_entry));
+		memset(item->util, 0, sizeof(struct mailmap_entry));
+	}
+	me = (struct mailmap_entry *)map->items[index].util;
+
+	if (name2 == NULL) {
+		debug_mm("mailmap: adding (simple) entry for %s at index %d\n", email1, index);
+		/* Replace current name and new email for simple entry */
+		free(me->name);
+		free(me->email);
+		me->name = xstrdup(name1);
+		if (email2)
+			me->email = xstrdup(email2);
+	} else {
+		struct mailmap_info *mi = xmalloc(sizeof(struct mailmap_info));
+		debug_mm("mailmap: adding (complex) entry for %s at index %d\n", email1, index);
+		mi->name = xstrdup(name2);
+		if (email2)
+			mi->email = xstrdup(email2);
+		string_list_insert(name1, &me->namemap)->util = mi;
+	}
+
+	debug_mm("mailmap:  '%s' <%s> -> '%s' <%s>\n",
+		 name2 ? name1 : "", email1,
+		 name2 ? name2 : name1, email2 ? email2 : "");
+}
+
 static int read_single_mailmap(struct string_list *map, const char *filename, char **repo_abbrev)
 {
 	char buffer[1024];
@@ -11,8 +91,8 @@ static int read_single_mailmap(struct string_list *map, const char *filename, ch
 	if (f == NULL)
 		return 1;
 	while (fgets(buffer, sizeof(buffer), f) != NULL) {
-		char *end_of_name, *left_bracket, *right_bracket;
-		char *name, *email;
+		char *end_of_name, *left_bracket1, *right_bracket1, *left_bracket2, *right_bracket2;
+		char *name1, *email1, *name2, *email2;
 		int i;
 		if (buffer[0] == '#') {
 			static const char abbrev[] = "# repo-abbrev:";
@@ -37,25 +117,65 @@ static int read_single_mailmap(struct string_list *map, const char *filename, ch
 			}
 			continue;
 		}
-		if ((left_bracket = strchr(buffer, '<')) == NULL)
+		/* Locate name and email */
+		if ((left_bracket1 = strchr(buffer, '<')) == NULL)
 			continue;
-		if ((right_bracket = strchr(left_bracket + 1, '>')) == NULL)
+		if ((right_bracket1 = strchr(left_bracket1 + 1, '>')) == NULL)
 			continue;
-		if (right_bracket == left_bracket + 1)
+		if (right_bracket1 == left_bracket1 + 1)
 			continue;
-		for (end_of_name = left_bracket;
+		for (end_of_name = left_bracket1;
 		     end_of_name != buffer && isspace(end_of_name[-1]);
 		     end_of_name--)
 			; /* keep on looking */
 		if (end_of_name == buffer)
 			continue;
-		name = xmalloc(end_of_name - buffer + 1);
-		strlcpy(name, buffer, end_of_name - buffer + 1);
-		email = xmalloc(right_bracket - left_bracket);
-		for (i = 0; i < right_bracket - left_bracket - 1; i++)
-			email[i] = tolower(left_bracket[i + 1]);
-		email[right_bracket - left_bracket - 1] = '\0';
-		string_list_insert(email, map)->util = name;
+		name1 = xmalloc(end_of_name - buffer + 1);
+		strlcpy(name1, buffer, end_of_name - buffer + 1);
+		email1 = xmalloc(right_bracket1 - left_bracket1);
+		for (i = 0; i < right_bracket1 - left_bracket1 - 1; i++)
+			email1[i] = tolower(left_bracket1[i + 1]);
+		email1[right_bracket1 - left_bracket1 - 1] = '\0';
+
+		/* Locate 2nd name and email. Possible mappings in mailmap file are:
+		 *   proper_name <commit_email>
+		 *   proper_name <proper_email> <commit_email>
+		 *   proper_name <proper_email> commit_name <commit_email>
+		 */
+		do {
+			email2 = name2 = 0;
+			right_bracket1 += 1;
+			if ((left_bracket2 = strchr(right_bracket1, '<')) == NULL)
+				continue;
+			if ((right_bracket2 = strchr(left_bracket2 + 1, '>')) == NULL)
+				continue;
+			if (right_bracket2 == left_bracket2 + 1)
+				continue;
+			for (end_of_name = left_bracket2;
+			     end_of_name != right_bracket1 && isspace(end_of_name[-1]);
+			     end_of_name--)
+				; /* keep on looking for name end */
+			for (;
+			     end_of_name != right_bracket1 && isspace(right_bracket1[0]);
+			     right_bracket1++)
+				; /* keep on looking for name start */
+			if (end_of_name != right_bracket1) {
+				name2 = xmalloc(end_of_name - right_bracket1 + 1);
+				strlcpy(name2, right_bracket1, end_of_name - right_bracket1 + 1);
+				char *tmp = name1;
+				name1 = name2;
+				name2 = tmp;
+			}
+			email2 = xmalloc(right_bracket2 - left_bracket2);
+			for (i = 0; i < right_bracket2 - left_bracket2 - 1; i++)
+				email2[i] = tolower(left_bracket2[i + 1]);
+			email2[right_bracket2 - left_bracket2 - 1] = '\0';
+			char *tmp = email1;
+			email1 = email2;
+			email2 = tmp;
+		} while(0);
+
+		add_mapping(map, name1, email1, name2, email2);
 	}
 	fclose(f);
 	return 0;
@@ -68,17 +188,31 @@ int read_mailmap(struct string_list *map, char **repo_abbrev)
 	       read_single_mailmap(map, git_log_mailmap, repo_abbrev) > 1;
 }
 
-int map_email(struct string_list *map, const char *email, char *name, int maxlen)
+void clear_mailmap(struct string_list *map)
+{
+	debug_mm("mailmap: clearing %d entries...\n", map->nr);
+	map->strdup_strings = 1;
+	string_list_clear_func(map, free_mailmap_entry);
+	debug_mm("mailmap: cleared\n");
+}
+
+int map_user(struct string_list *map,
+	     char *email, int maxlen_email, char *name, int maxlen_name)
 {
 	char *p;
 	struct string_list_item *item;
+	struct mailmap_entry *me;
 	char buf[1024], *mailbuf;
 	int i;
 
-	/* autocomplete common developers */
+	/* figure out space requirement for email */
 	p = strchr(email, '>');
-	if (!p)
-		return 0;
+	if (!p) {
+		/* email passed in might not be wrapped in <>, but end with a \0 */
+		p = memchr(email, '\0', maxlen_email);
+		if (p == 0)
+			return 0;
+	}
 	if (p - email + 1 < sizeof(buf))
 		mailbuf = buf;
 	else
@@ -88,13 +222,39 @@ int map_email(struct string_list *map, const char *email, char *name, int maxlen
 	for (i = 0; i < p - email; i++)
 		mailbuf[i] = tolower(email[i]);
 	mailbuf[i] = 0;
+
+	debug_mm("map_user: map '%s' <%s>\n", name, mailbuf);
 	item = string_list_lookup(mailbuf, map);
+	if (item != NULL) {
+		me = (struct mailmap_entry *)item->util;
+		if (me->namemap.nr) {
+			/* The item has multiple items, so we'll look up on name too */
+			/* If the name is not found, we choose the simple entry      */
+			struct string_list_item *subitem = string_list_lookup(name, &me->namemap);
+			if (subitem)
+				item = subitem;
+		}
+	}
 	if (mailbuf != buf)
 		free(mailbuf);
 	if (item != NULL) {
-		const char *realname = (const char *)item->util;
-		strlcpy(name, realname, maxlen);
+		struct mailmap_info *mi = (struct mailmap_info *)item->util;
+		if (mi->email == NULL && mi->name == NULL) {
+			debug_mm("map_user:  -- (no simple mapping)\n");
+			return 0;
+		}
+		if (maxlen_email && mi->email)
+			strlcpy(email, mi->email, maxlen_email);
+		if (maxlen_name && mi->name)
+			strlcpy(name, mi->name, maxlen_name);
+		debug_mm("map_user:  to '%s' <%s>\n", name, mi->email ? email : mailbuf);
 		return 1;
 	}
+	debug_mm("map_user:  --\n");
 	return 0;
 }
+
+int map_email(struct string_list *map, const char *email, char *name, int maxlen)
+{
+	return map_user(map, (char *)email, 0, name, maxlen);
+}
diff --git a/mailmap.h b/mailmap.h
index ba2ee76..4b2ca3a 100644
--- a/mailmap.h
+++ b/mailmap.h
@@ -2,6 +2,10 @@
 #define MAILMAP_H
 
 int read_mailmap(struct string_list *map, char **repo_abbrev);
+void clear_mailmap(struct string_list *map);
+
 int map_email(struct string_list *mailmap, const char *email, char *name, int maxlen);
+int map_user(struct string_list *mailmap,
+	     char *email, int maxlen_email, char *name, int maxlen_name);
 
 #endif
-- 
1.6.1.2.257.g84fd75
