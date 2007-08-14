From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] attr.c: refactoring
Date: Tue, 14 Aug 2007 01:40:45 -0700
Message-ID: <7v1we6ecfm.fsf_-_@assigned-by-dhcp.cox.net>
References: <11869508753328-git-send-email-prohaska@zib.de>
	<118695087531-git-send-email-prohaska@zib.de>
	<7veji8ifs2.fsf@assigned-by-dhcp.cox.net>
	<7vfy2ogdvl.fsf@assigned-by-dhcp.cox.net>
	<46BFFB1A.4070704@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>, dmitry.kakurin@gmail.com,
	git@vger.kernel.org
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 10:40:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKrxO-0004RL-PP
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 10:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753881AbXHNIkv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 04:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753915AbXHNIkt
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 04:40:49 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:60274 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753787AbXHNIkq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 04:40:46 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070814084046.PIUJ325.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Tue, 14 Aug 2007 04:40:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id bkgl1X00M1kojtg0000000; Tue, 14 Aug 2007 04:40:46 -0400
In-Reply-To: <46BFFB1A.4070704@trolltech.com> (Marius Storm-Olsen's message of
	"Mon, 13 Aug 2007 08:32:58 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55816>

This splits out a common routine that parses a single line of
attribute file and adds it to the attr_stack.  It should not
change any behaviour, other than attrs array in the attr_stack
structure is now grown with alloc_nr() macro, instead of one by
one, which relied on xrealloc() to give enough slack to be
efficient enough.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Marius Storm-Olsen <marius@trolltech.com> writes:

 >> This essentially treats not having .gitattributes files checked
 >> out as equivalent to having these files checked out unmodified,
 >> which is very much in line with how the world is designed to
 >> work.
 >
 > ACK! We really need this! :-)

 So this is the first part, which does not do much.  The second
 one is interesting.

 attr.c |   67 +++++++++++++++++++++++++++++++++++++++------------------------
 1 files changed, 41 insertions(+), 26 deletions(-)

diff --git a/attr.c b/attr.c
index a071254..8d778f1 100644
--- a/attr.c
+++ b/attr.c
@@ -257,6 +257,7 @@ static struct attr_stack {
 	struct attr_stack *prev;
 	char *origin;
 	unsigned num_matches;
+	unsigned alloc;
 	struct match_attr **attrs;
 } *attr_stack;
 
@@ -287,6 +288,26 @@ static const char *builtin_attr[] = {
 	NULL,
 };
 
+static void handle_attr_line(struct attr_stack *res,
+			     const char *line,
+			     const char *src,
+			     int lineno,
+			     int macro_ok)
+{
+	struct match_attr *a;
+
+	a = parse_attr_line(line, src, lineno, macro_ok);
+	if (!a)
+		return;
+	if (res->alloc <= res->num_matches) {
+		res->alloc = alloc_nr(res->num_matches);
+		res->attrs = xrealloc(res->attrs,
+				      sizeof(struct match_attr *) *
+				      res->alloc);
+	}
+	res->attrs[res->num_matches++] = a;
+}
+
 static struct attr_stack *read_attr_from_array(const char **list)
 {
 	struct attr_stack *res;
@@ -294,42 +315,34 @@ static struct attr_stack *read_attr_from_array(const char **list)
 	int lineno = 0;
 
 	res = xcalloc(1, sizeof(*res));
-	while ((line = *(list++)) != NULL) {
-		struct match_attr *a;
-
-		a = parse_attr_line(line, "[builtin]", ++lineno, 1);
-		if (!a)
-			continue;
-		res->attrs = xrealloc(res->attrs,
-			sizeof(struct match_attr *) * (res->num_matches + 1));
-		res->attrs[res->num_matches++] = a;
-	}
+	while ((line = *(list++)) != NULL)
+		handle_attr_line(res, line, "[builtin]", ++lineno, 1);
 	return res;
 }
 
 static struct attr_stack *read_attr_from_file(const char *path, int macro_ok)
 {
-	FILE *fp;
+	FILE *fp = fopen(path, "r");
 	struct attr_stack *res;
 	char buf[2048];
 	int lineno = 0;
 
-	res = xcalloc(1, sizeof(*res));
-	fp = fopen(path, "r");
 	if (!fp)
-		return res;
+		return NULL;
+	res = xcalloc(1, sizeof(*res));
+	while (fgets(buf, sizeof(buf), fp))
+		handle_attr_line(res, buf, path, ++lineno, macro_ok);
+	fclose(fp);
+	return res;
+}
 
-	while (fgets(buf, sizeof(buf), fp)) {
-		struct match_attr *a;
+static struct attr_stack *read_attr(const char *path, int macro_ok)
+{
+	struct attr_stack *res;
 
-		a = parse_attr_line(buf, path, ++lineno, macro_ok);
-		if (!a)
-			continue;
-		res->attrs = xrealloc(res->attrs,
-			sizeof(struct match_attr *) * (res->num_matches + 1));
-		res->attrs[res->num_matches++] = a;
-	}
-	fclose(fp);
+	res = read_attr_from_file(path, macro_ok);
+	if (!res)
+		res = xcalloc(1, sizeof(*res));
 	return res;
 }
 
@@ -370,13 +383,15 @@ static void bootstrap_attr_stack(void)
 		elem->prev = attr_stack;
 		attr_stack = elem;
 
-		elem = read_attr_from_file(GITATTRIBUTES_FILE, 1);
+		elem = read_attr(GITATTRIBUTES_FILE, 1);
 		elem->origin = strdup("");
 		elem->prev = attr_stack;
 		attr_stack = elem;
 		debug_push(elem);
 
 		elem = read_attr_from_file(git_path(INFOATTRIBUTES_FILE), 1);
+		if (!elem)
+			elem = xcalloc(1, sizeof(*elem));
 		elem->origin = NULL;
 		elem->prev = attr_stack;
 		attr_stack = elem;
@@ -441,7 +456,7 @@ static void prepare_attr_stack(const char *path, int dirlen)
 		memcpy(pathbuf + dirlen, "/", 2);
 		cp = strchr(pathbuf + len + 1, '/');
 		strcpy(cp + 1, GITATTRIBUTES_FILE);
-		elem = read_attr_from_file(pathbuf, 0);
+		elem = read_attr(pathbuf, 0);
 		*cp = '\0';
 		elem->origin = strdup(pathbuf);
 		elem->prev = attr_stack;
-- 
1.5.3.rc4.89.g18078
