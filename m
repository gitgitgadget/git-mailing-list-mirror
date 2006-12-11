X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH/RFC] Add support for push globbed refspecs
Date: Mon, 11 Dec 2006 21:33:41 +0000
Message-ID: <200612112133.42060.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 21:36:47 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=mD9bIBSB93S8kgSk2ZQcDwnY12OBJ+ocwnbnuYtRb05FgUmhhwo8fW6jGUWb3kttIcJwOwLGNCMkN/79mpldP7bMu8wQSVli/ZatLCsklGJYqnbwDI0lKeVJJ4Tt4sq/XZrtfRkeB4UD637wc0L5dKHqijLhg2IHPSPKUmg0Nd4=
X-TUID: 9f2ff0cb3ad9b080
X-UID: 182
X-Length: 3238
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34039>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtspG-0002yB-5X for gcvg-git@gmane.org; Mon, 11 Dec
 2006 22:36:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937020AbWLKVgj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 16:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937052AbWLKVgj
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 16:36:39 -0500
Received: from an-out-0708.google.com ([209.85.132.245]:48164 "EHLO
 an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S937020AbWLKVgi (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec
 2006 16:36:38 -0500
Received: by an-out-0708.google.com with SMTP id b33so330633ana for
 <git@vger.kernel.org>; Mon, 11 Dec 2006 13:36:37 -0800 (PST)
Received: by 10.78.170.17 with SMTP id s17mr1655824hue.1165872995793; Mon, 11
 Dec 2006 13:36:35 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id 39sm3226080hug.2006.12.11.13.36.34; Mon, 11 Dec
 2006 13:36:35 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Just as we now have glob support in fetch refspecs, this patch adds
support for globs in the push refspecs.  In other words you can do:

[remote "globs"]
	url = proto://host/repo.git
	push = refs/heads/*:refs/remotes/from_me/*

With this, a git-push will then do a normal directory glob on the local
ref path; whatever it finds will have the matching part extracted and
inserted into the remote half of the refspec.

Note the following:
 - subdirectories aren't supported
 - globs with more than one "*" will probably go /very/ wrong

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
I'm not sure this is the right way to have done this.

My feeling is that perhaps a for_each_ref() call and some string
manipulation would have been better.  What'd you all reckon?


 builtin-push.c |   70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index d23974e..e60db71 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -5,6 +5,7 @@
 #include "refs.h"
 #include "run-command.h"
 #include "builtin.h"
+#include <glob.h>
 
 #define MAX_URI (16)
 
@@ -22,6 +23,75 @@ static int refspec_nr;
 static void add_refspec(const char *ref)
 {
 	int nr = refspec_nr + 1;
+	char *globpos_local = NULL,
+		 *globpos_remote = NULL,
+		 *separator = NULL;
+	char *buffer;
+
+	/* See if the ref is a globref */
+	buffer = xmalloc(strlen(ref)+1);
+	strcpy(buffer, ref);
+	separator = strstr(buffer, ":");
+	if (separator != NULL)
+		globpos_remote = strstr(separator, "*");
+	globpos_local = strstr(buffer, "*");
+
+	/* If globpos is set, then we have enough information to perform
+	 * the expansion */
+	if( globpos_remote != NULL && globpos_local != NULL) {
+		glob_t globres;
+		int ret;
+		unsigned int i;
+		unsigned int gitpathlen;
+		char *newrefspec;
+
+		/* Break the refspec into chunks:
+		 *  <localref>:<remote_prefix>*<remoteref_suffix>
+		 */
+		*separator = '\0';
+		separator++;
+		*globpos_remote = '\0';
+		globpos_remote++;
+		/* Now buffer points at localref; separator points at
+		 * remoteref prefix, globpos_remote points at remoteref suffix */
+
+		/* Fetch all the matching local refs */
+		globres.gl_offs = 0;
+		ret = glob(git_path("%s", buffer), GLOB_ERR, NULL, &globres);
+		gitpathlen = strlen( git_path("") );
+
+		if (ret == 0) {
+			for (i = 0; i < globres.gl_pathc; i++) {
+				char *p, *q;
+
+				p = globres.gl_pathv[i] + gitpathlen + (globpos_local - buffer);
+				q = p + strlen(p) - strlen(globpos_local+1);
+
+				newrefspec = xmalloc(
+						strlen(globres.gl_pathv[i] + gitpathlen)
+						+ strlen(separator)
+						+ (q-p)
+						+ strlen( globpos_remote)
+						+ 1 + 1 );
+
+				sprintf( newrefspec, "%s:%s%.*s%s",
+						globres.gl_pathv[i] + gitpathlen,
+						separator,
+						q-p, p,
+						globpos_remote );
+
+				add_refspec( newrefspec );
+			}
+		}
+
+		/* tidy up */
+		globfree( &globres );
+
+		/* Don't add the globspec */
+		return;
+	}
+	free(buffer);
+
 	refspec = xrealloc(refspec, nr * sizeof(char *));
 	refspec[nr-1] = ref;
 	refspec_nr = nr;
-- 
1.4.4.1.GIT
