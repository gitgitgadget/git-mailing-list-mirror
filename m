From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: gitpacker progress report and a question
Date: Thu, 15 Nov 2012 16:28:18 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121115212818.GA21558@thyrsus.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SUOF0GtieIMvvwua"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 15 22:29:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZ703-0006Zj-8g
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 22:29:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321Ab2KOV24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 16:28:56 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:58736
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438Ab2KOV2y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 16:28:54 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 072724065B; Thu, 15 Nov 2012 16:28:18 -0500 (EST)
Content-Disposition: inline
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209846>


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Some days ago I reported that I was attempting to write a tool that could
(a) take a git repo and unpack it into a tarball sequence plus a metadata log,
(b) reverse that operation, packing a tarball and log sequence into a repo.

Thanks in part to advice by Andreas Schwab and in part to looking at the
text of the p4 import script, this effort has succeeded.  A proof of
concept is enclosed.  It isn't documented yet, and has not been tested
on a repository with branches or merges in the history, but I am confident
that the distance from here to a finished and tested tool is short. 

The immediate intended use is for importing older projects that are
available only as sequences of release tarballs, but there are other
sorts of repository surgery that would become easier using it.

I'm still looking for a better name for it and would welcome suggestions.

Before I do much further work, I need to determine how this will be shipped.
I see two possibilities: either I ship it as a small standalone project,
or it becomes a git subcommand shipped with the git suite. How I document 
it and set up its tests would differ between these two cases.

Is there a process for submitting new subcommands?  What are the 
test-suite and documentation requirements?
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>

--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=gitpacker

#!/usr/bin/env python
"""
gitpacker - assemble tree sequences into repository histories

Requires git and cpio.
"""
import sys, os, getopt, subprocess, time, tempfile

DEBUG_GENERAL  = 1
DEBUG_PROGRESS = 2
DEBUG_COMMANDS = 3

class Fatal(Exception):
    "Unrecoverable error."
    def __init__(self, msg):
        Exception.__init__(self)
        self.msg = msg

class Baton:
    "Ship progress indications to stdout."
    def __init__(self, prompt, endmsg='done', enable=False):
        self.prompt = prompt
        self.endmsg = endmsg
        self.countfmt = None
        self.counter = 0
        if enable:
            self.stream = sys.stdout
        else:
            self.stream = None
        self.count = 0
        self.time = 0
    def __enter__(self):
        if self.stream:
            self.stream.write(self.prompt + "...")
            if os.isatty(self.stream.fileno()):
                self.stream.write(" \010")
            self.stream.flush()
        self.count = 0
        self.time = time.time()
        return self
    def startcounter(self, countfmt, initial=1):
        self.countfmt = countfmt
        self.counter = initial
    def bumpcounter(self):
        if self.stream is None:
            return
        if os.isatty(self.stream.fileno()):
            if self.countfmt:
                update = self.countfmt % self.counter
                self.stream.write(update + ("\010" * len(update)))
                self.stream.flush()
            else:
                self.twirl()
        self.counter = self.counter + 1
    def endcounter(self):
        if self.stream:
            w = len(self.countfmt % self.count)
            self.stream.write((" " * w) + ("\010" * w))
            self.stream.flush()
        self.countfmt = None
    def twirl(self, ch=None):
        "One twirl of the baton."
        if self.stream is None:
            return
        if os.isatty(self.stream.fileno()):
            if ch:
                self.stream.write(ch)
                self.stream.flush()
                return
            else:
                update = "-/|\\"[self.count % 4]
                self.stream.write(update + ("\010" * len(update)))
                self.stream.flush()
        self.count = self.count + 1
    def __exit__(self, extype, value_unused, traceback_unused):
        if extype == KeyboardInterrupt:
            self.endmsg = "interrupted"
        if extype == Fatal:
            self.endmsg = "aborted by error"
        if self.stream:
            self.stream.write("...(%2.2f sec) %s.\n" \
                              % (time.time() - self.time, self.endmsg))
        return False

def do_or_die(dcmd, legend=""):
    "Either execute a command or raise a fatal exception."
    if legend:
        legend = " "  + legend
    if verbose >= DEBUG_COMMANDS:
        sys.stdout.write("executing '%s'%s\n" % (dcmd, legend))
    try:
        retcode = subprocess.call(dcmd, shell=True)
        if retcode < 0:
            raise Fatal("child was terminated by signal %d." % -retcode)
        elif retcode != 0:
            raise Fatal("child returned %d." % retcode)
    except (OSError, IOError) as e:
        raise Fatal("execution of %s%s failed: %s" % (dcmd, legend, e))

def capture_or_die(dcmd, legend=""):
    "Either execute a command and capture its output or die."
    if legend:
        legend = " "  + legend
    if verbose >= DEBUG_COMMANDS:
        sys.stdout.write("executing '%s'%s\n" % (dcmd, legend))
    try:
        return subprocess.check_output(dcmd, shell=True)
    except subprocess.CalledProcessError as e:
        if e.returncode < 0:
            raise Fatal("child was terminated by signal %d." % -e.returncode)
        elif e.returncode != 0:
            sys.stderr.write("gitpacker: child returned %d." % e.returncode)
        sys.exit(1)
    
def git_pack(indir, outdir, quiet=False):
    "Pack a tree sequence and associated logfile into a repository"
    do_or_die("mkdir %s; git init -q %s" % (outdir, outdir))
    logfile = os.path.join(indir, "log")
    commit_id = [None]
    state = 0
    parents = []
    comment = committername = authorname = ""
    commitdate = authordate = commitemail = authoremail = ""
    commitcount = 1;
    linecount = 0
    with Baton("Packing", enable=not quiet) as baton:
        for line in open(logfile):
            if verbose > DEBUG_PROGRESS:
                print "Looking at: '%s'" % repr(line)
            if state == 0:
                if line == '\n':
                    state = 1
                else:
                    try:
                        space = line.index(' ')
                        leader = line[:space]
                        follower = line[space:].strip()
                        if leader == "commit":
                            commit = follower
                        elif leader == "parent":
                            parents.append(follower)
                        elif leader not in ("author", "committer"):
                            raise Fatal("unexpected log attribute at %s" \
                                        % repr(line))
                        elif leader == "committer":
                            (committername, committeremail, committerdate) = [x.strip() for x in follower.replace('>','<').split('<')]
                        elif leader == "author":
                            (authorname, authoremail, authordate) = [x.strip() for x in follower.replace('>','<').split('<')]
                    except ValueError:
                        raise Fatal('"%s", line %d: ill-formed log entry' % (logfile, linecount))
            elif state == 1:
                if line == ".\n":
                    if verbose > DEBUG_PROGRESS:
                        print "Interpretation begins"
                    os.chdir(outdir)
                    if commitcount > 1:
                        do_or_die("rm `git ls-tree --name-only HEAD`")
                    if verbose > DEBUG_PROGRESS:
                        print "Copying"
                    os.chdir("%s/%d" % (indir, commitcount))
                    do_or_die("find . -print | cpio -pd --quiet %s" % (outdir,))
                    os.chdir(outdir)
                    do_or_die("git add -A") 
                    tree_id = capture_or_die("git write-tree").strip()
                    if verbose > DEBUG_PROGRESS:
                        print "Tree ID is", tree_id
                    (_, commentfile) = tempfile.mkstemp()
                    with open(commentfile, "w") as cfp:
                        cfp.write(comment)
                    command = "git commit-tree %s " % tree_id
                    command += " ".join(map(lambda p: "-p " + commit_id[int(p)],parents))
                    command += "<'%s'" % commentfile
                    environment = ""
                    environment += " GIT_AUTHOR_NAME='%s' " % authorname
                    environment += " GIT_AUTHOR_EMAIL='%s' " % authoremail 
                    environment += " GIT_AUTHOR_DATE='%s' " % authordate 
                    environment += " GIT_COMMITTER_NAME='%s' " % committername
                    environment += " GIT_COMMITTER_EMAIL='%s' " % committeremail 
                    environment += " GIT_COMMITTER_DATE='%s' " % committerdate 
                    commit_id.append(capture_or_die(environment + command).strip())
                    do_or_die("git update-ref HEAD %s" % commit_id[-1])
                    os.remove(commentfile)
                    state = 0
                    parents = []
                    comment = committername = authorname = ""
                    committerdate = authordate = committeremail = authoremail = ""
                    commitcount += 1
                    baton.twirl()
                    if maxcommit != 0 and commitcount >= maxcommit:
                        break
                else:
                    if line.startswith("."):
                        line = line[1:]
                    comment += line

def git_unpack(indir, outdir, quiet=False):
    "Unpack a repository into a tree sequence and associated logfile."
    rawlogfile = os.path.join(outdir, "rawlog")
    with Baton("Unpacking", enable=not quiet) as baton:
        do_or_die("rm -fr %s; mkdir %s" % (outdir, outdir))
        baton.twirl()
        do_or_die("cd %s; git log --all --reverse --format=raw >%s" % (indir, rawlogfile))
        baton.twirl()
        commitcount = 1
        commit_map = {}
        os.chdir(indir)
        try:
            for line in open(rawlogfile):
                baton.twirl()
                if line.startswith("commit "):
                    commit = line.split()[1]
                    commit_map[commit] = commitcount
                    do_or_die("git checkout %s 2>/dev/null; mkdir %s/%d" \
                              % (commit, outdir, commitcount))
                    do_or_die("git ls-tree -r --name-only --full-tree %s | cpio -pd --quiet %s/%d"
                              % (commit, outdir, commitcount))
                    commitcount += 1

        finally:
            do_or_die("git reset --hard >/dev/null; git checkout master >/dev/null 2>&1")
        cooked = os.path.join(outdir, "log")
        body_latch = False
        try:
            with open(cooked, "w") as wfp:
                linecount = 0
                for line in open(rawlogfile):
                    linecount += 1
                    if line[0].isspace():
                        if line.startswith(" " * 4):
                            line = line[4:]
                            # Old-school byte stuffing.
                            if line.startswith("."):
                                line = "." + line
                    else:
                        space = line.index(' ')
                        leader = line[:space]
                        follower = line[space:].strip()
                        if leader == "tree":
                            continue
                        if leader == "commit" and linecount > 1:
                            wfp.write(".\n")
                        # FIXME: Check that log raw emits one parent per line
                        if leader in ("commit", "parent"):
                            line = "%s %s\n" % (leader, commit_map[follower])
                            body_latch = False
                        elif leader not in ("author", "committer"):
                            raise Fatal("unexpected log attribute at %s" \
                                        % repr(line))
                    if line == '\n':
                        if not body_latch:
                            body_latch = True
                        else:
                            continue
                    wfp.write(line)
                wfp.write(".\n")
        except (ValueError, IndexError, KeyError):
            raise Fatal("log rewrite failed on %s" % repr(line))
    os.remove(rawlogfile)

if __name__ == '__main__':
    (options, arguments) = getopt.getopt(sys.argv[1:], "ci:m:o:qxv")
    mode = 'auto'
    indir = '.'
    outdir = None
    quiet = False
    maxcommit = 0
    verbose = 0
    for (opt, val) in options:
        if opt == '-x':
            mode = 'unpack'
        elif opt == '-c':
            mode = 'pack'
        elif opt == '-m':
            indir = int(val)
        elif opt == '-i':
            indir = val
        elif opt == '-o':
            outdir = val
        elif opt == '-q':
            quiet = True
        elif opt == '-v':
            verbose += 1
    if not os.path.exists(indir):
        sys.stderr.write("gitpacker: input directory %s must exist.\n" % indir)
        sys.exit(1)
    if mode == 'auto':
        if os.path.exists(os.path.join(indir, ".git")):
            mode = 'unpack'
        else:
            mode = 'pack'
    assert mode == 'pack' or mode == 'unpack'
    if outdir is None:
        if mode == 'pack':
            outdir = indir + "/packed"
        elif mode == 'unpack':
            outdir = indir + "/unpacked"
    if os.path.exists(outdir):
        sys.stderr.write("gitpacker: output directory %s must not exist.\n" % outdir)
        sys.exit(1)
    indir = os.path.abspath(indir)
    outdir = os.path.abspath(outdir)
    if verbose >= DEBUG_PROGRESS:
        sys.stderr.write("gitpacker: %s from %s to %s.\n" % (mode, indir, outdir))
    try:
        try:
            here = os.getcwd()
            if mode == 'pack':
                git_pack(indir, outdir, quiet=quiet)
            elif mode == 'unpack':
                git_unpack(indir, outdir, quiet=quiet)
        finally:
            os.chdir(here)
    except Fatal, e:
        sys.stderr.write(e.msg + "\n")
        sys.exit(1)
    except KeyboardInterrupt:
        pass

# end


--SUOF0GtieIMvvwua--
