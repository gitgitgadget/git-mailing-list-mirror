From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Improve error message about fetch into current branch
Date: Sun, 22 Mar 2009 23:07:33 +0100
Message-ID: <20090322220732.GA6736@blimp.localdomain>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 22 23:09:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlVrH-0004tX-Hv
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 23:09:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756192AbZCVWHo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 18:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755940AbZCVWHo
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 18:07:44 -0400
Received: from mout4.freenet.de ([195.4.92.94]:43093 "EHLO mout4.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752484AbZCVWHn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 18:07:43 -0400
Received: from [195.4.92.13] (helo=3.mx.freenet.de)
	by mout4.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.69 #76)
	id 1LlVpR-0002If-F2; Sun, 22 Mar 2009 23:07:37 +0100
Received: from x5a0c.x.pppool.de ([89.59.90.12]:36051 helo=tigra.home)
	by 3.mx.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 587) (Exim 4.69 #79)
	id 1LlVpR-00041S-85; Sun, 22 Mar 2009 23:07:37 +0100
Received: from blimp.localdomain (blimp.home [192.168.1.28])
	by tigra.home (Postfix) with ESMTP id 9B2EE277D8;
	Sun, 22 Mar 2009 23:07:33 +0100 (CET)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 4A0A936D27; Sun, 22 Mar 2009 23:07:33 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114186>

Otherwise, it is hard to guess why the fetch failed.
Make sure we at least mention that the repository must be bare.
Also the current branch is printed.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

In particular, a repository not marked bare with core.bare is, for
some reason, considered non-bare even if there is no work tree nor
index. I found about the message while trying to run git remote,
in an essentially bare repository without core.bare set. Funny,
git --bare fetch worked properly, but git --bare remote update failed:

    $ GIT_TRACE=1 ~/projects/git/git --bare remote -v update
    trace: built-in: git 'remote' '-v' 'update'
    Updating origin
    trace: run_command: 'fetch' '-v' 'origin'
    trace: exec: 'git' 'fetch' '-v' 'origin'
    trace: built-in: git 'fetch' '-v' 'origin'
    fatal: Refusing to fetch into current branch refs/heads/master
    error: Could not fetch origin
    $ git --bare fetch -v origin
    From git://git.kernel.org/pub/scm/linux/hotplug/udev
     = [up to date]      master     -> master
    $

Looks like --bare is lost somewhere.

 builtin-fetch.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 7fb35fc..7293146 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -544,7 +544,8 @@ static void check_not_current_branch(struct ref *ref_map)
 	for (; ref_map; ref_map = ref_map->next)
 		if (ref_map->peer_ref && !strcmp(current_branch->refname,
 					ref_map->peer_ref->name))
-			die("Refusing to fetch into current branch");
+			die("Refusing to fetch into current branch %s "
+			    "of non-bare repository", current_branch->refname);
 }
 
 static int do_fetch(struct transport *transport,
-- 
1.6.2.1.316.g4241
