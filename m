From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH RFC 3/8] git remote add: refactor configuration
Date: Mon, 20 Jul 2009 19:49:50 +0200
Message-ID: <1248112195-3761-4-git-send-email-bonzini@gnu.org>
References: <1248112195-3761-1-git-send-email-bonzini@gnu.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 20 19:50:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSx0A-0005Xp-EW
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 19:50:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753268AbZGTRuK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 13:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753235AbZGTRuK
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 13:50:10 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:56552 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752957AbZGTRuH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 13:50:07 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1MSx03-000331-EO
	for git@vger.kernel.org; Mon, 20 Jul 2009 13:50:07 -0400
X-Mailer: git-send-email 1.6.2.5
In-Reply-To: <1248112195-3761-1-git-send-email-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123625>

This moves the configuration setup of git remote add to
a separate function.  The next patch will add more
configuration options in setup_remote_config.

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
---
 builtin-remote.c |   74 ++++++++++++++++++++++++++++++++----------------------
 1 files changed, 44 insertions(+), 30 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 008abfe..c30fbb7 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -36,6 +36,49 @@ static inline int postfixcmp(const char *string, const char *postfix)
 	return strcmp(string + len1 - len2, postfix);
 }
 
+static int setup_remote_config(const char *name, const char *url, int mirror, struct string_list *track)
+{
+	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
+	int i;
+
+	if (mirror) {
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "remote.%s.mirror", name);
+		if (git_config_set(buf.buf, "true"))
+			return 1;
+	}
+
+	strbuf_reset(&buf);
+	strbuf_addf(&buf, "remote.%s.url", name);
+	if (git_config_set(buf.buf, url))
+		return 1;
+
+	strbuf_reset(&buf);
+	strbuf_addf(&buf, "remote.%s.fetch", name);
+
+	if (track->nr == 0)
+		string_list_append("*", track);
+
+	for (i = 0; i < track->nr; i++) {
+		struct string_list_item *item = track->items + i;
+
+		strbuf_reset(&buf2);
+		if (mirror)
+			strbuf_addf(&buf2, "+refs/%s:refs/%s",
+					item->string, item->string);
+		else
+			strbuf_addf(&buf2, "+refs/heads/%s:refs/remotes/%s/%s",
+					item->string, name, item->string);
+		if (git_config_set_multivar(buf.buf, buf2.buf, "^$", 0))
+			return 1;
+	}
+
+	strbuf_release(&buf);
+	strbuf_release(&buf2);
+	return 0;
+}
+
+
 static int opt_parse_track(const struct option *opt, const char *arg, int not)
 {
 	struct string_list *list = opt->value;
@@ -67,7 +110,6 @@ static int add(int argc, const char **argv)
 	struct remote *remote;
 	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
 	const char *name, *url;
-	int i;
 
 	struct option options[] = {
 		OPT_GROUP("add specific options"),
@@ -97,37 +139,9 @@ static int add(int argc, const char **argv)
 	if (!valid_fetch_refspec(buf2.buf))
 		die("'%s' is not a valid remote name", name);
 
-	strbuf_addf(&buf, "remote.%s.url", name);
-	if (git_config_set(buf.buf, url))
+	if (setup_remote_config(name, url, mirror, &track))
 		return 1;
 
-	strbuf_reset(&buf);
-	strbuf_addf(&buf, "remote.%s.fetch", name);
-
-	if (track.nr == 0)
-		string_list_append("*", &track);
-	for (i = 0; i < track.nr; i++) {
-		struct string_list_item *item = track.items + i;
-
-		strbuf_reset(&buf2);
-		strbuf_addch(&buf2, '+');
-		if (mirror)
-			strbuf_addf(&buf2, "refs/%s:refs/%s",
-					item->string, item->string);
-		else
-			strbuf_addf(&buf2, "refs/heads/%s:refs/remotes/%s/%s",
-					item->string, name, item->string);
-		if (git_config_set_multivar(buf.buf, buf2.buf, "^$", 0))
-			return 1;
-	}
-
-	if (mirror) {
-		strbuf_reset(&buf);
-		strbuf_addf(&buf, "remote.%s.mirror", name);
-		if (git_config_set(buf.buf, "true"))
-			return 1;
-	}
-
 	if (fetch && fetch_remote(name))
 		return 1;
 
-- 
1.6.2.5
