From: Christoph <christoph.duelli@gmx.de>
Subject: importing bk into git
Date: Thu, 29 Nov 2007 22:32:03 +0100
Message-ID: <200711292232.03352.christoph.duelli@gmx.de>
Reply-To: christoph.duelli@gmx.de
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_T/yTH96EsQ6GJKh"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 29 22:32:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixqzl-00047N-L1
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 22:32:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761197AbXK2VcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 16:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757832AbXK2VcJ
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 16:32:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:59975 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754102AbXK2VcH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 16:32:07 -0500
Received: (qmail invoked by alias); 29 Nov 2007 21:32:04 -0000
Received: from dslb-088-065-133-246.pools.arcor-ip.net (EHLO dslb-088-065-133-246.pools.arcor-ip.net) [88.65.133.246]
  by mail.gmx.net (mp008) with SMTP; 29 Nov 2007 22:32:04 +0100
X-Authenticated: #2486746
X-Provags-ID: V01U2FsdGVkX1+kEyl0w6ikk+xcQ77DnWJJdDVT4meI3Paoj5ute+
	kS9JAMTt1syVbY
User-Agent: KMail/1.9.6 (enterprise 20070904.708012)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66565>

--Boundary-00=_T/yTH96EsQ6GJKh
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I am trying to import a BitKeeper repo into a (new) git repo.

I am trying with the script bk2git.py that I found on the web.
This does not quite work - I fear script is no longer working with the current 
git release. (I am using the current git release.)

If I have understood the script correctly, it does repeated bk checkouts and 
imports the updates the git repo diff of the (next) checkout etc.

It seems this script tries to do so by settings environment vars
GIT_OBJECT_DIRECTORY and GIT_INDEX_FILE
to point at the git repo.

The bk checkout are done at a temp. dir (tmp_dir).


The following lines fail
  os.system("cd %s; git-ls-files --deleted | xargs 
git-update-cache --remove" % tmp_dir)

with: fatal: Not a git repository
xargs: git-update-cache: No such file or directory

The problem seems to be that the script cd's into the temp dir (which is not a 
git repo) and the git-ls-files fails to find a git repo there.
I think the issue might be that an earlier version of git was perhaps able to 
find the repo by means of the env. vars mentioned above.

Any idea if/how I can fix this?
Thanks for any ideas and best regards

Christoph
(Sorry, my python and git skills are so far very limited.)

PS: I have attached the script I downloaded from the net.
-- 
FORTUNE'S PARTY TIPS		#14

Tired of finding that other people are helping themselves to your good
liquor at BYOB parties?  Take along a candle, which you insert and
light after you've opened the bottle.  No one ever expects anything
drinkable to be in a bottle which has a candle stuck in its neck.

--Boundary-00=_T/yTH96EsQ6GJKh
Content-Type: application/x-python;
  name="bk2git.py"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bk2git.py"

# just a small script to convert a bk-repo to git.

import os
import time

# start with some config...
bk_dir = "/home/andersg/xmms2"
git_dir = "/home/andersg/xmms2.git"
tmp_dir = "/tmp/xmms2-export"

#bk only have "email" not full name.
committers = {
    "andersg@0x63.nu": "Anders Gustafsson",
    "andersg@chernushka.(none)": "Anders Gustafsson",
    "andersg@genesis.xmms.se": "Anders Gustafsson",
    "andersg@netintact.se": "Anders Gustafsson",
    "andersg@xmms.org": "Anders Gustafsson",
    "blow@hal.(none)": "Anders Gustafsson",
    "cmorgan@captainmorgan.(none)": "Chris Morgan",
    "daniel@nittionio.nu": "Daniel Svensson",
    "eleusis@eleusis.f2o.org": "Sham Chukoury",
    "jlt_speex@shamrock.dyndns.org": "Jens Taprogge",
    "jlt_xmms2@shamrock.dyndns.org": "Jens Taprogge",
    "lindgren@debian.(none)": "Michael Lindgren",
    "lindgren@debian.as": "Michael Lindgren",
    "ln@maggie.taprogge.wh": "Jens Taprogge",
    "ln@shamrock.dyndns.org": "Jens Taprogge",
    "nano@insomnia.(none)": "Daniel Svensson",
    "nano@insomnia.nittionio.nu": "Daniel Svensson",
    "nano@neurozine.(none)": "Daniel Svensson",
    "nano@nittionio.nu": "Daniel Svensson",
    "nano@purgatory.lan": "Daniel Svensson",
    "olle@xmms.org": "Olle Hallnas",
    "peter@data.netintact.se": "Peter Alm",
    "peter@dumburk.ithora.nu": "Peter Alm",
    "softchill@blacky.sympatico.ca": "Kristian Benoit",
    "tbe@bernhard.hemma.tobbe.nu": "Tobias Bengtsson",
    "thomas@xmms.org": "Thomas Nilsson",
    "tilman@code-monkey.de": "Tilman Sauerbeck",
    "tru@arclight.local": "Tobias Rundstrom",
    "tru@burnout.home.ithora.nu": "Tobias Rundstrom",
    "tru@darkangel.(none)": "Tobias Rundstrom",
    "tru@electronaut.(none)": "Tobias Rundstrom",
    "tru@electronaut.tobi.debian.as": "Tobias Rundstrom",
    "tru@forsaken.debian.as": "Tobias Rundstrom",
    "tru@nellie.tobi.nu": "Tobias Rundstrom",
    "tru@netintact.se": "Tobias Rundstrom",
    "tru@purgatory.guldkusten.com": "Tobias Rundstrom",
    "tru@shift.local": "Tobias Rundstrom",
    "tru@solitude.debian.as": "Tobias Rundstrom",
    "tru@worf.(none)": "Tobias Rundstrom",
    "tru@xmms.org": "Tobias Rundstrom",
    }




f = os.popen("cd %s; bk prs -d':REV:\\t:PARENT:\\t:MPARENT:\\t\\n' ChangeSet" % bk_dir)
f.readline()
parents={}
for rev in f:
    [n,p] = rev.rstrip().split("\t",1)
    parents[n] = p.split("\t")

os.putenv("GIT_OBJECT_DIRECTORY","%s/objects/" % git_dir)
os.putenv("GIT_INDEX_FILE","%s/index" % git_dir)

os.system("mkdir %s; cd %s; git-init-db" % (git_dir, git_dir))


unknown = {}

def get_name(email):
    if committers.has_key(email):
        return committers[email]
    unknown[email] = True
    return ""

def git_commit(rev, p):
    os.system("cd %s; git-ls-files --deleted | xargs git-update-cache --remove" % tmp_dir)
    os.system("cd %s; git-ls-files --others | xargs git-update-cache --add" % tmp_dir)
    os.system("cd %s; git-ls-files -z | xargs -0 git-update-cache" % tmp_dir)
    treeid = os.popen("git-write-tree").read().rstrip()
    print "wrote tree as %s" % treeid
    os.system("rm -Rf %s" % tmp_dir)

    bk_info = os.popen("cd %s; bk prs -r%s -d':KEY:\\n:UTC:\\n:USER:@:HOST:\\n$each(:C:){:C\\n}\\n' ChangeSet | sed 1d" % (bk_dir, rev)).read()

    [key, date, user, comments] = bk_info.split("\n", 3)
    f = file("/tmp/git-comments","w")
    f.write(comments)
    f.write("\nBK KEY: %s\n" % key)
    f.close()
    os.putenv("GIT_AUTHOR_DATE", str(int(time.mktime(time.strptime(date+" UTC", "%Y%m%d%H%M%S %Z")))))
    os.putenv("GIT_AUTHOR_EMAIL", user)
    os.putenv("GIT_AUTHOR_NAME", get_name(user))
    os.putenv("GIT_COMMITTER_EMAIL", user)
    os.putenv("GIT_COMMITTER_NAME", get_name(user))
    
    commitid = os.popen("git-commit-tree %s %s < /tmp/git-comments" % (treeid, " ".join(["-p "+a for a in p]))).read().rstrip()
    print "committed %s as %s" % (rev, commitid)
    return commitid

os.system("mkdir %s; touch %s/initial" % (tmp_dir, tmp_dir))
resolved = {'1.1': git_commit("1.1",[])}

def res(ver):
    if resolved.has_key(ver):
        return
    
    for v in parents[ver]:
        res(v)
    os.system("cd %s; bk export -r%s %s" % (bk_dir, ver, tmp_dir))
    resolved[ver] = git_commit(ver, [resolved[v] for v in parents[ver]])
    return resolved[ver]

tot = os.popen("cd %s; bk prs -r+ -d':REV:' ChangeSet | tail -n 1" % bk_dir).read()
print "Exporting bitkeeper up to version %s" % tot

HEAD = res(tot)
print "HEAD: %s" % HEAD
os.mkdir("%s/refs" % git_dir)
os.mkdir("%s/refs/tags" % git_dir)
os.mkdir("%s/refs/heads" % git_dir)
file("%s/refs/heads/master" % git_dir,"w").write(HEAD + "\n")
os.symlink("refs/heads/master", "%s/HEAD" % git_dir)
print unknown.keys()

--Boundary-00=_T/yTH96EsQ6GJKh--
