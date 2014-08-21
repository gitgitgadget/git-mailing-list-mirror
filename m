From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH] sha1_name: avoid quadratic list insertion in handle_one_ref
Date: Thu, 21 Aug 2014 20:30:29 +0200
Message-ID: <53F63AC5.80901@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 21 20:31:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKX8Y-0005lf-Rf
	for gcvg-git-2@plane.gmane.org; Thu, 21 Aug 2014 20:31:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753756AbaHUSa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2014 14:30:58 -0400
Received: from mout.web.de ([212.227.17.12]:61896 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753304AbaHUSa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2014 14:30:58 -0400
Received: from [192.168.178.27] ([79.250.165.107]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MddBI-1WzgKR3Trg-00PKL7; Thu, 21 Aug 2014 20:30:39
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
X-Provags-ID: V03:K0:PMSXTtFoO/ebDHCVpar0HXoBfMufh5G2WnrDxRN/bPAxFYoHz7Z
 SR8NxQQafaUyoLkyAp3QF9ABDIOULjwhnIan5tnYb4Xnmz5R4uxc6gNb7MhzqclYA/3DZNU
 yceUaM/rcZho27t3tSre7Ent18MwoON29/dWtgBcnrtHDPpJkAPaYywtYBELA10U0kKbThy
 Nx/+V+Ev32wL5NKGer6Jw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255628>

Similar to 16445242 (fetch-pack: avoid quadratic list insertion in
mark_complete), sort only after all refs are collected instead of while
inserting.  The result is the same, but it's more efficient that way.
The difference will only be measurable in repositories with a large
number of refs.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 sha1_name.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sha1_name.c b/sha1_name.c
index 63ee66f..7098b10 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -839,7 +839,7 @@ static int handle_one_ref(const char *path,
 	}
 	if (object->type != OBJ_COMMIT)
 		return 0;
-	commit_list_insert_by_date((struct commit *)object, list);
+	commit_list_insert((struct commit *)object, list);
 	return 0;
 }
 
@@ -1366,6 +1366,7 @@ static int get_sha1_with_context_1(const char *name,
 		if (!only_to_die && namelen > 2 && name[1] == '/') {
 			struct commit_list *list = NULL;
 			for_each_ref(handle_one_ref, &list);
+			commit_list_sort_by_date(&list);
 			return get_sha1_oneline(name + 2, sha1, list);
 		}
 		if (namelen < 3 ||
-- 
2.1.0
