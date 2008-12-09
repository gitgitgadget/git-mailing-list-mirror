From: John Chapman <thestar@fussycoder.id.au>
Subject: New script to convert p4 repositories to git - git-p4c version 1.
Date: Tue, 09 Dec 2008 21:25:17 +1100
Message-ID: <1228818317.5504.23.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-mKmaWW3/RZ42cRimIrjV"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 09 13:41:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LA1tm-00054p-1i
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 13:41:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751829AbYLIMjw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 07:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751844AbYLIMjw
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 07:39:52 -0500
Received: from nskntqsrv03p.mx.bigpond.com ([61.9.168.237]:21426 "EHLO
	nskntqsrv03p.mx.bigpond.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751724AbYLIMju (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Dec 2008 07:39:50 -0500
Received: from nskntotgx02p.mx.bigpond.com ([58.173.132.215])
          by nskntmtas01p.mx.bigpond.com with ESMTP
          id <20081209102537.JWGJ6186.nskntmtas01p.mx.bigpond.com@nskntotgx02p.mx.bigpond.com>
          for <git@vger.kernel.org>; Tue, 9 Dec 2008 10:25:37 +0000
Received: from arafangion-lenovo.local ([58.173.132.215])
          by nskntotgx02p.mx.bigpond.com with ESMTP
          id <20081209102532.HOTJ17941.nskntotgx02p.mx.bigpond.com@arafangion-lenovo.local>
          for <git@vger.kernel.org>; Tue, 9 Dec 2008 10:25:32 +0000
X-Mailer: Evolution 2.6.3 
X-RPD-ScanID: Class unknown; VirusThreatLevel unknown, RefID str=0001.0A150205.493E479F.0054,ss=1,fgs=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102628>


--=-mKmaWW3/RZ42cRimIrjV
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I couldn't use git-p4 on my system because I kept running out of memory,
and I didn't like the workflow it imposed.
Also, it had various other issues with the repo I was trying to use,
mainly because it is not an ideal repository, however those are
(generally) the fault of the particular repo I was using, and not
git-p4. (Which is an excellent script by itself).

This script is severely crippled in that it doesn't (yet) allow one to
contribute changesets back to perforce, however it manages to read from
perforce with:
* No need to rebase.
* Mangling of file names. (Especially with regards to case sensitivity).
* Tagging of revisions with the perforce changesets.
* Ability to handle branches with spaces in the name.
* Ability to pretend that perforce doesn't exist. (That's the plan,
anyway).
* Be extremely memory efficient. It does NOT require as much memory as
does git-p4, even when the size of the change is large.
* Be easy to manually modify the repository, particularly if bad things
happen.

Unfortunately, not all of the above features may be reliable yet,
however I offer this script in order to obtain hopefully constructive
feedback so that I may improve the script and make it work very well.

Once I perfect this script, I plan to work on getting changes from git
back into perforce, which I have a few ideas as to how I might do it.
(None of which require rebasing).

It requires an OS that can efficiently utilise many open files and
pipes, and can run many processes. Such as Linux.  I seriously doubt it
can work on Windows.

It is called git-p4c, because 'git-p4' was taken, and I intended to
write it in C++.  I may still rewrite it in C++ if it is found
neccessary to use it on windows. (The Perforce C++ ABI will remove the
need to fork so many processes), but I won't be doing that before I
implement the write to perforce support.

Consider this to be experimental, not yet worthy of a version number.

Remember, I crave (constructive) feedback.

Thankyou.

--=-mKmaWW3/RZ42cRimIrjV
Content-Disposition: attachment; filename=git-p4c
Content-Type: text/x-python; name=git-p4c; charset=UTF-8
Content-Transfer-Encoding: 7bit

#!/usr/bin/env python

USAGE = r'''
git-p4c - written by John Chapman.

License:
    You are free to use this under the terms of the GPL License
    http://www.fsf.org/licensing/licenses/gpl.html

    I may change the license at any date in the future, unless
    I have substantial contributions, but regardless of what licence
    I choose, it will be an open source license.

    Probably it will become whatever license Git itself is under,
    just to make my life easier.

Example:
~/git-p4c/git-p4c \
--server=localhost:1666 \
--root=//depot \
--repo=/tmp/playground \
--user=arafangion \
--pass= \
--p4=/home/arafangion/perforce/p4 \
--max-changes=2 \
--branches='
trunk=//depot/(trunk)/(.*)
branches=//depot/branches/(.*?)/(.*)
'
'''

import datetime
import fcntl
import marshal
import os
import subprocess
import sys
import time
import sre

def main():
    opts = (
        '--server',
        '--user',
        '--pass',
        '--allow-case-changes',
        '--root',
        '--p4',
        '--branches',
        '--repo',
        '--initial',
        '--max-changes')

    config = git_config()

    # Now, override configuration if specified:
    for arg in sys.argv:
        for opt in opts:
            if arg.startswith(opt):
                config[opt[2:]] = arg.split('=', 1)[1]

    config = git_config(config)

    P4C = p4c_Connection(config)
    GIT = git_Connection(config)

    start = max(int(config['initial'])-1, GIT.latest())

    print 'Downloading Changesets...'
    c = 0
    t = time.time()
    for cs in P4C.changesets(start):
        if c != 0:
            print 'Processing:', cs.number, 'Avg: ', (time.time()-t)/float(c), ' at', datetime.datetime.today().ctime(),
        else:
            print 'Processing:', cs.number,
        g = GIT.commit(cs)
        if g is not None:
            for file in cs.files():
                if file.is_interesting():
                    sys.stdout.write('.')
                    g.add(file)
            sys.stdout.write('\n')
            g.commit()
        c += 1

        if c >= int(config['max-changes']):
            break

    print 'Fetch Complete!'

def git_config(conf=None):
    if conf is not None:
        if 'repo' in conf:
            try:
                os.mkdir(conf['repo'])
            except:
                pass
            os.chdir(conf['repo'])
        g = subprocess.Popen(('git', 'init'))
        g.wait()

        for key in conf:
            if '\n' in conf[key]:
                c = 1
                for line in conf[key].split('\n'):
                    line = line.strip()
                    if line=='':
                        continue
                    p = subprocess.Popen(('git', 'config', 'git-p4c.'+key+'-'+str(c), line))
                    p.wait()
                    c += 1
            else:
                p = subprocess.Popen(('git', 'config', 'git-p4c.'+key, conf[key]))
                p.wait()
    else:
        conf = {}

    p = subprocess.Popen(('git', 'config', '-l'), stdout=subprocess.PIPE)
    p.wait()
    conf = {}
    for line in p.stdout.readlines():
        line = line.strip()
        if line.startswith('git-p4c.'):
            key, value = line.split('=', 1)
            key = key[len('git-p4c.'):]
            if key.split('-')[0] == 'branches':
                if 'branches' not in conf:
                    conf['branches'] = []
                conf['branches'].append(value)
            else:
                conf[key] = value

    # Default Values:
    if 'initial' not in conf:
        conf['initial'] = '0'
    if 'max-changes' not in conf:
        conf['max-changes'] = '999999999'

    return conf

class git_Connection:
    def __init__(self, config):
        self._latest_mark = 1
        self._latest_changeset = 0
        self.config = config
        self._tags = {}
        cmd = ('git', 'fast-import')
        self._fast_import = subprocess.Popen(cmd,
            bufsize=0,
            stdin=subprocess.PIPE,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE)
        self._prev_p4changeset = None

        # Now, determine the current heads:
        g = subprocess.Popen(('git', 'tag'),
            stdout=subprocess.PIPE)
        heads = {}
        for line in g.stdout.readlines():
            line = line.strip()
            branch, number = unformat_tag(config, line)
            if branch not in heads:
                heads[branch] = [line, number]
            if heads[branch][1] < number:
                heads[branch][1] = number
        max = 0
        for head in heads:
            if max < heads[head][1]:
                max = heads[head][1]
            tag = 'refs/tags/'+heads[head][0]
            t = open('.git/'+tag, 'rb')
            committish = t.read().strip()
            self._record_tag(
                format_tag(
                    self.config, head, heads[head][1]),
                committish)
        self._latest_changeset = max
        self._heads = heads

    def _record_tag(self, tag, committish):
        self._tags[tag] = committish
    def tag_sha1(self, tag):
        return self._tags[tag]
    def heads(self):
        return self._heads
    def latest(self):
        'Returns the latest perforce changeset'
        return self._latest_changeset
    def commit(self, p4changeset):
        return git_Commit(self, p4changeset)
    def next_mark(self):
        'TODO: Ensure that the latest mark in the marks file is used as the starting point.'
        self._latest_mark += 1
        return self._latest_mark

class git_Commit:
    def __init__(self, connection, commit):
        self._con = connection
        self._commit = commit
        self._files = {}
    def add(self, p4file):
        if not self._files.has_key(p4file.branch()):
            self._files[p4file.branch()] = []
        self._files[p4file.branch()].append(p4file)

        if not p4file.action in ('delete', 'purge'):
            p4file.mark = self._con.next_mark()
            self._write('blob\nmark :%(mark)d\ndata %(size)d\n' % {
                'mark':p4file.mark,
                'size':p4file.size})

            data = 'foo'
            while data != '':
                try:
                    data = p4file.read(1024)
                    self._write(data)
                except:
                    time.sleep(0.1)
                    data = 'foo'
        p4file.close_files()
    def _write(self, s):
        self._con._fast_import.stdin.write(s)
    def commit(self):
        self._mark = self._con.next_mark()
        mark = self._mark
        for branch in self._files.keys():
            if branch in self._con.heads():
                from_tag = format_tag(self._con.config, branch, self._con.heads()[branch][1])
            else:
                from_tag = None
            self._con.heads()[branch] = [format_tag(self._con.config, branch, self._commit.number), self._commit.number]
            from_branch = self._files[branch][0].orig_branch()
            self._write(
'''commit %(ref)s
mark :%(mark)d
committer %(name)s <%(email)s> %(when)d +0000
data %(length)d
%(message)s
''' % {'ref':'refs/heads/'+branch,
                'mark':mark, 
                'name':self._commit.author(),
                'email':self._commit.email(),
                'when':self._commit.time(),
                'length':len(self._commit.commit_msg()),
                'message':self._commit.commit_msg()})
            if branch != from_branch:
                self._write(
                    'from %(from)s\n' %
                    {'from':'refs/heads/'+from_branch})
            elif from_tag is not None:
                self._write(
                    'from %(from)s\n' %
                    {'from':self._con.tag_sha1(from_tag)})

            for file in self._files[branch]:
                if file.action in ('add', 'edit', 'integrate', 'branch'):
                    self._c_add(file)
                elif file.action in ('delete', 'purge'):
                    self._c_delete(file)
                else:
                    print 'Unhandled action:', file

            tagname = format_tag(self._con.config, branch, self._commit.number)
            self._write(
'''tag %(tagname)s
from %(committish)s
tagger %(name)s <%(email)s> %(when)d +0000
data 0
''' % {
            'tagname':tagname,
            'committish':':'+str(mark),
            'name':self._commit.author(),
            'email':self._commit.email(),
            'when':self._commit.time()})
            self._con._record_tag(tagname, ':'+str(mark))
    def _c_add(self, file):
        self._write(
            '''M 100644 :%(mark)d %(path)s\n''' % {
                'path':file.name(),
                'mark':file.mark})
    def _c_delete(self, file):
        self._write('D %(path)s\n' % {'path':file.name()})

class p4c_Connection:
    def __init__(self, details):
        self._p4_exe = details['p4']
        self._p4port = details['server']
        self.config = details
        self._users = None
    def _p4(self, args):
        return subprocess.Popen(
            (self._p4_exe,)+args,
            bufsize=0,
            stdin=subprocess.PIPE,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            env={'P4PORT':self._p4port,'P4PASSWD':self.config['pass'],'P4USER':self.config['user']},
            close_fds=True)
    def user(self, username):
        if self._users is None:
            p = self._p4(('-G', 'users'))
            try:
                self._users = {}
                while True:
                    d = marshal.load(p.stdout)
                    self._users[username] = {}
                    self._users[username]['email'] = d['Email']
                    self._users[username]['name'] = d['FullName']
            except EOFError, e:
                pass
        try:
            return self._users[username]
        except:
            return {'email':'Not A Current P4 User', 'name':username}

    def changesets(self, start):
        if self.config['root'][-1] != '/':
            self.config['root'] += '/'

        p = self._p4(('-G', 'changes', '-l', '-t', self.config['root']+'...'))

        try:
            self._changesets = []
            while True:
                d = marshal.load(p.stdout)
                self._changesets.append((int(d['change']), int(d['time'])))
        except EOFError, e:
            pass

        def s(x, y):
            if x[1] < y[1]: return -1
            if x[1] > y[1]: return 1
            return 0
        self._changesets.sort(s)
        for change, time in self._changesets:
            if change > start:
                yield self._Changeset(self, change, time)

    class _File:
        def __init__(self, connection, details):
            self._connection = connection
            self._details = details
            self.action = self._details['action']
            p = self._connection._p4(('-G', 'sizes', self.p4name()))
            try:
                if not self.action in ('delete', 'purge'):
                    self.size = marshal.load(p.stdout)
                    self.size = int(self.size['fileSize'])
            except Exception, e:
                self.size = 0
                self.action = 'purge'
            self._p = self._connection._p4(('print', '-q', self.p4name()))
            self.read = self._p.stdout.read

            oldflags = fcntl.fcntl(self._p.stdout, fcntl.F_GETFL)
            fcntl.fcntl(self._p.stdout, fcntl.F_SETFL, oldflags|os.O_NONBLOCK)

            try:
                self._branch_name, self._orig_branch, self._name = on_branch(self._connection.config, self.p4name())
            except:
                self._branch_name = None
                self._orig_branch = None
                self._name = None
        def p4name(self):
            return '//'+self._details['file']+'#'+self.rev()
        def branch(self):
            return self._branch_name
        def orig_branch(self):
            return self._orig_branch
        def name(self):
            return self._name
        def is_interesting(self):
            return self._branch_name is not None
        def rev(self):
            return self._details['rev']
        def tag(self):
            print self
            return self._details['tag']
        def __str__(self):
            return '\t'.join([key+' '+self._details[key] for key in self._details.keys()])
        def __del__(self):
            if self.read is not None:
                self.close_files() 
        def close_files(self):
            self.read = None
            self._p.stdout.close()
            self._p.stderr.close()
            self._p.stdin.close()
            self._p.wait()
            del self._p

    class _Changeset:
        def __init__(self, connection, number, time):
            self.number = number
            self._time = time
            self._connection = connection
            self._desc = {}
            self._files = {}

            p = self._connection._p4(('-G', 'describe',  str(self.number)))
            try:
                d = marshal.load(p.stdout)
                for key in d.keys():
                    if key[-1] in '0123456789':
                        'Is referring to a particular file.'
                        num = 0
                        name = ''
                        for c in key:
                            if c in '0123456789':
                                num *= 10
                                num += int(c)
                            else:
                                name += c
                        if not self._files.has_key(num):
                            self._files[num] = {}
                        'TODO: Determine which branch(es) this file belongs to.'
                        if name == 'depotFile':
                            self._files[num]['file'] = d[key][2:]
                        else:
                            self._files[num][name] = d[key]
                        self._files[num][name] = d[key]
                    else:
                        self._desc[key] = d[key]
            except EOFError, e:
                pass
        def __str__(self):
            return 'Changeset: %s Time: %s' % (self.number, self.time)
        def commit_msg(self):
            return self._desc['desc']
        def author(self):
            return self._connection.user(self._desc['client'])['name']+" '"+self._desc['client']+"'"
        def email(self):
            return self._connection.user(self._desc['client'])['email']
        def time(self):
            return self._time

        def files(self):
            for number in self._files.keys():
                yield self._connection._File(self._connection, self._files[number])


_seen = None
_tree = None
def generate_tree():
    '''Reads the current git repo and iterates over every branch, reading all files and
    directories, in order to ensure that file case does not ever change'''

    def get_branches():
        p = subprocess.Popen(('git', 'branch'), stdout=subprocess.PIPE)
        p.wait()
        for line in p.stdout.readlines():
            yield line.strip()
    def get_ls_tree(BranchOrSha1, dir=''):
        '''This function is very recursive,
        it returns ALL the trees (ie, the directories).'''
        p = subprocess.Popen(('git', 'ls-tree', BranchOrSha1), stdout=subprocess.PIPE)
        p.wait()
        for line in p.stdout.readlines():
            items = [item.strip() for item in line.strip().split(' ', 2)]
            last = items[-1]
            del items[-1]
            split_items = last.split('\t', 1)
            items.append(split_items[0])
            items.append(dir+split_items[1]+'/')

            if items[1] == 'tree':
                yield items
                for item in get_ls_tree(items[2], items[-1]):
                    yield item

    global _tree
    _tree = {}

    for branch in get_branches():
        for items in get_ls_tree(branch):
            _tree[items[-1][:-1].lower()] = items[-1][:-1].split('/')[-1]

def mangle_case(config, file):
    components = file.split('/')
    for i in range(len(components)-1):
        part = '/'.join(components[:i+1]).lower()
        if part in _tree:
            components[i] = _tree[part]
        else:
            _tree['/'.join(components[:i+1])] = components[i]

    file = '/'.join(components)
    return file

def on_branch(config, p4_filename):
    # TODO: Need to change this so that:
    # * If desired, prevent changes in case, either by simply preventing changes in case,
    #   or also by using an 'authoritative' perforce changeset.
    # * Stop using the stupid global for _seen, and consult the repo.
    #   (Currently it's worse than nothing, because
    #   it stuffs up the parent commits.)
    global _seen

    if _tree is None:
        generate_tree()

    if _seen is None:
        _seen = {}
        p = subprocess.Popen(('git', 'branch'), stdout=subprocess.PIPE)
        for line in p.stdout.readlines():
            _seen[line.strip()] = None
        p.wait()

    first=None
    for b in config['branches']:
        b, p = b.split('=', 1)

        if first is None:
            first = b
        m = sre.match('^'+p+'\#.*$', p4_filename)
        if m:
            branch, file = m.groups()
            if branch in _seen:
                return branch, branch, mangle_case(config, file)
            else:
                _seen[branch] = None
                return branch, first, mangle_case(config, file)

def format_tag(config, branch, number):
    return branch+'/'+str(number)

def unformat_tag(config, tag):
    branch, number = tag.rsplit('/', 1)
    number = int(number)

    return branch, number

if __name__ == '__main__':
    main()


--=-mKmaWW3/RZ42cRimIrjV--
