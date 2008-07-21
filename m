From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 0/9] Make gitexecdir relative to $(bindir) on Windows
Date: Mon, 21 Jul 2008 21:19:49 +0200
Message-ID: <1216667998-8879-1-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 21:21:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL0wz-00025p-6R
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 21:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753749AbYGUTUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 15:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754544AbYGUTUH
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 15:20:07 -0400
Received: from smtp1.srv.eunet.at ([193.154.160.119]:39810 "EHLO
	smtp1.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753571AbYGUTUD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 15:20:03 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp1.srv.eunet.at (Postfix) with ESMTP id 7DE8A33C31;
	Mon, 21 Jul 2008 21:19:59 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.18.g6aef2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89388>

This is a revival of the series of a week or so ago.

I found a workaround for the problem that made me abondon the effort.
The problem was that argv[0] does not have a path in certain cases.
The workaround is in 8/9, namely to redefine main() and replace
argv[0] by the value of _pgmptr that the C runtime on Windows provides
and that always has a full path.

Steffen has suggested not to the path discovery for 'git-*' programs.
No change is necessary to do that because programs with a 'git-' prefix
already take the path via handle_internal_command() early.

9/9 actually is off-topic, but it depends on 2/9 because it replaces
the instance of git-shell in the ./check_bindir line by git-add. If
you think it's worthwhile, you could squash this hunk into 2/9.

I'll follow-up with 10/9, which is git-gui specific.

Johannes Sixt (9):
  Makefile: Do not install a copy of 'git' in $(gitexecdir)
  Makefile: Normalize $(bindir) and $(gitexecdir) before comparing
  Record the command invocation path early
  Fix relative built-in paths to be relative to the command invocation
  Allow the built-in exec path to be relative to the command invocation
    path
  Allow add_path() to add non-existent directories to the path
  Windows: Make $(gitexecdir) relative
  Windows: Make sure argv[0] has a path
  Windows: Do not compile git-shell

 Makefile       |   38 ++++++++++++++++++++++++--------------
 abspath.c      |   36 ++++++++++++++++++++++++++++++++++++
 compat/mingw.h |   12 ++++++++++++
 exec_cmd.c     |   54 +++++++++++++-----------------------------------------
 exec_cmd.h     |    3 ++-
 git.c          |    5 ++---
 path.c         |   36 ------------------------------------
 receive-pack.c |    2 +-
 shell.c        |    4 ++--
 upload-pack.c  |    2 +-
 10 files changed, 93 insertions(+), 99 deletions(-)
