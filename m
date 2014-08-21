From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH] walker: avoid quadratic list insertion in mark_complete
Date: Thu, 21 Aug 2014 20:30:24 +0200
Message-ID: <53F63AC0.1090605@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 21 20:31:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKX96-00064i-Ln
	for gcvg-git-2@plane.gmane.org; Thu, 21 Aug 2014 20:31:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753850AbaHUSbc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2014 14:31:32 -0400
Received: from mout.web.de ([212.227.17.12]:55121 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753841AbaHUSbb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2014 14:31:31 -0400
Received: from [192.168.178.27] ([79.250.165.107]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0M6mPA-1WOQhd2KN2-00wWir; Thu, 21 Aug 2014 20:30:38
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
X-Provags-ID: V03:K0:Q/wI8AcpdzJLrKQLuP775QnG+BwG1EXZl7KYpsCBYg6HQ+tCNMe
 6C/A42k1GeBGpQfBLs1wKIRHAv9sgyUjbGitxeRjtAkE8/85ORvUY/wHjQkel2F8fs7zxAk
 k9jJ5w5KcJfbaEej7TLM/Fc0F7LycaDVETd0eJVmDrqLBTUsw4NXasGrZ3TE8XBG06pKPfh
 0HEPw6+KBvHPc4ku6TXpg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255629>

Similar to 16445242 (fetch-pack: avoid quadratic list insertion in
mark_complete), sort only after all refs are collected instead of while
inserting.  The result is the same, but it's more efficient that way.
The difference will only be measurable in repositories with a large
number of refs.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 walker.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/walker.c b/walker.c
index 0148264..0596e99 100644
--- a/walker.c
+++ b/walker.c
@@ -205,7 +205,7 @@ static int mark_complete(const char *path, const unsigned char *sha1, int flag,
 	struct commit *commit = lookup_commit_reference_gently(sha1, 1);
 	if (commit) {
 		commit->object.flags |= COMPLETE;
-		commit_list_insert_by_date(commit, &complete);
+		commit_list_insert(commit, &complete);
 	}
 	return 0;
 }
@@ -271,8 +271,10 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 		}
 	}
 
-	if (!walker->get_recover)
+	if (!walker->get_recover) {
 		for_each_ref(mark_complete, NULL);
+		commit_list_sort_by_date(&complete);
+	}
 
 	for (i = 0; i < targets; i++) {
 		if (interpret_target(walker, target[i], &sha1[20 * i])) {
-- 
2.1.0
