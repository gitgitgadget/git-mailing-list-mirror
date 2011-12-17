From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 3/3] submodule: use diff_tree_combined_merge() instead of
 diff_tree_combined()
Date: Sat, 17 Dec 2011 11:27:19 +0100
Message-ID: <4EEC6E87.3060204@lsrfire.ath.cx>
References: <4EEC6BD4.4040302@lsrfire.ath.cx> <4EEC6CD7.2030408@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?=C6var_Arnfj=F6?= =?ISO-8859-15?Q?r=F0_Bjarmason?= 
	<avarab@gmail.com>, Jens Lehmann <Jens.Lehmann@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 17 11:27:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbrUT-0004cB-PR
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 11:27:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751858Ab1LQK10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Dec 2011 05:27:26 -0500
Received: from india601.server4you.de ([85.25.151.105]:40072 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746Ab1LQK1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 05:27:25 -0500
Received: from [192.168.2.105] (p579BE8BE.dip.t-dialin.net [87.155.232.190])
	by india601.server4you.de (Postfix) with ESMTPSA id 1F5C82F8038;
	Sat, 17 Dec 2011 11:27:24 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <4EEC6CD7.2030408@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187370>

Use diff_tree_combined_merge() instead of open-coding it.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 submodule.c |   14 +++-----------
 1 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/submodule.c b/submodule.c
index 788d532..9a28060 100644
--- a/submodule.c
+++ b/submodule.c
@@ -371,23 +371,15 @@ static void collect_submodules_from_diff(struct diff_queue_struct *q,
 }
 
 
-static void commit_need_pushing(struct commit *commit, struct commit_list *parent, int *needs_pushing)
+static void commit_need_pushing(struct commit *commit, int *needs_pushing)
 {
-	struct sha1_array parents = SHA1_ARRAY_INIT;
 	struct rev_info rev;
 
-	while (parent) {
-		sha1_array_append(&parents, parent->item->object.sha1);
-		parent = parent->next;
-	}
-
 	init_revisions(&rev, NULL);
 	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = collect_submodules_from_diff;
 	rev.diffopt.format_callback_data = needs_pushing;
-	diff_tree_combined(commit->object.sha1, &parents, 1, &rev);
-
-	sha1_array_clear(&parents);
+	diff_tree_combined_merge(commit, 1, &rev);
 }
 
 int check_submodule_needs_pushing(unsigned char new_sha1[20], const char *remotes_name)
@@ -410,7 +402,7 @@ int check_submodule_needs_pushing(unsigned char new_sha1[20], const char *remote
 		die("revision walk setup failed");
 
 	while ((commit = get_revision(&rev)) && !needs_pushing)
-		commit_need_pushing(commit, commit->parents, &needs_pushing);
+		commit_need_pushing(commit, &needs_pushing);
 
 	free(sha1_copy);
 	strbuf_release(&remotes_arg);
-- 
1.7.8
