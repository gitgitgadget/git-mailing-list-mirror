From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 02/25] contrib: remove 'hg-to-git'
Date: Thu,  8 May 2014 19:58:13 -0500
Message-ID: <1399597116-1851-3-git-send-email-felipe.contreras@gmail.com>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Miklos Vajna <vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 03:09:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiZJp-0007uH-F6
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 03:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755091AbaEIBJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 21:09:40 -0400
Received: from mail-yh0-f47.google.com ([209.85.213.47]:61272 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754438AbaEIBJh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 21:09:37 -0400
Received: by mail-yh0-f47.google.com with SMTP id z6so2754303yhz.34
        for <git@vger.kernel.org>; Thu, 08 May 2014 18:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5yQcRKC6ylfoiLYPG4pM9pN+sqCQG00xNSuf6MZkFak=;
        b=TmYzHl2vaMRhR755GVRLpr9UPDgwk/9CYYLbkkzNsnyfDVPu3EUe6CxZ5DVu4OxFW+
         x93QK7cUvn5QRlfqyk/S5lszQ2GsWTJr7LxbuIlvDmlFPH+yUUtHXuRSUFGtrEm4gwtl
         /WJq2ayZeM98DMXf7yrrptZ/qupMP6KQonH7/HYhYeloa+ondb4ypJ74arUavC4ns1R2
         fEBfNo9E0Oa0m2xicRWzc2Jik1MZsNBTviEi6cv0W4GG8CKylTg42kWD4NZrAJI9WdvE
         a0yazjGbnedGswj39F+ooLt5J+8oD9/UMvMR8g6NF6lbD0FL8RVDD/8dN9Sq50NIn4hC
         JNuA==
X-Received: by 10.236.99.99 with SMTP id w63mr10235243yhf.52.1399597776490;
        Thu, 08 May 2014 18:09:36 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id n65sm3928605yhc.8.2014.05.08.18.09.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 May 2014 18:09:35 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.27.gbce2056
In-Reply-To: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248470>

There hasn't been any real activity on it since 2010.

Plus there are better out-of-tree tools.

No tests and no real documentation either.

Cc: Miklos Vajna <vmiklos@frugalware.org>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/hg-to-git/hg-to-git.py  | 255 ----------------------------------------
 contrib/hg-to-git/hg-to-git.txt |  21 ----
 2 files changed, 276 deletions(-)
 delete mode 100755 contrib/hg-to-git/hg-to-git.py
 delete mode 100644 contrib/hg-to-git/hg-to-git.txt

diff --git a/contrib/hg-to-git/hg-to-git.py b/contrib/hg-to-git/hg-to-git.py
deleted file mode 100755
index 60dec86..0000000
--- a/contrib/hg-to-git/hg-to-git.py
+++ /dev/null
@@ -1,255 +0,0 @@
-#!/usr/bin/env python
-
-""" hg-to-git.py - A Mercurial to GIT converter
-
-    Copyright (C)2007 Stelian Pop <stelian@popies.net>
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2, or (at your option)
-    any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-"""
-
-import os, os.path, sys
-import tempfile, pickle, getopt
-import re
-
-if sys.hexversion < 0x02030000:
-   # The behavior of the pickle module changed significantly in 2.3
-   sys.stderr.write("hg-to-git.py: requires Python 2.3 or later.\n")
-   sys.exit(1)
-
-# Maps hg version -> git version
-hgvers = {}
-# List of children for each hg revision
-hgchildren = {}
-# List of parents for each hg revision
-hgparents = {}
-# Current branch for each hg revision
-hgbranch = {}
-# Number of new changesets converted from hg
-hgnewcsets = 0
-
-#------------------------------------------------------------------------------
-
-def usage():
-
-        print """\
-%s: [OPTIONS] <hgprj>
-
-options:
-    -s, --gitstate=FILE: name of the state to be saved/read
-                         for incrementals
-    -n, --nrepack=INT:   number of changesets that will trigger
-                         a repack (default=0, -1 to deactivate)
-    -v, --verbose:       be verbose
-
-required:
-    hgprj:  name of the HG project to import (directory)
-""" % sys.argv[0]
-
-#------------------------------------------------------------------------------
-
-def getgitenv(user, date):
-    env = ''
-    elems = re.compile('(.*?)\s+<(.*)>').match(user)
-    if elems:
-        env += 'export GIT_AUTHOR_NAME="%s" ;' % elems.group(1)
-        env += 'export GIT_COMMITTER_NAME="%s" ;' % elems.group(1)
-        env += 'export GIT_AUTHOR_EMAIL="%s" ;' % elems.group(2)
-        env += 'export GIT_COMMITTER_EMAIL="%s" ;' % elems.group(2)
-    else:
-        env += 'export GIT_AUTHOR_NAME="%s" ;' % user
-        env += 'export GIT_COMMITTER_NAME="%s" ;' % user
-        env += 'export GIT_AUTHOR_EMAIL= ;'
-        env += 'export GIT_COMMITTER_EMAIL= ;'
-
-    env += 'export GIT_AUTHOR_DATE="%s" ;' % date
-    env += 'export GIT_COMMITTER_DATE="%s" ;' % date
-    return env
-
-#------------------------------------------------------------------------------
-
-state = ''
-opt_nrepack = 0
-verbose = False
-
-try:
-    opts, args = getopt.getopt(sys.argv[1:], 's:t:n:v', ['gitstate=', 'tempdir=', 'nrepack=', 'verbose'])
-    for o, a in opts:
-        if o in ('-s', '--gitstate'):
-            state = a
-            state = os.path.abspath(state)
-        if o in ('-n', '--nrepack'):
-            opt_nrepack = int(a)
-        if o in ('-v', '--verbose'):
-            verbose = True
-    if len(args) != 1:
-        raise Exception('params')
-except:
-    usage()
-    sys.exit(1)
-
-hgprj = args[0]
-os.chdir(hgprj)
-
-if state:
-    if os.path.exists(state):
-        if verbose:
-            print 'State does exist, reading'
-        f = open(state, 'r')
-        hgvers = pickle.load(f)
-    else:
-        print 'State does not exist, first run'
-
-sock = os.popen('hg tip --template "{rev}"')
-tip = sock.read()
-if sock.close():
-    sys.exit(1)
-if verbose:
-    print 'tip is', tip
-
-# Calculate the branches
-if verbose:
-    print 'analysing the branches...'
-hgchildren["0"] = ()
-hgparents["0"] = (None, None)
-hgbranch["0"] = "master"
-for cset in range(1, int(tip) + 1):
-    hgchildren[str(cset)] = ()
-    prnts = os.popen('hg log -r %d --template "{parents}"' % cset).read().strip().split(' ')
-    prnts = map(lambda x: x[:x.find(':')], prnts)
-    if prnts[0] != '':
-        parent = prnts[0].strip()
-    else:
-        parent = str(cset - 1)
-    hgchildren[parent] += ( str(cset), )
-    if len(prnts) > 1:
-        mparent = prnts[1].strip()
-        hgchildren[mparent] += ( str(cset), )
-    else:
-        mparent = None
-
-    hgparents[str(cset)] = (parent, mparent)
-
-    if mparent:
-        # For merge changesets, take either one, preferably the 'master' branch
-        if hgbranch[mparent] == 'master':
-            hgbranch[str(cset)] = 'master'
-        else:
-            hgbranch[str(cset)] = hgbranch[parent]
-    else:
-        # Normal changesets
-        # For first children, take the parent branch, for the others create a new branch
-        if hgchildren[parent][0] == str(cset):
-            hgbranch[str(cset)] = hgbranch[parent]
-        else:
-            hgbranch[str(cset)] = "branch-" + str(cset)
-
-if not hgvers.has_key("0"):
-    print 'creating repository'
-    os.system('git init')
-
-# loop through every hg changeset
-for cset in range(int(tip) + 1):
-
-    # incremental, already seen
-    if hgvers.has_key(str(cset)):
-        continue
-    hgnewcsets += 1
-
-    # get info
-    log_data = os.popen('hg log -r %d --template "{tags}\n{date|date}\n{author}\n"' % cset).readlines()
-    tag = log_data[0].strip()
-    date = log_data[1].strip()
-    user = log_data[2].strip()
-    parent = hgparents[str(cset)][0]
-    mparent = hgparents[str(cset)][1]
-
-    #get comment
-    (fdcomment, filecomment) = tempfile.mkstemp()
-    csetcomment = os.popen('hg log -r %d --template "{desc}"' % cset).read().strip()
-    os.write(fdcomment, csetcomment)
-    os.close(fdcomment)
-
-    print '-----------------------------------------'
-    print 'cset:', cset
-    print 'branch:', hgbranch[str(cset)]
-    print 'user:', user
-    print 'date:', date
-    print 'comment:', csetcomment
-    if parent:
-	print 'parent:', parent
-    if mparent:
-        print 'mparent:', mparent
-    if tag:
-        print 'tag:', tag
-    print '-----------------------------------------'
-
-    # checkout the parent if necessary
-    if cset != 0:
-        if hgbranch[str(cset)] == "branch-" + str(cset):
-            print 'creating new branch', hgbranch[str(cset)]
-            os.system('git checkout -b %s %s' % (hgbranch[str(cset)], hgvers[parent]))
-        else:
-            print 'checking out branch', hgbranch[str(cset)]
-            os.system('git checkout %s' % hgbranch[str(cset)])
-
-    # merge
-    if mparent:
-        if hgbranch[parent] == hgbranch[str(cset)]:
-            otherbranch = hgbranch[mparent]
-        else:
-            otherbranch = hgbranch[parent]
-        print 'merging', otherbranch, 'into', hgbranch[str(cset)]
-        os.system(getgitenv(user, date) + 'git merge --no-commit -s ours "" %s %s' % (hgbranch[str(cset)], otherbranch))
-
-    # remove everything except .git and .hg directories
-    os.system('find . \( -path "./.hg" -o -path "./.git" \) -prune -o ! -name "." -print | xargs rm -rf')
-
-    # repopulate with checkouted files
-    os.system('hg update -C %d' % cset)
-
-    # add new files
-    os.system('git ls-files -x .hg --others | git update-index --add --stdin')
-    # delete removed files
-    os.system('git ls-files -x .hg --deleted | git update-index --remove --stdin')
-
-    # commit
-    os.system(getgitenv(user, date) + 'git commit --allow-empty --allow-empty-message -a -F %s' % filecomment)
-    os.unlink(filecomment)
-
-    # tag
-    if tag and tag != 'tip':
-        os.system(getgitenv(user, date) + 'git tag %s' % tag)
-
-    # delete branch if not used anymore...
-    if mparent and len(hgchildren[str(cset)]):
-        print "Deleting unused branch:", otherbranch
-        os.system('git branch -d %s' % otherbranch)
-
-    # retrieve and record the version
-    vvv = os.popen('git show --quiet --pretty=format:%H').read()
-    print 'record', cset, '->', vvv
-    hgvers[str(cset)] = vvv
-
-if hgnewcsets >= opt_nrepack and opt_nrepack != -1:
-    os.system('git repack -a -d')
-
-# write the state for incrementals
-if state:
-    if verbose:
-        print 'Writing state'
-    f = open(state, 'w')
-    pickle.dump(hgvers, f)
-
-# vim: et ts=8 sw=4 sts=4
diff --git a/contrib/hg-to-git/hg-to-git.txt b/contrib/hg-to-git/hg-to-git.txt
deleted file mode 100644
index 91f8fe6..0000000
--- a/contrib/hg-to-git/hg-to-git.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-hg-to-git.py is able to convert a Mercurial repository into a git one,
-and preserves the branches in the process (unlike tailor)
-
-hg-to-git.py can probably be greatly improved (it's a rather crude
-combination of shell and python) but it does already work quite well for
-me. Features:
-	- supports incremental conversion
-	  (for keeping a git repo in sync with a hg one)
-        - supports hg branches
-        - converts hg tags
-
-Note that the git repository will be created 'in place' (at the same
-location as the source hg repo). You will have to manually remove the
-'.hg' directory after the conversion.
-
-Also note that the incremental conversion uses 'simple' hg changesets
-identifiers (ordinals, as opposed to SHA-1 ids), and since these ids
-are not stable across different repositories the hg-to-git.py state file
-is forever tied to one hg repository.
-
-Stelian Pop <stelian@popies.net>
-- 
1.9.2+fc1.27.gbce2056
