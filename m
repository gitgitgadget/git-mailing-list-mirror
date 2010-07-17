From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 1/2] fast-export: Fix dropping of files with --import-marks and path limiting
Date: Sat, 17 Jul 2010 11:00:50 -0600
Message-ID: <1279386051-31112-2-git-send-email-newren@gmail.com>
References: <1279386051-31112-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, srabbelier@gmail.com,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jul 17 18:59:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaAjd-0006Rh-NJ
	for gcvg-git-2@lo.gmane.org; Sat, 17 Jul 2010 18:59:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760065Ab0GQQ7X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jul 2010 12:59:23 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:38248 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760062Ab0GQQ7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jul 2010 12:59:16 -0400
Received: by mail-pv0-f174.google.com with SMTP id 7so1199705pvc.19
        for <git@vger.kernel.org>; Sat, 17 Jul 2010 09:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=I/C/pHwiRfTnulQmZumsscv4V3OlGKUp6UDi62IPUQI=;
        b=eRiRgS5azHj6uSmMer4RnUruhPJbpG/iKodO7IOK8HErEryxwATlw8X7uHRuwzoUfY
         tGanAw8DiA3ryxYRAaK00FfBrb699WGjN1OpF6PNKFOv7xAZXr/7AxrQALwAL3meenmt
         gcCv/ft2vIyQI4inZ1MfhP2u32IsazxoxzrNg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FugEIMEBdXI28CUPLvljmoxVzKyPX4YqcfgaMNt42/XlnpPpFAcCwkBZFmMWLIs/nJ
         82lLZfAKeywipCy26cwMxOga+EF/12EB1yvBMFEq6xgOTyyoExn0zhKAwhnXJs2dlqTG
         tP+jmzgPszzpnw1JfLh0I1oC/Q6/jXnfOwAK8=
Received: by 10.142.142.12 with SMTP id p12mr2654782wfd.300.1279385955928;
        Sat, 17 Jul 2010 09:59:15 -0700 (PDT)
Received: from localhost.localdomain (63-248-104-17.static.layl0101.digis.net [63.248.104.17])
        by mx.google.com with ESMTPS id r27sm14724374rvq.9.2010.07.17.09.59.14
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 17 Jul 2010 09:59:15 -0700 (PDT)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1279386051-31112-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151196>

Since fast-export operates by listing file changes since the (first) parent
commit, when using --import-marks and path limiting and using a wider list
of paths than in previous runs, files from the new path(s) will silently be
omitted from the result unless or until a commit which explicitly changes
those files.  The resulting repository in such cases is broken and makes no
sense.

This commit fixes this by having fast-export work with complete trees
instead of incremental changes (when both --import-marks and path limiting
are used).  It works by issuing a 'deleteall' directive with each commit and
then listing the full set of files that make up that commit, rather than
just showing the list of files that have changed since the (first) parent
commit.

Signed-off-by: Elijah Newren <newren@gmail.com>
Acked-by: Sverre Rabbelier <srabbelier@gmail.com>
---
 builtin/fast-export.c  |    9 ++++++++-
 t/t9350-fast-export.sh |    9 +++++++++
 2 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index c6dd71a..25d13a1 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -27,6 +27,7 @@ static enum { ABORT, VERBATIM, WARN, STRIP } signed_tag_mode = ABORT;
 static enum { ERROR, DROP, REWRITE } tag_of_filtered_mode = ABORT;
 static int fake_missing_tagger;
 static int no_data;
+static int full_tree = 0;
 
 static int parse_opt_signed_tag_mode(const struct option *opt,
 				     const char *arg, int unset)
@@ -241,7 +242,8 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
 		message += 2;
 
 	if (commit->parents &&
-	    get_object_mark(&commit->parents->item->object) != 0) {
+	    get_object_mark(&commit->parents->item->object) != 0 &&
+	    !full_tree) {
 		parse_commit(commit->parents->item);
 		diff_tree_sha1(commit->parents->item->tree->object.sha1,
 			       commit->tree->object.sha1, "", &rev->diffopt);
@@ -281,6 +283,8 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
 		i++;
 	}
 
+	if (full_tree)
+		printf("deleteall\n");
 	log_tree_diff_flush(rev);
 	rev->diffopt.output_format = saved_output_format;
 
@@ -608,6 +612,9 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	if (import_filename)
 		import_marks(import_filename);
 
+	if (import_filename && revs.prune_data)
+		full_tree = 1;
+
 	get_tags_and_duplicates(&revs.pending, &extra_refs);
 
 	if (prepare_revision_walk(&revs))
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index d43f37c..6069e1f 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -355,6 +355,15 @@ test_expect_failure 'no exact-ref revisions included' '
 	)
 '
 
+test_expect_success 'path limiting with import-marks does not lose unmodified files'        '
+	git checkout -b simple marks~2 &&
+	git fast-export --export-marks=marks simple -- file > /dev/null &&
+	echo more content >> file &&
+	test_tick &&
+	git commit -mnext file &&
+	git fast-export --import-marks=marks simple -- file file0 | grep file0
+'
+
 test_expect_success 'set-up a few more tags for tag export tests' '
 	git checkout -f master &&
 	HEAD_TREE=`git show -s --pretty=raw HEAD | grep tree | sed "s/tree //"` &&
-- 
1.6.6.1
