Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 852D2209A9
	for <e@80x24.org>; Wed, 19 Oct 2016 04:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752948AbcJSEYK (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 00:24:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65287 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751292AbcJSEYG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 00:24:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 594C147E32;
        Wed, 19 Oct 2016 00:24:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=sSFS
        sQg7Ur8iFrKE4hY+BpF9iB0=; b=cn6HRmqqGBljj9pxX6TLy29QFV4RyAdmWPGV
        n9EO54zoNAJR3SIlKFKZDtNG0h5bf0ao++7GENC2mcawdsw7aTJlAm6JdE9SmW1h
        YPm58crHCdjsTvp3dVnNjK7phkPQuB6r7//tVLMjnZG5UF9gGI2v8xJxtLORWotJ
        BSvnBXU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references; q=dns; s=sasl; b=STaAxk
        Ao3Jc6zSy7E+lA7gqf4XtElCPH4ceTNcw1InUDFFNP151VDi/5XICdT0KbTCQdSC
        Zeqr+iua7s8Kcfpe98MEy9YynCOk6hGE+vN6Ik+zsR2jOAz4uPUQ87hsNNHxCyDA
        8OkD9JmWJzM5wtSA2Zfc6UQYxvgbtZufmmZ/c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5175747E31;
        Wed, 19 Oct 2016 00:24:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AACB947E30;
        Wed, 19 Oct 2016 00:24:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 7/7] merge: allow to use only the fp-only merge bases
Date:   Tue, 18 Oct 2016 21:23:45 -0700
Message-Id: <20161019042345.29766-8-gitster@pobox.com>
X-Mailer: git-send-email 2.10.1-631-gb2c64dcf30
In-Reply-To: <20161019042345.29766-1-gitster@pobox.com>
References: <xmqqmvi2sj8f.fsf@gitster.mtv.corp.google.com>
 <20161019042345.29766-1-gitster@pobox.com>
X-Pobox-Relay-ID: DE920864-95B3-11E6-9E15-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach "git merge" a new option "--fp-base-only" that tells it to
consider only merge bases that are on the first-parent chain.

This speeds up back-merges needed in the topic branch workflow.  The
merge of 'master' back into 'next' used as an example in the RFD
article <xmqqmvi2sj8f.fsf@gitster.mtv.corp.google.com>, i.e.

    git checkout 4868def05e && git merge 659889482a

in our history takes about 1.22-1.33 seconds without the series,
while running the latter "git merge" with the "--fp-base-only"
option takes about 0.54-0.59 seconds.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/merge-options.txt |  9 +++++++++
 builtin/merge.c                 | 15 ++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 5b4a62e936..7927f069e4 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -116,6 +116,15 @@ ifndef::git-pull[]
 	Note that not all merge strategies may support progress
 	reporting.
 
+--fp-base-only::
+	Instead of using all merge bases when computing the
+	three-way merge result, use only the merge bases on the
+	first-parent chain of the commits being merged.  This
+	experimental feature is meant to be used when merging an
+	older integration branch back to a newer integration branch
+	in the topic-branch workflow.
+
+
 endif::git-pull[]
 
 --allow-unrelated-histories::
diff --git a/builtin/merge.c b/builtin/merge.c
index 0ae099f746..a38b878e61 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -88,6 +88,8 @@ enum ff_type {
 
 static enum ff_type fast_forward = FF_ALLOW;
 
+static int fp_base_only;
+
 static int option_parse_message(const struct option *opt,
 				const char *arg, int unset)
 {
@@ -210,6 +212,8 @@ static struct option builtin_merge_options[] = {
 	{ OPTION_SET_INT, 0, "ff-only", &fast_forward, NULL,
 		N_("abort if fast-forward is not possible"),
 		PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, FF_ONLY },
+	OPT_BOOL(0, "fp-base-only", &fp_base_only,
+		 N_("use only merge bases on first-parent chain")),
 	OPT_RERERE_AUTOUPDATE(&allow_rerere_auto),
 	OPT_BOOL(0, "verify-signatures", &verify_signatures,
 		N_("verify that the named commit has a valid GPG signature")),
@@ -1340,9 +1344,14 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 	if (!remoteheads)
 		; /* already up-to-date */
-	else if (!remoteheads->next)
-		common = get_merge_bases(head_commit, remoteheads->item);
-	else {
+	else if (!remoteheads->next) {
+		unsigned flags = MB_POSTCLEAN;
+		if (fp_base_only)
+			flags |= MB_FPCHAIN;
+		common = get_merge_bases_opt(head_commit,
+					     1, &remoteheads->item,
+					     flags);
+	} else {
 		struct commit_list *list = remoteheads;
 		commit_list_insert(head_commit, &list);
 		common = get_octopus_merge_bases(list);
-- 
2.10.1-631-gb2c64dcf30

