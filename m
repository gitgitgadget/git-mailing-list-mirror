Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 547CB1F576
	for <e@80x24.org>; Thu, 15 Feb 2018 11:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967536AbeBOLSb (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 06:18:31 -0500
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:58802
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S966589AbeBOLSa (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 15 Feb 2018 06:18:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1518693509;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=RMgccgCt77aHY/fXqzbYT+oHgp+e68QjCQeHL0zCW6E=;
        b=Ja6bYp4SEZhINRo4gZkN59o2hjbyYcimpizu0FirHHxD5rO7ilgPLjKn6DSOGDf/
        quiIZKbY1A9qjGoZ75uRuqmkEoMZ00BFMuCr89R3l1eg9z+/buFr6ZmzRL3kepHZwEc
        F78VPbe+it9McS1ElOeYsueL9TUqJMHKH7dVRKGA=
From:   =?UTF-8?Q?Herv=C3=A9_Beraud?= <herveberaud.pro@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020161992fe7ce-b41bf370-1480-4efe-8980-0c52fb9b9be5-000000@eu-west-1.amazonses.com>
Subject: [PATCH] make hg-to-git compatible with python2.x and 3.x
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Thu, 15 Feb 2018 11:18:29 +0000
X-SES-Outgoing: 2018.02.15-54.240.7.17
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 contrib/hg-to-git/hg-to-git.py | 140 ++++++++++++++++++++++++-----------------
 1 file changed, 83 insertions(+), 57 deletions(-)

diff --git a/contrib/hg-to-git/hg-to-git.py b/contrib/hg-to-git/hg-to-git.py
index de3f81667ed97..9b0842c3883dc 100755
--- a/contrib/hg-to-git/hg-to-git.py
+++ b/contrib/hg-to-git/hg-to-git.py
@@ -18,14 +18,19 @@
     along with this program; if not, see <http://www.gnu.org/licenses/>.
 """
 
-import os, os.path, sys
-import tempfile, pickle, getopt
+import os
+import os.path
+import sys
+import tempfile
+import pickle
+import getopt
+import textwrap
 import re
 
 if sys.hexversion < 0x02030000:
-   # The behavior of the pickle module changed significantly in 2.3
-   sys.stderr.write("hg-to-git.py: requires Python 2.3 or later.\n")
-   sys.exit(1)
+    # The behavior of the pickle module changed significantly in 2.3
+    sys.stderr.write("hg-to-git.py: requires Python 2.3 or later.\n")
+    sys.exit(1)
 
 # Maps hg version -> git version
 hgvers = {}
@@ -38,29 +43,31 @@
 # Number of new changesets converted from hg
 hgnewcsets = 0
 
-#------------------------------------------------------------------------------
+# -----------------------------------------------------------------------------
+
 
 def usage():
 
-        print """\
-%s: [OPTIONS] <hgprj>
+    print(textwrap.dedent("""\
+        {0}: [OPTIONS] <hgprj>
 
-options:
-    -s, --gitstate=FILE: name of the state to be saved/read
-                         for incrementals
-    -n, --nrepack=INT:   number of changesets that will trigger
-                         a repack (default=0, -1 to deactivate)
-    -v, --verbose:       be verbose
+        options:
+            -s, --gitstate=FILE: name of the state to be saved/read
+                                 for incrementals
+            -n, --nrepack=INT:   number of changesets that will trigger
+                                 a repack (default=0, -1 to deactivate)
+            -v, --verbose:       be verbose
 
-required:
-    hgprj:  name of the HG project to import (directory)
-""" % sys.argv[0]
+        required:
+            hgprj:  name of the HG project to import (directory)
+    """).format(sys.argv[0]))
+
+# -----------------------------------------------------------------------------
 
-#------------------------------------------------------------------------------
 
 def getgitenv(user, date):
     env = ''
-    elems = re.compile('(.*?)\s+<(.*)>').match(user)
+    elems = re.compile(r'(.*?)\s+<(.*)>').match(user)
     if elems:
         env += 'export GIT_AUTHOR_NAME="%s" ;' % elems.group(1)
         env += 'export GIT_COMMITTER_NAME="%s" ;' % elems.group(1)
@@ -76,14 +83,16 @@ def getgitenv(user, date):
     env += 'export GIT_COMMITTER_DATE="%s" ;' % date
     return env
 
-#------------------------------------------------------------------------------
+# -----------------------------------------------------------------------------
+
 
 state = ''
 opt_nrepack = 0
 verbose = False
 
 try:
-    opts, args = getopt.getopt(sys.argv[1:], 's:t:n:v', ['gitstate=', 'tempdir=', 'nrepack=', 'verbose'])
+    options = ['gitstate=', 'tempdir=', 'nrepack=', 'verbose']
+    opts, args = getopt.getopt(sys.argv[1:], 's:t:n:v', options)
     for o, a in opts:
         if o in ('-s', '--gitstate'):
             state = a
@@ -94,7 +103,7 @@ def getgitenv(user, date):
             verbose = True
     if len(args) != 1:
         raise Exception('params')
-except:
+except Exception:
     usage()
     sys.exit(1)
 
@@ -104,37 +113,38 @@ def getgitenv(user, date):
 if state:
     if os.path.exists(state):
         if verbose:
-            print 'State does exist, reading'
+            print('State does exist, reading')
         f = open(state, 'r')
         hgvers = pickle.load(f)
     else:
-        print 'State does not exist, first run'
+        print('State does not exist, first run')
 
 sock = os.popen('hg tip --template "{rev}"')
 tip = sock.read()
 if sock.close():
     sys.exit(1)
 if verbose:
-    print 'tip is', tip
+    print('tip is', tip)
 
 # Calculate the branches
 if verbose:
-    print 'analysing the branches...'
+    print('analysing the branches...')
 hgchildren["0"] = ()
 hgparents["0"] = (None, None)
 hgbranch["0"] = "master"
 for cset in range(1, int(tip) + 1):
     hgchildren[str(cset)] = ()
-    prnts = os.popen('hg log -r %d --template "{parents}"' % cset).read().strip().split(' ')
+    prnts = os.popen(
+        'hg log -r %d --template "{parents}"' % cset).read().strip().split(' ')
     prnts = map(lambda x: x[:x.find(':')], prnts)
     if prnts[0] != '':
         parent = prnts[0].strip()
     else:
         parent = str(cset - 1)
-    hgchildren[parent] += ( str(cset), )
+    hgchildren[parent] += (str(cset), )
     if len(prnts) > 1:
         mparent = prnts[1].strip()
-        hgchildren[mparent] += ( str(cset), )
+        hgchildren[mparent] += (str(cset), )
     else:
         mparent = None
 
@@ -148,59 +158,65 @@ def getgitenv(user, date):
             hgbranch[str(cset)] = hgbranch[parent]
     else:
         # Normal changesets
-        # For first children, take the parent branch, for the others create a new branch
+        # For first children, take the parent branch,
+        # for the others create a new branch
         if hgchildren[parent][0] == str(cset):
             hgbranch[str(cset)] = hgbranch[parent]
         else:
             hgbranch[str(cset)] = "branch-" + str(cset)
 
-if not hgvers.has_key("0"):
-    print 'creating repository'
+if "0" not in hgvers:
+    print('creating repository')
     os.system('git init')
 
 # loop through every hg changeset
 for cset in range(int(tip) + 1):
 
     # incremental, already seen
-    if hgvers.has_key(str(cset)):
+    if str(cset) in hgvers:
         continue
     hgnewcsets += 1
 
     # get info
-    log_data = os.popen('hg log -r %d --template "{tags}\n{date|date}\n{author}\n"' % cset).readlines()
+    log_data = os.popen(
+        'hg log -r %d --template "{tags}\n{date|date}\n{author}\n"' % cset
+    ).readlines()
     tag = log_data[0].strip()
     date = log_data[1].strip()
     user = log_data[2].strip()
     parent = hgparents[str(cset)][0]
     mparent = hgparents[str(cset)][1]
 
-    #get comment
+    # get comment
     (fdcomment, filecomment) = tempfile.mkstemp()
-    csetcomment = os.popen('hg log -r %d --template "{desc}"' % cset).read().strip()
+    csetcomment = os.popen(
+        'hg log -r %d --template "{desc}"' % cset).read().strip()
     os.write(fdcomment, csetcomment)
     os.close(fdcomment)
 
-    print '-----------------------------------------'
-    print 'cset:', cset
-    print 'branch:', hgbranch[str(cset)]
-    print 'user:', user
-    print 'date:', date
-    print 'comment:', csetcomment
+    print('-----------------------------------------')
+    print('cset:', cset)
+    print('branch:', hgbranch[str(cset)])
+    print('user:', user)
+    print('date:', date)
+    print('comment:', csetcomment)
     if parent:
-	print 'parent:', parent
+        print('parent:', parent)
     if mparent:
-        print 'mparent:', mparent
+        print('mparent:', mparent)
     if tag:
-        print 'tag:', tag
-    print '-----------------------------------------'
+        print('tag:', tag)
+    print('-----------------------------------------')
 
     # checkout the parent if necessary
     if cset != 0:
         if hgbranch[str(cset)] == "branch-" + str(cset):
-            print 'creating new branch', hgbranch[str(cset)]
-            os.system('git checkout -b %s %s' % (hgbranch[str(cset)], hgvers[parent]))
+            print('creating new branch', hgbranch[str(cset)])
+            os.system(
+                'git checkout -b %s %s' % (hgbranch[str(cset)], hgvers[parent])
+            )
         else:
-            print 'checking out branch', hgbranch[str(cset)]
+            print('checking out branch', hgbranch[str(cset)])
             os.system('git checkout %s' % hgbranch[str(cset)])
 
     # merge
@@ -209,11 +225,18 @@ def getgitenv(user, date):
             otherbranch = hgbranch[mparent]
         else:
             otherbranch = hgbranch[parent]
-        print 'merging', otherbranch, 'into', hgbranch[str(cset)]
-        os.system(getgitenv(user, date) + 'git merge --no-commit -s ours "" %s %s' % (hgbranch[str(cset)], otherbranch))
+        print('merging', otherbranch, 'into', hgbranch[str(cset)])
+        mrg = 'git merge --no-commit -s ours "" %s %s' % (
+            hgbranch[str(cset)], otherbranch)
+        os.system(getgitenv(user, date) + mrg)
 
     # remove everything except .git and .hg directories
-    os.system('find . \( -path "./.hg" -o -path "./.git" \) -prune -o ! -name "." -print | xargs rm -rf')
+    xargs_rm = 'xargs rm -rf'
+    ignore_path = r'\( -path "./.hg" -o -path "./.git" \)'
+    rm_all = r'find . {0} -prune -o ! -name "." -print | {1}'.format(
+        ignore_path,
+        xargs_rm)
+    os.system(rm_all)
 
     # repopulate with checkouted files
     os.system('hg update -C %d' % cset)
@@ -221,10 +244,13 @@ def getgitenv(user, date):
     # add new files
     os.system('git ls-files -x .hg --others | git update-index --add --stdin')
     # delete removed files
-    os.system('git ls-files -x .hg --deleted | git update-index --remove --stdin')
+    rm_f = 'git ls-files -x .hg --deleted | git update-index --remove --stdin'
+    os.system(rm_f)
 
     # commit
-    os.system(getgitenv(user, date) + 'git commit --allow-empty --allow-empty-message -a -F %s' % filecomment)
+    commit = 'git commit --allow-empty --allow-empty-message -a -F {}'.format(
+        filecomment)
+    os.system(getgitenv(user, date) + commit)
     os.unlink(filecomment)
 
     # tag
@@ -233,12 +259,12 @@ def getgitenv(user, date):
 
     # delete branch if not used anymore...
     if mparent and len(hgchildren[str(cset)]):
-        print "Deleting unused branch:", otherbranch
+        print("Deleting unused branch:", otherbranch)
         os.system('git branch -d %s' % otherbranch)
 
     # retrieve and record the version
     vvv = os.popen('git show --quiet --pretty=format:%H').read()
-    print 'record', cset, '->', vvv
+    print('record', cset, '->', vvv)
     hgvers[str(cset)] = vvv
 
 if hgnewcsets >= opt_nrepack and opt_nrepack != -1:
@@ -247,7 +273,7 @@ def getgitenv(user, date):
 # write the state for incrementals
 if state:
     if verbose:
-        print 'Writing state'
+        print('Writing state')
     f = open(state, 'w')
     pickle.dump(hgvers, f)
 

--
https://github.com/git/git/pull/458
