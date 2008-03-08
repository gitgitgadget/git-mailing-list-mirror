From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] builtin remote rm: remove symbolic refs, too
Date: Sat, 8 Mar 2008 23:40:42 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803082339060.3975@racer.site>
References: <200803051338.44938.tlikonen@iki.fi> <7v7iggn9ts.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org,
	James Bowes <jbowes@dangerouslyinc.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 08 23:41:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY7jB-00010m-Mt
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 23:41:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbYCHWkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 17:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbYCHWkk
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 17:40:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:48936 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750740AbYCHWkj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 17:40:39 -0500
Received: (qmail invoked by alias); 08 Mar 2008 22:40:37 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp052) with SMTP; 08 Mar 2008 23:40:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18nFKYayM4npPmekV655TDOp8rK1HIWIaQHW/T+Dl
	wb0GCUn8G5O3xC
X-X-Sender: gene099@racer.site
In-Reply-To: <7v7iggn9ts.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76598>


"git remote add" can add a symbolic ref "HEAD", and "rm" should delete
it, too.

Noticed by Teemu Likonen.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-remote.c  |    5 +++++
 t/t5505-remote.sh |    1 +
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index aa90cc9..f7653b6 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -267,6 +267,11 @@ static int add_branch_for_removal(const char *refname,
 
 	if (!prefixcmp(refname, branches->prefix)) {
 		struct path_list_item *item;
+
+		/* make sure that symrefs are deleted */
+		if (flags & REF_ISSYMREF)
+			return unlink(git_path(refname));
+
 		item = path_list_append(refname, branches->branches);
 		item->util = xmalloc(20);
 		hashcpy(item->util, sha1);
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index f45ea68..2822a65 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -80,6 +80,7 @@ test_expect_success 'add another remote' '
 test_expect_success 'remove remote' '
 (
 	cd test &&
+	git symbolic-ref refs/remotes/second/HEAD refs/remotes/second/master &&
 	git remote rm second
 )
 '
-- 
1.5.4.3.653.gbc310

