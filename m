From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [RFC/PATCH] git-shortlog: respect i18n.logOutputEncoding config setting
Date: Fri, 20 Feb 2009 02:12:38 +0100
Message-ID: <1235092358-6895-1-git-send-email-vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 20 02:13:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaJxY-00021O-Ry
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 02:13:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756994AbZBTBMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 20:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756575AbZBTBMO
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 20:12:14 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:50530 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756212AbZBTBMN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 20:12:13 -0500
Received: from vmobile.example.net (catv-80-98-230-81.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTPA id 22E05446CF0
	for <git@vger.kernel.org>; Fri, 20 Feb 2009 02:12:11 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id C9BDA186208; Fri, 20 Feb 2009 02:12:38 +0100 (CET)
X-Mailer: git-send-email 1.6.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110777>

As git-shortlog can be used as a filter as well, we do not really have
the encoding info to do a reencode_string(), but in case
i18n.logOutputEncoding is set, we can try to convert to the given value
from utf-8.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

It was just annoying for me that git log respected
i18n.logOutputEncoding, but I still saw unencoded utf-8 in git-shortlog
output. This patches fixes my problem.

Yes, I'm aware that hardwiring that utf-8 value is a bit hackish. But at
least this way the output encoding is correct in case the original
encoding is utf-8, which is true in most cases.

Or do you have a better idea?

 builtin-shortlog.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index badd912..cd95858 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -45,6 +45,7 @@ static void insert_one_record(struct shortlog *log,
 	const char *eol;
 	const char *boemail, *eoemail;
 	struct strbuf subject = STRBUF_INIT;
+	char *encoded_name = NULL;
 
 	boemail = strchr(author, '<');
 	if (!boemail)
@@ -84,7 +85,12 @@ static void insert_one_record(struct shortlog *log,
 		snprintf(namebuf + len, room, " <%.*s>", maillen, emailbuf);
 	}
 
-	item = string_list_insert(namebuf, &log->list);
+	if (git_log_output_encoding)
+		encoded_name = reencode_string(namebuf, git_log_output_encoding, "utf-8");
+	if (!encoded_name)
+		encoded_name = xstrdup(namebuf);
+	item = string_list_insert(encoded_name, &log->list);
+	free(encoded_name);
 	if (item->util == NULL)
 		item->util = xcalloc(1, sizeof(struct string_list));
 
-- 
1.6.1.3
