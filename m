From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 5/6] fetch/pull: Don't recurse into a submodule when commits
 are already present
Date: Wed, 23 Feb 2011 21:36:23 +0100
Message-ID: <4D656FC7.2060201@web.de>
References: <4D656F25.5090007@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Kevin Ballard <kevin@sb.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 23 21:36:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsLRq-000807-Rh
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 21:36:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932600Ab1BWUgZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 15:36:25 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:33157 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755780Ab1BWUgY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 15:36:24 -0500
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate01.web.de (Postfix) with ESMTP id DF393189C4F7B;
	Wed, 23 Feb 2011 21:36:23 +0100 (CET)
Received: from [93.240.119.189] (helo=[192.168.178.43])
	by smtp01.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PsLRf-0008VY-00; Wed, 23 Feb 2011 21:36:23 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <4D656F25.5090007@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18Tg58dZ6M2HoxXWIx3H1V3+jxW5/lSSAe0cYAc
	z+oZMrN0ochrs3Oj/U/dGie9bX5MFge1sknFXFLzOyz8wCeDVM
	BiDiMij17vuAWGmNM4Tg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167726>

When looking for submodules where new commits have been recorded in the
superproject ignore those cases where the submodules commits are already
present locally. This can happen e.g. when the submodule has been rewound
to an earlier state. Then there is no need to fetch the submodule again
as the commit recorded in the newly fetched superproject commit has
already been fetched earlier into the submodule.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 submodule.c                 |    9 ++++++++-
 t/t5526-fetch-submodules.sh |   19 +++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/submodule.c b/submodule.c
index b477c3c..ddb0a29 100644
--- a/submodule.c
+++ b/submodule.c
@@ -263,6 +263,13 @@ void set_config_fetch_recurse_submodules(int value)
 	config_fetch_recurse_submodules = value;
 }

+static int is_submodule_commit_present(const char *path, unsigned char sha1[20])
+{
+	if (!add_submodule_odb(path))
+		return lookup_commit_reference(sha1) != 0;
+	return 0;
+}
+
 static void submodule_collect_changed_cb(struct diff_queue_struct *q,
 					 struct diff_options *options,
 					 void *data)
@@ -280,7 +287,7 @@ static void submodule_collect_changed_cb(struct diff_queue_struct *q,
 			 * being moved around. */
 			struct string_list_item *path;
 			path = unsorted_string_list_lookup(&changed_submodule_paths, p->two->path);
-			if (!path)
+			if (!path && !is_submodule_commit_present(p->two->path, p->two->sha1))
 				string_list_append(&changed_submodule_paths, xstrdup(p->two->path));
 		} else {
 			/* Submodule is new or was moved here */
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 09701aa..3decfae 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -428,4 +428,23 @@ test_expect_success "'submodule.<sub>.fetchRecurseSubmodules=on-demand' override
 	test_cmp expect.err.2 actual.err
 '

+test_expect_success "don't fetch submodule when newly recorded commits are already present" '
+	(
+		cd submodule &&
+		git checkout -q HEAD^^
+	) &&
+	head1=$(git rev-parse --short HEAD) &&
+	git add submodule &&
+	git commit -m "submodule rewound" &&
+	head2=$(git rev-parse --short HEAD) &&
+	echo "From $pwd/." > expect.err &&
+	echo "   $head1..$head2  master     -> origin/master" >> expect.err &&
+	(
+		cd downstream &&
+		git fetch >../actual.out 2>../actual.err
+	) &&
+	! test -s actual.out &&
+	test_cmp expect.err actual.err
+'
+
 test_done
-- 
1.7.4.1.190.g13e20
