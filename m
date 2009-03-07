From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH v2 5/5] Support '*' in the middle of a refspec
Date: Sat, 7 Mar 2009 01:11:39 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0903070109590.19665@iabervon.org>
References: <alpine.LNX.1.00.0903052356010.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 07:13:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfpmY-0002N0-6Y
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 07:13:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752434AbZCGGLn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 01:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752397AbZCGGLn
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 01:11:43 -0500
Received: from iabervon.org ([66.92.72.58]:44327 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751998AbZCGGLl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 01:11:41 -0500
Received: (qmail 6957 invoked by uid 1000); 7 Mar 2009 06:11:39 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Mar 2009 06:11:39 -0000
In-Reply-To: <alpine.LNX.1.00.0903052356010.19665@iabervon.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112512>

In order to keep the requirements strict, each * has to be a full path
component, and there may only be one * per side. This requirement is
enforced entirely by check_ref_format(); the matching implementation
will substitute the whatever matches the * in the lhs for the * in the
rhs.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
Rebased on the new version of the earlier patches

 refs.c             |   11 +++++++----
 remote.c           |   24 +++++++++++++++++-------
 t/t5511-refspec.sh |   12 ++++++++++++
 3 files changed, 36 insertions(+), 11 deletions(-)

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
index d596a48..90203e2 100644
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
@@ -718,22 +718,32 @@ static int match_name_with_pattern(const char *key, const char *name,
 {
 	const char *kstar = strchr(key, '*');
 	size_t klen;
+	size_t ksuffixlen;
+	size_t namelen;
 	int ret;
 	if (!kstar)
 		die("Key '%s' of pattern had no '*'", key);
 	klen = kstar - key;
-	ret = !strncmp(key, name, klen);
+	ksuffixlen = strlen(kstar + 1);
+	namelen = strlen(name);
+	ret = !strncmp(name, key, klen) && namelen >= klen + ksuffixlen &&
+		!memcmp(name + namelen - ksuffixlen, kstar + 1, ksuffixlen);
 	if (ret && value) {
 		const char *vstar = strchr(value, '*');
 		size_t vlen;
+		size_t vsuffixlen;
 		if (!vstar)
 			die("Value '%s' of pattern has no '*'", value);
 		vlen = vstar - value;
-		*result = xmalloc(vlen +
+		vsuffixlen = strlen(vstar + 1);
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
+		       vstar + 1);
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
