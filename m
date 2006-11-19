X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/3] shortlog: read mailmap from ./.mailmap again
Date: Sun, 19 Nov 2006 17:28:51 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611191728340.13772@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
NNTP-Posting-Date: Sun, 19 Nov 2006 16:29:05 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31837>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlpXM-0000wd-GR for gcvg-git@gmane.org; Sun, 19 Nov
 2006 17:28:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756756AbWKSQ2x (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 11:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756757AbWKSQ2x
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 11:28:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:41448 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1756756AbWKSQ2x (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 11:28:53 -0500
Received: (qmail invoked by alias); 19 Nov 2006 16:28:51 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp021) with SMTP; 19 Nov 2006 17:28:51 +0100
To: junkio@cox.net, git@vger.kernel.org
Sender: git-owner@vger.kernel.org


While at it, remove the linux specific mailmap into
contrib/mailmap.linux.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 builtin-shortlog.c    |   81 +++++++++++++++++++++++-------------------------
 contrib/mailmap.linux |   40 ++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 42 deletions(-)

diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index 26212b0..afc9456 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -22,48 +22,40 @@ static int compare_by_number(const void
 		return +1;
 }
 
-static struct path_list_item mailmap_list[] = {
-	{ "R.Marek@sh.cvut.cz", (void*)"Rudolf Marek" },
-	{ "Ralf.Wildenhues@gmx.de", (void*)"Ralf Wildenhues" },
-	{ "aherrman@de.ibm.com", (void*)"Andreas Herrmann" },
-	{ "akpm@osdl.org", (void*)"Andrew Morton" },
-	{ "andrew.vasquez@qlogic.com", (void*)"Andrew Vasquez" },
-	{ "aquynh@gmail.com", (void*)"Nguyen Anh Quynh" },
-	{ "axboe@suse.de", (void*)"Jens Axboe" },
-	{ "blaisorblade@yahoo.it", (void*)"Paolo 'Blaisorblade' Giarrusso" },
-	{ "bunk@stusta.de", (void*)"Adrian Bunk" },
-	{ "domen@coderock.org", (void*)"Domen Puncer" },
-	{ "dougg@torque.net", (void*)"Douglas Gilbert" },
-	{ "dwmw2@shinybook.infradead.org", (void*)"David Woodhouse" },
-	{ "ecashin@coraid.com", (void*)"Ed L Cashin" },
-	{ "felix@derklecks.de", (void*)"Felix Moeller" },
-	{ "fzago@systemfabricworks.com", (void*)"Frank Zago" },
-	{ "gregkh@suse.de", (void*)"Greg Kroah-Hartman" },
-	{ "hch@lst.de", (void*)"Christoph Hellwig" },
-	{ "htejun@gmail.com", (void*)"Tejun Heo" },
-	{ "jejb@mulgrave.(none)", (void*)"James Bottomley" },
-	{ "jejb@titanic.il.steeleye.com", (void*)"James Bottomley" },
-	{ "jgarzik@pretzel.yyz.us", (void*)"Jeff Garzik" },
-	{ "johnpol@2ka.mipt.ru", (void*)"Evgeniy Polyakov" },
-	{ "kay.sievers@vrfy.org", (void*)"Kay Sievers" },
-	{ "minyard@acm.org", (void*)"Corey Minyard" },
-	{ "mshah@teja.com", (void*)"Mitesh shah" },
-	{ "pj@ludd.ltu.se", (void*)"Peter A Jonsson" },
-	{ "rmps@joel.ist.utl.pt", (void*)"Rui Saraiva" },
-	{ "santtu.hyrkko@gmail.com", (void*)"Santtu Hyrkk,Av(B" },
-	{ "simon@thekelleys.org.uk", (void*)"Simon Kelley" },
-	{ "ssant@in.ibm.com", (void*)"Sachin P Sant" },
-	{ "terra@gnome.org", (void*)"Morten Welinder" },
-	{ "tony.luck@intel.com", (void*)"Tony Luck" },
-	{ "welinder@anemone.rentec.com", (void*)"Morten Welinder" },
-	{ "welinder@darter.rentec.com", (void*)"Morten Welinder" },
-	{ "welinder@troll.com", (void*)"Morten Welinder" }
-};
-
-static struct path_list mailmap = {
-	mailmap_list,
-	sizeof(mailmap_list) / sizeof(struct path_list_item), 0, 0
-};
+static struct path_list mailmap = {NULL, 0, 0, 0};
+
+static int read_mailmap(const char *filename)
+{
+	char buffer[1024];
+	FILE *f = fopen(filename, "r");
+
+	if (f == NULL)
+		return 1;
+	while (fgets(buffer, sizeof(buffer), f) != NULL) {
+		char *end_of_name, *left_bracket, *right_bracket;
+		char *name, *email;
+		if (buffer[0] == '#')
+			continue;
+		if ((left_bracket = strchr(buffer, '<')) == NULL)
+			continue;
+		if ((right_bracket = strchr(left_bracket + 1, '>')) == NULL)
+			continue;
+		if (right_bracket == left_bracket + 1)
+			continue;
+		for (end_of_name = left_bracket; end_of_name != buffer
+				&& isspace(end_of_name[-1]); end_of_name--)
+			/* keep on looking */
+		if (end_of_name == buffer)
+			continue;
+		name = xmalloc(end_of_name - buffer + 1);
+		strlcpy(name, buffer, end_of_name - buffer + 1);
+		email = xmalloc(right_bracket - left_bracket);
+		strlcpy(email, left_bracket + 1, right_bracket - left_bracket);
+		path_list_insert(email, &mailmap)->util = name;
+	}
+	fclose(f);
+	return 0;
+}
 
 static int map_email(char *email, char *name, int maxlen)
 {
@@ -269,6 +261,9 @@ int cmd_shortlog(int argc, const char **
 		argc--;
 	}
 
+	if (!access(".mailmap", R_OK))
+		read_mailmap(".mailmap");
+
 	if (rev.pending.nr == 1)
 		die ("Need a range!");
 	else if (rev.pending.nr == 0)
@@ -298,6 +293,8 @@ int cmd_shortlog(int argc, const char **
 
 	list.strdup_paths = 1;
 	path_list_clear(&list, 1);
+	mailmap.strdup_paths = 1;
+	path_list_clear(&mailmap, 1);
 
 	return 0;
 }
diff --git a/contrib/mailmap.linux b/contrib/mailmap.linux
new file mode 100644
index 0000000..83927c9
--- /dev/null
+++ b/contrib/mailmap.linux
@@ -0,0 +1,40 @@
+#
+# Even with git, we don't always have name translations.
+# So have an email->real name table to translate the
+# (hopefully few) missing names
+#
+Adrian Bunk <bunk@stusta.de>
+Andreas Herrmann <aherrman@de.ibm.com>
+Andrew Morton <akpm@osdl.org>
+Andrew Vasquez <andrew.vasquez@qlogic.com>
+Christoph Hellwig <hch@lst.de>
+Corey Minyard <minyard@acm.org>
+David Woodhouse <dwmw2@shinybook.infradead.org>
+Domen Puncer <domen@coderock.org>
+Douglas Gilbert <dougg@torque.net>
+Ed L Cashin <ecashin@coraid.com>
+Evgeniy Polyakov <johnpol@2ka.mipt.ru>
+Felix Moeller <felix@derklecks.de>
+Frank Zago <fzago@systemfabricworks.com>
+Greg Kroah-Hartman <gregkh@suse.de>
+James Bottomley <jejb@mulgrave.(none)>
+James Bottomley <jejb@titanic.il.steeleye.com>
+Jeff Garzik <jgarzik@pretzel.yyz.us>
+Jens Axboe <axboe@suse.de>
+Kay Sievers <kay.sievers@vrfy.org>
+Mitesh shah <mshah@teja.com>
+Morten Welinder <terra@gnome.org>
+Morten Welinder <welinder@anemone.rentec.com>
+Morten Welinder <welinder@darter.rentec.com>
+Morten Welinder <welinder@troll.com>
+Nguyen Anh Quynh <aquynh@gmail.com>
+Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
+Peter A Jonsson <pj@ludd.ltu.se>
+Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
+Rudolf Marek <R.Marek@sh.cvut.cz>
+Rui Saraiva <rmps@joel.ist.utl.pt>
+Sachin P Sant <ssant@in.ibm.com>
+Santtu Hyrkk,Av(B <santtu.hyrkko@gmail.com>
+Simon Kelley <simon@thekelleys.org.uk>
+Tejun Heo <htejun@gmail.com>
+Tony Luck <tony.luck@intel.com>
-- 
1.4.4.GIT
