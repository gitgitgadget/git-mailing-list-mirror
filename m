From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 4/5] Keep '*' in pattern refspecs
Date: Thu, 5 Mar 2009 23:56:22 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0903052355480.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 05:58:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfS8T-00005C-2y
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 05:58:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753200AbZCFE4b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 23:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753268AbZCFE43
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 23:56:29 -0500
Received: from iabervon.org ([66.92.72.58]:51782 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753082AbZCFE41 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 23:56:27 -0500
Received: (qmail 6381 invoked by uid 1000); 6 Mar 2009 04:56:22 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Mar 2009 04:56:22 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112383>

In order to do anything more capable with refspecs, the first step is
to keep the entire input. Additionally, validate patterns by checking
for the ref matching the rules for a pattern as given by
check_ref_format(). This requires a slight change to make it require
the '*' to be at the beginning of a path component.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 refs.c   |    4 +---
 remote.c |   24 +++++++++---------------
 2 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/refs.c b/refs.c
index 6eb5f53..a50ba79 100644
--- a/refs.c
+++ b/refs.c
@@ -718,9 +718,7 @@ int check_ref_format(const char *ref)
 		while ((ch = *cp++) != 0) {
 			bad_type = bad_ref_char(ch);
 			if (bad_type) {
-				return (bad_type == 2 && !*cp)
-					? CHECK_REF_FORMAT_WILDCARD
-					: CHECK_REF_FORMAT_ERROR;
+				return CHECK_REF_FORMAT_ERROR;
 			}
 			if (ch == '/')
 				break;
diff --git a/remote.c b/remote.c
index 93fd03d..d0ce4c6 100644
--- a/remote.c
+++ b/remote.c
@@ -10,8 +10,8 @@ static struct refspec s_tag_refspec = {
 	0,
 	1,
 	0,
-	"refs/tags/",
-	"refs/tags/"
+	"refs/tags/*",
+	"refs/tags/*"
 };
 
 const struct refspec *tag_refspec = &s_tag_refspec;
@@ -451,16 +451,11 @@ static void read_config(void)
  */
 static int verify_refname(char *name, int is_glob)
 {
-	int result, len = -1;
+	int result;
 
-	if (is_glob) {
-		len = strlen(name);
-		assert(name[len - 1] == '/');
-		name[len - 1] = '\0';
-	}
 	result = check_ref_format(name);
-	if (is_glob)
-		name[len - 1] = '/';
+	if (is_glob && result == CHECK_REF_FORMAT_WILDCARD)
+		result = CHECK_REF_FORMAT_OK;
 	return result;
 }
 
@@ -517,7 +512,7 @@ static struct refspec *parse_refspec_internal(int nr_refspec, const char **refsp
 		if (rhs) {
 			size_t rlen = strlen(++rhs);
 			is_glob = (2 <= rlen && !strcmp(rhs + rlen - 2, "/*"));
-			rs[i].dst = xstrndup(rhs, rlen - is_glob);
+			rs[i].dst = xstrndup(rhs, rlen);
 		}
 
 		llen = (rhs ? (rhs - lhs - 1) : strlen(lhs));
@@ -525,7 +520,6 @@ static struct refspec *parse_refspec_internal(int nr_refspec, const char **refsp
 			if ((rhs && !is_glob) || (!rhs && fetch))
 				goto invalid;
 			is_glob = 1;
-			llen--;
 		} else if (rhs && is_glob) {
 			goto invalid;
 		}
@@ -722,10 +716,10 @@ int remote_has_url(struct remote *remote, const char *url)
 static int name_fits_pattern(const char *key, const char *name,
 			     const char *value, char **result)
 {
-	size_t klen = strlen(key);
-	int ret = !strncmp(key, name, klen);
+	size_t klen = strchr(key, '*') - key;
+	int ret = !strncmp(name, key, klen);
 	if (ret && value) {
-		size_t vlen = strlen(value);
+		size_t vlen = strchr(value, '*') - value;
 		*result = xmalloc(vlen +
 				  strlen(name) -
 				  klen + 1);
-- 
1.6.1.286.gd33a4.dirty
