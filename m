Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321033C082
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 09:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710928108; cv=none; b=BOb+I6nALzIZ8X9a3j16DuDRfLUkOM++HFtr6+ocrwWGqBGQp99nhnlIxvOwy/1zwsuY8i4J/qdUYHI3DhGddDtujuyE264ayLXiUGR++M9HFlb/24N4st/L0WxlNqqx2PSpNiwpGg38c3sta42E3YFLAUtRqDEc7IAGAypuB4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710928108; c=relaxed/simple;
	bh=le8VYKOllWvCtJBj0mhixcfTf+M61Uy20AUuEWX72MM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Z3j82vtAd2jx7v0uFJ/HXwagT/B6Vc/c5TZ4x9KKHh9J1oEep4d3ZnAPwbwlN2RHLA4eQSIRCVNlm/1QVFWdo+DPXbXeJDEdFcyRDJnYdrki4FL/E1flXJecPA+P0lg5sBwVkPD2vOHP2YGElTkmAaty1rXItUkGGWquC2KyM+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 11218 invoked by uid 109); 20 Mar 2024 09:48:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 20 Mar 2024 09:48:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16879 invoked by uid 111); 20 Mar 2024 09:48:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 20 Mar 2024 05:48:30 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 20 Mar 2024 05:48:24 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH] contrib: drop hg-to-git script
Message-ID: <20240320094824.GA2445978@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The hg-to-git script is full of command injection vulnerabilities
against malicious branch and tag names. It's also old and largely
unmaintained; the last commit was over 4 years ago, and the last code
change before that was from 2013. Users are better off with a modern
remote-helper tool like cinnabar or remote-hg.

So rather than spending time to fix it, let's just get rid of it.

Reported-by: Matthew Rollings <admin@stealthcopter.com>
Signed-off-by: Jeff King <peff@peff.net>
---
This was reported to the security list in December. I suggested there
that we should just get rid of it, but there was no follow-up. Until
now. ;) Speak now if anybody wants to volunteer to fix the script
instead.

 contrib/hg-to-git/hg-to-git.py  | 254 --------------------------------
 contrib/hg-to-git/hg-to-git.txt |  21 ---
 2 files changed, 275 deletions(-)
 delete mode 100755 contrib/hg-to-git/hg-to-git.py
 delete mode 100644 contrib/hg-to-git/hg-to-git.txt

diff --git a/contrib/hg-to-git/hg-to-git.py b/contrib/hg-to-git/hg-to-git.py
deleted file mode 100755
index 7eb1b24cc7..0000000000
--- a/contrib/hg-to-git/hg-to-git.py
+++ /dev/null
@@ -1,254 +0,0 @@
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
-    along with this program; if not, see <http://www.gnu.org/licenses/>.
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
-        print("""\
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
-""" % sys.argv[0])
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
-            print('State does exist, reading')
-        f = open(state, 'r')
-        hgvers = pickle.load(f)
-    else:
-        print('State does not exist, first run')
-
-sock = os.popen('hg tip --template "{rev}"')
-tip = sock.read()
-if sock.close():
-    sys.exit(1)
-if verbose:
-    print('tip is', tip)
-
-# Calculate the branches
-if verbose:
-    print('analysing the branches...')
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
-if "0" not in hgvers:
-    print('creating repository')
-    os.system('git init')
-
-# loop through every hg changeset
-for cset in range(int(tip) + 1):
-
-    # incremental, already seen
-    if str(cset) in hgvers:
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
-    print('-----------------------------------------')
-    print('cset:', cset)
-    print('branch:', hgbranch[str(cset)])
-    print('user:', user)
-    print('date:', date)
-    print('comment:', csetcomment)
-    if parent:
-        print('parent:', parent)
-    if mparent:
-        print('mparent:', mparent)
-    if tag:
-        print('tag:', tag)
-    print('-----------------------------------------')
-
-    # checkout the parent if necessary
-    if cset != 0:
-        if hgbranch[str(cset)] == "branch-" + str(cset):
-            print('creating new branch', hgbranch[str(cset)])
-            os.system('git checkout -b %s %s' % (hgbranch[str(cset)], hgvers[parent]))
-        else:
-            print('checking out branch', hgbranch[str(cset)])
-            os.system('git checkout %s' % hgbranch[str(cset)])
-
-    # merge
-    if mparent:
-        if hgbranch[parent] == hgbranch[str(cset)]:
-            otherbranch = hgbranch[mparent]
-        else:
-            otherbranch = hgbranch[parent]
-        print('merging', otherbranch, 'into', hgbranch[str(cset)])
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
-        print("Deleting unused branch:", otherbranch)
-        os.system('git branch -d %s' % otherbranch)
-
-    # retrieve and record the version
-    vvv = os.popen('git show --quiet --pretty=format:%H').read()
-    print('record', cset, '->', vvv)
-    hgvers[str(cset)] = vvv
-
-if hgnewcsets >= opt_nrepack and opt_nrepack != -1:
-    os.system('git repack -a -d')
-
-# write the state for incrementals
-if state:
-    if verbose:
-        print('Writing state')
-    f = open(state, 'w')
-    pickle.dump(hgvers, f)
-
-# vim: et ts=8 sw=4 sts=4
diff --git a/contrib/hg-to-git/hg-to-git.txt b/contrib/hg-to-git/hg-to-git.txt
deleted file mode 100644
index 91f8fe6410..0000000000
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
2.44.0.650.g4615f65fe0
