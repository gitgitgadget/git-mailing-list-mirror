From: Marius Storm-Olsen <marius@trolltech.com>
Subject: [PATCH v2 4/4] Change current mailmap usage to do matching on both name and email of author/committer.
Date: Sun,  1 Feb 2009 21:59:59 +0100
Message-ID: <68028794e4be1e67448838a88466ccb1a8b8de19.1233520945.git.marius@trolltech.com>
References: <cover.1233520945.git.marius@trolltech.com>
 <ce94ea88e3182e97997c23f71e184e0db64fa708.1233520945.git.marius@trolltech.com>
 <75a7d437c1b32600c509bdef5010e6ac30b6cb08.1233520945.git.marius@trolltech.com>
 <0f360e115bde662b5297e803d8829b79c573ad58.1233520945.git.marius@trolltech.com>
Cc: Marius Storm-Olsen <marius@trolltech.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 01 22:02:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTjSq-0005JH-TM
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 22:02:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755389AbZBAVB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 16:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755155AbZBAVBZ
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 16:01:25 -0500
Received: from hoat.troll.no ([62.70.27.150]:48417 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754557AbZBAVBO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 16:01:14 -0500
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 0D94720F33;
	Sun,  1 Feb 2009 22:01:08 +0100 (CET)
Received: from localhost.localdomain (unknown [172.24.90.96])
	by hoat.troll.no (Postfix) with ESMTP id DC59E20F29;
	Sun,  1 Feb 2009 22:01:07 +0100 (CET)
X-Mailer: git-send-email 1.6.1.2.257.g34f62
In-Reply-To: <0f360e115bde662b5297e803d8829b79c573ad58.1233520945.git.marius@trolltech.com>
In-Reply-To: <cover.1233520945.git.marius@trolltech.com>
References: <cover.1233520945.git.marius@trolltech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108005>


Signed-off-by: Marius Storm-Olsen <marius@trolltech.com>
---
 Documentation/pretty-formats.txt |    2 +
 builtin-blame.c                  |   50 ++++++++++++-------
 builtin-shortlog.c               |   22 +++++++--
 pretty.c                         |   59 ++++++++++++-----------
 t/t4203-mailmap.sh               |   99 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 180 insertions(+), 52 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 3d87d3e..28808b7 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -103,6 +103,7 @@ The placeholders are:
 - '%an': author name
 - '%aN': author name (respecting .mailmap)
 - '%ae': author email
+- '%aE': author email (respecting .mailmap)
 - '%ad': author date (format respects --date= option)
 - '%aD': author date, RFC2822 style
 - '%ar': author date, relative
@@ -111,6 +112,7 @@ The placeholders are:
 - '%cn': committer name
 - '%cN': committer name (respecting .mailmap)
 - '%ce': committer email
+- '%cE': committer email (respecting .mailmap)
 - '%cd': committer date
 - '%cD': committer date, RFC2822 style
 - '%cr': committer date, relative
diff --git a/builtin-blame.c b/builtin-blame.c
index 4b63775..c166ba1 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -1263,11 +1263,12 @@ struct commit_info
  * Parse author/committer line in the commit object buffer
  */
 static void get_ac_line(const char *inbuf, const char *what,
-			int bufsz, char *person, const char **mail,
+			int person_len, char *person,
+			int mail_len, char *mail,
 			unsigned long *time, const char **tz)
 {
 	int len, tzlen, maillen;
-	char *tmp, *endp, *timepos;
+	char *tmp, *endp, *timepos, *mailpos;
 
 	tmp = strstr(inbuf, what);
 	if (!tmp)
@@ -1278,10 +1279,11 @@ static void get_ac_line(const char *inbuf, const char *what,
 		len = strlen(tmp);
 	else
 		len = endp - tmp;
-	if (bufsz <= len) {
+	if (person_len <= len) {
 	error_out:
 		/* Ugh */
-		*mail = *tz = "(unknown)";
+		*tz = "(unknown)";
+		strcpy(mail, *tz);
 		*time = 0;
 		return;
 	}
@@ -1304,9 +1306,10 @@ static void get_ac_line(const char *inbuf, const char *what,
 	*tmp = 0;
 	while (*tmp != ' ')
 		tmp--;
-	*mail = tmp + 1;
+	mailpos = tmp + 1;
 	*tmp = 0;
 	maillen = timepos - tmp;
+	memcpy(mail, mailpos, maillen);
 
 	if (!mailmap.nr)
 		return;
@@ -1315,20 +1318,23 @@ static void get_ac_line(const char *inbuf, const char *what,
 	 * mailmap expansion may make the name longer.
 	 * make room by pushing stuff down.
 	 */
-	tmp = person + bufsz - (tzlen + 1);
+	tmp = person + person_len - (tzlen + 1);
 	memmove(tmp, *tz, tzlen);
 	tmp[tzlen] = 0;
 	*tz = tmp;
 
-	tmp = tmp - (maillen + 1);
-	memmove(tmp, *mail, maillen);
-	tmp[maillen] = 0;
-	*mail = tmp;
-
 	/*
-	 * Now, convert e-mail using mailmap
+	 * Now, convert both name and e-mail using mailmap
 	 */
-	map_email(&mailmap, tmp + 1, person, tmp-person-1);
+	if(map_user(&mailmap, mail+1, mail_len-1, person, tmp-person-1)) {
+		/* Add a trailing '>' to email, since map_user returns plain emails
+		   Note: It already has '<', since we replace from mail+1 */
+		mailpos = memchr(mail, '\0', mail_len);
+		if (mailpos && mailpos-mail < mail_len - 1) {
+			*mailpos = '>';
+			*(mailpos+1) = '\0';
+		}
+	}
 }
 
 static void get_commit_info(struct commit *commit,
@@ -1337,8 +1343,10 @@ static void get_commit_info(struct commit *commit,
 {
 	int len;
 	char *tmp, *endp, *reencoded, *message;
-	static char author_buf[1024];
-	static char committer_buf[1024];
+	static char author_name[1024];
+	static char author_mail[1024];
+	static char committer_name[1024];
+	static char committer_mail[1024];
 	static char summary_buf[1024];
 
 	/*
@@ -1356,9 +1364,11 @@ static void get_commit_info(struct commit *commit,
 	}
 	reencoded = reencode_commit_message(commit, NULL);
 	message   = reencoded ? reencoded : commit->buffer;
-	ret->author = author_buf;
+	ret->author = author_name;
+	ret->author_mail = author_mail;
 	get_ac_line(message, "\nauthor ",
-		    sizeof(author_buf), author_buf, &ret->author_mail,
+		    sizeof(author_name), author_name,
+		    sizeof(author_mail), author_mail,
 		    &ret->author_time, &ret->author_tz);
 
 	if (!detailed) {
@@ -1366,9 +1376,11 @@ static void get_commit_info(struct commit *commit,
 		return;
 	}
 
-	ret->committer = committer_buf;
+	ret->committer = committer_name;
+	ret->committer_mail = committer_mail;
 	get_ac_line(message, "\ncommitter ",
-		    sizeof(committer_buf), committer_buf, &ret->committer_mail,
+		    sizeof(committer_name), committer_name,
+		    sizeof(committer_mail), committer_mail,
 		    &ret->committer_time, &ret->committer_tz);
 
 	ret->summary = summary_buf;
diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index 04832a8..19975ce 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -40,6 +40,7 @@ static void insert_one_record(struct shortlog *log,
 	char *buffer, *p;
 	struct string_list_item *item;
 	char namebuf[1024];
+	char emailbuf[1024];
 	size_t len;
 	const char *eol;
 	const char *boemail, *eoemail;
@@ -51,7 +52,19 @@ static void insert_one_record(struct shortlog *log,
 	eoemail = strchr(boemail, '>');
 	if (!eoemail)
 		return;
-	if (!map_email(&log->mailmap, boemail+1, namebuf, sizeof(namebuf))) {
+
+	/* copy author name to namebuf, to support matching on both name and email */
+	memcpy(namebuf, author, boemail - author);
+	len = boemail - author;
+	while(len > 0 && isspace(namebuf[len-1]))
+		len--;
+	namebuf[len] = 0;
+
+	/* copy email name to emailbuf, to allow email replacement as well */
+	memcpy(emailbuf, boemail+1, eoemail - boemail);
+	emailbuf[eoemail - boemail - 1] = 0;
+
+	if (!map_user(&log->mailmap, emailbuf, sizeof(emailbuf), namebuf, sizeof(namebuf))) {
 		while (author < boemail && isspace(*author))
 			author++;
 		for (len = 0;
@@ -67,8 +80,8 @@ static void insert_one_record(struct shortlog *log,
 
 	if (log->email) {
 		size_t room = sizeof(namebuf) - len - 1;
-		int maillen = eoemail - boemail + 1;
-		snprintf(namebuf + len, room, " %.*s", maillen, boemail);
+		int maillen = strlen(emailbuf);
+		snprintf(namebuf + len, room, " <%.*s>", maillen, emailbuf);
 	}
 
 	item = string_list_insert(namebuf, &log->list);
@@ -321,6 +334,5 @@ void shortlog_output(struct shortlog *log)
 
 	log->list.strdup_strings = 1;
 	string_list_clear(&log->list, 1);
-	log->mailmap.strdup_strings = 1;
-	string_list_clear(&log->mailmap, 1);
+	clear_mailmap(&log->mailmap);
 }
diff --git a/pretty.c b/pretty.c
index cc460b5..e93e472 100644
--- a/pretty.c
+++ b/pretty.c
@@ -305,23 +305,14 @@ static char *logmsg_reencode(const struct commit *commit,
 	return out;
 }
 
-static int mailmap_name(struct strbuf *sb, const char *email)
+static int mailmap_name(char *email, int email_len, char *name, int name_len)
 {
 	static struct string_list *mail_map;
-	char buffer[1024];
-
 	if (!mail_map) {
 		mail_map = xcalloc(1, sizeof(*mail_map));
-		read_mailmap(mail_map, ".mailmap", NULL);
+		read_mailmap(mail_map, NULL, NULL);
 	}
-
-	if (!mail_map->nr)
-		return -1;
-
-	if (!map_email(mail_map, email, buffer, sizeof(buffer)))
-		return -1;
-	strbuf_addstr(sb, buffer);
-	return 0;
+	return mail_map->nr && map_user(mail_map, email, email_len, name, name_len);
 }
 
 static size_t format_person_part(struct strbuf *sb, char part,
@@ -332,6 +323,9 @@ static size_t format_person_part(struct strbuf *sb, char part,
 	int start, end, tz = 0;
 	unsigned long date = 0;
 	char *ep;
+	const char *name_start, *name_end, *mail_start, *mail_end, *msg_end = msg+len;
+	char person_name[1024];
+	char person_mail[1024];
 
 	/* advance 'end' to point to email start delimiter */
 	for (end = 0; end < len && msg[end] != '<'; end++)
@@ -345,25 +339,34 @@ static size_t format_person_part(struct strbuf *sb, char part,
 	if (end >= len - 2)
 		goto skip;
 
+	/* Seek for both name and email part */
+	name_start = msg;
+	name_end = msg+end;
+	while (name_end > name_start && isspace(*(name_end-1)))
+		name_end--;
+	mail_start = msg+end+1;
+	mail_end = mail_start;
+	while (mail_end < msg_end && *mail_end != '>')
+		mail_end++;
+	if (mail_end == msg_end)
+		goto skip;
+	end = mail_end-msg;
+
+	if (part == 'N' || part == 'E') { /* mailmap lookup */
+		strlcpy(person_name, name_start, name_end-name_start+1);
+		strlcpy(person_mail, mail_start, mail_end-mail_start+1);
+		mailmap_name(person_mail, sizeof(person_mail), person_name, sizeof(person_name));
+		name_start = person_name;
+		name_end = name_start + strlen(person_name);
+		mail_start = person_mail;
+		mail_end = mail_start +  strlen(person_mail);
+	}
 	if (part == 'n' || part == 'N') {	/* name */
-		while (end > 0 && isspace(msg[end - 1]))
-			end--;
-		if (part != 'N' || !msg[end] || !msg[end + 1] ||
-		    mailmap_name(sb, msg + end + 2) < 0)
-			strbuf_add(sb, msg, end);
+		strbuf_add(sb, name_start, name_end-name_start);
 		return placeholder_len;
 	}
-	start = ++end; /* save email start position */
-
-	/* advance 'end' to point to email end delimiter */
-	for ( ; end < len && msg[end] != '>'; end++)
-		; /* do nothing */
-
-	if (end >= len)
-		goto skip;
-
-	if (part == 'e') {	/* email */
-		strbuf_add(sb, msg + start, end - start);
+	if (part == 'e' || part == 'E') {	/* email */
+		strbuf_add(sb, mail_start, mail_end-mail_start);
 		return placeholder_len;
 	}
 
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 57fd88e..271ef26 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -50,4 +50,103 @@ test_expect_success 'No mailmap files, but configured' '
 	test_cmp expect actual
 '
 
+# Extended mailmap configurations should give us the following output for shortlog
+cat >expect <<\EOF
+A U Thor <author@example.com> (1):
+      initial
+
+Other Author <other@author.xx> (2):
+      third
+      fourth
+
+Santa Claus <santa.claus@northpole.xx> (2):
+      fifth
+      sixth
+
+Some Dude <some@dude.xx> (1):
+      second
+
+EOF
+
+test_expect_success 'Shortlog output (complex mapping)' '
+
+	echo two >>one &&
+	git add one &&
+	test_tick &&
+	git commit --author "nick1 <bugs@company.xx>" -m second &&
+
+	echo three >>one &&
+	git add one &&
+	test_tick &&
+	git commit --author "nick2 <bugs@company.xx>" -m third &&
+
+	echo four >>one &&
+	git add one &&
+	test_tick &&
+	git commit --author "nick2 <nick2@company.xx>" -m fourth &&
+
+	echo five >>one &&
+	git add one &&
+	test_tick &&
+	git commit --author "santa <me@company.xx>" -m fifth &&
+
+	echo six >>one &&
+	git add one &&
+	test_tick &&
+	git commit --author "claus <me@company.xx>" -m sixth &&
+
+	mkdir internal_mailmap &&
+	echo "Committed <committer@example.com>" > internal_mailmap/.mailmap &&
+	echo "Some Dude <some@dude.xx>         nick1 <bugs@company.xx>" >> internal_mailmap/.mailmap &&
+	echo "Other Author <other@author.xx>   nick2 <bugs@company.xx>" >> internal_mailmap/.mailmap &&
+	echo "Other Author <other@author.xx>         <nick2@company.xx>" >> internal_mailmap/.mailmap &&
+	echo "Santa Claus <santa.claus@northpole.xx> <me@company.xx>" >> internal_mailmap/.mailmap &&
+	echo "Santa Claus <santa.claus@northpole.xx> <me@company.xx>" >> internal_mailmap/.mailmap &&
+
+	git shortlog -e >actual &&
+	test_cmp expect actual
+
+'
+
+# git log with --pretty format which uses the name and email mailmap placemarkers
+cat >expect <<\EOF
+Author claus <me@company.xx> maps to Santa Claus <santa.claus@northpole.xx>
+Committer C O Mitter <committer@example.com> maps to Committed <committer@example.com>
+
+Author santa <me@company.xx> maps to Santa Claus <santa.claus@northpole.xx>
+Committer C O Mitter <committer@example.com> maps to Committed <committer@example.com>
+
+Author nick2 <nick2@company.xx> maps to Other Author <other@author.xx>
+Committer C O Mitter <committer@example.com> maps to Committed <committer@example.com>
+
+Author nick2 <bugs@company.xx> maps to Other Author <other@author.xx>
+Committer C O Mitter <committer@example.com> maps to Committed <committer@example.com>
+
+Author nick1 <bugs@company.xx> maps to Some Dude <some@dude.xx>
+Committer C O Mitter <committer@example.com> maps to Committed <committer@example.com>
+
+Author A U Thor <author@example.com> maps to A U Thor <author@example.com>
+Committer C O Mitter <committer@example.com> maps to Committed <committer@example.com>
+EOF
+
+test_expect_success 'Log output (complex mapping)' '
+	git log --pretty=format:"Author %an <%ae> maps to %aN <%aE>%nCommitter %cn <%ce> maps to %cN <%cE>%n" >actual &&
+	test_cmp expect actual
+'
+
+# git blame
+cat >expect <<\EOF
+^3a2fdcb (A U Thor     2005-04-07 15:13:13 -0700 1) one
+e0f60492 (Some Dude    2005-04-07 15:14:13 -0700 2) two
+4db1a3df (Other Author 2005-04-07 15:15:13 -0700 3) three
+e3718380 (Other Author 2005-04-07 15:16:13 -0700 4) four
+25e4bf3d (Santa Claus  2005-04-07 15:17:13 -0700 5) five
+17c39712 (Santa Claus  2005-04-07 15:18:13 -0700 6) six
+EOF
+
+test_expect_success 'Blame output (complex mapping)' '
+	git blame one >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.6.1.2.257.g34f62
