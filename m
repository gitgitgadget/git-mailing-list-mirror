From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-push: allow globbing wildcard refspec.
Date: Mon, 05 Feb 2007 23:48:09 -0800
Message-ID: <7vtzxziv5y.fsf_-_@assigned-by-dhcp.cox.net>
References: <7v7iv2soxv.fsf@assigned-by-dhcp.cox.net>
	<7vps8qtgbm.fsf@assigned-by-dhcp.cox.net>
	<7v3b5jka3t.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 06 08:48:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEL3q-0004Lh-PT
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 08:48:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbXBFHsM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 02:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbXBFHsL
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 02:48:11 -0500
Received: from fed1rmmtai18.cox.net ([68.230.241.41]:54164 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750949AbXBFHsK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 02:48:10 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070206074810.MFJX1302.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Tue, 6 Feb 2007 02:48:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id L7o91W00L1kojtg0000000; Tue, 06 Feb 2007 02:48:09 -0500
In-Reply-To: <7v3b5jka3t.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 05 Feb 2007 23:40:06 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38820>

This allows you to set up mothership-satellite configuration
more symmetrically and naturally by allowing the globbing
wildcard refspec for git-push.  On your satellite machine:

    [remote "mothership"]
        url = mothership:project.git
        pull = refs/heads/*:refs/remotes/mothership/*
        push = refs/heads/*:refs/remotes/satellite/*

You would say "git fetch mothership" to update your tracking
branches under mothership/ to keep track of the progress on the
mothership side, and when you are done working on the satellite
machine, you would "git push mothership" to update their
tracking branches under satellite/.  Corresponding configuration
on the mothership machine can be used to make "git fetch satellite"
update its tracking branch under satellite/. on the mothership.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-push.c |  114 ++++++++++++++++++++++++++++++++++++++++----------------
 1 files changed, 82 insertions(+), 32 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index 5f4d7d3..c45649e 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -54,38 +54,84 @@ static void expand_refspecs(void)
 	for_each_ref(expand_one_ref, NULL);
 }
 
+struct wildcard_cb {
+	const char *from_prefix;
+	int from_prefix_len;
+	const char *to_prefix;
+	int to_prefix_len;
+	int force;
+};
+
+static int expand_wildcard_ref(const char *ref, const unsigned char *sha1, int flag, void *cb_data)
+{
+	struct wildcard_cb *cb = cb_data;
+	int len = strlen(ref);
+	char *expanded, *newref;
+
+	if (len < cb->from_prefix_len ||
+	    memcmp(cb->from_prefix, ref, cb->from_prefix_len))
+		return 0;
+	expanded = xmalloc(len * 2 + cb->force +
+			   (cb->to_prefix_len - cb->from_prefix_len) + 2);
+	newref = expanded + cb->force;
+	if (cb->force)
+		expanded[0] = '+';
+	memcpy(newref, ref, len);
+	newref[len] = ':';
+	memcpy(newref + len + 1, cb->to_prefix, cb->to_prefix_len);
+	strcpy(newref + len + 1 + cb->to_prefix_len,
+	       ref + cb->from_prefix_len);
+	add_refspec(expanded);
+	return 0;
+}
+
+static int wildcard_ref(const char *ref)
+{
+	int len;
+	const char *colon;
+	struct wildcard_cb cb;
+
+	memset(&cb, 0, sizeof(cb));
+	if (ref[0] == '+') {
+		cb.force = 1;
+		ref++;
+	}
+	len = strlen(ref);
+	colon = strchr(ref, ':');
+	if (! (colon && ref < colon &&
+	       colon[-2] == '/' && colon[-1] == '*' &&
+	       /* "<mine>/<asterisk>:<yours>/<asterisk>" is at least 7 bytes */
+	       7 <= len &&
+	       ref[len-2] == '/' && ref[len-1] == '*') )
+		return 0 ;
+	cb.from_prefix = ref;
+	cb.from_prefix_len = colon - ref - 1;
+	cb.to_prefix = colon + 1;
+	cb.to_prefix_len = len - (colon - ref) - 2;
+	for_each_ref(expand_wildcard_ref, &cb);
+	return 1;
+}
+
 static void set_refspecs(const char **refs, int nr)
 {
 	if (nr) {
-		int pass;
-		for (pass = 0; pass < 2; pass++) {
-			/* pass 0 counts and allocates, pass 1 fills */
-			int i, cnt;
-			for (i = cnt = 0; i < nr; i++) {
-				if (!strcmp("tag", refs[i])) {
-					int len;
-					char *tag;
-					if (nr <= ++i)
-						die("tag <tag> shorthand without <tag>");
-					if (pass) {
-						len = strlen(refs[i]) + 11;
-						tag = xmalloc(len);
-						strcpy(tag, "refs/tags/");
-						strcat(tag, refs[i]);
-						refspec[cnt] = tag;
-					}
-					cnt++;
-					continue;
-				}
-				if (pass)
-					refspec[cnt] = refs[i];
-				cnt++;
-			}
-			if (!pass) {
-				size_t bytes = cnt * sizeof(char *);
-				refspec_nr = cnt;
-				refspec = xrealloc(refspec, bytes);
+		int i;
+		for (i = 0; i < nr; i++) {
+			const char *ref = refs[i];
+			if (!strcmp("tag", ref)) {
+				char *tag;
+				int len;
+				if (nr <= ++i)
+					die("tag shorthand without <tag>");
+				len = strlen(refs[i]) + 11;
+				tag = xmalloc(len);
+				strcpy(tag, "refs/tags/");
+				strcat(tag, refs[i]);
+				ref = tag;
 			}
+			else if (wildcard_ref(ref))
+				continue;
+			add_refspec(ref);
 		}
 	}
 	expand_refspecs();
@@ -129,8 +175,10 @@ static int get_remotes_uri(const char *repo, const char *uri[MAX_URI])
 			else
 				error("more than %d URL's specified, ignoring the rest", MAX_URI);
 		}
-		else if (is_refspec && !has_explicit_refspec)
-			add_refspec(xstrdup(s));
+		else if (is_refspec && !has_explicit_refspec) {
+			if (!wildcard_ref(s))
+				add_refspec(xstrdup(s));
+		}
 	}
 	fclose(f);
 	if (!n)
@@ -156,8 +204,10 @@ static int get_remote_config(const char* key, const char* value)
 				error("more than %d URL's specified, ignoring the rest", MAX_URI);
 		}
 		else if (config_get_refspecs &&
-			 !strcmp(key + 7 + config_repo_len, ".push"))
-			add_refspec(xstrdup(value));
+			 !strcmp(key + 7 + config_repo_len, ".push")) {
+			if (!wildcard_ref(value))
+				add_refspec(xstrdup(value));
+		}
 		else if (config_get_receivepack &&
 			 !strcmp(key + 7 + config_repo_len, ".receivepack")) {
 			if (!receivepack) {
-- 
1.5.0.rc3.83.g88293c-dirty
