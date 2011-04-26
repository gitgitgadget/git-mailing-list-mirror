From: Jonas Gehring <jonas.gehring@boolsoft.org>
Subject: [PATCH/RFC] Implemented return value for rev-list --quiet
Date: Wed, 27 Apr 2011 00:36:37 +0200
Message-ID: <4DB748F5.4050300@boolsoft.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 00:40:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEqvd-00005Y-40
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 00:40:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136Ab1DZWkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 18:40:06 -0400
Received: from smtprelay06.ispgateway.de ([80.67.31.104]:49361 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208Ab1DZWkF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 18:40:05 -0400
X-Greylist: delayed 335 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Apr 2011 18:40:05 EDT
Received: from [109.193.12.52] (helo=[192.168.10.4])
	by smtprelay06.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <jonas.gehring@boolsoft.org>)
	id 1QEqpu-0003Me-0c; Wed, 27 Apr 2011 00:34:26 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110307 Lanikai/3.1.9
X-Enigmail-Version: 1.1.2
X-Df-Sender: jonas.gehring@boolsoft.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172132>

If --quiet is given, the program will return non-zero if the traversed
commit set was empty. This way, rev-list can be used to check commit
ancestry as described by the documentation for --quiet.

"Non-zero" is implemented as 1 in order to avoid confusion with the
usual 128 for die_builtin().

Signed-off-by: Jonas Gehring <jonas.gehring@boolsoft.org>
---
 builtin/rev-list.c        |    8 ++++++++
 revision.h                |    1 +
 t/t6041-rev-list-quiet.sh |   27 +++++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 0 deletions(-)
 create mode 100755 t/t6041-rev-list-quiet.sh

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 9bfb942..001d6af 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -157,12 +157,17 @@ static void show_commit(struct commit *commit, void *data)
 
 static void finish_commit(struct commit *commit, void *data)
 {
+	struct rev_list_info *info = data;
+	struct rev_info *revs = info->revs;
+
 	if (commit->parents) {
 		free_commit_list(commit->parents);
 		commit->parents = NULL;
 	}
 	free(commit->buffer);
 	commit->buffer = NULL;
+
+	revs->count_finished++;
 }
 
 static void finish_object(struct object *obj, const struct name_path *path, const char *name)
@@ -412,5 +417,8 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			printf("%d\n", revs.count_left + revs.count_right);
 	}
 
+	if (quiet)
+		/* Return non-zero if no commits have been traversed. */
+		return (revs.count_finished == 0 ? 1 : 0);
 	return 0;
 }
diff --git a/revision.h b/revision.h
index 9fd8f30..ddc35d2 100644
--- a/revision.h
+++ b/revision.h
@@ -141,6 +141,7 @@ struct rev_info {
 	/* commit counts */
 	int count_left;
 	int count_right;
+	int count_finished;
 };
 
 #define REV_TREE_SAME		0
diff --git a/t/t6041-rev-list-quiet.sh b/t/t6041-rev-list-quiet.sh
new file mode 100755
index 0000000..6cb9120
--- /dev/null
+++ b/t/t6041-rev-list-quiet.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+
+test_description='Non-zero return value for empty commit sets and --quiet'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo >fileA fileA
+	git add fileA
+	git commit -a -m "Initial"
+	echo >fileA fileA modified
+	git commit -a -m "fileA modified"
+'
+
+test_expect_success 'not quiet' '
+	test $(git rev-list master | wc -l) = 2 &&
+	test $(git rev-list master..master^ | wc -l) = 0 &&
+	test $(git rev-list master^..master | wc -l) = 1
+'
+
+test_expect_success '--quiet' '
+	test $(git rev-list --quiet master; echo $?) = 0 &&
+	test $(git rev-list --quiet master..master^; echo $?) != 0 &&
+	test $(git rev-list --quiet master^..master; echo $?) = 0
+'
+
+test_done
-- 
1.7.4.4
