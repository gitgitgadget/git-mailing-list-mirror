From: marcnarc@xiplink.com
Subject: [PATCH 1/3] submodules: recursive fetch also checks new tags for submodule commits
Date: Mon, 16 Apr 2012 18:08:48 -0400
Message-ID: <1334614130-31826-2-git-send-email-marcnarc@xiplink.com>
References: <1334591542-25136-1-git-send-email-marcnarc@xiplink.com>
 <1334614130-31826-1-git-send-email-marcnarc@xiplink.com>
Cc: Jens Lehmann <Jens.Lehmann@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 00:08:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJu67-0006Ks-Rs
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 00:08:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755321Ab2DPWIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 18:08:30 -0400
Received: from 208-85-112-101.zerofail.com ([208.85.112.101]:22401 "EHLO
	farnsworth.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754218Ab2DPWI3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Apr 2012 18:08:29 -0400
Received: from xiplink.com (rincewind.xiplink.com [192.168.1.166])
	by farnsworth.xiplink.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id q3GM8QLP000947;
	Mon, 16 Apr 2012 18:08:27 -0400
X-Mailer: git-send-email 1.7.10.2.ge89da.dirty
In-Reply-To: <1334614130-31826-1-git-send-email-marcnarc@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195706>

From: Jens Lehmann <Jens.Lehmann@web.de>

Since 88a21979c (fetch/pull: recurse into submodules when necessary) all
fetched commits are examined if they contain submodule changes (unless
configuration or command line options inhibit that). If a newly recorded
submodule commit is not present in the submodule, a fetch is run inside
it to download that commit.

Checking new refs was done in an else branch where it wasn't executed for
tags. This normally isn't a problem because tags are only fetched with
the branches they live on, then checking the new commits in the fetched
branches for submodule commits will also process all tags. But when a
specific tag is fetched (or the refspec contains refs/tags/) commits only
reachable by tags won't be searched for submodule commits, which is a bug.

Fix that by moving the code outside the if/else construct to handle new
tags just like any other ref. The performance impact of adding tags that
most of the time lie on a branch which is checked anyway for new submodule
commit should be minimal, as since 6859de4 (fetch: avoid quadratic loop
checking for updated submodules) all ref-tips are collected first and then
fed to a single rev-list.

Spotted-by: Jeff King <peff@peff.net>
Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 builtin/fetch.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 65f5f9b..cfb43df 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -300,11 +300,11 @@ static int update_local_ref(struct ref *ref,
 		else {
 			msg = "storing head";
 			what = _("[new branch]");
-			if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
-			    (recurse_submodules != RECURSE_SUBMODULES_ON))
-				check_for_new_submodule_commits(ref->new_sha1);
 		}
 
+		if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
+		    (recurse_submodules != RECURSE_SUBMODULES_ON))
+			check_for_new_submodule_commits(ref->new_sha1);
 		r = s_update_ref(msg, ref, 0);
 		strbuf_addf(display, "%c %-*s %-*s -> %s%s",
 			    r ? '!' : '*',
-- 
1.7.10.2.ge89da.dirty
