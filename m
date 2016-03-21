From: Junio C Hamano <gitster@pobox.com>
Subject: merge: fix NULL pointer dereference when merging nothing into void
Date: Mon, 21 Mar 2016 12:01:43 -0700
Message-ID: <xmqq7fgvmz8o.fsf_-_@gitster.mtv.corp.google.com>
References: <CAPig+cRVtzLjKTW7FZ-h8thEXkTqBJtbSwpKJs3+wdRHYV1qrQ@mail.gmail.com>
	<1458519102-32621-1-git-send-email-joseivan@lavid.ufpb.br>
Mime-Version: 1.0
Content-Type: text/plain
Cc: sunshine@sunshineco.com, git@vger.kernel.org
To: "Jose Ivan B. Vilarouca Filho" <joseivan@lavid.ufpb.br>
X-From: git-owner@vger.kernel.org Mon Mar 21 20:19:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai5MA-0001CY-0I
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 20:19:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757613AbcCUTSx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 15:18:53 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:60848 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757562AbcCUTSt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 15:18:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0396A4D986;
	Mon, 21 Mar 2016 15:01:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u5AZJ8Y6iwvTuflNBCF3hYwCzjQ=; b=SIHjj5
	BXqhk+f7wDmudeTxZSLyrFj+EDzRHMVxIBar/3EpWWREMbuq5Mzs8KqHsXgqbR0e
	KeQUarTzTqADTbtoBzLsRh7trM459XTDtGL56CwVlNSozoFbqNqZJY98NmI/dsy9
	IKNxZ64vFyn13CvapNyd7Lpy8nfetiHjzTRM4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CywllASZ57v/JS5gJmoIm4RsegJgmQ4Z
	9rLsS3EaN8t26GklwVRb+d6in+UXlLpobKiioFKI62AlEAbJmt86kL62s53ssTmz
	PBddoL4N6rEfoCv+EDGwSAACvK+W4cYMr2sA3LhlVcHtDjaLZHQVzNfpBxh3AkF8
	/LgyeU6qsPU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EE1214D985;
	Mon, 21 Mar 2016 15:01:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5ABE64D982;
	Mon, 21 Mar 2016 15:01:45 -0400 (EDT)
In-Reply-To: <1458519102-32621-1-git-send-email-joseivan@lavid.ufpb.br> (Jose
	Ivan B. Vilarouca Filho's message of "Sun, 20 Mar 2016 20:11:42
	-0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5B33A242-EF97-11E5-8A70-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289437>

When we are on an unborn branch and merging only one foreign parent,
we allow "git merge" to fast-forward to that foreign parent commit.

This codepath incorrectly attempted to dereference the list of
parents that the merge is going to record even when the list is
empty.  It must refuse to operate instead when there is no parent.

All other codepaths make sure the list is not empty before they
dereference it, and are safe.

Reported by Jose Ivan B. Vilarouca Filho
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * So here is what I came up with as a suggestion.  The original
   check to see if remote_head is empty is simply bogus (an empty
   list would to have a single element whose item is NULL), so I
   rewrote it to clarify what is going on in this codepath.

 builtin/merge.c  | 10 +++++-----
 t/t7600-merge.sh | 10 ++++++++++
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 101ffef..bf2f261 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1257,12 +1257,12 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			builtin_merge_options);
 
 	if (!head_commit) {
-		struct commit *remote_head;
 		/*
 		 * If the merged head is a valid one there is no reason
 		 * to forbid "git merge" into a branch yet to be born.
 		 * We do the same for "git pull".
 		 */
+		unsigned char *remote_head_sha1;
 		if (squash)
 			die(_("Squash commit into empty head not supported yet"));
 		if (fast_forward == FF_NO)
@@ -1270,13 +1270,13 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			    "an empty head"));
 		remoteheads = collect_parents(head_commit, &head_subsumed,
 					      argc, argv, NULL);
-		remote_head = remoteheads->item;
-		if (!remote_head)
+		if (!remoteheads)
 			die(_("%s - not something we can merge"), argv[0]);
 		if (remoteheads->next)
 			die(_("Can merge only exactly one commit into empty head"));
-		read_empty(remote_head->object.oid.hash, 0);
-		update_ref("initial pull", "HEAD", remote_head->object.oid.hash,
+		remote_head_sha1 = remoteheads->item->object.oid.hash;
+		read_empty(remote_head_sha1, 0);
+		update_ref("initial pull", "HEAD", remote_head_sha1,
 			   NULL, 0, UPDATE_REFS_DIE_ON_ERR);
 		goto done;
 	}
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 302e238..9d7952f 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -725,4 +725,14 @@ test_expect_success 'merge detects mod-256 conflicts (resolve)' '
 	test_must_fail git merge -s resolve master
 '
 
+test_expect_success 'merge nothing into void' '
+	git init void &&
+	(
+		cd void &&
+		git remote add up .. &&
+		git fetch up &&
+		test_must_fail git merge FETCH_HEAD
+	)
+'
+
 test_done
