From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] Don't ignore write failure from git-diff, git-log, etc.
Date: Mon, 28 May 2007 15:14:07 +0200
Message-ID: <87sl9hw0o0.fsf@rho.meyering.net>
References: <87bqg724gp.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0705260910220.26602@woody.linux-foundation.org>
	<87odk6y6cd.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0705270904240.26602@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon May 28 15:14:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hsf3F-0000kB-Mt
	for gcvg-git@gmane.org; Mon, 28 May 2007 15:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbXE1NOL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 09:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751662AbXE1NOK
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 09:14:10 -0400
Received: from mx.meyering.net ([82.230.74.64]:50882 "EHLO mx.meyering.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751362AbXE1NOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2007 09:14:09 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id CE8852CAB7; Mon, 28 May 2007 15:14:07 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.98.0705270904240.26602@woody.linux-foundation.org> (Linus Torvalds's message of "Sun\, 27 May 2007 09\:17\:58 -0700 \(PDT\)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48617>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Sun, 27 May 2007, Jim Meyering wrote:
>>
>> I have to disagree.  There may be precedent for hiding EPIPE errors,
>> but that is not the norm among command line tools wrt piped stdout.
>
> .. and this is a PROBLEM. Which is why I think your patch was really
> wrong.
>
> I don't know how many people remember all the _stupid_ problems we had
> exactly because many versions of bash are crap, crap, crap, and people
> (including you) don't realize that EPIPE is _different_ from other write
> errors.
>
> Just do a google search for
>
> 	"broken pipe" bash
>
> and not only will you see a lot of complaints, but the #5 entry is a
> complaint for a git issue that we had tons of problems with. See for
> example
>
> 	http://www.gelato.unsw.edu.au/archives/git/0504/2602.html

Whether bash should print a diagnostic when it kills a process with
SIGPIPE is _different_ from whether the writing process should diagnose
its own write failure arising from a handled SIGPIPE.

I suspect that git's special treatment of EPIPE was a shoot-the-messenger
reaction to the work-around (trap '' PIPE) required to avoid diagnostics
from porcelain being interpreted by what would now be a 2-year-old
version of bash.  It is time to remove that work-around, because it
can obscure real errors, and removing it will be largely unnoticed.

...
>> Do you really want git-log to continue to do this?
>>
>>     $ (trap '' PIPE; git-log; echo $? >&2 ) | :
>>     0
>>
>> With my patch, it does this:
>>
>>     $ (trap '' PIPE; ./git-log; echo $? >&2 ) | :
>>     fatal: write failure on standard output: Broken pipe
>>     128
>
> That error return is fine.  The annoying error report, however, is NOT.

That error message serves to indicate a REAL FLAW, some of the time.
In such cases, the diagnostic is likely to be welcome, not annoying.
Which is more important: avoiding annoyance in some now-very-unusual
circumstances, or allowing robust porcelain to diagnose real errors?

> And your arguments that "others do it wrong, so we can too" is so broken
> as to be really really sad. If you cannot see the serious problem with
> that argument, I don't know what to tell you.

Questionable debate tactic: misrepresent an opponent's argument with a
statement that is obviously foolish, then proceed to argue that anyone
who doesn't recognise the silliness of the restated argument leaves
you speechless.

My argument is "If so many other tools do it RIGHT,
why can't git do it right, too?".

> Try this:
>
> 	trap '' PIPE; ./git-log | head
>
> and dammit, if you get an error message from that, your program is BROKEN.
>
> And if you cannot understand that, then I don't even know what to say.

Of course error messages are annoying when your short-pipe-read is
_deliberate_ (tho, most real uses of git tools will actually get no
message to be annoyed about[*]), but what if there really *is* a mistake?
Try this:

    # You want to force git to ignore the error.
    $ trap '' PIPE; git-rev-list HEAD | sync
    $

    # I want to diagnose the error (the exit 128 is from zsh, bash gets 0):
    $ trap '' PIPE; git-rev-list HEAD | sync
    fatal: write failure on standard output: Broken pipe
    [Exit 128]

The use of "sync" above is obviously a mistake.
With the existing git tools, most write-to-stdout errors are ignored,
including EPIPE, so this erroneous command completes successfully, just as
it would when writing to a full or corrupt disk.  Even if you use bash's
"set -o pipefail" option, there is no indication of the failure.  With my
patch, write errors are reported, even EPIPE, so that in this case, the
user of the above will get an error message.  And with bash's pipefail
option, the git-rev-list write failure can propagate "out" to the script.

Since using "sync" is contrived, for a little more realism, imagine the
SHA1 strings are being written to a FIFO, and you don't have access to
the program running on the other side.  The sender should have a way to
detect when the other end closes the pipe prematurely.  Exempting EPIPE,
it CANNOT detect failure:

    $ mkfifo F && head -1 F > /dev/null & sleep 1
    $ trap '' PIPE; git-rev-list HEAD > F && echo bad: ignored write failure
    bad: ignored write failure

Handling EPIPE like other write errors, it CAN detect failure:

    $ mkfifo F && head -1 F > /dev/null & sleep 1
    $ trap '' PIPE; ./git-rev-list HEAD > F || echo ok
    fatal: write failure on standard output: Broken pipe
    ok

> But _exiting_ is fine. It's the bogus error reporting that isn't. The
> above command like should NOT cause the user to have to skip stderr -
> because no error happened!

Don't worry about the diagnostic.  It probably won't show up much at all
[*] these days, since most shells now let SIGPIPE kill the writer (silently).
And if the message does appear once in a while, there are cleaner ways
to suppress it than hamstringing all of the git plumbing for everyone.

In fact, in this vein, the existing EPIPE exceptions in write_or_die.c
and merge-recursive.c should be removed.  Here's a revised patch to do
that, too.  Junio, if you see fit to accept any part of this, I'll be
happy to write test case additions demonstrating before/after improvements.

========================================================================
Subject: [PATCH] Don't ignore write failure from git-diff, git-log, etc.

Currently, when git-diff writes to a full device or gets an I/O error,
it fails to detect the write error:

    $ git-diff |wc -c
    3984
    $ git-diff > /dev/full && echo ignored write failure
    ignored write failure

git-log does the same thing:

    $ git-log -n1 > /dev/full && echo ignored write failure
    ignored write failure

Each and every git command should report such a failure.
Some already do, but with the patch below, they all do, and we
won't have to rely on code in each command's implementation to
perform the right incantation.

    $ ./git-log -n1 > /dev/full
    fatal: write failure on standard output: No space left on device
    [Exit 128]
    $ ./git-diff > /dev/full
    fatal: write failure on standard output: No space left on device
    [Exit 128]

You can demonstrate this with git's own --version output, too:
(but git --help detects the failure without this patch)

    $ ./git --version > /dev/full
    fatal: write failure on standard output: No space left on device
    [Exit 128]

Note that the fcntl test (for whether the fileno may be closed) is
required in order to avoid EBADF upon closing an already-closed stdout,
as would happen for each git command that already closes stdout; I think
update-index was the one I noticed in the failure of t5400, before I
added that test.

Also, to be consistent, don't ignore EPIPE write failures.

Signed-off-by: Jim Meyering <jim@meyering.net>
---
 git.c             |   11 ++++++++++-
 merge-recursive.c |    3 ---
 write_or_die.c    |    4 ----
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/git.c b/git.c
index 29b55a1..e176ab4 100644
--- a/git.c
+++ b/git.c
@@ -308,6 +308,7 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 	for (i = 0; i < ARRAY_SIZE(commands); i++) {
 		struct cmd_struct *p = commands+i;
 		const char *prefix;
+		int status;
 		if (strcmp(p->cmd, cmd))
 			continue;

@@ -321,7 +322,15 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 			die("%s must be run in a work tree", cmd);
 		trace_argv_printf(argv, argc, "trace: built-in: git");

-		exit(p->fn(argc, argv, prefix));
+		status = p->fn(argc, argv, prefix);
+
+		/* Close stdout if necessary, and diagnose any failure.  */
+		if (fcntl(fileno (stdout), F_GETFD) >= 0)
+		    && (ferror(stdout) || fclose(stdout)))
+			die("write failure on standard output: %s",
+			    strerror(errno));
+
+		exit(status);
 	}
 }

diff --git a/merge-recursive.c b/merge-recursive.c
index 8f72b2c..bfa4335 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -523,9 +523,6 @@ static void flush_buffer(int fd, const char *buf, unsigned long size)
 	while (size > 0) {
 		long ret = write_in_full(fd, buf, size);
 		if (ret < 0) {
-			/* Ignore epipe */
-			if (errno == EPIPE)
-				break;
 			die("merge-recursive: %s", strerror(errno));
 		} else if (!ret) {
 			die("merge-recursive: disk full?");
diff --git a/write_or_die.c b/write_or_die.c
index 5c4bc85..fadfcaa 100644
--- a/write_or_die.c
+++ b/write_or_die.c
@@ -41,8 +41,6 @@ int write_in_full(int fd, const void *buf, size_t count)
 void write_or_die(int fd, const void *buf, size_t count)
 {
 	if (write_in_full(fd, buf, count) < 0) {
-		if (errno == EPIPE)
-			exit(0);
 		die("write error (%s)", strerror(errno));
 	}
 }
@@ -50,8 +48,6 @@ void write_or_die(int fd, const void *buf, size_t count)
 int write_or_whine_pipe(int fd, const void *buf, size_t count, const char *msg)
 {
 	if (write_in_full(fd, buf, count) < 0) {
-		if (errno == EPIPE)
-			exit(0);
 		fprintf(stderr, "%s: write error (%s)\n",
 			msg, strerror(errno));
 		return 0;
