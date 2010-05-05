From: Eli Barzilay <eli@barzilay.org>
Subject: [PATCH] An alias that starts with "!!" runs in the current directory.
Date: Wed, 5 May 2010 16:28:24 -0400
Message-ID: <19425.54504.163875.379151@winooski.ccs.neu.edu>
References: <1273019122.16093.6.camel@ubuntu.ubuntu-domain>
	<20100505005153.GC25390@coredump.intra.peff.net>
	<4BE115EF.8010306@viscovery.net>
	<20100505070131.GA11265@coredump.intra.peff.net>
	<19425.9169.537598.876589@winooski.ccs.neu.edu>
	<7v1vdql4c9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>,
	Jared Hance <jaredhance@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 05 22:28:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9lDC-00068P-6k
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 22:28:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758383Ab0EEU2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 May 2010 16:28:43 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:39137 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758369Ab0EEU2n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 16:28:43 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1O9lCi-0007NI-7B; Wed, 05 May 2010 16:28:24 -0400
In-Reply-To: <7v1vdql4c9.fsf@alter.siamese.dyndns.org>
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146415>

With "!"-prefixed shell aliases, the shell command not only gets
executed at the repository top level, but there is no way to know the
current directory of the original call.  This adds "!!"-prefixed aliases
as a similar variant for "!"-prefixed ones, but the commands are
executed in the original directory instead of the top level.

Signed-off-by: Eli Barzilay <eli@barzilay.org>
---

(Sending as a reply to the earlier message, keeping CCs.)

It looks like setup_git_directory_gently() returns the original CWD, but
since it's not documented or commented, I don't know if this is reliable
or not, so it might need to change.

Also, it might make more sense to document the "!!" variant first, since
it is generally more useful, but the way things evolved with "!!" being
the longer prefix, it seems to me that documenting it after "!" is more
sensible.

 Documentation/config.txt |    9 +++++++--
 git.c                    |    8 ++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

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
index 6bae305..f3f8346 100644
--- a/git.c
+++ b/git.c
@@ -167,6 +167,14 @@ static int handle_alias(int *argcp, const char ***argv)
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
 				     alias_command, alias_string + 1);
 			ret = system(alias_string + 1);
-- 
1.7.1
