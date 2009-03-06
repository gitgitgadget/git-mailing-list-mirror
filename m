From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 5/5] Support '*' in the middle of a refspec
Date: Thu, 5 Mar 2009 23:56:25 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0903052356010.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 05:58:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfS8T-00005C-QL
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 05:58:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753892AbZCFE4e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 23:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753268AbZCFE4c
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 23:56:32 -0500
Received: from iabervon.org ([66.92.72.58]:51784 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753157AbZCFE41 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 23:56:27 -0500
Received: (qmail 6385 invoked by uid 1000); 6 Mar 2009 04:56:25 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Mar 2009 04:56:25 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112384>

In order to keep the requirements strict, each * has to be a full path
component, and there may only be one * per side. This requirement is
enforced entirely by check_ref_format(); the matching implementation
will substitute the whatever matches the * in the lhs for the * in the
rhs.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 refs.c             |   11 +++++++----
 remote.c           |   27 ++++++++++++++++++---------
 t/t5511-refspec.sh |   12 ++++++++++++
 3 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/refs.c b/refs.c
index a50ba79..fef7c9f 100644
--- a/refs.c
+++ b/refs.c
@@ -694,6 +694,7 @@ static inline int bad_ref_char(int ch)
 int check_ref_format(const char *ref)
 {
 	int ch, level, bad_type;
+	int ret = CHECK_REF_FORMAT_OK;
 	const char *cp = ref;
 
 	level = 0;
@@ -709,9 +710,11 @@ int check_ref_format(const char *ref)
 			return CHECK_REF_FORMAT_ERROR;
 		bad_type = bad_ref_char(ch);
 		if (bad_type) {
-			return (bad_type == 2 && !*cp)
-				? CHECK_REF_FORMAT_WILDCARD
-				: CHECK_REF_FORMAT_ERROR;
+			if (bad_type == 2 && (!*cp || *cp == '/') &&
+			    ret == CHECK_REF_FORMAT_OK)
+				ret = CHECK_REF_FORMAT_WILDCARD;
+			else
+				return CHECK_REF_FORMAT_ERROR;
 		}
 
 		/* scan the rest of the path component */
@@ -729,7 +732,7 @@ int check_ref_format(const char *ref)
 		if (!ch) {
 			if (level < 2)
 				return CHECK_REF_FORMAT_ONELEVEL;
-			return CHECK_REF_FORMAT_OK;
+			return ret;
 		}
 	}
 }
diff --git a/remote.c b/remote.c
index d0ce4c6..41005cf 100644
--- a/remote.c
+++ b/remote.c
@@ -511,12 +511,12 @@ static struct refspec *parse_refspec_internal(int nr_refspec, const char **refsp
 
 		if (rhs) {
 			size_t rlen = strlen(++rhs);
-			is_glob = (2 <= rlen && !strcmp(rhs + rlen - 2, "/*"));
+			is_glob = (1 <= rlen && strchr(rhs, '*'));
 			rs[i].dst = xstrndup(rhs, rlen);
 		}
 
 		llen = (rhs ? (rhs - lhs - 1) : strlen(lhs));
-		if (2 <= llen && !memcmp(lhs + llen - 2, "/*", 2)) {
+		if (1 <= llen && memchr(lhs, '*', llen)) {
 			if ((rhs && !is_glob) || (!rhs && fetch))
 				goto invalid;
 			is_glob = 1;
@@ -716,15 +716,24 @@ int remote_has_url(struct remote *remote, const char *url)
 static int name_fits_pattern(const char *key, const char *name,
 			     const char *value, char **result)
 {
-	size_t klen = strchr(key, '*') - key;
-	int ret = !strncmp(name, key, klen);
+	const char *keystar = strchr(key, '*');
+	size_t klen = keystar - key;
+	size_t ksuffixlen = strlen(keystar + 1);
+	size_t namelen = strlen(name);
+	int ret = !strncmp(name, key, klen) && namelen >= klen + ksuffixlen &&
+		!memcmp(name + namelen - ksuffixlen, keystar + 1, ksuffixlen);
 	if (ret && value) {
-		size_t vlen = strchr(value, '*') - value;
-		*result = xmalloc(vlen +
+		const char *valuestar = strchr(value, '*');
+		size_t vlen = valuestar - value;
+		size_t vsuffixlen = strlen(valuestar + 1);
+		*result = xmalloc(vlen + vsuffixlen +
 				  strlen(name) -
-				  klen + 1);
-		strcpy(*result, value);
-		strcpy(*result + vlen, name + klen);
+				  klen - ksuffixlen + 1);
+		strncpy(*result, value, vlen);
+		strncpy(*result + vlen,
+			name + klen, namelen - klen - ksuffixlen);
+		strcpy(*result + vlen + namelen - klen - ksuffixlen,
+		       valuestar + 1);
 	}
 	return ret;
 }
diff --git a/t/t5511-refspec.sh b/t/t5511-refspec.sh
index 22ba380..c289322 100755
--- a/t/t5511-refspec.sh
+++ b/t/t5511-refspec.sh
@@ -72,4 +72,16 @@ test_refspec fetch ':refs/remotes/frotz/HEAD-to-me'
 test_refspec push ':refs/remotes/frotz/delete me'		invalid
 test_refspec fetch ':refs/remotes/frotz/HEAD to me'		invalid
 
+test_refspec fetch 'refs/heads/*/for-linus:refs/remotes/mine/*-blah' invalid
+test_refspec push 'refs/heads/*/for-linus:refs/remotes/mine/*-blah' invalid
+
+test_refspec fetch 'refs/heads*/for-linus:refs/remotes/mine/*' invalid
+test_refspec push 'refs/heads*/for-linus:refs/remotes/mine/*' invalid
+
+test_refspec fetch 'refs/heads/*/*/for-linus:refs/remotes/mine/*' invalid
+test_refspec push 'refs/heads/*/*/for-linus:refs/remotes/mine/*' invalid
+
+test_refspec fetch 'refs/heads/*/for-linus:refs/remotes/mine/*'
+test_refspec push 'refs/heads/*/for-linus:refs/remotes/mine/*'
+
 test_done
-- 
1.6.1.286.gd33a4.dirty
