From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH/RFCv1] git-p4: handle files with shell metacharacters
Date: Mon, 26 Sep 2011 17:47:58 -0400
Message-ID: <20110926214758.GB3433@arf.padd.com>
References: <1317072555-23438-1-git-send-email-luke@diamand.org>
 <1317072555-23438-2-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, vitor.hda@gmail.com
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Mon Sep 26 23:48:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8J26-0004qG-QD
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 23:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752517Ab1IZVsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 17:48:09 -0400
Received: from honk.padd.com ([74.3.171.149]:49593 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751514Ab1IZVsI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 17:48:08 -0400
Received: from arf.padd.com (unknown [50.55.131.180])
	by honk.padd.com (Postfix) with ESMTPSA id 9AFFFF4;
	Mon, 26 Sep 2011 14:48:06 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id B66A8313B4; Mon, 26 Sep 2011 17:47:58 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1317072555-23438-2-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182171>

luke@diamand.org wrote on Mon, 26 Sep 2011 22:29 +0100:
> git-p4 used to simply pass strings into system() and popen(), and
> relied on the shell doing the necessary expansion. This though meant
> that shell metacharacters in file names would be corrupted - for
> example files with $ or space in them.
> 
> Switch to using subprocess.Popen() and friends, and pass in explicit
> arrays in the places where it matters. This then avoids needing shell
> expansion.
> 
> Add trivial helper functions for some common perforce operations. Add
> test case.

This is great.  Some code comments below.  Could you resend an
RFCv2?  I'll fixup your test case along with mine later, and send
you the patch just for that.

		-- Pete

> Signed-off-by: Luke Diamand <luke@diamand.org>
> ---
>  contrib/fast-import/git-p4     |  174 +++++++++++++++++++++++++---------------
>  t/t9800-git-p4.sh              |    2 +-
>  t/t9803-git-shell-metachars.sh |   70 ++++++++++++++++
>  3 files changed, 179 insertions(+), 67 deletions(-)
>  create mode 100755 t/t9803-git-shell-metachars.sh
> 
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index 782b891..be67d30 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -14,7 +14,6 @@ import re
>  
>  verbose = False
>  
> -
>  def p4_build_cmd(cmd):
>      """Build a suitable p4 command line.
>  
> @@ -22,36 +21,40 @@ def p4_build_cmd(cmd):
>      location. It means that hooking into the environment, or other configuration
>      can be done more easily.
>      """
> -    real_cmd = "%s " % "p4"
> +    real_cmd = ["p4"]
>  
>      user = gitConfig("git-p4.user")
>      if len(user) > 0:
> -        real_cmd += "-u %s " % user
> +        real_cmd += ["-u",user]
>  
>      password = gitConfig("git-p4.password")
>      if len(password) > 0:
> -        real_cmd += "-P %s " % password
> +        real_cmd += ["-P", password]
>  
>      port = gitConfig("git-p4.port")
>      if len(port) > 0:
> -        real_cmd += "-p %s " % port
> +        real_cmd += ["-p", port]
>  
>      host = gitConfig("git-p4.host")
>      if len(host) > 0:
> -        real_cmd += "-h %s " % host
> +        real_cmd += ["-h", host]
>  
>      client = gitConfig("git-p4.client")
>      if len(client) > 0:
> -        real_cmd += "-c %s " % client
> +        real_cmd += ["-c", client]
> +
>  
> -    real_cmd += "%s" % (cmd)
> +    if isinstance(cmd,basestring):
> +        real_cmd = ' '.join(real_cmd) + ' ' + cmd
> +    else:
> +        real_cmd += cmd
>      if verbose:
> -        print real_cmd
> +        print ' '.join(real_cmd)
>      return real_cmd

Okay, so it returns a string if given a string, only.  Would be
nice if we could kill off the string usages eventually?

The verbose print ' '.join(real_cmd) will look quite funny if
it real_cmd is a string.

>  def chdir(dir):
> -    if os.name == 'nt':
> -        os.environ['PWD']=dir
> +    # P4 uses the PWD environment variable rather than getcwd(), it would appear!
> +    os.environ['PWD']=dir
>      os.chdir(dir)

Interesting.  Separate unrelated fix?  Both "nt" and other OSes?

>  def die(msg):
> @@ -65,9 +68,12 @@ def write_pipe(c, str):
>      if verbose:
>          sys.stderr.write('Writing pipe: %s\n' % c)

Needs str(c) like in read_pipe()?

> -    pipe = os.popen(c, 'w')
> +    p = subprocess.Popen(c, shell=isinstance(c,basestring),
> +            stdin=subprocess.PIPE)
> +    pipe = p.stdin
>      val = pipe.write(str)
> -    if pipe.close():
> +    pipe.close();

Stray semicolon.

> +    if p.wait():
>          die('Command failed: %s' % c)
>      return val
> @@ -78,11 +84,13 @@ def p4_write_pipe(c, str):
>  
>  def read_pipe(c, ignore_error=False):
>      if verbose:
> -        sys.stderr.write('Reading pipe: %s\n' % c)
> +        sys.stderr.write('Reading pipe: %s\n' % str(c))
>  
> -    pipe = os.popen(c, 'rb')
> +    expand = isinstance(c,basestring)
> +    p = subprocess.Popen(c, stdout=subprocess.PIPE, shell=expand)
> +    pipe = p.stdout
>      val = pipe.read()
> -    if pipe.close() and not ignore_error:
> +    if p.wait() and not ignore_error:
>          die('Command failed: %s' % c)

Can this be made more symmetric with read_pipe()? "expand",
order of args.

>      return val
> @@ -93,11 +101,13 @@ def p4_read_pipe(c, ignore_error=False):
>  
>  def read_pipe_lines(c):
>      if verbose:
> -        sys.stderr.write('Reading pipe: %s\n' % c)
> -    ## todo: check return status
> -    pipe = os.popen(c, 'rb')
> +        sys.stderr.write('Reading pipe: %s\n' % str(c))
> +
> +    expand = isinstance(c, basestring)
> +    p = subprocess.Popen(c, shell=expand, stdout=subprocess.PIPE)
> +    pipe = p.stdout
>      val = pipe.readlines()
> -    if pipe.close():
> +    if pipe.close() or p.wait():
>          die('Command failed: %s' % c)
>  
>      return val
> @@ -108,15 +118,37 @@ def p4_read_pipe_lines(c):
>      return read_pipe_lines(real_cmd)
>  
>  def system(cmd):
> +    expand = isinstance(cmd,basestring)
>      if verbose:
> -        sys.stderr.write("executing %s\n" % cmd)
> -    if os.system(cmd) != 0:
> -        die("command failed: %s" % cmd)
> +        sys.stderr.write("executing %s\n" % str(cmd))
> +    subprocess.check_call(cmd, shell=expand)
>  
>  def p4_system(cmd):
>      """Specifically invoke p4 as the system command. """
>      real_cmd = p4_build_cmd(cmd)
> -    return system(real_cmd)
> +    expand = isinstance(real_cmd, basestring)
> +    subprocess.check_call(real_cmd, shell=expand)
> +
> +def p4_integrate(src, dest):
> +    p4_system(["integrate", "-Dt", src, dest])
> +
> +def p4_sync(path):
> +    p4_system(["sync", path])
> +
> +def p4_add(f):
> +    p4_system(["add", f])
> +
> +def p4_delete(f):
> +    p4_system(["delete", f])
> +
> +def p4_edit(f):
> +    p4_system(["edit", f])
> +
> +def p4_revert(f):
> +    p4_system(["revert", f])
> +
> +def p4_reopen(type, file):
> +    p4_system(["reopen", "-t", type, file])

These look cleaner.  We almost need a class for this
p4 interface stuff.  Maybe a job for a later refactoring.

> @@ -1365,9 +1408,9 @@ class P4Sync(Command, P4UserMap):
>              def streamP4FilesCbSelf(entry):
>                  self.streamP4FilesCb(entry)
>  
> -            p4CmdList("-x - print",
> -                '\n'.join(['%s#%s' % (f['path'], f['rev'])
> -                                                  for f in filesToRead]),
> +            fileArgs = ['%s#%s' % (f['path'], f['rev']) for f in filesToRead]
> +
> +            p4CmdList(["print"] + fileArgs,
>                  cb=streamP4FilesCbSelf)

I think this used "-x -" because when there are too many
fileArgs, the kernel command line couldn't hold them all.  So
this trick feeds them on stdin instead.

> @@ -1429,7 +1472,7 @@ class P4Sync(Command, P4UserMap):
>              if self.verbose:
>                  print "Change %s is labelled %s" % (change, labelDetails)
>  
> -            files = p4CmdList("files " + ' '.join (["%s...@%s" % (p, change)
> +            files = p4CmdList(["files"] + (["%s...@%s" % (p, change)
>                                                      for p in branchPrefixes]))

Spurious parens around the list comprehension; confusing.

> @@ -1478,9 +1521,9 @@ class P4Sync(Command, P4UserMap):
>              newestChange = 0
>              if self.verbose:
>                  print "Querying files for label %s" % label
> -            for file in p4CmdList("files "
> -                                  +  ' '.join (["%s...@%s" % (p, label)
> -                                                for p in self.depotPaths])):
> +            for file in p4CmdList(["files"] +
> +                                      (["%s...@%s" % (p, label)
> +                                          for p in self.depotPaths])):

Here too.

> diff --git a/t/t9800-git-p4.sh b/t/t9800-git-p4.sh
> index bb89b63..12f374f 100755
> --- a/t/t9800-git-p4.sh
> +++ b/t/t9800-git-p4.sh
> @@ -150,7 +150,7 @@ test_expect_success 'preserve users' '
>  	git commit --author "Alice <alice@localhost>" -m "a change by alice" file1 &&
>  	git commit --author "Bob <bob@localhost>" -m "a change by bob" file2 &&
>  	git config git-p4.skipSubmitEditCheck true &&
> -	P4EDITOR=touch P4USER=alice P4PASSWD=secret "$GITP4" commit --preserve-user &&
> +	P4EDITOR=touch P4USER=alice P4PASSWD=secret "$GITP4" commit --verbose --preserve-user &&
>  	p4_check_commit_author file1 alice &&
>  	p4_check_commit_author file2 bob
>  '

Debugging change?

> diff --git a/t/t9803-git-shell-metachars.sh b/t/t9803-git-shell-metachars.sh
> new file mode 100755
> index 0000000..1143491
> --- /dev/null
> +++ b/t/t9803-git-shell-metachars.sh
> @@ -0,0 +1,70 @@
> +#!/bin/sh
> +
> +test_description='git-p4 transparency to shell metachars in filenames'
> +
> +. ./lib-git-p4.sh
> +
> +test_expect_success 'start p4d' '
> +	kill_p4d || : &&
> +	start_p4d &&
> +	cd "$TRASH_DIRECTORY"
> +'

Excellent, a test case.  I'm still waiting 1.7.7 to resubmit my
series, but part of it includes fixing the test cases.  I'll mail
a separate patch that does similar transformations to this.
Easier just to do it all at once.

> +test_expect_success 'init depot' '
> +	(
> +		cd "$cli" &&
> +		echo file1 >file1 &&
> +		p4 add file1 &&
> +		p4 submit -d "file1"
> +	)
> +'
> +
> +test_expect_success 'shell metachars in filenames' '
> +	"$GITP4" clone --dest="$git" //depot &&
> +	test_when_finished cleanup_git &&
> +	(
> +		cd "$git" &&
> +		git config git-p4.skipSubmitEditCheck true &&
> +		echo f1 >foo\$bar &&
> +		git add foo\$bar &&
> +		echo f2 >"file with spaces" &&
> +		git add "file with spaces" &&
> +		P4EDITOR=touch git commit -m "add files" &&
> +		"$GITP4" submit --verbose &&
> +		cd "$cli" &&
> +		p4 sync ... &&
> +		ls -l "file with spaces" &&
> +		ls -l "foo\$bar"
> +	)
> +'
> +
> +check_missing() {
> +	for i in $*; do
> +		if [ -f $i ]; then
> +			echo $i found but should be missing 1>&2
> +			exit 1
> +		fi
> +	done
> +}
> +
> +test_expect_success 'deleting with shell metachars' '
> +	"$GITP4" clone --dest="$git" //depot &&
> +	test_when_finished cleanup_git &&
> +	(
> +		cd "$git" &&
> +		git config git-p4.skipSubmitEditCheck true &&
> +		git rm foo\$bar &&
> +		git rm file\ with\ spaces &&
> +		P4EDITOR=touch git commit -m "remove files" &&
> +		"$GITP4" submit --verbose
> +		cd "$cli" &&
> +		p4 sync ... &&
> +		check_missing "file with spaces" foo\$bar
> +	)
> +'
> +
> +test_expect_success 'kill p4d' '
> +	kill_p4d
> +'
> +
> +test_done
> -- 
> 1.7.6.347.g4db0d
> 
