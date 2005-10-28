From: Linus Torvalds <torvalds@osdl.org>
Subject: Be more careful about reference parsing
Date: Fri, 28 Oct 2005 12:41:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510281220290.4664@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Oct 28 21:44:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVa7F-00004r-6A
	for gcvg-git@gmane.org; Fri, 28 Oct 2005 21:42:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030348AbVJ1TmF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Oct 2005 15:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030640AbVJ1TmF
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Oct 2005 15:42:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:138 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030638AbVJ1TmE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Oct 2005 15:42:04 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9SJfrFC028200
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 28 Oct 2005 12:41:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9SJfoE5014501;
	Fri, 28 Oct 2005 12:41:52 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10773>


This does two things:

 - we don't allow "." and ".." as components of a refname. Thus get_sha1() 
   will not accept "./refname" as being the same as "refname" any more.

 - git-rev-parse stops doing revision translation after seeing a pathname, 
   to match the brhaviour of all the tools (once we see a pathname, 
   everything else will also be parsed as a pathname).

Basically, if you did

	git log *

and "gitk" was somewhere in the "*", we don't want to replace the filename 
"gitk" with the SHA1 of the branch with the same name.

Of course, if there is any change of ambiguity, you should always use "--" 
to make it explicit what are filenames and what are revisions, but this 
makes the normal cases sane. The refname rule also means that instead of 
the "--", you can do the same thing we're used to doing with filenames 
that start with a slash: use "./filename" instead, and now it's a 
filename, not an option (and not a revision).

So "git log ./*.c" is now actually a perfectly valid thing to do, even if 
the first C-file might have the same name as a branch.

Trivial test:

	git-rev-parse gitk ./gitk gitk

should output something like

	9843c3074dfbf57117565f6b7c93e3e6812857ee
	./gitk
	gitk

where the "./gitk" isn't seen as a revision, and the second "gitk" is a 
filename simply because we've seen filenames already, and thus stopped 
doing revision parsing.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
----

I like my "ambiguous_path()" function. Now, admittedly it thinks that 
".../" is also an ambigious path since it doesn't count the dots. But 
since we already don't like ".." inside refnames, we don't much care.

diff --git a/rev-parse.c b/rev-parse.c
index adfc68c..169d0cc 100644
--- a/rev-parse.c
+++ b/rev-parse.c
@@ -292,6 +292,7 @@ int main(int argc, char **argv)
 		}
 		if (verify)
 			die("Needed a single revision");
+		as_is = 1;
 		show_file(arg);
 	}
 	show_default();
diff --git a/sha1_name.c b/sha1_name.c
index cc320d3..fe409fb 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -203,6 +203,29 @@ const char *find_unique_abbrev(const uns
 	return NULL;
 }
 
+static int ambiguous_path(const char *path)
+{
+	int slash = 1;
+
+	for (;;) {
+		switch (*path++) {
+		case '\0':
+			break;
+		case '/':
+			if (slash)
+				break;
+			slash = 1;
+			continue;
+		case '.':
+			continue;
+		default:
+			slash = 0;
+			continue;
+		}
+		return slash;
+	}
+}
+
 static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 {
 	static const char *prefix[] = {
@@ -217,6 +240,10 @@ static int get_sha1_basic(const char *st
 	if (len == 40 && !get_sha1_hex(str, sha1))
 		return 0;
 
+	/* Accept only unambiguous ref paths. */
+	if (ambiguous_path(str))
+		return -1;
+
 	for (p = prefix; *p; p++) {
 		char *pathname = git_path("%s/%.*s", *p, len, str);
 		if (!read_ref(pathname, sha1))
