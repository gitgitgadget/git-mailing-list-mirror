From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] reflog: ignore expire-unreachable for "HEAD" reflog
Date: Wed, 14 Apr 2010 13:35:45 -0700
Message-ID: <7vfx2xpyam.fsf@alter.siamese.dyndns.org>
References: <7vljcppycc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 14 22:36:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O29Jp-0001Hy-M4
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 22:36:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756693Ab0DNUfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 16:35:51 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59478 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756691Ab0DNUft (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 16:35:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 630EFAA2E6;
	Wed, 14 Apr 2010 16:35:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s6uWkUJnCRNdhjuCg4CyC8XTVOs=; b=ZWDTCc
	NGz9Xm2v2dRZwzcA1q5LcsDrF6CmLszKZU5MdNOBqRJcwk8Q8xZdltofAxLKyK1q
	/ipmh13ZePiChRQIUH/ny97G3muCRGDavnlf28LPaU7HOzxjlSFHnPA77uNClesq
	qiJb86quFw11tRX3tm8UxOnxTBwpUXRetmhdY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kOjux2vVmlFqiF5szTBhhGW5kgS9ok3S
	EmmsepcpEEFTVDoP1gntIyJMOfj820UGjTe4rB7ivBaBAIWG3KUpfXR4MFJXeDdl
	8uk3exFZwuk2bvs/d8VX1/eu0cDaYWV84o2j1a/KJHIlxdt1d/veWbSX9wgkknI2
	DXxhKrF6TUM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 51105AA2E1;
	Wed, 14 Apr 2010 16:35:48 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 949C6AA2DF; Wed, 14 Apr
 2010 16:35:46 -0400 (EDT)
In-Reply-To: <7vljcppycc.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 14 Apr 2010 13\:34\:43 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4F12339C-4805-11DF-89BD-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144908>

"git reflog expire" (and "git gc") examines the reflog entries and
discards old/stale ones using two criteria.  The entries that are older
than "reflogexpire" (defaults to 90 days) are unconditionally removed, and
the entries that are older than "reflogexpireunreachable" (defaults to 30
days) are removed if the entry point at commits that are not reachable
from the value of the ref.

This is reasonable for local branches, remote tracking branches and tags.
You (or other people) may have failed experiments that have been made and
then later discarded by resetting the tip of the branch back, and setting
the value of "reflogexpireunreachable" shorter than that of "reflogexpire"
will prune the entries that describe these failed experiments earlier than
the entries that describe the steps that led to the current history.

It however doesn't make much sense for "HEAD" reflog.  When you switch
between branches, it is normal that the tip of the branch you were on is
not an ancestor of the branch you have switched to.  Expiring the entries
that describe what you did while on the previous branch earlier than usual
does not help.

The test t7701 relied on this incorrect behaviour of entries being pruned
from the "HEAD" reflog.  Work it around by setting the "HEAD" reflog
entries to be expired immediately.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-reflog.c                     |   35 ++++++++++++++++++++++++---------
 t/t7701-repack-unpack-unreachable.sh |    1 +
 2 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/builtin-reflog.c b/builtin-reflog.c
index 9792090..c4bc5be 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -34,8 +34,11 @@ struct cmd_reflog_expire_cb {
 
 struct expire_reflog_cb {
 	FILE *newlog;
-	const char *ref;
-	struct commit *ref_commit;
+	enum {
+		UE_NORMAL,
+		UE_ALWAYS,
+		UE_NEVER
+	} unreachable_expire_kind;
 	struct commit_list *mark_list;
 	unsigned long mark_limit;
 	struct cmd_reflog_expire_cb *cmd;
@@ -304,8 +307,9 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 	    (!keep_entry(&old, osha1) || !keep_entry(&new, nsha1)))
 		goto prune;
 
-	if (timestamp < cb->cmd->expire_unreachable) {
-		if (!cb->ref_commit)
+	if ((cb->unreachable_expire_kind != UE_NEVER) &&
+	    (timestamp < cb->cmd->expire_unreachable)) {
+		if (cb->unreachable_expire_kind == UE_ALWAYS)
 			goto prune;
 		if (unreachable(cb, old, osha1) || unreachable(cb, new, nsha1))
 			goto prune;
@@ -338,6 +342,7 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 	struct expire_reflog_cb cb;
 	struct ref_lock *lock;
 	char *log_file, *newlog_path = NULL;
+	struct commit *tip_commit;
 	int status = 0;
 
 	memset(&cb, 0, sizeof(cb));
@@ -357,18 +362,28 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 		cb.newlog = fopen(newlog_path, "w");
 	}
 
-	cb.ref_commit = lookup_commit_reference_gently(sha1, 1);
-	cb.ref = ref;
 	cb.cmd = cmd;
-	if (cb.ref_commit) {
+
+	if (!cmd->expire_unreachable || !strcmp(ref, "HEAD")) {
+		tip_commit = NULL;
+		cb.unreachable_expire_kind = UE_NEVER;
+	} else {
+		tip_commit = lookup_commit_reference_gently(sha1, 1);
+		if (!tip_commit)
+			cb.unreachable_expire_kind = UE_ALWAYS;
+		else
+			cb.unreachable_expire_kind = UE_NORMAL;
+	}
+
+	if (cb.unreachable_expire_kind == UE_NORMAL) {
 		cb.mark_list = NULL;
-		commit_list_insert(cb.ref_commit, &cb.mark_list);
+		commit_list_insert(tip_commit, &cb.mark_list);
 		cb.mark_limit = cmd->expire_total;
 		mark_reachable(&cb);
 	}
 	for_each_reflog_ent(ref, expire_reflog_ent, &cb);
-	if (cb.ref_commit)
-		clear_commit_marks(cb.ref_commit, REACHABLE);
+	if (cb.unreachable_expire_kind == UE_NORMAL)
+		clear_commit_marks(tip_commit, REACHABLE);
  finish:
 	if (cb.newlog) {
 		if (fclose(cb.newlog)) {
diff --git a/t/t7701-repack-unpack-unreachable.sh b/t/t7701-repack-unpack-unreachable.sh
index 5babdf2..e14b110 100755
--- a/t/t7701-repack-unpack-unreachable.sh
+++ b/t/t7701-repack-unpack-unreachable.sh
@@ -9,6 +9,7 @@ csha1=
 tsha1=
 
 test_expect_success '-A with -d option leaves unreachable objects unpacked' '
+	git config gc.HEAD.reflogexpire now &&
 	echo content > file1 &&
 	git add . &&
 	git commit -m initial_commit &&
-- 
1.7.1.rc1.252.gce30c
