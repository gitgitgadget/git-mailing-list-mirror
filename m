From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH/RFC v1 5/5] builtin/remote.c: cleanup using strbuf_set operations
Date: Mon,  9 Jun 2014 01:36:29 -0700
Message-ID: <ddc394a84d897bbbb3b24253a2e45bbcbe4b9f55.1402301816.git.jmmahler@gmail.com>
References: <cover.1402301815.git.jmmahler@gmail.com>
Cc: Jeremiah Mahler <jmmahler@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 09 10:37:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wtv5S-0007Jz-R1
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jun 2014 10:37:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755219AbaFIIhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 04:37:46 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:57843 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755026AbaFIIho (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 04:37:44 -0400
Received: by mail-pd0-f175.google.com with SMTP id z10so4581619pdj.6
        for <git@vger.kernel.org>; Mon, 09 Jun 2014 01:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=KO8tTF2/0RXHIprrdidbf8txQewQ6AZRE3aV4Zg9vdY=;
        b=pbrqwH0Ez+lxQ71SZeJbqwLSRUqrWTkbHq6e0aXKSBbAh3RKC3KgJm5vErbVvV00sf
         a3sqXaxE7iDaTGFqfNkQuuFGziOmh1wbH2utDvjAyyatljaxv4bm3YDFpPEvhCkerzMK
         x1mX2emHr/f6DgVvmro45TZ40lrPdFHZtQMSf0P+5IgWUhcdBgERHeDiucyQTvzC8fhg
         GdVQN0yH21aaiZCX8SrJsaNJPgvYIjARxuiPIqXeTWdUBsd76F1HEgqsD6q0XuZQYBPm
         c3gjmqcj5y7wvTHt9xxEGsDUZKZ3A537uL3CFWalLAcU/C8Iky5n4GTxt597+hEPjWS2
         CcmA==
X-Received: by 10.66.66.199 with SMTP id h7mr3077457pat.30.1402303063301;
        Mon, 09 Jun 2014 01:37:43 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id jd5sm62733340pbb.18.2014.06.09.01.37.40
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 09 Jun 2014 01:37:41 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Mon, 09 Jun 2014 01:37:39 -0700
X-Mailer: git-send-email 2.0.0.573.ged771ce.dirty
In-Reply-To: <cover.1402301815.git.jmmahler@gmail.com>
In-Reply-To: <cover.1402301815.git.jmmahler@gmail.com>
References: <cover.1402301815.git.jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251064>

Simplified cases where a strbuf_reset was immediately followed by a
strbuf_add using the new strbuf_set operations.

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 builtin/remote.c | 51 +++++++++++++++++----------------------------------
 1 file changed, 17 insertions(+), 34 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index c9b67ff..b059852 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -193,8 +193,7 @@ static int add(int argc, const char **argv)
 		return 1;
 
 	if (!mirror || mirror & MIRROR_FETCH) {
-		strbuf_reset(&buf);
-		strbuf_addf(&buf, "remote.%s.fetch", name);
+		strbuf_setf(&buf, "remote.%s.fetch", name);
 		if (track.nr == 0)
 			string_list_append(&track, "*");
 		for (i = 0; i < track.nr; i++) {
@@ -205,15 +204,13 @@ static int add(int argc, const char **argv)
 	}
 
 	if (mirror & MIRROR_PUSH) {
-		strbuf_reset(&buf);
-		strbuf_addf(&buf, "remote.%s.mirror", name);
+		strbuf_setf(&buf, "remote.%s.mirror", name);
 		if (git_config_set(buf.buf, "true"))
 			return 1;
 	}
 
 	if (fetch_tags != TAGS_DEFAULT) {
-		strbuf_reset(&buf);
-		strbuf_addf(&buf, "remote.%s.tagopt", name);
+		strbuf_setf(&buf, "remote.%s.tagopt", name);
 		if (git_config_set(buf.buf,
 			fetch_tags == TAGS_SET ? "--tags" : "--no-tags"))
 			return 1;
@@ -223,11 +220,9 @@ static int add(int argc, const char **argv)
 		return 1;
 
 	if (master) {
-		strbuf_reset(&buf);
-		strbuf_addf(&buf, "refs/remotes/%s/HEAD", name);
+		strbuf_setf(&buf, "refs/remotes/%s/HEAD", name);
 
-		strbuf_reset(&buf2);
-		strbuf_addf(&buf2, "refs/remotes/%s/%s", name, master);
+		strbuf_setf(&buf2, "refs/remotes/%s/%s", name, master);
 
 		if (create_symref(buf.buf, buf2.buf, "remote add"))
 			return error(_("Could not setup master '%s'"), master);
@@ -589,14 +584,12 @@ static int migrate_file(struct remote *remote)
 		if (git_config_set_multivar(buf.buf, remote->url[i], "^$", 0))
 			return error(_("Could not append '%s' to '%s'"),
 					remote->url[i], buf.buf);
-	strbuf_reset(&buf);
-	strbuf_addf(&buf, "remote.%s.push", remote->name);
+	strbuf_setf(&buf, "remote.%s.push", remote->name);
 	for (i = 0; i < remote->push_refspec_nr; i++)
 		if (git_config_set_multivar(buf.buf, remote->push_refspec[i], "^$", 0))
 			return error(_("Could not append '%s' to '%s'"),
 					remote->push_refspec[i], buf.buf);
-	strbuf_reset(&buf);
-	strbuf_addf(&buf, "remote.%s.fetch", remote->name);
+	strbuf_setf(&buf, "remote.%s.fetch", remote->name);
 	for (i = 0; i < remote->fetch_refspec_nr; i++)
 		if (git_config_set_multivar(buf.buf, remote->fetch_refspec[i], "^$", 0))
 			return error(_("Could not append '%s' to '%s'"),
@@ -644,23 +637,20 @@ static int mv(int argc, const char **argv)
 	if (!valid_fetch_refspec(buf.buf))
 		die(_("'%s' is not a valid remote name"), rename.new);
 
-	strbuf_reset(&buf);
-	strbuf_addf(&buf, "remote.%s", rename.old);
+	strbuf_setf(&buf, "remote.%s", rename.old);
 	strbuf_addf(&buf2, "remote.%s", rename.new);
 	if (git_config_rename_section(buf.buf, buf2.buf) < 1)
 		return error(_("Could not rename config section '%s' to '%s'"),
 				buf.buf, buf2.buf);
 
-	strbuf_reset(&buf);
-	strbuf_addf(&buf, "remote.%s.fetch", rename.new);
+	strbuf_setf(&buf, "remote.%s.fetch", rename.new);
 	if (git_config_set_multivar(buf.buf, NULL, NULL, 1))
 		return error(_("Could not remove config section '%s'"), buf.buf);
 	strbuf_addf(&old_remote_context, ":refs/remotes/%s/", rename.old);
 	for (i = 0; i < oldremote->fetch_refspec_nr; i++) {
 		char *ptr;
 
-		strbuf_reset(&buf2);
-		strbuf_addstr(&buf2, oldremote->fetch_refspec[i]);
+		strbuf_setstr(&buf2, oldremote->fetch_refspec[i]);
 		ptr = strstr(buf2.buf, old_remote_context.buf);
 		if (ptr) {
 			refspec_updated = 1;
@@ -683,8 +673,7 @@ static int mv(int argc, const char **argv)
 		struct string_list_item *item = branch_list.items + i;
 		struct branch_info *info = item->util;
 		if (info->remote_name && !strcmp(info->remote_name, rename.old)) {
-			strbuf_reset(&buf);
-			strbuf_addf(&buf, "branch.%s.remote", item->string);
+			strbuf_setf(&buf, "branch.%s.remote", item->string);
 			if (git_config_set(buf.buf, rename.new)) {
 				return error(_("Could not set '%s'"), buf.buf);
 			}
@@ -715,12 +704,10 @@ static int mv(int argc, const char **argv)
 
 		if (item->util)
 			continue;
-		strbuf_reset(&buf);
-		strbuf_addstr(&buf, item->string);
+		strbuf_setstr(&buf, item->string);
 		strbuf_splice(&buf, strlen("refs/remotes/"), strlen(rename.old),
 				rename.new, strlen(rename.new));
-		strbuf_reset(&buf2);
-		strbuf_addf(&buf2, "remote: renamed %s to %s",
+		strbuf_setf(&buf2, "remote: renamed %s to %s",
 				item->string, buf.buf);
 		if (rename_ref(item->string, buf.buf, buf2.buf))
 			die(_("renaming '%s' failed"), item->string);
@@ -730,16 +717,13 @@ static int mv(int argc, const char **argv)
 
 		if (!item->util)
 			continue;
-		strbuf_reset(&buf);
-		strbuf_addstr(&buf, item->string);
+		strbuf_setstr(&buf, item->string);
 		strbuf_splice(&buf, strlen("refs/remotes/"), strlen(rename.old),
 				rename.new, strlen(rename.new));
-		strbuf_reset(&buf2);
-		strbuf_addstr(&buf2, item->util);
+		strbuf_setstr(&buf2, item->util);
 		strbuf_splice(&buf2, strlen("refs/remotes/"), strlen(rename.old),
 				rename.new, strlen(rename.new));
-		strbuf_reset(&buf3);
-		strbuf_addf(&buf3, "remote: renamed %s to %s",
+		strbuf_setf(&buf3, "remote: renamed %s to %s",
 				item->string, buf.buf);
 		if (create_symref(buf.buf, buf2.buf, buf3.buf))
 			die(_("creating '%s' failed"), buf.buf);
@@ -804,8 +788,7 @@ static int rm(int argc, const char **argv)
 		if (info->remote_name && !strcmp(info->remote_name, remote->name)) {
 			const char *keys[] = { "remote", "merge", NULL }, **k;
 			for (k = keys; *k; k++) {
-				strbuf_reset(&buf);
-				strbuf_addf(&buf, "branch.%s.%s",
+				strbuf_setf(&buf, "branch.%s.%s",
 						item->string, *k);
 				if (git_config_set(buf.buf, NULL)) {
 					strbuf_release(&buf);
-- 
2.0.0.573.ged771ce.dirty
