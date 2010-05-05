From: Eli Barzilay <eli@barzilay.org>
Subject: [PATCH v2] An alias that starts with "!!" runs in the current directory.
Date: Wed, 5 May 2010 17:31:30 -0400
Message-ID: <19425.58290.42871.986460@winooski.ccs.neu.edu>
References: <1273019122.16093.6.camel@ubuntu.ubuntu-domain>
	<20100505005153.GC25390@coredump.intra.peff.net>
	<4BE115EF.8010306@viscovery.net>
	<20100505070131.GA11265@coredump.intra.peff.net>
	<19425.9169.537598.876589@winooski.ccs.neu.edu>
	<7v1vdql4c9.fsf@alter.siamese.dyndns.org>
	<19425.54504.163875.379151@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jared Hance <jaredhance@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 05 23:33:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9mDB-0003S7-MX
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 23:32:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758655Ab0EEVcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 May 2010 17:32:00 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:51095 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758706Ab0EEVbs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 17:31:48 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1O9mBm-00086m-1j; Wed, 05 May 2010 17:31:30 -0400
In-Reply-To: <19425.54504.163875.379151@winooski.ccs.neu.edu>
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146423>

With "!"-prefixed shell aliases, the shell command not only gets
executed at the repository top level, but there is no way to know the
current directory of the original call.  This adds "!!"-prefixed aliases
as a similar variant for "!"-prefixed ones, but the commands are
executed in the original directory instead of the top level.

Signed-off-by: Eli Barzilay <eli@barzilay.org>
---

It looks like setup_git_directory_gently() returns the original CWD, but
since it's not documented or commented, I don't know if this is reliable
or not, so it might need to change.

Also, it might make more sense to document the "!!" variant first, since
it is generally more useful, but the way things evolved with "!!" being
the longer prefix, it seems to me that documenting it after "!" is more
sensible.

This fixes the broken use of alias_command that Jared Hance caught.

 Documentation/config.txt |    9 +++++++--
 git.c                    |   14 +++++++++++---
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 92f851e..055f4e3 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -549,13 +549,18 @@ alias.*::
 	spaces, the usual shell quoting and escaping is supported.
 	quote pair and a backslash can be used to quote them.
 +
-If the alias expansion is prefixed with an exclamation point,
+If the alias expansion is prefixed with a single exclamation point,
 it will be treated as a shell command.  For example, defining
 "alias.new = !gitk --all --not ORIG_HEAD", the invocation
 "git new" is equivalent to running the shell command
-"gitk --all --not ORIG_HEAD".  Note that shell commands will be
+"gitk --all --not ORIG_HEAD".  Note that such shell commands will be
 executed from the top-level directory of a repository, which may
 not necessarily be the current directory.
++
+If the alias expansion is prefixed with two exclamation points,
+it will be treader similarly to the above, except that the shell commands
+are executed at the current directory.
+
 
 am.keepcr::
 	If true, git-am will call git-mailsplit for patches in mbox format
diff --git a/git.c b/git.c
index 6bae305..3d8ed20 100644
--- a/git.c
+++ b/git.c
@@ -167,14 +167,22 @@ static int handle_alias(int *argcp, const char ***argv)
 				free(alias_string);
 				alias_string = buf.buf;
 			}
+			/* going to exit anyway, so it's fine to change
+			 * alias_string to the actual command */
+			alias_string += 1;
+			if (alias_string[0] == '!') {
+				alias_string += 1;
+				if (subdir && chdir(subdir))
+					die_errno("Cannot change to '%s'", subdir);
+			}
 			trace_printf("trace: alias to shell cmd: %s => %s\n",
-				     alias_command, alias_string + 1);
-			ret = system(alias_string + 1);
+				     alias_command, alias_string);
+			ret = system(alias_string);
 			if (ret >= 0 && WIFEXITED(ret) &&
 			    WEXITSTATUS(ret) != 127)
 				exit(WEXITSTATUS(ret));
 			die("Failed to run '%s' when expanding alias '%s'",
-			    alias_string + 1, alias_command);
+			    alias_string, alias_command);
 		}
 		count = split_cmdline(alias_string, &new_argv);
 		if (count < 0)
-- 
1.7.1
