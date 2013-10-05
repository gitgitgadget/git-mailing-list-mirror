From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCHv2 1/3] Documentation/git-svn: Promote the use of --prefix in docs + examples
Date: Sun,  6 Oct 2013 01:30:31 +0200
Message-ID: <1381015833-696-1-git-send-email-johan@herland.net>
References: <20131003190139.GA8710@dcvr.yhbt.net>
Cc: tfnico@gmail.com, Johan Herland <johan@herland.net>,
	Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 06 01:31:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VSbJp-00023H-3g
	for gcvg-git-2@plane.gmane.org; Sun, 06 Oct 2013 01:31:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752698Ab3JEXbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Oct 2013 19:31:07 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:35783 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524Ab3JEXbF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Oct 2013 19:31:05 -0400
Received: by mail-la0-f50.google.com with SMTP id gx14so4436334lab.37
        for <git@vger.kernel.org>; Sat, 05 Oct 2013 16:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yCMVLu9se8bcL/275FtfAPp8flJoSmcEXD/orIWxf6I=;
        b=jJxfTNis3c3ZNeszmXeWZ236rbJSvZEiezUEGr3IHtoVOMX61M/f8rg99UIaFRheaC
         uxA92XQaQl6LWwPL7+EQp8jiZxiABdKnTUDeUbMFoHEr4JeG6uwlo8P3CUAF04mua5kK
         oVn5qy/O4o5M/4oONc8u9BnuM+ZI2qtgGb8+3eVX7Lo1aNb911tLnbnNEEwY25Gn/S1y
         /7y720JCbWtMvVF6zyGX2pRT4GyYbCYVrPJvipEzf/rFq68j8P5f6FkErhP3wpeq7Z9S
         k6J12NQJ3xdc5IHlJdWAoDgnzsY66s04R5NmK9kCyXrtQEgxJp5w2yAnR1EUE+SrXMSS
         7mnA==
X-Received: by 10.112.51.166 with SMTP id l6mr18425149lbo.5.1381015863185;
        Sat, 05 Oct 2013 16:31:03 -0700 (PDT)
Received: from beta.herland (96.37-191-129.fiber.lynet.no. [37.191.129.96])
        by mx.google.com with ESMTPSA id i3sm17824544laf.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 05 Oct 2013 16:31:02 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.653.g2df02b3
In-Reply-To: <20131003190139.GA8710@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235732>

Currently, the git-svn defaults to using an empty prefix, which ends
up placing the SVN-tracking refs directly in refs/remotes/*. This
placement runs counter to Git's convention of placing remote-tracking
branches in refs/remotes/$remote/*.

Furthermore, combining git-svn with "regular" Git remotes run the risk
of clobbering refs under refs/remotes (e.g. if you have a git remote
called "tags" with a "v1" branch, it will overlap with the git-svn's
tracking branch for the "v1" tag from Subversion.

Even though the git-svn refs stored in refs/remotes/* are not "proper"
remote-tracking branches (since they are not covered by a proper git
remote's refspec), they clearly represent a similar concept, and would
benefit from following the same convention.

For example, if git-svn tracks Subversion branch "foo" at
refs/remotes/foo, and you create a local branch refs/heads/foo to add
some commits to be pushed back to Subversion (using "git svn dcommit),
then it is clearly unhelpful of Git to throw

  warning: refname 'foo' is ambiguous.

every time you checkout, rebase, or otherwise interact with the branch.

At this time, the user is better off using the --prefix=foo/ (the
trailing slash is important) to git svn init/clone, to cause the
SVN-tracking refs to be placed at refs/remotes/foo/* instead of
refs/remotes/*. This patch updates the documentation to encourage
use of --prefix.

This is also in preparation for changing the default value of --prefix
at some point in the future.

Cc: Eric Wong <normalperson@yhbt.net>
Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-svn.txt | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 4dd3bcb..da00671 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -79,8 +79,13 @@ COMMANDS
 	trailing slash, so be sure you include one in the
 	argument if that is what you want.  If --branches/-b is
 	specified, the prefix must include a trailing slash.
-	Setting a prefix is useful if you wish to track multiple
-	projects that share a common repository.
+	Setting a prefix (with a trailing slash) is strongly
+	encouraged in any case, as your SVN-tracking refs will
+	then be located at "refs/remotes/$prefix/*", which is
+	compatible with Git's own remote-tracking ref layout
+	(refs/remotes/$remote/*). Setting a prefix is also useful
+	if you wish to track multiple projects that share a common
+	repository.
 --ignore-paths=<regex>;;
 	When passed to 'init' or 'clone' this regular expression will
 	be preserved as a config key.  See 'fetch' for a description
@@ -804,16 +809,16 @@ Tracking and contributing to an entire Subversion-managed project
 
 ------------------------------------------------------------------------
 # Clone a repo with standard SVN directory layout (like git clone):
-	git svn clone http://svn.example.com/project --stdlayout
+	git svn clone http://svn.example.com/project --stdlayout --prefix svn/
 # Or, if the repo uses a non-standard directory layout:
-	git svn clone http://svn.example.com/project -T tr -b branch -t tag
+	git svn clone http://svn.example.com/project -T tr -b branch -t tag --prefix svn/
 # View all branches and tags you have cloned:
 	git branch -r
 # Create a new branch in SVN
     git svn branch waldo
 # Reset your master to trunk (or any other branch, replacing 'trunk'
 # with the appropriate name):
-	git reset --hard remotes/trunk
+	git reset --hard svn/trunk
 # You may only dcommit to one branch/tag/trunk at a time.  The usage
 # of dcommit/rebase/show-ignore should be the same as above.
 ------------------------------------------------------------------------
@@ -827,7 +832,7 @@ have each person clone that repository with 'git clone':
 
 ------------------------------------------------------------------------
 # Do the initial import on a server
-	ssh server "cd /pub && git svn clone http://svn.example.com/project
+	ssh server "cd /pub && git svn clone http://svn.example.com/project [options...]"
 # Clone locally - make sure the refs/remotes/ space matches the server
 	mkdir project
 	cd project
@@ -840,8 +845,9 @@ have each person clone that repository with 'git clone':
 	git config --remove-section remote.origin
 # Create a local branch from one of the branches just fetched
 	git checkout -b master FETCH_HEAD
-# Initialize 'git svn' locally (be sure to use the same URL and -T/-b/-t options as were used on server)
-	git svn init http://svn.example.com/project
+# Initialize 'git svn' locally (be sure to use the same URL and
+# --stdlayout/-T/-b/-t/--prefix options as were used on server)
+	git svn init http://svn.example.com/project [options...]
 # Pull the latest changes from Subversion
 	git svn rebase
 ------------------------------------------------------------------------
@@ -973,6 +979,15 @@ without giving any repository layout options.  If the full history with
 branches and tags is required, the options '--trunk' / '--branches' /
 '--tags' must be used.
 
+When using the options for describing the repository layout (--trunk,
+--tags, --branches, --stdlayout), please also specify the --prefix
+option (e.g. '--prefix=origin/') to cause your SVN-tracking refs to be
+placed at refs/remotes/origin/* rather than the default refs/remotes/*.
+The former is more compatible with the layout of Git's "regular"
+remote-tracking refs (refs/remotes/$remote/*), and may potentially
+prevent similarly named SVN branches and Git remotes from clobbering
+eachother.
+
 When using multiple --branches or --tags, 'git svn' does not automatically
 handle name collisions (for example, if two branches from different paths have
 the same name, or if a branch and a tag have the same name).  In these cases,
@@ -1035,8 +1050,8 @@ comma-separated list of names within braces. For example:
 [svn-remote "huge-project"]
 	url = http://server.org/svn
 	fetch = trunk/src:refs/remotes/trunk
-	branches = branches/{red,green}/src:refs/remotes/branches/*
-	tags = tags/{1.0,2.0}/src:refs/remotes/tags/*
+	branches = branches/{red,green}/src:refs/remotes/project-a/branches/*
+	tags = tags/{1.0,2.0}/src:refs/remotes/project-a/tags/*
 ------------------------------------------------------------------------
 
 Multiple fetch, branches, and tags keys are supported:
-- 
1.8.4.653.g2df02b3
