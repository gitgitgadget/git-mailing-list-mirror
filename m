From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/6] run-command: add "use shell" option
Date: Fri, 01 Jan 2010 23:12:36 +0100
Message-ID: <4B3E7354.209@kdbg.org>
References: <20091230095634.GA16349@coredump.intra.peff.net> <20091230105316.GA22959@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 01 23:17:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQpoJ-0000lJ-0j
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jan 2010 23:17:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828Ab0AAWRR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jan 2010 17:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751800Ab0AAWRR
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jan 2010 17:17:17 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:53099 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751502Ab0AAWRQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jan 2010 17:17:16 -0500
Received: from [77.117.209.219] (77.117.209.219.wireless.dyn.drei.com [77.117.209.219])
	by bsmtp.bon.at (Postfix) with ESMTP id A1888A7EB3;
	Fri,  1 Jan 2010 23:17:10 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20091230105316.GA22959@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136012>

Jeff King schrieb:
> Many callsites run "sh -c $CMD" to run $CMD. We can make it
> a little simpler for them by factoring out the munging of
> argv.
> 
> For simple cases with no arguments, this doesn't help much, but:
> 
>   1. For cases with arguments, we save the caller from
>      having to build the appropriate shell snippet.
> 
>   2. We can later optimize to avoid the shell when
>      there are no metacharacters in the program.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I made the matching tweak to the Windows half of run-command, but I
> don't actually have a box to test it on.
> 
> I modeled this after execv_git_cmd. Like that function, I try to release
> the allocated argv on error. However, we do actually leak the strbuf
> memory in one case. I'm not sure how much we care. On unix, this will
> always happen in a forked process which will either exec or die. On
> Windows, we seem to already be leaking the prepared argv for the git_cmd
> case (and now we leak the shell_cmd case, too).

That is OK. We can fix this when we find a work-load where this is
a problem.

But would you please squash this in to avoid a warning about an unused
static function on Windows.

---
  run-command.c |    2 ++
  1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/run-command.c b/run-command.c
index 22e2777..47ced57 100644
--- a/run-command.c
+++ b/run-command.c
@@ -48,6 +48,7 @@ static const char **prepare_shell_cmd(const char **argv)
  	return nargv;
  }

+#ifndef WIN32
  static int execv_shell_cmd(const char **argv)
  {
  	const char **nargv = prepare_shell_cmd(argv);
@@ -56,6 +57,7 @@ static int execv_shell_cmd(const char **argv)
  	free(nargv);
  	return -1;
  }
+#endif

  int start_command(struct child_process *cmd)
  {
-- 
1.6.6.1073.gd853b.dirty
