From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] fetch: refuse to fetch into the current branch in a non-bare
 repository
Date: Sat, 11 Oct 2008 13:38:02 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810111336350.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Oct 11 13:32:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Koci7-00027k-R1
	for gcvg-git-2@gmane.org; Sat, 11 Oct 2008 13:32:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911AbYJKLb3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2008 07:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751626AbYJKLb3
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Oct 2008 07:31:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:52806 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751505AbYJKLb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Oct 2008 07:31:28 -0400
Received: (qmail invoked by alias); 11 Oct 2008 11:31:34 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp018) with SMTP; 11 Oct 2008 13:31:34 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18N4Sx+7R8NgTGbzAe+VtmVV6k6NLzm9qWafkeWEK
	0rH6VHfTm2ZiTc
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97972>


Some confusing tutorials suggest that it would be a good idea to call
something like this:

	git pull origin master:master

While it might make sense to store what you want to merge, it typically
is plain wrong.  Especially so when the current branch is "master".

Be at least a little bit helpful by refusing to fetch something into
the current branch.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-fetch.c   |   20 ++++++++++++++++++++
 t/t5505-remote.sh |    2 +-
 t/t5510-fetch.sh  |    6 ++++++
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index ee93d3a..d701550 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -534,6 +534,25 @@ static void find_non_local_tags(struct transport *transport,
 	string_list_clear(&new_refs, 0);
 }
 
+static void check_ref_map(struct ref *ref_map)
+{
+	int flag;
+	unsigned char sha1[20];
+	const char *HEAD;
+
+	if (is_bare_repository())
+		return;
+
+	HEAD = resolve_ref("HEAD", sha1, 1, &flag);
+
+	if (!HEAD || !(flag & REF_ISSYMREF))
+		return;
+
+	for (; ref_map; ref_map = ref_map->next)
+		if (ref_map->peer_ref && !strcmp(HEAD, ref_map->peer_ref->name))
+			die("Refusing to fetch into current branch");
+}
+
 static int do_fetch(struct transport *transport,
 		    struct refspec *refs, int ref_count)
 {
@@ -558,6 +577,7 @@ static int do_fetch(struct transport *transport,
 	}
 
 	ref_map = get_ref_map(transport, refs, ref_count, tags, &autotags);
+	check_ref_map(ref_map);
 
 	for (rm = ref_map; rm; rm = rm->next) {
 		if (rm->peer_ref)
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index c449663..0103e1a 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -188,7 +188,7 @@ test_expect_success 'prune --dry-run' '
 test_expect_success 'add --mirror && prune' '
 	(mkdir mirror &&
 	 cd mirror &&
-	 git init &&
+	 git init --bare &&
 	 git remote add --mirror -f origin ../one) &&
 	(cd one &&
 	 git branch -m side2 side) &&
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 9aae496..cd8b550 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -323,4 +323,10 @@ test_expect_success 'auto tag following fetches minimum' '
 	)
 '
 
+test_expect_success 'refuse to fetch into the current branch' '
+
+	test_must_fail git fetch . side:master
+
+'
+
 test_done
-- 
1.6.0.2.749.g0cc32
