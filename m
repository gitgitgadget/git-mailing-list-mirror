From: Junio C Hamano <gitster@pobox.com>
Subject: Fix --signoff in builtin-commit differently.
Date: Sun, 02 Dec 2007 13:43:34 -0800
Message-ID: <7v63zgvkl5.fsf@gitster.siamese.dyndns.org>
References: <5F1A20CC-7427-4E7A-AB95-E89C9FA17951@zib.de>
	<7vir3hx70y.fsf@gitster.siamese.dyndns.org>
	<20071202193918.GQ6212@lavos.net>
	<7vmyssvn55.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bdowning@lavos.net (Brian Downing),
	Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Dec 02 22:44:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iywba-00070K-Jx
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 22:44:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbXLBVnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 16:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbXLBVnn
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 16:43:43 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:40941 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbXLBVnm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 16:43:42 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 3B5312F0;
	Sun,  2 Dec 2007 16:44:03 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 2E8D39C359;
	Sun,  2 Dec 2007 16:43:58 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66821>

Introduce fmt_name() specifically meant for formatting the name and
email pair, to add signed-off-by value.  This reverts parts of
13208572fbe8838fd8835548d7502202d1f7b21d (builtin-commit: fix --signoff)
so that an empty datestamp string given to fmt_ident() by mistake will
error out as before.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Junio C Hamano <gitster@pobox.com> writes:

 >> Personally, I think if the date_str is not NULL, it should die() on
 >> anything that can't successfully be parsed as a date, rather than simply
 >> falling back to the current time.  But maybe that's a bit extreme.
 >
 > Yeah, that change does look like a hack now we look at it again.  It
 > would have been much cleaner to make the caller accept the default
 > behaviour of fmt_ident() and strip out the part it does not want from
 > the result.  That way, the damage would have been much contained.
 >
 > The next issue would be to find who could pass an empty GIT_AUTHOR_DATE
 > without noticing...

 Perhaps like this...

 builtin-commit.c |    6 ++----
 cache.h          |    1 +
 ident.c          |   34 ++++++++++++++++++++++++----------
 3 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 96cb544..2319cc1 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -346,11 +346,9 @@ static int prepare_log_message(const char *index_file, const char *prefix)
 
 		strbuf_init(&sob, 0);
 		strbuf_addstr(&sob, sign_off_header);
-		strbuf_addstr(&sob, fmt_ident(getenv("GIT_COMMITTER_NAME"),
-					      getenv("GIT_COMMITTER_EMAIL"),
-					      "", 1));
+		strbuf_addstr(&sob, fmt_name(getenv("GIT_COMMITTER_NAME"),
+					     getenv("GIT_COMMITTER_EMAIL")));
 		strbuf_addch(&sob, '\n');
-
 		for (i = sb.len - 1; i > 0 && sb.buf[i - 1] != '\n'; i--)
 			; /* do nothing */
 		if (prefixcmp(sb.buf + i, sob.buf)) {
diff --git a/cache.h b/cache.h
index cf0bdc6..43cfebb 100644
--- a/cache.h
+++ b/cache.h
@@ -444,6 +444,7 @@ enum date_mode parse_date_format(const char *format);
 extern const char *git_author_info(int);
 extern const char *git_committer_info(int);
 extern const char *fmt_ident(const char *name, const char *email, const char *date_str, int);
+extern const char *fmt_name(const char *name, const char *email);
 
 struct checkout {
 	const char *base_dir;
diff --git a/ident.c b/ident.c
index 5be7533..021d79b 100644
--- a/ident.c
+++ b/ident.c
@@ -192,12 +192,14 @@ static const char *env_hint =
 "Omit --global to set the identity only in this repository.\n"
 "\n";
 
-const char *fmt_ident(const char *name, const char *email,
-		      const char *date_str, int error_on_no_name)
+static const char *fmt_ident_1(const char *name, const char *email,
+			       const char *date_str, int flag)
 {
 	static char buffer[1000];
 	char date[50];
 	int i;
+	int error_on_no_name = !!(flag & 01);
+	int name_addr_only = !!(flag & 02);
 
 	setup_ident();
 	if (!name)
@@ -224,24 +226,36 @@ const char *fmt_ident(const char *name, const char *email,
 	}
 
 	strcpy(date, git_default_date);
-	if (date_str) {
-		if (*date_str)
-			parse_date(date_str, date, sizeof(date));
-		else
-			date[0] = '\0';
-	}
+	if (!name_addr_only && date_str)
+		parse_date(date_str, date, sizeof(date));
 
 	i = copy(buffer, sizeof(buffer), 0, name);
 	i = add_raw(buffer, sizeof(buffer), i, " <");
 	i = copy(buffer, sizeof(buffer), i, email);
-	i = add_raw(buffer, sizeof(buffer), i, date[0] ? "> " : ">");
-	i = copy(buffer, sizeof(buffer), i, date);
+	if (!name_addr_only) {
+		i = add_raw(buffer, sizeof(buffer), i,  "> ");
+		i = copy(buffer, sizeof(buffer), i, date);
+	} else {
+		i = add_raw(buffer, sizeof(buffer), i, ">");
+	}
 	if (i >= sizeof(buffer))
 		die("Impossibly long personal identifier");
 	buffer[i] = 0;
 	return buffer;
 }
 
+const char *fmt_ident(const char *name, const char *email,
+		      const char *date_str, int error_on_no_name)
+{
+	int flag = (error_on_no_name ? 01 : 0);
+	return fmt_ident_1(name, email, date_str, flag);
+}
+
+const char *fmt_name(const char *name, const char *email)
+{
+	return fmt_ident_1(name, email, NULL, 03);
+}
+
 const char *git_author_info(int error_on_no_name)
 {
 	return fmt_ident(getenv("GIT_AUTHOR_NAME"),
