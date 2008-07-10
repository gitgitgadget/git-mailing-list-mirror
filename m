From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Fix backwards-incompatible handling of core.sharedRepository
Date: Fri, 11 Jul 2008 01:19:48 +0200
Message-ID: <20080710231853.21448.18643.stgit@rover.dkm.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Heikki Orsila <heikki.orsila@iki.fi>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jul 11 01:22:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH5ST-0005Aa-87
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 01:21:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753087AbYGJXUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 19:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752916AbYGJXUz
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 19:20:55 -0400
Received: from rover.dkm.cz ([62.24.64.27]:53125 "EHLO rover.dkm.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752774AbYGJXUz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 19:20:55 -0400
Received: from rover.dkm.cz (localhost [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id 3EA4E166741;
	Fri, 11 Jul 2008 01:19:48 +0200 (CEST)
User-Agent: StGIT/0.14.3.171.ge0e6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88053>

The 06cbe8550324e0fd2290839bf3b9a92aa53b70ab core.sharedRepository
handling extension broke backwards compatibility; before, shared=1 meant
that Git merely ensured the repository is group-writable, not that it's
_only_ group-writable, which is the current behaviour.

Maybe it makes sense to provide the current semantics in some way too,
but that cannot be done at the expense of ditching backwards
compatibility; this bug has just wasted me two hours and broke
repo.or.cz pushing for several hours.

Signed-off-by: Petr Baudis <pasky@rover.dkm.cz>
---

 Sorry for the resend, StGIT kind of tricked me to adding two Cc headers and
 the first one just got dropped.

 path.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/path.c b/path.c
index 5983255..75c5915 100644
--- a/path.c
+++ b/path.c
@@ -269,7 +269,7 @@ int adjust_shared_perm(const char *path)
 	mode = st.st_mode;
 
 	if (shared_repository) {
-		int tweak = shared_repository;
+		int tweak = (mode & 0777) | shared_repository;
 		if (!(mode & S_IWUSR))
 			tweak &= ~0222;
 		mode = (mode & ~0777) | tweak;
