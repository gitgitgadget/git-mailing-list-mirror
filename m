From: Christoph <christoph.duelli@gmx.de>
Subject: Re: importing bk into git (succeeded)
Date: Sat, 8 Dec 2007 20:19:09 +0100
Message-ID: <200712082019.10273.christoph.duelli@gmx.de>
References: <200711292232.03352.christoph.duelli@gmx.de> <474FC2C5.8060400@op5.se>
Reply-To: christoph.duelli@gmx.de
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_u4uWH8MWSUNeLLz"
Cc: git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sat Dec 08 20:19:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J15DI-00030E-E3
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 20:19:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015AbXLHTT0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 14:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751995AbXLHTTZ
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 14:19:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:48488 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751841AbXLHTTY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 14:19:24 -0500
Received: (qmail invoked by alias); 08 Dec 2007 19:19:21 -0000
Received: from dslb-088-065-136-221.pools.arcor-ip.net (EHLO dslb-088-065-136-221.pools.arcor-ip.net) [88.65.136.221]
  by mail.gmx.net (mp056) with SMTP; 08 Dec 2007 20:19:21 +0100
X-Authenticated: #2486746
X-Provags-ID: V01U2FsdGVkX18VIyZ2LHIVsyzOWTqS1emqQ5e4M0XKu+Yq+RgQ0z
	FWdLwfslEkmjCh
User-Agent: KMail/1.9.6 (enterprise 20070904.708012)
In-Reply-To: <474FC2C5.8060400@op5.se>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67565>

--Boundary-00=_u4uWH8MWSUNeLLz
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 30 November 2007 08:59:01 you wrote:
> Christoph wrote:
> > I am trying to import a BitKeeper repo into a (new) git repo.
> >
> > I am trying with the script bk2git.py that I found on the web.
> > This does not quite work - I fear script is no longer working with the
> > current git release. (I am using the current git release.)
[snip]
> > The following lines fail
> >   os.system("cd %s; git-ls-files --deleted | xargs
> > git-update-cache --remove" % tmp_dir)
[snip]
> It should still do this, afaik, although it's probably better
> to just use GIT_DIR nowadays.
Using GIT_DIR works, one has to set it to point to the .git directory (I had 
assumed the git_dir to be the one *containing* .git).

Another point with the original script was that you had to have all commiters 
in the mapping (email -> name), otherwise it would not work. 
(Supplying '*Unknown*' fixed this.)

I have added
- better arguments parsing (see --help)
- ability to do incremental conversions (--incr-db, -r)
- different levels of verbosity

I have attached a working version of the script. I have added comments that 
(try to) explain the script if someone else has trouble with it.

Moreover, it is very helpful to put the directories inside a ramdisk. 
Otherwise, you have to be extremely patient.
(You have to be patient anyway. For a bk repo of some 14k files (>110MB  
when 'clean', 8000 changesets) the script took some 11hrs).
Another issue (when using ramdisks) is memory. On my machine memory is scarce 
(only 1 GB). So the ever growing bare repo (can't be gc'ed before getting its 
head) exhausted the ramdisk space. I worked around this by doing an 
incremental conversion. After each increment a gc is possible and the git 
repo shrinks to a managable size (and still fits inside the ramdisk).

So, to sum up: converting a big repo is no fun, but it works, given enough 
time (and ram).

Thanks, best regards
Christoph
-- 
A billion here, a couple of billion there -- first thing you know it
adds up to be real money.
		-- Senator Everett McKinley Dirksen

--Boundary-00=_u4uWH8MWSUNeLLz
Content-Type: application/x-python;
  name="bk2git.py"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bk2git.py"

# A small script to convert a bk-repo to git.

import cPickle
import getopt
import os
import sys
import time

# Log what the importer is doing
log_import=0
# Log bitkeeper commands
log_bk=0
# Log git commands
log_git=0
# indent log output (acc. to recursion level)
log_indent=0

# Important: if you have many more change sets the script might fail
# due to to deeply nested recursion. If so, increase this number.
sys.setrecursionlimit(10000)

# Working directories (HINT: using a ramdisk greatly speeds things up!)
#    (usually as root: mount -t tmpfs none /tmp/ramdisk -o size=250m)
# The directory containing the bk repo
tmpdir = '/tmp/ramdisk'
if not os.path.exists(tmpdir):
    tmpdir = '/tmp'

def usage():
    print 'usage: bk2git BK_REPO GIT_REPO --committers=<file> [--to-rev=<rev>]'
    print
    print '   Converts BK_REPO into a GIT_REPO.'
    print '   (The git repo created is bare, you have to clone it afterwards'
    print '    to get a \'normal\' repo with a work tree.'
    print
    print
    print ' Arguments:'
    print '   BK_REPO path to bitkeeper repo to convert to git'
    print '   GIT_REPO path to git repo to be created'
    print '   --committers:  Path to committers file'
    print '                  (one committer per line: email first-name surname)'
    print '   --to-rev, -r:  Revision up to which the repo should be converted'
    print '                  (if omitted, the whole repo will be converted)'
    print '   --tmpdir       Temp. directory to store bk checkouts in'
    print '   --incr-db      \'Database\' file for incremental bk2git conversions'
    print '   --verbose, -v  Show details about the conversion process'
    print '   --verbose-bk   Print bk commands executed'
    print '   --verbose-git  Print git commands executed'
    print '   --help, -h     Print this help.'
    print
    print '(Hint: the conversion is WAY faster if you use a ramdisk for all the paths!)'
    sys.exit(1);

try:
    opts, args = getopt.getopt(sys.argv[3:], 'vhr:c:', ['help', 'committers=', 'to-rev=',
                                                        'tmpdir=', 'incr-db=',
                                                        'verbose', 'verbose-bk', 'verbose-git'])
except getopt.GetoptError:
    # print help information and exit:
    usage()
to_rev = None
committers_file = None
incr_db = None
for o, a in opts:
    if o in ('-r', '--to-rev'):
        to_rev = a
    if o in ('-h', '--help'):
        usage()
        sys.exit()
    if o in ('-c', '--committers'):
        committers_file = a
    if o in ('-b' , '--verbose'):
        log_import = 1
    if o == '--verbose-bk':
        log_bk = 1
    if o == '--verbose-git':
        log_git = 1
    if o == '--tmpdir':
        tmpdir = a
        os.system("mkdir -p %s" % tmpdir)
    if o == '--incr-db':
        incr_db = a

templates_dir = "%s/bk2git/templates" % tmpdir
tmp_dir = "%s/bk-export%d" % (tmpdir, os.getpid())

if committers_file==None:
    print '--committers is a mandatory argument.'
    usage()

# Get repository locations.
if len(sys.argv) < 3:
    print 'BK_REPO and GIT_REPO are mandatory arguments'
    usage()

bk_dir = os.path.abspath(sys.argv[1])
git_dir = os.path.abspath(sys.argv[2])

print 'BK ', bk_dir
print 'GIT', git_dir

# Get committer names.
# (bk only has "email", not full name.)
f = file(committers_file, 'r')
committers = {}
for line in f:
    [m,n] = line.split(' ',1)
    committers[m] = n.strip();
f.close()

# if we do an incremental conversion (and the conversion file
# exists) then the git repo should exist as well
if (incr_db!=None) and os.path.exists(incr_db) and not (os.path.exists(git_dir)):
    print 'Doing an incremental conversion without a git repo to continue from?'
    print '... can not really work.'
    usage()


# aux. function: for indenting log output
depth = 0
def indent():
    ind = ''
    if (log_indent):
       for i in range(depth):
          ind = ind + ' '
    return ind

unknown = {}
# produce the full name (has to be customized above) for bk's email
def get_name(email):
    if committers.has_key(email):
        return committers[email]
    unknown[email] = True
    return '*Unknown*' # git needs a non-empty name, otherwise the commit would fail

# After we have exported bk revision rev we need to update the git index to reflect that revision.
# We the extract the bk commit message and commit the tree with appopriate comments.
def git_commit(rev, p):
    if log_import:
       print indent(), 'Updating index for revision', rev
    os.chdir(tmp_dir)
    os.symlink(git_dir, '.git')
    os.system('git ls-files --deleted | xargs git update-index --remove')
    os.system('git ls-files --others | xargs git update-index --add')
    os.system('git ls-files -z | xargs -0 git update-index')
    treeid = os.popen('git write-tree').read().rstrip()
    os.chdir(git_dir)
    if log_import:
        print indent(), 'wrote tree as ', treeid

    call = "bk prs -r%s -d':KEY:\\n:UTC:\\n:USER:@:HOST:\\n$each(:C:){:C\\n}\\n' ChangeSet | sed 1d" % rev;
    if log_bk:
       print indent(), 'bk: ', call
    bk_info = os.popen("cd %s; %s" % (bk_dir, call)).read()
    [key, date, user, comments] = bk_info.split("\n", 3)

    f = file('/tmp/git-comments','w')
    f.write(comments)
    f.write("BK KEY: %s\n" % key)
    f.close()
    sdate = str(int(time.mktime(time.strptime(date+' UTC', "%Y%m%d%H%M%S %Z"))))
    os.putenv('GIT_AUTHOR_DATE', sdate)
    os.putenv('GIT_AUTHOR_EMAIL', user)
    os.putenv('GIT_AUTHOR_NAME', get_name(user))
    os.putenv('GIT_COMMITTER_EMAIL', user)
    os.putenv('GIT_COMMITTER_NAME', get_name(user))
    call = "git commit-tree %s %s < /tmp/git-comments" % (treeid, ' '.join(['-p '+a for a in p]));
    if log_git:
       print indent(), 'git: ', call
    commitid = os.popen(call).read().rstrip()
    if log_import:
        print indent(), "committed %s as %s" % (rev, commitid)

    if tags.has_key(rev):
        os.system("git-tag %s %s" % (tags[rev], commitid))
        print 'tagged', tags[rev]

    return commitid


# List all bk changesets and the dependencies between them.
# Store the dependencies in parent.
# (We have to look up the dependencies when importing a revision later:
#  all the dependencies have to be done first. This is achieved recursively.
#  Therefore the recursion-level has to be set high enouh. (See above.))
call = 'bk prs -d\':REV:\\t:PARENT:\\t:MPARENT:\\t\\n\' ChangeSet'
if log_bk:
   print call
f = os.popen("cd %s; %s" % (bk_dir, call))
f.readline()
parents={}
for rev in f:
    [n,p] = rev.rstrip().split("\t",1)
    parents[n] = p.split("\t")
f.close()

# Get bk tags.
f = os.popen("cd %s;  bk changes -t -n -d':I:\\t:TAG:'" % bk_dir)
tags={}
for rev in f:
    [n,t] = rev.rstrip().split("\t",1)
    tags[n] = t
f.close()

# Determine and create the root of the (initial/empty) repository
# (if nec., for incremental conversions, this is not needed anymore)
os.putenv('GIT_DIR', git_dir)

count=0
resolved={}
if (incr_db!=None) and os.path.exists(incr_db):
    FILE = open(incr_db, 'r')
    resolved = cPickle.load(FILE)
    FILE.close()

if not resolved.has_key('1.1'):
    os.system("mkdir -p %s; cd %s; git init" % (git_dir, git_dir))
    os.system("git --bare init --template=%s" % templates_dir)
    os.system('git-config core.bare false')
    # commit the initial revision
    os.system("mkdir -p %s; touch %s/initial" % (tmp_dir, tmp_dir))
    resolved = {'1.1': git_commit('1.1',[])}

# Create revision ver (if not yet created) and all revisions it depends upon.
def res(ver):
    if log_import:
       print indent(), 'Importing/Checking revision', ver
    # the revision might already have been imported (branching)
    if resolved.has_key(ver):
        if log_import:
           print indent(), '  already done.'
        return

    global depth # for indentation
    depth += 1
    for v in parents[ver]: # recursion: create all the revisions v depends upon
       res(v)
    depth -= 1

    # now all dependencies should be fulfilled: we can now import the revison ver
    global count
    print indent(), "(%d to go)"%count, 'Exporting revision', ver # always print this message, so the script does not seem hung
    count = count-1
    os.system("rm -Rf %s" % tmp_dir)
    # export the corresponding bk revison into tmp_dir
    call = "bk export -r%s %s" % (ver, tmp_dir)
    if log_bk:
       print indent(), 'bk: ', call
    os.system("cd %s; %s" % (bk_dir, call))

    # not really too useful: better create all the ignores in per-directory files after conversion
    # create the ignore file by extracting the files for this directory from the central bk ignore file
    # todo: create one .gitignore file per directory?
    #ignore = "%s/.gitignore" % tmp_dir
    #call = "bk co -kpq -r@%s BitKeeper/etc/ignore | sed '/^BitKeeper/d;/^PENDING/d;/^$/d' > %s" % (ver, ignore)
    #if log_bk:
    #   print indent(), 'bk: ', call
    #os.system("cd %s; %s" % (bk_dir, call))
    #os.system("test -s %s || rm %s" % (ignore, ignore))

    # commit it into git (and mark it as resolved)
    resolved[ver] = git_commit(ver, [resolved[v] for v in parents[ver]])

    # clean up now and then, otherwise the repo gets quite big
    #if count%100==0:
    #    os.system("cd %s; git gc --aggressive" % git_dir)

    return resolved[ver]

if to_rev==None:
    # Determine the top revision.
    call = 'bk prs -r+ -d\':REV:\' ChangeSet | tail -n 1'
    if log_bk:
        print indent(), call
    to_rev = os.popen("cd %s; %s" % (bk_dir, call)).read()

# Count the number of revisions to be converted
todos=resolved.copy()
def count_todos(ver):
   if todos.has_key(ver):
       return
   global count
   count=count+1
   todos[ver]=1
   for v in parents[ver]: # recursion: create all the revision we depend upon
       count_todos(v)

count_todos(to_rev)
print 'Exporting bitkeeper up to version', to_rev, ("(%d revisions todo)" % count)
# Create top revision (and, recursively, all that it depends upon)
HEAD = res(to_rev)
print 'HEAD:', HEAD
file("%s/refs/heads/master" % git_dir,'w').write(HEAD + "\n")
# Print any emails (from bk commits) that no full names where customized for.
os.system('git gc')
print unknown.keys()

# cleanup
os.system("rm -Rf %s" % tmp_dir)

if incr_db!=None:
    print 'Writing db file for further incremental conversion.'
    FILE = open(incr_db, 'w')
    cPickle.dump(resolved, FILE)
    FILE.close()


--Boundary-00=_u4uWH8MWSUNeLLz--
