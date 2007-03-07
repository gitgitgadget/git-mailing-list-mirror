From: Theodore Tso <tytso@mit.edu>
Subject: Re: mercurial to git
Date: Tue, 6 Mar 2007 19:11:05 -0500
Message-ID: <20070307001105.GJ18370@thunk.org>
References: <20070306210629.GA42331@peter.daprodeges.fqdn.th-h.de> <20070306215459.GI18370@thunk.org> <20070306230802.GA17226@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Wed Mar 07 01:11:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOjkR-0008Rd-03
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 01:11:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030760AbXCGALL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 19:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030761AbXCGALL
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 19:11:11 -0500
Received: from thunk.org ([69.25.196.29]:48848 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030760AbXCGALJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 19:11:09 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HOjpu-0003pb-JW; Tue, 06 Mar 2007 19:16:55 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HOjkH-0006dQ-ME; Tue, 06 Mar 2007 19:11:05 -0500
Content-Disposition: inline
In-Reply-To: <20070306230802.GA17226@filer.fsl.cs.sunysb.edu>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41625>

On Tue, Mar 06, 2007 at 06:08:02PM -0500, Josef Sipek wrote:
> I'll try to dig up the code, and put it up somewhere...

Here's a hacked up version of Stelian Pop's converter code that I used
for an initial test conversion of e2fsprogs from hg to git.  The main
improvements from Stelian's is that it's a bit faster by caching the
results of "hg log", and that it handles parses the Signed-off-by:
headers to feed in into the ChangeSet's Author identity (as distinct
from the committer identity, which it gets from the hg information).

The other change which I added was add a pretty kludgy committer name
cannonicalizer, since there the commiter information dates is pretty
grotty.  That's because the e2fsprogs source repository has over the
years been converted from CVS, to BitKeeper, to Mercurial, and now at
some point soon when I'm happy with a decent hg-to-git tool, to git.

My plan was to rewrite the converter to call Mercurial's python
classes directly (using the equivalent python code to 'hg manifest'
and 'hg cat' to speed things up enormously, compared to checking out
each revision one at a time and then using git to figure out which
files had been added/changed/deleted), and to interface it into
git-fast-import, and make the necessary changes (including more
intelligent handling of .hgtags) so that the conversion could be
bidrectional.

But if I can convince someone else to do the work, especially if their
converter handles the Signed-off-by: parsing, and making sure the
author and commit dates are properly set, that would certainly be a
bonus.  :-)

						- Ted

P.S.  Oh yes, my plan was to use Python's ConfigParser class to store
the author cannonicalization information, instead of hard-coding the
data into the python script.  Code snippets to do this available on
request; it was pretty trivial to do.

#! /usr/bin/python

""" hg-to-git.py - A Mercurial to GIT converter

    Copyright (C)2007 Stelian Pop <stelian@xxxxxxxxxx>

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2, or (at your option)
    any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
"""

import os, os.path, sys
import tempfile, popen2, pickle, getopt
import re

# Maps hg version -> git version
hgvers = {}
# List of children for each hg revision
hgchildren = {}
# Current branch for each hg revision
hgbranch = {}

#------------------------------------------------------------------------------

def usage():

        print """\
%s: [OPTIONS] <hgprj>

options:
    -s, --gitstate=FILE: name of the state to be saved/read
                         for incrementals

required:
    hgprj:  name of the HG project to import (directory)
""" % sys.argv[0]

#------------------------------------------------------------------------------

def getgitenv(user, author, date):
    env = ''
    if author == '':
	author = user

    elems = re.compile('(.*?)\s+<(.*)>').match(user)
    if elems:
        env += 'export GIT_COMMITER_NAME="%s" ;' % elems.group(1)
        env += 'export GIT_COMMITER_EMAIL="%s" ;' % elems.group(2)
    else:
        env += 'export GIT_COMMITER_NAME="%s" ;' % user
        env += 'export GIT_COMMITER_EMAIL= ;'

    elems = re.compile('(.*?)\s+<(.*)>').match(author)
    if elems:
        env += 'export GIT_AUTHOR_NAME="%s" ;' % elems.group(1)
        env += 'export GIT_AUTHOR_EMAIL="%s" ;' % elems.group(2)
    else:
        env += 'export GIT_AUTHOR_NAME="%s" ;' % author
        env += 'export GIT_AUTHOR_EMAIL= ;'

    env += 'export GIT_AUTHOR_DATE="%s" ;' % date
    env += 'export GIT_COMMITTER_DATE="%s" ;' % date
    return env

#------------------------------------------------------------------------------

state = ''

try:
    opts, args = getopt.getopt(sys.argv[1:], 's:t:', ['gitstate=', 'tempdir='])
    for o, a in opts:
        if o in ('-s', '--gitstate'):
            state = a
            state = os.path.abspath(state)

    if len(args) != 1:
        raise('params')
except:
    usage()
    sys.exit(1)

hgprj = args[0]
os.chdir(hgprj)

if state:
    if os.path.exists(state):
        print 'State does exist, reading'
        f = open(state, 'r')
        hgvers = pickle.load(f)
    else:
        print 'State does not exist, first run'

tip = os.popen('hg tip | head -1 | cut -f 2 -d :').read().strip()
print 'tip is', tip

# Calculate the branches
print 'analysing the branches...'
hgchildren["0"] = ()
hgbranch["0"] = "master"
for cset in range(1, int(tip) + 1):
    hgchildren[str(cset)] = ()
    prnts = os.popen('hg log -r %d | grep ^parent: | cut -f 2 -d :' % cset).readlines()
    if len(prnts) > 0:
        parent = prnts[0].strip()
    else:
        parent = str(cset - 1)
    hgchildren[parent] += ( str(cset), )
    if len(prnts) > 1:
        mparent = prnts[1].strip()
        hgchildren[mparent] += ( str(cset), )
    else:
        mparent = None

    if mparent:
        # For merge changesets, take either one, preferably the 'master' branch
        if hgbranch[mparent] == 'master':
            hgbranch[str(cset)] = 'master'
        else:
            hgbranch[str(cset)] = hgbranch[parent]
    else:
        # Normal changesets
        # For first children, take the parent branch, for the others create a new branch
        if hgchildren[parent][0] == str(cset):
            hgbranch[str(cset)] = hgbranch[parent]
        else:
            hgbranch[str(cset)] = "branch-" + str(cset)

if not hgvers.has_key("0"):
    print 'creating repository'
    os.system('git-init-db')

# loop through every hg changeset
for cset in range(int(tip) + 1):

    # incremental, already seen
    if hgvers.has_key(str(cset)):
        continue

    # get info
    prnts = os.popen('hg log -r %d | grep ^parent: | cut -f 2 -d :' % cset).readlines()
    if len(prnts) > 0:
        parent = prnts[0].strip()
    else:
        parent = str(cset - 1)
    if len(prnts) > 1:
        mparent = prnts[1].strip()
    else:
        mparent = None

    (fdlog, filelog) = tempfile.mkstemp()
    logtxt = os.popen('hg log -r %d -v' % cset).read().strip()
    os.write(fdlog, logtxt)
    os.close(fdlog)

    (fdcomment, filecomment) = tempfile.mkstemp()
    csetcomment = os.popen('grep -v ^changeset: < %s | grep -v ^parent: | grep -v ^user: | grep -v ^date | grep -v ^files: | grep -v ^description: | grep -v ^tag:' % filelog).read().strip()
    os.write(fdcomment, csetcomment)
    os.close(fdcomment)

    date = os.popen('grep -m 1 ^date: < %s | cut -f 2- -d :' % filelog).read().strip()

    tag = os.popen('grep -m 1 ^tag: < %s | cut -f 2- -d :' % filelog).read().strip()

    user = os.popen('grep -m 1 ^user: < %s | cut -f 2- -d :' % filelog).read().strip()
    if user == 'tytso@mit.edu':
	user = "Theodore Ts'o <tytso@mit.edu>"
    if user == 'tytso@think.thunk.org':
	user = "Theodore Ts'o <tytso@mit.edu>"
    if user == 'tytso@snap.thunk.org':
	user = "Theodore Ts'o <tytso@mit.edu>"
    if user == 'tytso@fs.thunk.org':
	user = "Theodore Ts'o <tytso@mit.edu>"
    if user == 'tytso@voltaire.debian.org':
	user = "Theodore Ts'o <tytso@mit.edu>"
    if user == 'tytso@who-could-of.thunk.org':
	user = "Theodore Ts'o <tytso@mit.edu>"
    if user == 'tytso@universal.(none)':
	user = "Theodore Ts'o <tytso@mit.edu>"
    if user == 'tytso@theodore-tsos-computer.local':
	user = "Theodore Ts'o <tytso@mit.edu>"

    if user == 'adilger@clusterfs.com':
	user = "Andreas Dilger <adilger@clusterfs.com>"
    if user == 'adilger@lynx.adilger.int':
	user = "Andreas Dilger <adilger@clusterfs.com>"
    if user == 'root@lynx.adilger.int':
	user = "Andreas Dilger <adilger@clusterfs.com>"
    if user == 'matthias.andree@gmx.de':
	user = "Matthias Andree <matthias.andree@gmx.de>"

    if user == 'laptop@duncow.home.oldelvet.org.uk':
	user = "Richard Mortimer <richm@oldelvet.org.uk>"

    if user == 'sct@redhat.com':
	user = 'Stephen Tweedie <sct@redhat.com>'
    if user == 'sct@sisko.scot.redhat.com':
	user = 'Stephen Tweedie <sct@redhat.com>'

    if user == 'paubert@gra-vd1.iram.es':
	user = 'Gabriel Paubert <paubert@iram.es>'

    author = os.popen('grep -m 1 ^Signed-off-by: < %s | cut -f 2- -d :' % filelog).read().strip()
    if author == '"Theodore Ts\'o" <tytso@mit.edu>':
	author = "Theodore Ts'o <tytso@mit.edu>"

    os.unlink(filelog)

    print '-----------------------------------------'
    print 'cset:', cset
    print 'branch:', hgbranch[str(cset)]
    print 'user:', user
    print 'author:', author
    print 'date:', date
    print 'comment:', csetcomment
    print 'parent:', parent
    if mparent:
        print 'mparent:', mparent
    if tag:
        print 'tag:', tag
    print '-----------------------------------------'

    # checkout the parent if necessary
    if cset != 0:
        if hgbranch[str(cset)] == "branch-" + str(cset):
            print 'creating new branch', hgbranch[str(cset)]
            os.system('git-checkout -b %s %s' % (hgbranch[str(cset)], hgvers[parent]))
        else:
            print 'checking out branch', hgbranch[str(cset)]
            os.system('git-checkout %s' % hgbranch[str(cset)])

    # merge
    if mparent:
        if hgbranch[parent] == hgbranch[str(cset)]:
            otherbranch = hgbranch[mparent]
        else:
            otherbranch = hgbranch[parent]
        print 'merging', otherbranch, 'into', hgbranch[str(cset)]
        os.system(getgitenv(user, author, date) + 'git-merge --no-commit -s ours "" %s %s' % (hgbranch[str(cset)], otherbranch))

    # remove everything except .git and .hg directories
    os.system('find . \( -path "./.hg" -o -path "./.git" \) -prune -o ! -name "." -print | xargs rm -rf')

    # repopulate with checkouted files
    os.system('hg update -C %d' % cset)

    # add new files
    os.system('git-ls-files -x .hg --others | git-update-index --add --stdin')
    # delete removed files
    os.system('git-ls-files -x .hg --deleted | git-update-index --remove --stdin')

    # commit
    os.system(getgitenv(user, author, date) + 'git-commit -a -F %s' % filecomment)
    os.unlink(filecomment)

    # tag
    if tag and tag != 'tip':
        os.system(getgitenv(user, author, date) + 'git-tag %s' % tag)

    # delete branch if not used anymore...
    if mparent and len(hgchildren[str(cset)]):
        print "Deleting unused branch:", otherbranch
        os.system('git-branch -d %s' % otherbranch)

    # retrieve and record the version
    vvv = os.popen('git-show | head -1').read()
    vvv = vvv[vvv.index(' ') + 1 : ].strip()
    print 'record', cset, '->', vvv
    hgvers[str(cset)] = vvv

os.system('git-repack -a -d')

# write the state for incrementals
if state:
    print 'Writing state'
    f = open(state, 'w')
    pickle.dump(hgvers, f)

# vim: et ts=8 sw=4 sts=4
