From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 1/2] fix segfault showing an empty remote
Date: Wed, 27 May 2009 22:13:43 +0200
Message-ID: <1243455224-3463-1-git-send-email-drizzd@aon.at>
References: <76718490905260727v7261391uab169167978e4522@mail.gmail.com>
Cc: Erik Faye-Lund <kusmabite@googlemail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 27 22:14:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9PW8-00041L-5K
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 22:14:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbZE0UNv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 16:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763440AbZE0UNu
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 16:13:50 -0400
Received: from postman.fh-hagenberg.at ([193.170.124.96]:50731 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932326AbZE0UNt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 16:13:49 -0400
Received: from darc.dnsalias.org ([84.154.120.211]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 27 May 2009 22:13:47 +0200
Received: from drizzd by darc.dnsalias.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1M9PVX-0000y8-FT; Wed, 27 May 2009 22:13:51 +0200
X-Mailer: git-send-email 1.6.3.1.147.g637c3
In-Reply-To: <76718490905260727v7261391uab169167978e4522@mail.gmail.com>
X-OriginalArrivalTime: 27 May 2009 20:13:47.0988 (UTC) FILETIME=[A4D3D140:01C9DF07]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120101>

In case of an empty list, the search for its tail caused a
NULL-pointer dereference.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
Reported-by: Erik Faye-Lund <kusmabite@googlemail.com>
Acked-by: Jay Soffian <jaysoffian@gmail.com>
---
 builtin-remote.c  |    8 ++++----
 t/t5505-remote.sh |   10 ++++++++++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 71abf68..fda9a54 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -299,11 +299,11 @@ static int get_push_ref_states(const struct ref *remote_refs,
 		return 0;
 
 	local_refs = get_local_heads();
-	ref = push_map = copy_ref_list(remote_refs);
-	while (ref->next)
-		ref = ref->next;
-	push_tail = &ref->next;
+	push_map = copy_ref_list(remote_refs);
 
+	push_tail = &push_map;
+	while (*push_tail)
+		push_tail = &((*push_tail)->next);
 	match_refs(local_refs, push_map, &push_tail, remote->push_refspec_nr,
 		   remote->push_refspec, MATCH_REFS_NONE);
 
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 5ec668d..e70246b 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -494,5 +494,15 @@ test_expect_success 'remote prune to cause a dangling symref' '
 	grep "dangling symref" err
 '
 
+test_expect_success 'show empty remote' '
+
+	test_create_repo empty &&
+	git clone empty empty-clone &&
+	(
+		cd empty-clone &&
+		git remote show origin
+	)
+'
+
 test_done
 
-- 
1.6.3.1.147.g637c3
