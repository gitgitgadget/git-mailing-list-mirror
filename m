From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: Segfault in "git remote show <remote-name>"
Date: Mon, 25 May 2009 21:01:21 +0200
Message-ID: <20090525190121.GA3979@localhost>
References: <40aa078e0905250910v268faa66p29a0183db26cb0df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Mon May 25 21:01:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8fQb-0005uB-Km
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 21:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752607AbZEYTBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 15:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752446AbZEYTBb
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 15:01:31 -0400
Received: from postman.fh-hagenberg.at ([193.170.124.96]:13505 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbZEYTBa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 15:01:30 -0400
Received: from darc.dnsalias.org ([84.154.65.240]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 25 May 2009 21:01:30 +0200
Received: from drizzd by darc.dnsalias.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1M8fQH-0005jz-Vb; Mon, 25 May 2009 21:01:21 +0200
Content-Disposition: inline
In-Reply-To: <40aa078e0905250910v268faa66p29a0183db26cb0df@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 25 May 2009 19:01:30.0638 (UTC) FILETIME=[36BD3AE0:01C9DD6B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119950>

Subject: [PATCH] fix segfault showing an empty remote

In case of an empty list, the search for its tail caused a
NULL-pointer dereference.

Reported-by: Erik Faye-Lund <kusmabite@googlemail.com>
Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

On Mon, May 25, 2009 at 06:10:12PM +0200, Erik Faye-Lund wrote:
> I've been messing around a bit, trying to set up a gitosis repo to
> mirror one of my projects. Now, I added the remote to my project, but
> when running "git remote show <remote-name>", I'm getting a segfault
> in builtin-remote.c at line 303 ("while (ref->next)"), because ref
> itself is NULL.

This should fix it.

I simply copied this from other uses of match_refs. I wonder if this calls
for a find_link_ref_tail() function, but I didn't know where to put it.

Clemens

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
