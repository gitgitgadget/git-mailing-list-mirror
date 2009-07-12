From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH 0/6] Tracking setup improvements: per-remote config, autosetuppush
Date: Sun, 12 Jul 2009 14:17:27 +0200
Message-ID: <1247401053-20429-1-git-send-email-bonzini@gnu.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 12 14:17:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPy07-0001H1-Dl
	for gcvg-git-2@gmane.org; Sun, 12 Jul 2009 14:17:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752510AbZGLMRi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jul 2009 08:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752264AbZGLMRi
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jul 2009 08:17:38 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:60345 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182AbZGLMRh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jul 2009 08:17:37 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1MPxzs-0003Qu-0u
	for git@vger.kernel.org; Sun, 12 Jul 2009 08:17:36 -0400
X-Mailer: git-send-email 1.6.2.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123141>

This patch series adds two features that are a step toward providing
consistent per-remote configuration of push behavior in addition
to merge (tracking) behavior.

In particular, the two features are:

1) per-remote configuration of automatic tracking setup.  This leads
to some nice refactoring of the code handling autosetup, where the
combination of autosetupmerge and autosetuprebase is consolidated in
a struct.

2) The ability to automatically setup push refspecs corresponding
to local branches tracking a remote.  This is false by default, since
we also have push.default---and actually, a generalized default of
true is probably not a good idea, unlike a per-remote setting.  In
the future, 'git remote add' might set the per-remote autosetuppush
to true if it gets some appropriate command-line argument.


Patch 1 is a somewhat tangential DWIM that I've meant to send for
a while.  It conflicts with this patch series, so I've included it.

Patches 2 and 3 include the refactorings in preparation for the new
remote.*.autosetup configuration, which is then implemented by
patch 4.

Patch 5 extracts some code to a function that will become more
complicated in patch 6.  Patch 6 implements autosetuppush by
automatically creating and deleting push refspecs upon branch
creation and deletion.

 config: allow false and true values for branch.autosetuprebase
 branch: install_branch_config and struct tracking refactoring
 introduce a struct tracking_config
 remote: add per-remote autosetupmerge and autosetuprebase configuration
 move deletion of merge configuration to branch.c
 branch, checkout: introduce autosetuppush

 Documentation/config.txt |   36 +++++++++++++++++-
 branch.c                 |   92 +++++++++++++++++++++++++++++++++++++--------
 branch.h                 |    5 ++-
 builtin-branch.c         |   10 +----
 builtin-checkout.c       |    2 +-
 builtin-clone.c          |    4 +-
 cache.h                  |   11 ++++-
 config.c                 |   48 +++++++++++++++++-------
 environment.c            |    7 ++-
 remote.c                 |    3 +
 remote.h                 |    1 +
 t/t3200-branch.sh        |   92 ++++++++++++++++++++++++++++++++++++++++++++-
 12 files changed, 259 insertions(+), 52 deletions(-)
