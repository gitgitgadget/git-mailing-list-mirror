From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: What's cooking in git.git (Mar 2009, #06; Sat, 21)
Date: Sat, 21 Mar 2009 23:21:18 +0100
Message-ID: <200903212321.18283.j6t@kdbg.org>
References: <7vk56jfgt2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 21 23:22:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll9ae-0000wH-Au
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 23:22:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755185AbZCUWVX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Mar 2009 18:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753738AbZCUWVW
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 18:21:22 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:41516 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752581AbZCUWVW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 18:21:22 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 13A872C400D;
	Sat, 21 Mar 2009 23:21:18 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 63B0E4000D;
	Sat, 21 Mar 2009 23:21:18 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <7vk56jfgt2.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114084>

On Samstag, 21. M=E4rz 2009, Junio C Hamano wrote:
> * js/maint-1.6.0-exec-path-env (Wed Mar 18 08:42:53 2009 +0100) 1 com=
mit
>  - export GIT_EXEC_PATH when git is run with --exec-path

Here is the patch again with a commit message that explains what's goin=
g on.

But notice that this is probably not a complete solution: As you can se=
e
(below) from the analysis, a git-repack that was taken from $prefix wou=
ld
invoke a git that is not from $prefix, but from the initial command's
--exec-path. I think this can be solved by installing the git executabl=
e
in $prefix/libexec/git-core as well.

-- Hannes

-- 8< --
Subject: [PATCH] Propagate --exec-path setting to external commands via=
 GIT_EXEC_PATH

Let PATH0=3D$PATH that was set before the invocation.
Let /foo be a build directory.
Let /pfx be the installation prefix.
Let pfxexecpath=3D/pfx/libexec/git-core.

The following is going on when 'git --exec-path=3D/foo gc' is invoked:

1. git sets PATH=3D/foo:$PATH0 using the path from --exec-path

2. gc execs 'git repack' (note: no dash).

3. Since there is a git in /foo (it's a build directory), /foo/git is
   taken.

4. No explicit exec-path is set this time, hence, this secondary git se=
ts
   PATH=3D$pfxexecpath:/foo:$PATH

5. Since 'repack' is not a built-in, execv_dashed_external execs
   'git-repack' (note: dash).

6. There is a $pfxexecpath/git-repack, and it is taken.

7. This git-repack runs 'git pack-objects' (note: no dash).

8. There is no git in $pfxexecpath, but there is one in /foo. Hence,
   /foo/git is run.

9. pack-objects is a builtin, hence, in effect /foo/git-pack-objects
   is run.

As you can see, the way in which we previously set the PATH allowed to
mix gits of different vintage.  By setting GIT_EXEC_PATH when --exec-pa=
th
was given on the command line, we reduce the confusion.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 exec_cmd.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index 217c125..408e4e5 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -61,6 +61,10 @@ const char *git_extract_argv0_path(const char *argv0=
)
 void git_set_argv_exec_path(const char *exec_path)
 {
 	argv_exec_path =3D exec_path;
+	/*
+	 * Propagate this setting to external programs.
+	 */
+	setenv(EXEC_PATH_ENVIRONMENT, exec_path, 1);
 }
=20
=20
--=20
1.6.2.1.224.g2225f
