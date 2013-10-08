From: Chris J Arges <christopherarges@gmail.com>
Subject: [PATCH] blame: add color
Date: Tue,  8 Oct 2013 09:18:49 -0500
Message-ID: <1381241929-23378-1-git-send-email-christopherarges@gmail.com>
Cc: Chris J Arges <christopherarges@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 08 16:19:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTY8T-0006w1-Ar
	for gcvg-git-2@plane.gmane.org; Tue, 08 Oct 2013 16:19:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754508Ab3JHOTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Oct 2013 10:19:37 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:61514 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214Ab3JHOTg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Oct 2013 10:19:36 -0400
Received: by mail-oa0-f41.google.com with SMTP id n10so7633002oag.28
        for <git@vger.kernel.org>; Tue, 08 Oct 2013 07:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=hRzMGn4vjnViPvvFhpV5Hbxp3B/J9yDOTKnLJGRDeOc=;
        b=EtEcUP5wTWUZMjW/JlVenuoufPZyw8KAh8ufN2WrEwafxxPgd4EBK1q/IFHhdzogCc
         5ki0ChQAyPNwprDmVhRWYceWIQw1XgRoAYrynriceUz9JTizBJJZ6Tx2ybMjE96OO1Il
         yjJfzJ1ld03Wvbsmb2AJ8/h1uU/R9n/sJlaMFDRYmn+dCd2pWoGhRAJDS62hDs0pwvIC
         BZ0NfcJEp4wlBYBtMsY0JTQveYTtXu8rf5katKabXKehs+oCDPoRikQpheqng3SRz/C0
         0vUs8XMole7he+L0ypfMBMMLZEe1S+PXcGF5rO1hBQIN1HSTMj23UjcXb0XVHSNcO07i
         h9Rw==
X-Received: by 10.182.49.166 with SMTP id v6mr1376735obn.13.1381241975208;
        Tue, 08 Oct 2013 07:19:35 -0700 (PDT)
Received: from localhost.localdomain (cpe-66-68-155-223.austin.res.rr.com. [66.68.155.223])
        by mx.google.com with ESMTPSA id d8sm70524781oeu.6.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 08 Oct 2013 07:19:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235775>

Add colorized text for git blame when color.interactive is enabled.
This work is based on the colorization code in builtin/clean.c.

Signed-off-by: Chris J Arges <christopherarges@gmail.com>
---
 builtin/blame.c |   51 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 6da7233..fbff437 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -23,6 +23,7 @@
 #include "userdiff.h"
 #include "line-range.h"
 #include "line-log.h"
+#include "color.h"
 
 static char blame_usage[] = N_("git blame [options] [rev-opts] [rev] [--] file");
 
@@ -51,6 +52,24 @@ static size_t blame_date_width;
 
 static struct string_list mailmap;
 
+static int blame_use_color = -1;
+static char blame_colors[][COLOR_MAXLEN] = {
+	GIT_COLOR_RESET,
+	GIT_COLOR_NORMAL,	/* PLAIN */
+	GIT_COLOR_YELLOW,	/* COMMIT */
+	GIT_COLOR_BOLD,		/* NAME */
+	GIT_COLOR_CYAN,		/* LINE */
+	GIT_COLOR_GREEN,	/* TIME */
+};
+enum color_blame {
+	BLAME_COLOR_RESET = 0,
+	BLAME_COLOR_PLAIN = 1,
+	BLAME_COLOR_COMMIT = 2,
+	BLAME_COLOR_NAME = 3,
+	BLAME_COLOR_LINE = 4,
+	BLAME_COLOR_TIME = 5,
+};
+
 #ifndef DEBUG
 #define DEBUG 0
 #endif
@@ -1575,6 +1594,18 @@ static void assign_blame(struct scoreboard *sb, int opt)
 	}
 }
 
+static const char *blame_get_color(enum color_blame ix)
+{
+	if (want_color(blame_use_color))
+		return blame_colors[ix];
+	return "";
+}
+
+static void blame_print_color(enum color_blame ix)
+{
+	printf("%s", blame_get_color(ix));
+}
+
 static const char *format_time(unsigned long time, const char *tz_str,
 			       int show_raw_time)
 {
@@ -1680,7 +1711,9 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 			}
 		}
 
+		blame_print_color(BLAME_COLOR_COMMIT);
 		printf("%.*s", length, hex);
+		blame_print_color(BLAME_COLOR_RESET);
 		if (opt & OUTPUT_ANNOTATE_COMPAT) {
 			const char *name;
 			if (opt & OUTPUT_SHOW_EMAIL)
@@ -1711,14 +1744,22 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 				else
 					name = ci.author.buf;
 				pad = longest_author - utf8_strwidth(name);
-				printf(" (%s%*s %10s",
-				       name, pad, "",
+				blame_print_color(BLAME_COLOR_NAME);
+				printf(" (%s%*s ",
+				       name, pad, "");
+				blame_print_color(BLAME_COLOR_RESET);
+				blame_print_color(BLAME_COLOR_TIME);
+				printf(" (%10s",
 				       format_time(ci.author_time,
 						   ci.author_tz.buf,
 						   show_raw_time));
+
+				blame_print_color(BLAME_COLOR_RESET);
 			}
+			blame_print_color(BLAME_COLOR_LINE);
 			printf(" %*d) ",
 			       max_digits, ent->lno + 1 + cnt);
+			blame_print_color(BLAME_COLOR_RESET);
 		}
 		do {
 			ch = *cp++;
@@ -1948,6 +1989,12 @@ static int git_blame_config(const char *var, const char *value, void *cb)
 		blame_date_mode = parse_date_format(value);
 		return 0;
 	}
+	/* honors the color.interactive* config variables which also
+	   applied in git-add--interactive and git-stash */
+	if (!strcmp(var, "color.interactive")) {
+		blame_use_color = git_config_colorbool(var, value);
+		return 0;
+	}
 
 	if (userdiff_config(var, value) < 0)
 		return -1;
-- 
1.7.9.5
