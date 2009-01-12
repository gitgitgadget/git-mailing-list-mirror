From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Funny: git -p submodule summary
Date: Mon, 12 Jan 2009 11:59:04 +0100
Message-ID: <496B2278.9050905@viscovery.net>
References: <alpine.DEB.1.00.0901081601240.30769@pacific.mpi-cbg.de> <20090109083836.GB21389@coredump.intra.peff.net> <20090109092250.GA1809@coredump.intra.peff.net> <49672244.80200@viscovery.net> <20090109101335.GA4346@coredump.intra.peff.net> <496728B9.7090200@viscovery.net> <20090111112222.GA29656@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 12 12:00:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMKXG-0006Kp-Qu
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 12:00:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089AbZALK7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 05:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752031AbZALK7W
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 05:59:22 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:31934 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944AbZALK7V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 05:59:21 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LMKVi-0002rw-Lm; Mon, 12 Jan 2009 11:59:12 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id D5A6869F; Mon, 12 Jan 2009 11:59:05 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <20090111112222.GA29656@coredump.intra.peff.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105323>

From: Johannes Sixt <j6t@kdbg.org>

Jeff King schrieb:
> On Fri, Jan 09, 2009 at 11:36:41AM +0100, Johannes Sixt wrote:
> 
>> I'll test your other patch (that replaces the execvp in git.c by
>> run_command).
> 
> There is something funny with it that I have not diagnosed: aliases are
> broken, and "git foobar" does not return an error. Presumably just
> checking the "we did not exec succesfully" case is not triggering
> properly.  However, I think the right solution is actually to refactor
> git.c to figure out ahead of time whether we have a builtin, external,
> or alias. I can work on that, but not tonight, as my git-time is up for
> now.
> 
> But other than that, did it work for you on Windows?

It passed the test suite. This should already work better on Windows,
because we already *do* look-up the program, and exit from
mingw_spawnvpe() before the equivalent of fork+exec happens.

> However, here is a 4-patch series that handles the separate signal
> delivery problem. It should fix the "^C makes funny things happen"
> problems you were seeing. Please test and let me know how it works on
> Windows.

It does help a bit. The interesting thing is that the only case where I
can now reproduces the unwanted behavior with the unpatched version is
when all output was completely read by 'less' and git already waits in
wait_for_pager(), such as in 'git show'. But Ctrl-C'ing a 'git log -p'
works as expected even without these patches. With the patches, the 'git
show' case now works as well.

> The patches are:
>   1/4: Makefile: clean up TEST_PROGRAMS definition
>   2/4: chain kill signals for cleanup functions
>   3/4: refactor signal handling for cleanup functions
>   4/4: pager: do wait_for_pager on signal death

But we need to insert the patch below *before* 2/4. The test case needs a
change, too,(exit code on Windows is 3, not 130) but I'll keep that in my
repository, like with all other Windows related test suite changes.

-- Hannes

-- 8< --
From: Johannes Sixt <j6t@kdbg.org>
Subject: Windows: Fix signal numbers

We had defined some SIG_FOO macros that appear in the code, but that are
not supported on Windows, in order to make the code compile.  But a
subsequent change will assert that a signal number is non-zero.  We now
use the signal numbers that are commonly used on POSIX systems.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 compat/mingw.h |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 4f275cb..a255898 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -21,12 +21,12 @@ typedef int pid_t;
 #define WEXITSTATUS(x) ((x) & 0xff)
 #define WIFSIGNALED(x) ((unsigned)(x) > 259)

-#define SIGKILL 0
-#define SIGCHLD 0
-#define SIGPIPE 0
-#define SIGHUP 0
-#define SIGQUIT 0
-#define SIGALRM 100
+#define SIGHUP 1
+#define SIGQUIT 3
+#define SIGKILL 9
+#define SIGPIPE 13
+#define SIGALRM 14
+#define SIGCHLD 17

 #define F_GETFD 1
 #define F_SETFD 2
-- 
1.6.1.rc4.959.gcece.dirty
