From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH] clean: confirm before cleaning files and directories
Date: Fri, 26 Apr 2013 16:07:56 +0800
Message-ID: <1826d070612808b301f9295838e226e02d8097ad.1366963586.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 10:08:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVdhn-0001OR-NO
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 10:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753513Ab3DZII0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 04:08:26 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:59413 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636Ab3DZIIP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 04:08:15 -0400
Received: by mail-pb0-f45.google.com with SMTP id ro2so1072064pbb.32
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 01:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=Y/dREHsZmpgo7QWc29b6f43oWZSHqaQ1bdpLTsbJ/2w=;
        b=D/LzpBmb1LXFZfpR0Ve15EwtW6oFFqlrz/IHRlhTRI0Oa3r9OcmEx6HFboDsYVcCM1
         ankb2o6SY+eFh8C/231vhu8yHKsE/9RK6kVnD3qdeuATo70Zu4VM5JsN1a+kUbCoW1VA
         XlDnb35C5iD9JAGAA7rwPsMkFYMFKrJbWu7xBrmvVx+y2yZjXHnIhe5OGY4I6HMJi14T
         jpt2ZcEu6i+BpFJme84UpBQvWUSXbnr+zCaaHKt5OvaqcWff7MK+PnQySJ/FJL0rPcYu
         OLoki740wt8l9DR4bXTeMhyvuoeh2Md71SjZ0gISmBWV6tLhJgtJHU0+75O+OZLblKWj
         HOug==
X-Received: by 10.68.93.1 with SMTP id cq1mr58580695pbb.50.1366963694780;
        Fri, 26 Apr 2013 01:08:14 -0700 (PDT)
Received: from localhost.localdomain ([114.248.159.33])
        by mx.google.com with ESMTPSA id b7sm10697339pba.39.2013.04.26.01.08.11
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 26 Apr 2013 01:08:13 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.628.gcd33b41
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222507>

When running `git clean`, it will be convenient and safe to show a
confirm dialog and only delete files and directories when confirmed.
The confirm dialog will popup when:

 * run `git clean` in interactive sessions,
 * not a dry run,
 * and not quiet.

There may be existing scripts that call `git clean -f` while leave the
standard input and the standard output of the `git clean` connected to
whatever environment the scripts were started, and such invocation might
trigger the confirm dialog. In this case, add a `-q` option, such as
`git clean -q -f`, then the confirm dialog won't popup.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 builtin/clean.c | 66 +++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 52 insertions(+), 14 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 04e39..e31a1 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -169,6 +169,10 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 				N_("remove only ignored files")),
 		OPT_END()
 	};
+	struct string_list dels = STRING_LIST_INIT_DUP;
+	struct string_list_item *item;
+	struct strbuf confirm = STRBUF_INIT;
+	int confirmed = 0;
 
 	git_config(git_clean_config, NULL);
 	if (force < 0)
@@ -257,33 +261,67 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		}
 
 		if (S_ISDIR(st.st_mode)) {
-			strbuf_addstr(&directory, ent->name);
 			if (remove_directories || (matches == MATCHED_EXACTLY)) {
+				string_list_append(&dels, ent->name);
+			}
+		} else {
+			if (pathspec && !matches)
+				continue;
+			string_list_append(&dels, ent->name);
+		}
+	}
+
+	if (!isatty(0) || !isatty(1) || quiet || dry_run) {
+		confirmed = 1;
+	}
+
+	if (!confirmed && dels.nr > 0) {
+		for_each_string_list_item(item, &dels) {
+			qname = quote_path_relative(item->string, -1, &buf, prefix);
+			printf(_(msg_would_remove), qname);
+		}
+		printf(_("Are you sure [y/N]? "));
+		strbuf_getline(&confirm, stdin, '\n');
+		strbuf_trim(&confirm);
+		if (!strcasecmp(confirm.buf, "y")) {
+			confirmed = 1;
+		}
+	}
+
+	if (confirmed) {
+		for_each_string_list_item(item, &dels) {
+			struct stat st;
+
+			if (lstat(item->string, &st))
+				continue;
+
+			if (S_ISDIR(st.st_mode)) {
+				strbuf_addstr(&directory, item->string);
 				if (remove_dirs(&directory, prefix, rm_flags, dry_run, quiet, &gone))
 					errors++;
 				if (gone && !quiet) {
 					qname = quote_path_relative(directory.buf, directory.len, &buf, prefix);
 					printf(dry_run ? _(msg_would_remove) : _(msg_remove), qname);
 				}
-			}
-			strbuf_reset(&directory);
-		} else {
-			if (pathspec && !matches)
-				continue;
-			res = dry_run ? 0 : unlink(ent->name);
-			if (res) {
-				qname = quote_path_relative(ent->name, -1, &buf, prefix);
-				warning(_(msg_warn_remove_failed), qname);
-				errors++;
-			} else if (!quiet) {
-				qname = quote_path_relative(ent->name, -1, &buf, prefix);
-				printf(dry_run ? _(msg_would_remove) : _(msg_remove), qname);
+				strbuf_reset(&directory);
+			} else {
+				res = dry_run ? 0 : unlink(item->string);
+				if (res) {
+					qname = quote_path_relative(item->string, -1, &buf, prefix);
+					warning(_(msg_warn_remove_failed), qname);
+					errors++;
+				} else if (!quiet) {
+					qname = quote_path_relative(item->string, -1, &buf, prefix);
+					printf(dry_run ? _(msg_would_remove) : _(msg_remove), qname);
+				}
 			}
 		}
 	}
 	free(seen);
 
 	strbuf_release(&directory);
+	strbuf_release(&confirm);
 	string_list_clear(&exclude_list, 0);
+	string_list_clear(&dels, 0);
 	return (errors != 0);
 }
-- 
1.8.2.1.628.gcd33b41
