From: Andreas Ericsson <ae@op5.se>
Subject: [PATCH v2] fetch: Strip usernames from url's before storing them
Date: Wed, 15 Apr 2009 16:30:14 +0200
Message-ID: <1239805814-21340-1-git-send-email-ae@op5.se>
References: <49E5EBD2.1070704@op5.se>
Cc: git@vger.kernel.org, Andreas Ericsson <ae@op5.se>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Apr 15 16:32:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu69Z-00075m-H4
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 16:31:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753457AbZDOOaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 10:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752166AbZDOOaT
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 10:30:19 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:36430 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448AbZDOOaS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 10:30:18 -0400
Received: by fxm2 with SMTP id 2so2940838fxm.37
        for <git@vger.kernel.org>; Wed, 15 Apr 2009 07:30:16 -0700 (PDT)
Received: by 10.86.91.3 with SMTP id o3mr238872fgb.3.1239805815879;
        Wed, 15 Apr 2009 07:30:15 -0700 (PDT)
Received: from localhost.localdomain ([212.112.174.166])
        by mx.google.com with ESMTPS id 3sm3348241fge.4.2009.04.15.07.30.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Apr 2009 07:30:15 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc0.2.g743353.dirty
In-Reply-To: <49E5EBD2.1070704@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116613>

When pulling from a remote, the full URL including username
is by default added to the commit message. Since it adds
very little value but could be used by malicious people to
glean valid usernames (with matching hostnames), we're far
better off just stripping the username before storing the
remote URL locally.

Note that this patch has no lasting visible effect when
"git pull" does not create a merge commit. It simply
alters what gets written to .git/FETCH_HEAD, which is used
by "git merge" to automagically create its' messages.

Signed-off-by: Andreas Ericsson <ae@op5.se>
---

This incorporates the changes suggested by both J6t and
Michael Gruber, as well as the properly functioning
version of the patch (the last one had an off-by-lots
for some url's, as I failed at --amend'ing it).

 builtin-fetch.c |    7 +++++--
 transport.c     |   40 ++++++++++++++++++++++++++++++++++++++++
 transport.h     |    1 +
 3 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 3c998ea..0bb290b 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -289,7 +289,7 @@ static int update_local_ref(struct ref *ref,
 	}
 }
 
-static int store_updated_refs(const char *url, const char *remote_name,
+static int store_updated_refs(const char *raw_url, const char *remote_name,
 		struct ref *ref_map)
 {
 	FILE *fp;
@@ -298,11 +298,13 @@ static int store_updated_refs(const char *url, const char *remote_name,
 	char note[1024];
 	const char *what, *kind;
 	struct ref *rm;
-	char *filename = git_path("FETCH_HEAD");
+	char *url, *filename = git_path("FETCH_HEAD");
 
 	fp = fopen(filename, "a");
 	if (!fp)
 		return error("cannot open %s: %s\n", filename, strerror(errno));
+
+	url = transport_anonymize_url(raw_url);
 	for (rm = ref_map; rm; rm = rm->next) {
 		struct ref *ref = NULL;
 
@@ -376,6 +378,7 @@ static int store_updated_refs(const char *url, const char *remote_name,
 				fprintf(stderr, " %s\n", note);
 		}
 	}
+	free(url);
 	fclose(fp);
 	if (rc & 2)
 		error("some local refs could not be updated; try running\n"
diff --git a/transport.c b/transport.c
index 3dfb03c..9e6dc5e 100644
--- a/transport.c
+++ b/transport.c
@@ -1083,3 +1083,43 @@ int transport_disconnect(struct transport *transport)
 	free(transport);
 	return ret;
 }
+
+/*
+ * Strip username information from the url and return it in a
+ * newly allocated string which the caller has to free.
+ *
+ * The url's we want to catch are the following:
+ *   ssh://[user@]host.xz[:port]/path/to/repo.git/
+ *   [user@]host.xz:/path/to/repo.git/
+ *   http[s]://[user[:password]@]host.xz/path/to/repo.git
+ *
+ * Although git doesn't currently support giving the password
+ * to http url's on the command-line, it's easier to catch
+ * that case too than it is to cater for it specially.
+ */
+char *transport_anonymize_url(const char *url)
+{
+	char *anon_url;
+	const char *at_sign = strchr(url, '@');
+	size_t len, prefix_len = 0;
+
+	if (is_local(url) || !at_sign)
+		return xstrdup(url);
+
+	if (!prefixcmp(url, "ssh://"))
+		prefix_len = strlen("ssh://");
+	else if (!prefixcmp(url, "http://"))
+		prefix_len = strlen("http://");
+	else if (!prefixcmp(url, "https://"))
+		prefix_len = strlen("https://");
+	else if (!strchr(at_sign + 1, ':'))
+		return xstrdup(url);
+
+	len = prefix_len + strlen(at_sign + 1);
+	anon_url = xcalloc(1, 1 + prefix_len + strlen(at_sign + 1));
+	if (prefix_len)
+		memcpy(anon_url, url, prefix_len);
+	memcpy(anon_url + prefix_len, at_sign + 1, strlen(at_sign + 1));
+
+	return anon_url;
+}
diff --git a/transport.h b/transport.h
index b1c2252..27bfc52 100644
--- a/transport.h
+++ b/transport.h
@@ -74,5 +74,6 @@ const struct ref *transport_get_remote_refs(struct transport *transport);
 int transport_fetch_refs(struct transport *transport, const struct ref *refs);
 void transport_unlock_pack(struct transport *transport);
 int transport_disconnect(struct transport *transport);
+char *transport_anonymize_url(const char *url);
 
 #endif
-- 
1.6.3.rc0.2.g743353.dirty
