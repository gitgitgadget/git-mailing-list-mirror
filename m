From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 0/7] rework run_command error reporting
Date: Sat,  4 Jul 2009 21:26:36 +0200
Message-ID: <cover.1246734159.git.j6t@kdbg.org>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 04 21:27:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNAti-00052P-KP
	for gcvg-git-2@gmane.org; Sat, 04 Jul 2009 21:27:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521AbZGDT1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Jul 2009 15:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752428AbZGDT1R
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jul 2009 15:27:17 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:17612 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752507AbZGDT1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jul 2009 15:27:16 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 5F3552C4003;
	Sat,  4 Jul 2009 21:27:17 +0200 (CEST)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id B5A1B42784;
	Sat,  4 Jul 2009 21:27:16 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.17.g1665f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122723>

I got tired of thinking about which return values of run_command functions
are exit codes and which are error codes of system call failures.

Furthermore, it is a pitty that almost no run_command callers correctly
report system call failures.

But on top of all I find it unacceptable that recent git-daemon logs
"unable to run 'git-pack-objects'" if a client terminates the connection
early.

This series addresses these issues, and also fixes an error in git-bisect
on Windows.

1/7 Truncate result of run_command that is used in exit() to lowest 8 bits

    This one fixes a breakage of git-bisect on Windows and should be
    applied at any rate.

2/7 MinGW: simplify waitpid() emulation macros
3/7 run_command: return exit code as positive value
4/7 run_command: report system call errors instead of returning error codes

    These address the mentioned issues; 4/7 is the important change.

5/7 run_command: encode deadly signal number in the return value
6/7 run_command: report failure to execute the program, but optionally don't

    These two are nice to have.

7/7 receive-pack: remove unnecessary run_status report

    This one is actually RFC because it removes a status report that users
    might be used to see, or even depend on.


 bisect.c                     |    4 +-
 builtin-add.c                |    2 +-
 builtin-merge.c              |    2 +-
 builtin-receive-pack.c       |   38 ++--------------
 compat/mingw.h               |    5 +-
 convert.c                    |    2 +-
 git.c                        |   10 +---
 ll-merge.c                   |    4 --
 run-command.c                |  105 +++++++++++++++++++++++------------------
 run-command.h                |   13 +----
 t/t5530-upload-pack-error.sh |    5 ++-
 transport.c                  |   16 +------
 12 files changed, 81 insertions(+), 125 deletions(-)
