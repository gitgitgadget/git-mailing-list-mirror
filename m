From: Michal Marek <mmarek@suse.cz>
Subject: Re: [PATCH] apply: handle filenames with double slashes better
Date: Mon, 25 May 2009 11:11:43 +0200
Message-ID: <20090525091142.GA17042@sepie.suse.cz>
References: <20090521122511.GA31614@sepie.suse.cz> <7vd4a2bj3p.fsf@alter.siamese.dyndns.org> <20090521191204.GA29362@sepie.suse.cz> <7vws8a9s7r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 25 11:11:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8WDp-0001d4-1A
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 11:11:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259AbZEYJLp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 05:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752129AbZEYJLo
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 05:11:44 -0400
Received: from cantor.suse.de ([195.135.220.2]:57900 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751608AbZEYJLn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 05:11:43 -0400
Received: from relay2.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 95C5893B4B;
	Mon, 25 May 2009 11:11:44 +0200 (CEST)
Received: by sepie.suse.cz (Postfix, from userid 10020)
	id 14E6F76646; Mon, 25 May 2009 11:11:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vws8a9s7r.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119903>

On Thu, May 21, 2009 at 12:22:16PM -0700, Junio C Hamano wrote:
> Let's take your first patch with just the s/canon_name/squash_slash/
> change.

Sorry for the delay, Here's hopefully the final patch:

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
 builtin-apply.c |   28 ++++++++++++++++++++++------
 1 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 8a3771e..10fefa0 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -320,6 +320,22 @@ static int name_terminate(const char *name, int namelen, int c, int terminate)
 	return 1;
 }
 
+/* remove double slashes to make --index work with such filenames */
+static char *squash_slash(char *name)
+{
+	int i = 0, j = 0;
+
+	if (!name)
+		return name;
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
@@ -349,7 +365,7 @@ static char *find_name(const char *line, char *def, int p_value, int terminate)
 				free(def);
 				if (root)
 					strbuf_insert(&name, 0, root, root_len);
-				return strbuf_detach(&name, NULL);
+				return squash_slash(strbuf_detach(&name, NULL));
 			}
 		}
 		strbuf_release(&name);
@@ -369,10 +385,10 @@ static char *find_name(const char *line, char *def, int p_value, int terminate)
 			start = line;
 	}
 	if (!start)
-		return def;
+		return squash_slash(def);
 	len = line - start;
 	if (!len)
-		return def;
+		return squash_slash(def);
 
 	/*
 	 * Generally we prefer the shorter name, especially
@@ -383,7 +399,7 @@ static char *find_name(const char *line, char *def, int p_value, int terminate)
 	if (def) {
 		int deflen = strlen(def);
 		if (deflen < len && !strncmp(start, def, deflen))
-			return def;
+			return squash_slash(def);
 		free(def);
 	}
 
@@ -392,10 +408,10 @@ static char *find_name(const char *line, char *def, int p_value, int terminate)
 		strcpy(ret, root);
 		memcpy(ret + root_len, start, len);
 		ret[root_len + len] = '\0';
-		return ret;
+		return squash_slash(ret);
 	}
 
-	return xmemdupz(start, len);
+	return squash_slash(xmemdupz(start, len));
 }
 
 static int count_slashes(const char *cp)
-- 
1.6.3
