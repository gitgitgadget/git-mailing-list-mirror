From: marcnarc@xiplink.com
Subject: [PATCH 0/6] Default remote
Date: Thu,  5 Jul 2012 18:11:11 -0400
Message-ID: <1341526277-17055-1-git-send-email-marcnarc@xiplink.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, peff@peff.net,
	phil.hord@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 06 00:11:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmuGr-00069c-F8
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 00:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123Ab2GEWL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jul 2012 18:11:26 -0400
Received: from 208-85-112-101.zerofail.com ([208.85.112.101]:5720 "EHLO
	farnsworth.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756771Ab2GEWLU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jul 2012 18:11:20 -0400
Received: from xiplink.com (rincewind.xiplink.com [192.168.1.166])
	by farnsworth.xiplink.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id q65MBE09004223;
	Thu, 5 Jul 2012 18:11:15 -0400
X-Mailer: git-send-email 1.7.11.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201065>

This series is a follow-up to an earlier patch and discussion[1] that
suggested adding a remote.default setting.

The first patch simply renames a couple of variables in remote.c so that
the second patch is easier to understand.

The second patch teaches remote.c to look for remote.default in the config:

 - When deciding which remote to use, the code first tries the currently
   checked-out branch's remote.  If there isn't one it tries remote.default,
   and if that also fails it falls back to "origin".

 - The patch also adds a couple of helper functions for other code to use:
   remote_get_default_name() and remote_count().  remote_get_default_name()
   returns the value of remote.default, or "origin" if it's not configured
   (this preserves existing behavior).  remote_count() is used in patch
   four by "git remote add".

The third patch teaches "git clone" to set remote.default.

The fourth patch teaches "git remote" about remote.default.  In addition to
modifying the existing "add" "rm" and "rename" commands, it also adds a new
"git remote default" command to get/set remote.default.  The advantage of this
over just using "git config" directly is twofold:

 - "git remote default foo" checks that foo is a configured remote.

 - "git remote default" (with no parameter) returns "origin" if 
   remote.default isn't configured.

Note that this patch changes the way push.default=matching works when the
currently checked-out branch has no remote.  Before "git push" would error out
with "No configured push destination" but now it succeeds with "Everything
up-to-date".  I personally think this is a good thing.

The fifth patch just adds a test that plain "git fetch" respects
remote.default when on remoteless branch.  I suppose it could be squashed into
patch four, but it's really more of a side-effect of that work and not
strictly required by it.  So I felt patch four would be more understandable
without it.

The sixth patch changes git-parse-remote.sh:get_default_remote() to use
"git remote default" instead of implementing its own default-finding logic.
Because "git remote default" returns "origin" when no remote.default is
configured, this change preserves the old behavior in existing repos.  The
test accompanying this patch essentially tests the same condition that
inspired the original discussion[1].  (git-submodule is pretty much the only
thing that uses get_default_remote().)

This series still needs documentation updates, which I'll do if/when we
agree on the code changes.

		M.

[1] http://article.gmane.org/gmane.comp.version-control.git/200145

Marc Branchaud (6):
      Rename remote.c's default_remote_name static variables.
      Teach remote.c about the remote.default configuration setting.
      Teach clone to set remote.default.
      Teach "git remote" about remote.default.
      Test that plain "git fetch" uses remote.default when on a detached HEAD.
      Teach get_default_remote to respect remote.default.

 builtin/clone.c            |  2 ++
 builtin/remote.c           | 29 +++++++++++++++++++++
 git-parse-remote.sh        |  5 +---
 remote.c                   | 35 ++++++++++++++++++++-----
 remote.h                   |  2 ++
 t/t5505-remote.sh          | 64 ++++++++++++++++++++++++++++++++++++++++++++++
 t/t5510-fetch.sh           | 17 ++++++++++++
 t/t5512-ls-remote.sh       |  8 +++++-
 t/t5528-push-default.sh    |  4 +--
 t/t5601-clone.sh           | 10 ++++++++
 t/t5702-clone-options.sh   |  7 +++--
 t/t7400-submodule-basic.sh | 21 +++++++++++++++
 12 files changed, 188 insertions(+), 16 deletions(-)
