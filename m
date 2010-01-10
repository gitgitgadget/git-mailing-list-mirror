From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 0/4] Detect exec errors in start_command early
Date: Sun, 10 Jan 2010 14:04:21 +0100
Message-ID: <201001101404.22258.j6t@kdbg.org>
References: <1263044757-12560-1-git-send-email-ilari.liusvaara@elisanet.fi> <1263044757-12560-2-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Sun Jan 10 14:05:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTxTu-0007GY-Ml
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 14:05:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752774Ab0AJNFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2010 08:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752738Ab0AJNFR
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jan 2010 08:05:17 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:21049 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751203Ab0AJNFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2010 08:05:16 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 4E4F9A7EB7;
	Sun, 10 Jan 2010 14:05:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 7B9E219F610;
	Sun, 10 Jan 2010 14:04:22 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <1263044757-12560-2-git-send-email-ilari.liusvaara@elisanet.fi>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136576>

On Samstag, 9. Januar 2010, Ilari Liusvaara wrote:
>  6 files changed, 282 insertions(+), 13 deletions(-)

IMHO, you are going completely overboard with your patch.

You check every single possible and unlikely error condition in the new code 
that you introde, but ignore that there are quite a number of calls in the 
existing code whose error conditions go checked.

And as a result, you "only" report errno values of some calls, and ignore that 
there is at least one potential die() call hidden in execv_git_cmd(). IOW, 
your code is not a catch-all and only an isolated solution.

I hope I can do better.

I developed this series on top of il/vcs-helper. But patches 1-3/4 are 
actually an independent topic and also suitable to be merged into 
jk/run-command-use-shell to implement improved DWIM whether a shell is 
needed.

Patch 4/4 is to address your problem of weak error reporting with transport 
helpers. I think I understand now what your problem is -- namely that 
previously no error was reported if a transport helper program did not exist. 
The reason for the missing error message is IMO a design weakness in the 
protocol: It requires that the parent talks first - and by talking to an 
early-died child process it dies from SIGPIPE. I experimented with 
signal(SIGPIPE, SIG_IGN) to get around this, but it didn't work (the SIGPIPE 
arrived anyway).

Anyway, patch 4/4 goes on top of il/vcs-helper after merging the topic 
consisting of 1-3/4.

Ilari Liusvaara (1):
  Improve error message when a transport helper was not found

Johannes Sixt (3):
  start_command: report child process setup errors to the parent's
    stderr
  run-command: move wait_or_whine earlier
  start_command: detect execvp failures early

 Makefile               |    1 +
 run-command.c          |  177 
+++++++++++++++++++++++++++++++++++-------------
 t/t0061-run-command.sh |   14 ++++
 test-run-command.c     |   35 ++++++++++
 transport-helper.c     |   14 +++-
 5 files changed, 191 insertions(+), 50 deletions(-)
 create mode 100755 t/t0061-run-command.sh
 create mode 100644 test-run-command.c
