From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/6] log: pass rev_info to git_log_config()
Date: Wed,  3 Oct 2012 18:33:38 -0700
Message-ID: <1349314419-8397-6-git-send-email-gitster@pobox.com>
References: <7v626r48cv.fsf@alter.siamese.dyndns.org>
 <1349314419-8397-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 00:06:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtN2-0001DP-C0
	for gcvg-git-2@plane.gmane.org; Thu, 04 Oct 2012 23:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755382Ab2JDBd4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 21:33:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52932 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755143Ab2JDBdw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 21:33:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F240807C
	for <git@vger.kernel.org>; Wed,  3 Oct 2012 21:33:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=inGo
	aO5JuVyYQD/pPmGzbzpgRzo=; b=htXLcpiyfd4qHAolUHO763dHkMrAHW927PIy
	GCkKVcGal346ShGfstfPK1u+T59RXR5948n6XAPSmorwiHXV+sZSx/SBHd/YhF1Z
	+gp+Y9P8E02OhTNiRy7TkG32XUAT8a91Lum9gz/khvP3Yc7uh4pqBO8N+SJTFQzc
	YjCtqpk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=LpR9Tr
	uGPU7w3Ce6+gQdOifHDFxd/Bmy5wnwlfEBU/D/4cjwsPt+ONUECdtliJK1NgTfuw
	Jm2rlT5sjOrgOkrI3I4mEiSCjfr+Btjw3KdD6zFQvNsvvD/D8LlrfUw3tZvraQ9P
	JOtrXClLE2qyzqenzKSufz1a9OFsnrmBX458k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D3E1807B
	for <git@vger.kernel.org>; Wed,  3 Oct 2012 21:33:52 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6AFB98070 for
 <git@vger.kernel.org>; Wed,  3 Oct 2012 21:33:50 -0400 (EDT)
X-Mailer: git-send-email 1.8.0.rc0.57.g712528f
In-Reply-To: <1349314419-8397-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 8CACA9E0-0DC3-11E2-B1FE-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206963>

Call init_revisions() first to prepare the revision traversal
parameters and pass it to git_log_config(), so that necessary bits
in the traversal parameters can be tweaked before we call the
command line parsing infrastructure setup_revisions() from
the cmd_log_init_finish() function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is made separate from the next one that touches the contents
   of "rev" to make sure the existing code does not depend on the
   current initialization order.  I do not think it does but better
   be careful to keep the history easier to bisect, than be sorry
   when an issue does appear.

 builtin/log.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 09cf43e..07a0078 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -360,9 +360,8 @@ int cmd_whatchanged(int argc, const char **argv, const char *prefix)
 	struct rev_info rev;
 	struct setup_revision_opt opt;
 
-	git_config(git_log_config, NULL);
-
 	init_revisions(&rev, prefix);
+	git_config(git_log_config, &rev);
 	rev.diff = 1;
 	rev.simplify_history = 0;
 	memset(&opt, 0, sizeof(opt));
@@ -450,10 +449,9 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 	struct pathspec match_all;
 	int i, count, ret = 0;
 
-	git_config(git_log_config, NULL);
-
 	init_pathspec(&match_all, NULL);
 	init_revisions(&rev, prefix);
+	git_config(git_log_config, &rev);
 	rev.diff = 1;
 	rev.always_show_header = 1;
 	rev.no_walk = REVISION_WALK_NO_WALK_SORTED;
@@ -530,9 +528,8 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
 	struct rev_info rev;
 	struct setup_revision_opt opt;
 
-	git_config(git_log_config, NULL);
-
 	init_revisions(&rev, prefix);
+	git_config(git_log_config, &rev);
 	init_reflog_walk(&rev.reflog_info);
 	rev.verbose_header = 1;
 	memset(&opt, 0, sizeof(opt));
@@ -552,9 +549,8 @@ int cmd_log(int argc, const char **argv, const char *prefix)
 	struct rev_info rev;
 	struct setup_revision_opt opt;
 
-	git_config(git_log_config, NULL);
-
 	init_revisions(&rev, prefix);
+	git_config(git_log_config, &rev);
 	rev.always_show_header = 1;
 	memset(&opt, 0, sizeof(opt));
 	opt.def = "HEAD";
@@ -1121,8 +1117,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	extra_hdr.strdup_strings = 1;
 	extra_to.strdup_strings = 1;
 	extra_cc.strdup_strings = 1;
-	git_config(git_format_config, NULL);
 	init_revisions(&rev, prefix);
+	git_config(git_format_config, &rev);
 	rev.commit_format = CMIT_FMT_EMAIL;
 	rev.verbose_header = 1;
 	rev.diff = 1;
-- 
1.8.0.rc0.57.g712528f
