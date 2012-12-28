From: Aaron Schrab <aaron@schrab.com>
Subject: [PATCH 0/4] pre-push hook support
Date: Fri, 28 Dec 2012 17:57:28 -0500
Message-ID: <1356735452-21667-1-git-send-email-aaron@schrab.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 28 23:58:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ToisO-000114-K9
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 23:58:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754901Ab2L1W5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 17:57:46 -0500
Received: from pug.qqx.org ([50.116.43.67]:57401 "EHLO pug.qqx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754499Ab2L1W5n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 17:57:43 -0500
Received: from zim.qqx.org (cpe-107-015-024-243.nc.res.rr.com [107.15.24.243])
	by pug.qqx.org (Postfix) with ESMTPSA id 980341D2D2
	for <git@vger.kernel.org>; Fri, 28 Dec 2012 17:57:41 -0500 (EST)
Received: from ats (uid 1000)
	(envelope-from aaron@schrab.com)
	id 48071
	by zim.qqx.org (DragonFly Mail Agent);
	Fri, 28 Dec 2012 17:57:40 -0500
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212270>

There have been at least a couple of submissions to add support for a
pre-push hook, which were rejected at least partially because they didn't
provide enough information to a hook script for it to determine what was
to be pushed any better than a separate wrapper around the 'git push'
command would be able to do.  In this series I attempt to address that
problem.

The first two patches in this series do a little bit of refactoring in
order to make it easier to call hooks with a variable number of arguments.

The third patch actually adds support for calling a pre-push hook.  If it
exists, it will be called with the name and URL of the destination remote
(if a named remote isn't being used, the URL will be supplied for both)
followed by another argument for each ref being pushed; these arguments
take the form:

  <local ref>:<local sha1>:<remote ref>:<remote sha1>

This should provide enough information for a script to easily determine
the set of commits that is being pushed, and thus make a decision if that
should be allowed.

The final patch adds a sample pre-push hook script which will deny
attempts to push commits that are marked as a work in progress.

Aaron Schrab (4):
  hooks: Add function to check if a hook exists
  hooks: support variable number of parameters
  push: Add support for pre-push hooks
  Add sample pre-push hook script

 Documentation/githooks.txt       |   28 ++++++++
 builtin/push.c                   |    1 +
 run-command.c                    |   35 ++++++---
 run-command.h                    |    3 +
 t/t5571-pre-push-hook.sh         |  145 ++++++++++++++++++++++++++++++++++++++
 templates/hooks--pre-push.sample |   63 +++++++++++++++++
 transport.c                      |   25 +++++++
 transport.h                      |    1 +
 8 files changed, 292 insertions(+), 9 deletions(-)
 create mode 100755 t/t5571-pre-push-hook.sh
 create mode 100644 templates/hooks--pre-push.sample

-- 
1.7.10.4
