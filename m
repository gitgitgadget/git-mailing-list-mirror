From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] use the path as name from the revision:path syntax in setup_revisions
Date: Sat, 15 Jul 2006 14:56:02 +0200
Message-ID: <E1G1jgg-0007ds-DP@moooo.ath.cx>
References: <e9aff7$nk1$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 15 14:56:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1jgq-0005cB-4V
	for gcvg-git@gmane.org; Sat, 15 Jul 2006 14:56:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161153AbWGOM4H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Jul 2006 08:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161270AbWGOM4H
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Jul 2006 08:56:07 -0400
Received: from moooo.ath.cx ([85.116.203.178]:14807 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1161153AbWGOM4G (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Jul 2006 08:56:06 -0400
To: Jakub Narebski <jnareb@gmail.com>
Mail-Followup-To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <e9aff7$nk1$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23932>

---
Jakub Narebski <jnareb@gmail.com> wrote:
> git diff output for files specified by revision is somewhat unexpected. 
> 
>   $ git diff <revision_1>:<file> <revision_2>:<file>
> 
> outputs the following diff metainfo
> 
>   diff --git a/<revision_2>:<file> b/<revision_2>:<file>
>   index 5eabe06..2e87de4 100644
>   --- a/<revision_2>:<file>
>   +++ b/<revision_2>:<file>
> 
> Is it intended, or is it a bug? Looks like a bug to me...
I guess the revision should not be there.  Here is a patch to remove
it.
<matled> is there a name for 'revision:path' to specify a file at a
         certain revision?
<jdl> "That weird syntax, you know."
<matled> get_path_out_of_the_weird_syntax(const char *s)
<matled> you know :)
<jdl> That should do it!
Could someone please come up with a nice name for the function?
Without knowing a name for the '<revision>:<path>' syntax I can only
think of get_path or similar names and this is much too generic imo.
---
 cache.h     |    1 +
 revision.c  |    2 ++
 sha1_name.c |   12 ++++++++++++
 3 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index d433d46..7da1c5c 100644
--- a/cache.h
+++ b/cache.h
@@ -249,6 +249,7 @@ #define DEFAULT_ABBREV 7
 
 extern int get_sha1(const char *str, unsigned char *sha1);
 extern int get_sha1_hex(const char *hex, unsigned char *sha1);
+extern char *get_path_out_of_the_weird_syntax(const char *str);
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
 extern int read_ref(const char *filename, unsigned char *sha1);
 extern const char *resolve_ref(const char *path, unsigned char *sha1, int);
diff --git a/revision.c b/revision.c
index 874e349..fbd1458 100644
--- a/revision.c
+++ b/revision.c
@@ -908,6 +908,8 @@ int setup_revisions(int argc, const char
 		if (!seen_dashdash)
 			verify_non_filename(revs->prefix, arg);
 		object = get_reference(revs, arg, sha1, flags ^ local_flags);
+		if (object->type == OBJ_BLOB || object->type == OBJ_TREE)
+			arg = get_path_out_of_the_weird_syntax(arg);
 		add_pending_object(revs, object, arg);
 	}
 	if (show_merge)
diff --git a/sha1_name.c b/sha1_name.c
index 5fe8e5d..718ce1b 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -543,3 +543,15 @@ int get_sha1(const char *name, unsigned 
 	}
 	return ret;
 }
+
+/* get the path from sha1:path, :path and :[0-3]:path */
+char *get_path_out_of_the_weird_syntax(const char *str)
+{
+	if (strlen(str) >= 3 &&
+		str[0] == ':' && str[2] == ':' &&
+		str[1] >= '0' && str[2] <= '3')
+		return((char*)(str+3));
+	if (index(str, ':'))
+		return index(str, ':')+1;
+	return str;
+}
-- 
1.4.1.ga3e6
