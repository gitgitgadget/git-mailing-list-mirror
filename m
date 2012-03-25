From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH 0/2] Make run-command.c honour SHELL_PATH
Date: Sun, 25 Mar 2012 08:31:34 -0400
Message-ID: <1332678696-4001-1-git-send-email-bwalton@artsci.utoronto.ca>
Cc: git@vger.kernel.org, Ben Walton <bwalton@artsci.utoronto.ca>
To: gitster@pobox.com, peff@peff.net
X-From: git-owner@vger.kernel.org Sun Mar 25 14:31:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBmbt-0000Ki-Cd
	for gcvg-git-2@plane.gmane.org; Sun, 25 Mar 2012 14:31:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755997Ab2CYMbq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Mar 2012 08:31:46 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:46324 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755637Ab2CYMbl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2012 08:31:41 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:60891 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SBmbj-0002Oi-1C; Sun, 25 Mar 2012 08:31:39 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SBmbi-000131-Ry; Sun, 25 Mar 2012 08:31:38 -0400
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193866>

Hi Jeff and Junio,

[Others touched this file too, but it appears Jeff wrote the affected
functionality.]

I hit a glitch with t7006-pager while testing the 1.7.10 rc1/rc2
builds for OpenCSW/Solaris that turned out to be a problem with the
way run-command.c:prepare_shell_cmd was setting up external
utilities.  It was hard coded to fork 'sh -c' instead of honouring the
SHELL_PATH as set at build time.

In this case, the failing test was t7006-pager:command-specific
pager.  That test (and some subsequent ones) were setting the pager
command used by git log to "sed s/^/foo:/ >actual" which is fine in a
POSIX-compliant sh, but not in Solaris' sh.  If the user PATH at
runtime happened to allow the broken system sh used instead of a sane
sh, the ^ is interpreted the same as[1] | and this caused sed to fail
with incomplete s/ command and a "command not found: /foo:" from the
other forked process.

To mitigate this, the following patches introduce the macro SHELL_PATH
for use in run-command.c, defaulting to "sh" to preserve the current
behaviour and then cause the build system to provide the SHELL_PATH as
set by the builder.  This means that all processed forked by
run-command will use the same interpreter as the shell scripts in the
git suite.

I considered implementing a dynamically generated .h file for this,
similar to common-cmds.h, but thought that was overkill at the current
time.  If you think that (or something else) is a better fit for the
change, let me know and I'll make the required adjustments.

Thanks
-Ben

[1] http://src.opensolaris.org/source/xref/onnv/onnv-gate/usr/src/cmd/sh/cmd.c#184


Ben Walton (2):
  run-command.c: Define SHELL_PATH macro for use in prepare_shell_cmd
  Makefile: Set EXTRA_CPPFLAGS during the compilation of run-command

 Makefile      |    2 ++
 run-command.c |    6 +++++-
 2 files changed, 7 insertions(+), 1 deletions(-)

-- 
1.7.5.4
