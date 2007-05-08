From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Add a birdview-on-the-source-code section to the user manual
Date: Tue, 8 May 2007 17:10:47 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705081709230.4167@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: bfields@citi.umich.edu, junio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 08 17:45:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlRsh-0007mV-Sr
	for gcvg-git@gmane.org; Tue, 08 May 2007 17:45:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968069AbXEHPcl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 11:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966027AbXEHPYi
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 11:24:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:57164 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934347AbXEHPKg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 11:10:36 -0400
Received: (qmail invoked by alias); 08 May 2007 15:10:34 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp040) with SMTP; 08 May 2007 17:10:34 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/RNuMTUd/RetILfCMTfoy3Mu3LntNLRvlQyGGK7D
	pTYAquaifxz+h6
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46588>


In http://thread.gmane.org/gmane.comp.version-control.git/42479,
a birdview on the source code was requested.

J. Bruce Fields suggested that my reply should be included in the
user manual, and there was nothing of an outcry, so here it is,
not even 2 months later.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/user-manual.txt |  196 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 196 insertions(+), 0 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 67f5b9b..3c67b68 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -3161,6 +3161,202 @@ confusing and scary messages, but it won't actually do anything bad. In
 contrast, running "git prune" while somebody is actively changing the 
 repository is a *BAD* idea).
 
+[[birdview-on-the-source-code]]
+A birdview on Git's source code
+-----------------------------
+
+While Git's source code is quite elegant, it is not always easy for 
+new  developers to find their way through it.  A good idea is to look 
+at the contents of the initial commit: 
+_e83c5163316f89bfbde7d9ab23ca2e25604af290_ (also known as _v0.99~954_).
+
+Tip: you can see what files are in there with
+
+----------------------------------------------------
+$ git show e83c5163316f89bfbde7d9ab23ca2e25604af290:
+----------------------------------------------------
+
+and look at those files with something like
+
+-----------------------------------------------------------
+$ git show e83c5163316f89bfbde7d9ab23ca2e25604af290:cache.h
+-----------------------------------------------------------
+
+Be sure to read the README in that revision _after_ you are familiar with 
+the terminology (<<glossary>>), since the terminology has changed a little 
+since then.  For example, we call the things "commits" now, which are 
+described in that README as "changesets".
+
+Actually a lot of the structure as it is now can be explained by that 
+initial commit.
+
+For example, we do not call it "cache" any more, but "index", however, the 
+file is still called `cache.h`.  Remark: Not much reason to change it now, 
+especially since there is no good single name for it anyway, because it is 
+basically _the_ header file which is included by _all_ of Git's C sources.
+
+If you grasp the ideas in that initial commit (it is really small and you 
+can get into it really fast, and it will help you recognize things in the 
+much larger code base we have now), you should go on skimming `cache.h`, 
+`object.h` and `commit.h`.
+
+By now, you know what the index is (and find the corresponding data 
+structures in `cache.h`), and that there are just a couple of object types 
+(blobs, trees, commits and tags) which inherit their common structure from 
+`struct object`, which is their first member (and thus, you can cast e.g. 
+`(struct object *)commit` to achieve the _same_ as `&commit->object`, i.e. 
+get at the object name and flags).
+
+Now is a good point to take a break to let this information sink in.
+
+Next step: get familiar with the object naming.  Read <<naming-commits>>.
+There are quite a few ways to name an object (and not only revisions!).  
+All of these are handled in `sha1_name.c`. Just have a quick look at 
+the function `get_sha1()`. A lot of the special handling is done by 
+functions like `get_sha1_basic()` or the likes.
+
+This is just to get you into the groove for the most libified part of Git: 
+the revision walker.
+
+Basically, the initial version of `git log` was a shell script:
+
+----------------------------------------------------------------
+$ git-rev-list --pretty $(git-rev-parse --default HEAD "$@") | \
+	LESS=-S ${PAGER:-less}
+----------------------------------------------------------------
+
+What does this mean?
+
+`git-rev-list` is the original version of the revision walker, which 
+_always_ printed a list of revisions to stdout.  It is still functional, 
+and needs to, since most new Git programs start out as scripts using 
+`git-rev-list`.
+
+`git-rev-parse` is not as important any more; it was only used to filter out 
+options that were relevant for the different plumbing commands that were 
+called by the script.
+
+Most of what `git-rev-list` did is contained in `revision.c` and 
+`revision.h`.  It wraps the options in a struct named rev_info, which 
+controls how and what revisions are walked, and more.
+
+Nowadays, `git log` is a builtin, which means that it is _contained_ in the 
+command `git`.  The source side of a builtin is
+
+- a function called `cmd_<bla>`, typically defined in `builtin-<bla>.c`, 
+  and declared in `builtin.h`,
+
+- an entry in the `commands[]` array in `git.c`, and
+
+- an entry in `BUILTIN_OBJECTS` in the `Makefile`.
+
+Sometimes, more than one builtin is contained in one source file.  For 
+example, `cmd_whatchanged()` and `cmd_log()` both reside in `builtin-log.c`, 
+since they share quite a bit of code.  In that case, the commands which are 
+_not_ named like the `.c` file in which they live have to be listed in 
+`BUILT_INS` in the `Makefile`.
+
+`git log` looks more complicated in C than it does in the original script, 
+but that allows for a much greater flexibility and performance.
+
+Here again it is a good point to take a pause.
+
+Lesson three is: study the code.  Really, it is the best way to learn about 
+the organization of Git (after you know the basic concepts).
+
+So, think about something which you are interested in, say, "how can I 
+access a blob just knowing the object name of it?".  The first step is to 
+find a Git command with which you can do it.  In this example, it is either 
+`git show` or `git cat-file`.
+
+For the sake of clarity, let's stay with `git cat-file`, because it
+
+- is plumbing, and
+
+- was around even in the initial commit (it literally went only through 
+  some 20 revisions as `cat-file.c`, was renamed to `builtin-cat-file.c` 
+  when made a builtin, and then saw less than 10 versions).
+
+So, look into `builtin-cat-file.c`, search for `cmd_cat_file()` and look what 
+it does.
+
+------------------------------------------------------------------
+        git_config(git_default_config);
+        if (argc != 3)
+                usage("git-cat-file [-t|-s|-e|-p|<type>] <sha1>");
+        if (get_sha1(argv[2], sha1))
+                die("Not a valid object name %s", argv[2]);
+------------------------------------------------------------------
+
+Let's skip over the obvious details; the only really interesting part 
+here is the call to `get_sha1()`.  It tries to interpret `argv[2]` as an 
+object name, and if it refers to an object which is present in the current 
+repository, it writes the resulting SHA-1 into the variable `sha1`.
+
+Two things are interesting here:
+
+- `get_sha1()` returns 0 on _success_.  This might surprise some new 
+  Git hackers, but there is a long tradition in UNIX to return different 
+  negative numbers in case of different errors -- and 0 on success.
+
+- the variable `sha1` in the function signature of `get_sha1()` is `unsigned 
+  char *`, but is actually expected to be a pointer to `unsigned 
+  char[20]`.  This variable will contain the big endian version of the 
+  40-character hex string representation of the SHA-1.
+
+You will see both of these things throughout the code.
+
+Now, for the meat:
+
+-----------------------------------------------------------------------------
+        case 0:
+                buf = read_object_with_reference(sha1, argv[1], &size, NULL);
+-----------------------------------------------------------------------------
+
+This is how you read a blob (actually, not only a blob, but any type of 
+object).  To know how the function `read_object_with_reference()` actually 
+works, find the source code for it (something like `git grep 
+read_object_with | grep ":[a-z]"` in the git repository), and read 
+the source.
+
+To find out how the result can be used, just read on in `cmd_cat_file()`:
+
+-----------------------------------
+        write_or_die(1, buf, size);
+-----------------------------------
+
+Sometimes, you do not know where to look for a feature.  In many such cases, 
+it helps to search through the output of `git log`, and then `git show` the 
+corresponding commit.
+
+Example: If you know that there was some test case for `git bundle`, but 
+do not remember where it was (yes, you _could_ `git grep bundle t/`, but that 
+does not illustrate the point!):
+
+------------------------
+$ git log --no-merges t/
+------------------------
+
+In the pager (`less`), just search for "bundle", go a few lines back, 
+and see that it is in commit 18449ab0...  Now just copy this object name, 
+and paste it into the command line
+
+-------------------
+$ git show 18449ab0
+-------------------
+
+Voila.
+
+Another example: Find out what to do in order to make some script a 
+builtin:
+
+-------------------------------------------------
+$ git log --no-merges --diff-filter=A builtin-*.c
+-------------------------------------------------
+
+You see, Git is actually the best tool to find out about the source of Git 
+itself!
+
 [[glossary]]
 include::glossary.txt[]
 
-- 
1.5.2.rc2.2469.gea95f
