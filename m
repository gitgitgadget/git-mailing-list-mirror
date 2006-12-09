X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Pavel Roskin <proski@gnu.org>
Subject: RFC PATCH: support for default remote in StGIT
Date: Sat, 09 Dec 2006 04:23:25 -0500
Message-ID: <1165656205.2816.47.camel@portland.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 9 Dec 2006 09:23:50 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33808>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsyQs-0005GO-BW for gcvg-git@gmane.org; Sat, 09 Dec
 2006 10:23:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936590AbWLIJX3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 04:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936589AbWLIJX3
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 04:23:29 -0500
Received: from c60.cesmail.net ([216.154.195.49]:47150 "EHLO c60.cesmail.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S936583AbWLIJX1
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec 2006 04:23:27 -0500
Received: from unknown (HELO relay.cesmail.net) ([192.168.1.81]) by
 c60.cesmail.net with ESMTP; 09 Dec 2006 04:23:27 -0500
Received: from [192.168.1.102] (c-71-230-131-166.hsd1.pa.comcast.net
 [71.230.131.166]) by relay.cesmail.net (Postfix) with ESMTP id C1850618F25;
 Sat,  9 Dec 2006 04:23:26 -0500 (EST)
To: "Catalin Marinas catalin.marinas"@gmail.org
Sender: git-owner@vger.kernel.org

Hello, Catalin!

It's very important for me to have default remote support in StGIT.  I'm
trying to track different Linux branches, and I don't want to remember
what branch I'm on when I run "stg pull".

I have tried two approaches, and both work, but I'm not particular fond
of either of them, so I think I'll just send both, and maybe we'll come
to a satisfactory solution.

One approach is to leave the default remote selection completely to git.
The downside is that StGIT prints the remote it's pulling from.  Now
StGIT will have to print common words that it's pulling something.  Or
maybe it shouldn't print anything?

Also, git-pull doesn't allow to specify the refspec without the remote.
This limitation seems artificial to me, but we have to pass this
limitation to the StGIT users.

The positive side if that StGIT is completely unaware of the word
"origin", and any changes in git handling of the default remote will
propagate to StGIT immediately.


diff --git a/stgit/commands/pull.py b/stgit/commands/pull.py
index 227249e..3ef582e 100644
--- a/stgit/commands/pull.py
+++ b/stgit/commands/pull.py
@@ -50,7 +50,7 @@ def func(parser, options, args):
     if len(args) > 2:
         parser.error('incorrect number of arguments')
 
-    repository = 'origin'
+    repository = None
     refspec = None
     if len(args) >= 1:
         repository = args[0]
@@ -73,7 +73,11 @@ def func(parser, options, args):
         print 'done'
 
     # pull the remote changes
-    print 'Pulling from "%s"...' % repository
+    if repository:
+        print 'Pulling from "%s"...' % repository
+    else:
+        print 'Pulling from the default repository'
+
     git.pull(repository, refspec)
     print 'done'
 
diff --git a/stgit/git.py b/stgit/git.py
index eb8da4e..7aed357 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -790,14 +790,20 @@ def reset(files = None, tree_id = None, check_out = True):
     if not files:
         __set_head(tree_id)
 
-def pull(repository = 'origin', refspec = None):
+def pull(repository = None, refspec = None):
     """Pull changes from the remote repository. At the moment, just
     use the 'git-pull' command
     """
     # 'git-pull' updates the HEAD
     __clear_head_cache()
 
-    args = [repository]
+    if repository:
+        args = [repository]
+    else:
+	if refspec:
+            raise GitException, 'git-pull requires repository with refspec'
+        args = []
+
     if refspec:
         args.append(refspec)
 

The other approach is to calculate the default remote in StGIT.  This
would allow StGIT to tell the user where it's pulling from.

However, I had to introduce a function that ignores errors except there
is any output on stderr.  This is because git-repo-config returns error
code 1 if it cannot find the key.  Maybe git-repo-config should have an
option not to fail in this case?  Perhaps a default value to return?


diff --git a/stgit/commands/pull.py b/stgit/commands/pull.py
index 227249e..7824dc3 100644
--- a/stgit/commands/pull.py
+++ b/stgit/commands/pull.py
@@ -54,6 +54,9 @@ def func(parser, options, args):
     refspec = None
     if len(args) >= 1:
         repository = args[0]
+    else:
+        repository = git.get_default_remote()
+
     if len(args) == 2:
         refspec = args[1]
 
diff --git a/stgit/git.py b/stgit/git.py
index eb8da4e..ed08d7d 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -186,6 +186,20 @@ def _output_one_line(cmd, file_desc = None):
                                                 p.childerr.read().strip())
     return output
 
+def _output_one_line_try(cmd, file_desc = None):
+    """ Read one line of cmd output, fail only on stderr messages
+    """
+    p=popen2.Popen3(cmd, True)
+    if file_desc != None:
+        for line in file_desc:
+            p.tochild.write(line)
+        p.tochild.close()
+    output = p.fromchild.readline().strip()
+    errors = p.childerr.read().strip()
+    if errors:
+        raise GitException, '%s failed (%s)' % (str(cmd), errors)
+    return output
+
 def _output_lines(cmd):
     p=popen2.Popen3(cmd, True)
     lines = p.fromchild.readlines()
@@ -285,6 +299,20 @@ def get_head_file():
     return strip_prefix('refs/heads/',
                         _output_one_line('git-symbolic-ref HEAD'))
 
+def get_default_remote():
+    """Returns default remote to pull
+    """
+    branch = get_head_file()
+
+    repository = _output_one_line_try(['git-repo-config', '--get',
+                                       'branch.%s.remote' % branch])
+
+    if not repository:
+        repository = 'origin'
+
+    return repository
+
+
 def set_head_file(ref):
     """Resets HEAD to point to a new ref
     """


-- 
Regards,
