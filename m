From: Michal Marek <mmarek@suse.cz>
Subject: [PATCH] apply: handle filenames with double slashes better
Date: Thu, 21 May 2009 14:25:11 +0200
Message-ID: <20090521122511.GA31614@sepie.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michal Marek <mmarek@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 21 14:25:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M77Kz-0003Hn-Cd
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 14:25:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbZEUMZN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2009 08:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750880AbZEUMZM
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 08:25:12 -0400
Received: from cantor2.suse.de ([195.135.220.15]:58158 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750711AbZEUMZL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2009 08:25:11 -0400
Received: from relay1.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 6B27774862
	for <git@vger.kernel.org>; Thu, 21 May 2009 14:25:12 +0200 (CEST)
Received: by sepie.suse.cz (Postfix, from userid 10020)
	id 0F64576646; Thu, 21 May 2009 14:25:11 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119673>

Collapse double slashes to make patches like this work with --index or
--cached:

git apply --index <<-EOF
	--- a/perl//Git.pm
	+++ b/perl//Git.pm
	@@ -1358,3 +1358,4 @@


	 1; # Famous last words
	+# test
EOF

Signed-off-by: Michal Marek <mmarek@suse.cz>
---
 builtin-apply.c |   26 ++++++++++++++++++++------
 1 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 8a3771e..0c623e4 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -320,6 +320,20 @@ static int name_terminate(const char *name, int namelen, int c, int terminate)
 	return 1;
 }
 
+/* remove double slashes to make --index work with such filenames */
+static char *canon_name(char *name)
+{
+	int i = 0, j = 0;
+
+	while (name[i]) {
+		if ((name[j++] = name[i++]) == '/')
+			while (name[i] == '/')
+				i++;
+	}
+	name[j] = '\0';
+	return name;
+}
+
 static char *find_name(const char *line, char *def, int p_value, int terminate)
 {
 	int len;
@@ -349,7 +363,7 @@ static char *find_name(const char *line, char *def, int p_value, int terminate)
 				free(def);
 				if (root)
 					strbuf_insert(&name, 0, root, root_len);
-				return strbuf_detach(&name, NULL);
+				return canon_name(strbuf_detach(&name, NULL));
 			}
 		}
 		strbuf_release(&name);
@@ -369,10 +383,10 @@ static char *find_name(const char *line, char *def, int p_value, int terminate)
 			start = line;
 	}
 	if (!start)
-		return def;
+		return canon_name(def);
 	len = line - start;
 	if (!len)
-		return def;
+		return canon_name(def);
 
 	/*
 	 * Generally we prefer the shorter name, especially
@@ -383,7 +397,7 @@ static char *find_name(const char *line, char *def, int p_value, int terminate)
 	if (def) {
 		int deflen = strlen(def);
 		if (deflen < len && !strncmp(start, def, deflen))
-			return def;
+			return canon_name(def);
 		free(def);
 	}
 
@@ -392,10 +406,10 @@ static char *find_name(const char *line, char *def, int p_value, int terminate)
 		strcpy(ret, root);
 		memcpy(ret + root_len, start, len);
 		ret[root_len + len] = '\0';
-		return ret;
+		return canon_name(ret);
 	}
 
-	return xmemdupz(start, len);
+	return canon_name(xmemdupz(start, len));
 }
 
 static int count_slashes(const char *cp)
-- 
1.6.3
