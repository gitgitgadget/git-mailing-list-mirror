From: Linus Torvalds <torvalds@osdl.org>
Subject: Make git-rev-list and git-rev-parse argument parsing stricter
Date: Wed, 25 Jan 2006 17:00:37 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0601251655580.2644@evo.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Jan 25 23:01:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1shC-0000Ng-FH
	for gcvg-git@gmane.org; Wed, 25 Jan 2006 23:00:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWAYWAv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jan 2006 17:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWAYWAv
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jan 2006 17:00:51 -0500
Received: from smtp.osdl.org ([65.172.181.4]:36826 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751123AbWAYWAu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Jan 2006 17:00:50 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0PM0lDZ011266
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 25 Jan 2006 14:00:47 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0PM0jJj007306;
	Wed, 25 Jan 2006 14:00:46 -0800
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.66__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15138>


If you pass it a filename without the "--" marker to separate it from
revision information and flags, we now require that the file in question
actually exists. This makes mis-typed revision information not be silently
just considered a strange filename.

With the "--" marker, you can continue to pass in filenames that do not
actually exists - useful for querying what happened to a file that you
no longer have in the repository.

[ All scripts should use the "--" format regardless, to make things
  unambiguous. So this change should not affect any existing tools ]

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
----

I hit this the hard way when I was showing off git at Linux.Conf.Au 
yesterday, and I asked for

	git log v2.6.14..v2.6.16

which silently did nothing at all. The reason? I don't actually have a 
v2.6.16, the most recent version is 2.6.16-rc1. So it thought 
v2.6.14..v2.6.16 was a _filename_.

Now, normally, if you use the "proper" format (with the -- delimeter to 
mark where filenames start), you'd never have this ambiguity. But without 
the "--", the way I decided that we should disambiguate things is to 
verify that any filename given with the ambiguous shorthand version 
actually exists.

Comments?

diff --git a/rev-list.c b/rev-list.c
index d060966..e00e6fc 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -844,8 +844,12 @@ int main(int argc, const char **argv)
 			arg++;
 			limited = 1;
 		}
-		if (get_sha1(arg, sha1) < 0)
+		if (get_sha1(arg, sha1) < 0) {
+			struct stat st;
+			if (lstat(arg, &st) < 0)
+				die("'%s': %s", arg, strerror(errno));
 			break;
+		}
 		commit = get_commit_reference(arg, sha1, flags);
 		handle_one_commit(commit, &list);
 	}
diff --git a/rev-parse.c b/rev-parse.c
index 0c951af..7abad35 100644
--- a/rev-parse.c
+++ b/rev-parse.c
@@ -154,6 +154,7 @@ int main(int argc, char **argv)
 	const char *prefix = setup_git_directory();
 	
 	for (i = 1; i < argc; i++) {
+		struct stat st;
 		char *arg = argv[i];
 		char *dotdot;
 	
@@ -293,6 +294,8 @@ int main(int argc, char **argv)
 		}
 		if (verify)
 			die("Needed a single revision");
+		if (lstat(arg, &st) < 0)
+			die("'%s': %s", arg, strerror(errno));
 		as_is = 1;
 		show_file(arg);
 	}
