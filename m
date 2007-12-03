From: David Kettler <David.Kettler@dsto.defence.gov.au>
Subject: Re: importing bk into git
Date: 03 Dec 2007 13:32:43 +1030
Message-ID: <t1o1wa432gc.fsf@ednux512.dsto.defence.gov.au>
References: <200711292232.03352.christoph.duelli@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: git@vger.kernel.org
To: christoph.duelli@gmx.de
X-From: git-owner@vger.kernel.org Mon Dec 03 05:45:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz3Bi-0008Rr-1N
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 05:45:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501AbXLCEpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 23:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752337AbXLCEpS
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 23:45:18 -0500
Received: from digger1.defence.gov.au ([203.5.217.4]:59591 "EHLO
	digger1.defence.gov.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbXLCEpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 23:45:16 -0500
X-Greylist: delayed 5533 seconds by postgrey-1.27 at vger.kernel.org; Sun, 02 Dec 2007 23:45:15 EST
Received: from ednmsw511.dsto.defence.gov.au (ednmsw511.dsto.defence.gov.au [131.185.68.12])
	by digger1.defence.gov.au (8.13.8/8.13.8) with ESMTP id lB33CGEA010465
	for <git@vger.kernel.org>; Mon, 3 Dec 2007 13:42:17 +1030 (CST)
Received: from ednex510.dsto.defence.gov.au (ednex510.dsto.defence.gov.au) by 
    ednmsw511.dsto.defence.gov.au (Clearswift SMTPRS 5.2.9) with ESMTP id 
    <T83ac9e351283b9440c1764@ednmsw511.dsto.defence.gov.au>; Mon, 3 Dec 
    2007 13:32:45 +1030
Received: from ednux512.dsto.defence.gov.au ([131.185.28.7]) by 
    ednex510.dsto.defence.gov.au with Microsoft SMTPSVC(6.0.3790.1830); 
    Mon, 3 Dec 2007 13:32:44 +1030
In-Reply-To: <200711292232.03352.christoph.duelli@gmx.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
X-OriginalArrivalTime: 03 Dec 2007 03:02:44.0608 (UTC) 
    FILETIME=[F9E66800:01C83558]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-5.0.1023-15582.000
X-TM-AS-Result: No--12.917200-0.000000-1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66859>

G'day,

I modified that script to convert a number of our repositories in
February.  The version below worked for me at the time, but I'm not
able to test it now as our BK license has expired.  In particular I'm
not sure if the bk_info.split line is correct; I had a reduced form of
this line in the file which now looks obviously wrong.

The script is slow; most of the time is in the bk export for every
revision.  There are probably dumb things in there; I don't know
python and I was just starting with git.

Changes from the version I downloaded from the web include:
  - sundry changes to make it work for me
  - separate committers file to translate user names to full names
  - specify a git dir template
  - copy tags from BK
  - minimal conversion of ignore files
  - increased recursion limit to handle large number of commits

I hope this is useful to someone.

regards, David.

--snip,snip--
# Convert a BK repository to GIT
# usage: bk2git BK_REPO [GIT_REPO]
# Single branch only.

import os
import time
import sys

sys.setrecursionlimit(10000);

templates_dir = "/tmp/bk2git/templates"
committers_file = "/tmp/bk2git/committers"
tmp_dir = "/tmp/bk-export%d" % os.getpid()

# Get repository locations.
if len(sys.argv) < 2 or len(sys.argv) > 3:
    print "usage: bk2git BK_REPO [GIT_REPO]"
    sys.exit(1);

bk_dir = sys.argv[1]
if len(sys.argv) == 3:
    git_dir = sys.argv[2]
else:
    git_dir = bk_dir + ".git"

print "BK  " + bk_dir
print "GIT " + git_dir


# Get committer names.
f = file(committers_file, "r")
committers = {}
for line in f:
    [m,n] = line.split(" ",1)
    committers[m] = n.strip();
f.close()

# Get tree of commits.
f = os.popen("cd %s; bk prs -d':REV:\\t:PARENT:\\t:MPARENT:\\t\\n' ChangeSet" % bk_dir)
f.readline()
parents={}
for rev in f:
    [n,p] = rev.rstrip().split("\t",1)
    parents[n] = p.split("\t")
f.close()

# Get tags.
f = os.popen("cd %s;  bk changes -t -n -d':I:\\t:TAG:'" % bk_dir)
tags={}
for rev in f:
    [n,t] = rev.rstrip().split("\t",1)
    tags[n] = t
f.close()

# Initialize git repository.
os.system("mkdir %s" % git_dir)
os.chdir(git_dir)
os.system("git --bare init --template=%s" % templates_dir)
os.system("git-config core.bare false")

unknown = {}
def get_name(email):
    if committers.has_key(email):
        return committers[email]
    unknown[email] = True
    return "*Unknown*"

def git_commit(rev, p):
    os.chdir(tmp_dir)
    os.symlink(git_dir, "%s/.git" % tmp_dir)
#    os.system("pwd; ls -AlR")
    os.system("git-ls-files -z --deleted | xargs -0 git-update-index --remove")
    os.system("git-ls-files -z --others | xargs -0 git-update-index --add")
    os.system("git-ls-files -z | xargs -0 git-update-index")
    treeid = os.popen("git-write-tree").read().rstrip()
    print "wrote tree as %s" % treeid
    os.chdir(git_dir)
    os.system("rm -Rf %s" % tmp_dir)

    bk_info = os.popen("cd %s; bk prs -r%s -d':KEY:\\n:UTC:\\n:USER:@:HOST:\\n$each(:C:){:C\\n}\\n' ChangeSet | sed 1d" % (bk_dir, rev)).read()

    [key, date, user, comments] = bk_info.split("\n", 3)
#    [key, date, user] = bk_info.split("\n", 2)
    [name, machine] = user.split("@", 1);
    f = file("/tmp/git-comments","w")
    f.write(comments)
    f.write("BK KEY: %s\n" % key)
    f.close()
    sdate = str(int(time.mktime(time.strptime(date+" UTC", "%Y%m%d%H%M%S %Z"))))
    os.putenv("GIT_AUTHOR_DATE", sdate)
    os.putenv("GIT_AUTHOR_EMAIL", user)
    os.putenv("GIT_AUTHOR_NAME", get_name(name))
    os.putenv("GIT_COMMITTER_DATE", sdate)
    os.putenv("GIT_COMMITTER_EMAIL", user)
    os.putenv("GIT_COMMITTER_NAME", get_name(name))
    
    commitid = os.popen("git-commit-tree %s %s < /tmp/git-comments" % (treeid, " ".join(["-p "+a for a in p]))).read().rstrip()
    print "committed %s as %s" % (rev, commitid)

    if tags.has_key(rev):
        os.system("git-tag %s %s" % (tags[rev], commitid))
        print "tagged %s" % tags[rev]

    return commitid

os.system("mkdir %s; touch %s/initial" % (tmp_dir, tmp_dir))
resolved = {'1.1': git_commit("1.1",[])}

def res(ver):
    if resolved.has_key(ver):
        return
    
    for v in parents[ver]:
        res(v)

    os.system("cd %s; bk export -r%s %s" % (bk_dir, ver, tmp_dir))
    ignore = "%s/.gitignore" % tmp_dir
    os.system("cd %s; bk co -kpq -r@%s BitKeeper/etc/ignore | sed '/^BitKeeper/d;/^PENDING/d' > %s" % (bk_dir, ver, ignore))
    os.system("test -s %s || rm %s" % (ignore, ignore))

    resolved[ver] = git_commit(ver, [resolved[v] for v in parents[ver]])
    return resolved[ver]

tot = os.popen("cd %s; bk prs -r+ -d':REV:' ChangeSet | tail -n 1" % bk_dir).read()
print "Exporting bitkeeper up to version %s" % tot

HEAD = res(tot)
print "HEAD: %s" % HEAD
file("%s/refs/heads/master" % git_dir,"w").write(HEAD + "\n")
os.system("git-config core.bare true")
os.system("git gc")
print unknown.keys()
--snip,snip--
-- 
IMPORTANT: This email remains the property of the Australian Defence
Organisation and is subject to the jurisdiction of section 70 of the
CRIMES ACT 1914. If you have received this email in error, you are
requested to contact the sender and delete the email.
