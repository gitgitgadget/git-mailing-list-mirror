From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] remote show: do not show symbolic refs
Date: Wed, 19 Mar 2008 00:27:42 +0000 (GMT)
Message-ID: <alpine.DEB.1.00.0803182119320.2323@eeepc-johanness>
References: <7v7ig096ot.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 23:15:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc6Z5-0007Li-3h
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 23:15:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759288AbYCSWOb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 18:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934020AbYCSWO3
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 18:14:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:56070 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757788AbYCSWO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 18:14:26 -0400
Received: (qmail invoked by alias); 19 Mar 2008 00:27:44 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO eeepc-johanness.home) [86.138.198.40]
  by mail.gmx.net (mp024) with SMTP; 19 Mar 2008 01:27:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+uu80y352uI/Rjsa2eufhrhKZTu8lBiEpj+dUNJG
	oMearXv0xHPD0i
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7v7ig096ot.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77569>


For symbolic refs, a sane notion of being "stale" is that the ref
they point to no longer exists.  Since this is checked already,
"remote show" does not need to show them at all.

Incidentally, this fixes the issue that "HEAD" was shown as a
stale ref by "remote show" in a freshly cloned repository.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Mon, 17 Mar 2008, Junio C Hamano wrote:

	> "git remote" showing remotes/origin/HEAD as a candidate for 
	> pruning, and pruning it results in removal of what is pointed at 
	> by it.
	>
	> Pointers?  This may not be a regression but bug-to-bug 
	> compatibility with the older implementation, but this should 
	> better be fixed.

	How about this?

 builtin-remote.c  |    5 ++++-
 t/t5505-remote.sh |   10 ++++++++++
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 8e7fa6a..67139ec 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -210,7 +210,10 @@ static int handle_one_branch(const char *refname,
 	if (!remote_find_tracking(states->remote, &refspec)) {
 		struct path_list_item *item;
 		const char *name = skip_prefix(refspec.src, "refs/heads/");
-		if (unsorted_path_list_has_path(&states->tracked, name) ||
+		/* symbolic refs pointing nowhere were handled already */
+		if ((flags & REF_ISSYMREF) ||
+				unsorted_path_list_has_path(&states->tracked,
+					name) ||
 				unsorted_path_list_has_path(&states->new,
 					name))
 			return 0;
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index ecfc999..004a8dc 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -237,4 +237,14 @@ test_expect_success 'update default (overridden, with funny whitespace)' '
 
 '
 
+test_expect_success '"remote show" does not show symbolic refs' '
+
+	git clone one three &&
+	(cd three &&
+	 git remote show origin > output &&
+	 ! grep HEAD < output &&
+	 ! grep -i stale < output)
+
+'
+
 test_done
-- 
1.5.5.rc0.173.g90d70
