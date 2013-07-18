From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/6] diff: preparse --diff-filter string argument
Date: Wed, 17 Jul 2013 17:30:03 -0700
Message-ID: <1374107406-14357-4-git-send-email-gitster@pobox.com>
References: <7vvc496ruf.fsf@alter.siamese.dyndns.org>
 <1374107406-14357-1-git-send-email-gitster@pobox.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 18 02:30:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uzc7B-0006fN-QM
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 02:30:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934453Ab3GRAaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 20:30:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33282 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933696Ab3GRAaR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 20:30:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC64320AAD;
	Thu, 18 Jul 2013 00:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=SXke
	NpMFIWUnsPwayW8L0K9z6U0=; b=ZZNcylR2DtfrY5Kqafhaxe+NImRe/ldesZCk
	GDZMZy6jkQlMr35Vq2sWi4abCSS6khJRZlbSuRwlnF+jMVeoW1g23vqJsTRbP3K1
	7Mi4qfuvV+xb54VxJJnLhpY534IT3EppgHEVycNJ7v8ZuA46qwBTmBo7epV0Mylh
	aYodOeA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	kra1hByL1APrjRvkGhxQz7OuKnF3mY2FeOK2nqoXbPSFF4laLWraeBmfsjVkEz1f
	iH5/OTVVIp+vxS23887yOIsPe8/dvHs+V1YYnKG7AnI/oaa3Urr/Me1cLf+/Eige
	CGaTKepoLVWAVsYAgqDtpf1aLnIESG13f9nerOMscKQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C023320AAC;
	Thu, 18 Jul 2013 00:30:16 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E05BD20AAA;
	Thu, 18 Jul 2013 00:30:15 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.3-962-gf04df43
In-Reply-To: <1374107406-14357-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 3799C8D8-EF41-11E2-AFE4-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230670>

Instead of running strchr() on the list of status characters over
and over again, parse the --diff-filter option into bitfields and
use the bits to see if the change to the filepair matches the status
requested.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 diff.h |  5 ++++-
 2 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 0220c19..03f10e6 100644
--- a/diff.c
+++ b/diff.c
@@ -3496,6 +3496,53 @@ static int parse_submodule_opt(struct diff_options *options, const char *value)
 	return 1;
 }
 
+static const char diff_status_letters[] = {
+	DIFF_STATUS_ADDED,
+	DIFF_STATUS_COPIED,
+	DIFF_STATUS_DELETED,
+	DIFF_STATUS_MODIFIED,
+	DIFF_STATUS_RENAMED,
+	DIFF_STATUS_TYPE_CHANGED,
+	DIFF_STATUS_UNKNOWN,
+	DIFF_STATUS_UNMERGED,
+	DIFF_STATUS_FILTER_AON,
+	DIFF_STATUS_FILTER_BROKEN,
+	'\0',
+};
+
+static unsigned int filter_bit['Z' + 1];
+
+static void prepare_filter_bits(void)
+{
+	int i;
+
+	if (!filter_bit[DIFF_STATUS_ADDED]) {
+		for (i = 0; diff_status_letters[i]; i++)
+			filter_bit[(int) diff_status_letters[i]] = (1 << i);
+	}
+}
+
+static unsigned filter_bit_tst(char status, const struct diff_options *opt)
+{
+	return opt->filter & filter_bit[(int) status];
+}
+
+static int parse_diff_filter_opt(const char *optarg, struct diff_options *opt)
+{
+	int i, optch;
+
+	prepare_filter_bits();
+	for (i = 0; (optch = optarg[i]) != '\0'; i++) {
+		unsigned int bit;
+
+		bit = (0 <= optch && optch <= 'Z') ? filter_bit[optch] : 0;
+		if (!bit)
+			continue; /* ignore unknown ones, like we always have */
+		opt->filter |= bit;
+	}
+	return 0;
+}
+
 int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 {
 	const char *arg = av[0];
@@ -3717,7 +3764,10 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		return argcount;
 	}
 	else if ((argcount = parse_long_opt("diff-filter", av, &optarg))) {
-		options->filter = optarg;
+		int offending = parse_diff_filter_opt(optarg, options);
+		if (offending)
+			die("unknown change class '%c' in --diff-filter=%s",
+			    offending, optarg);
 		return argcount;
 	}
 	else if (!strcmp(arg, "--abbrev"))
@@ -4513,11 +4563,11 @@ static int match_filter(const struct diff_options *options, const struct diff_fi
 {
 	return (((p->status == DIFF_STATUS_MODIFIED) &&
 		 ((p->score &&
-		   strchr(options->filter, DIFF_STATUS_FILTER_BROKEN)) ||
+		   filter_bit_tst(DIFF_STATUS_FILTER_BROKEN, options)) ||
 		  (!p->score &&
-		   strchr(options->filter, DIFF_STATUS_MODIFIED)))) ||
+		   filter_bit_tst(DIFF_STATUS_MODIFIED, options)))) ||
 		((p->status != DIFF_STATUS_MODIFIED) &&
-		 strchr(options->filter, p->status)));
+		 filter_bit_tst(p->status, options)));
 }
 
 static void diffcore_apply_filter(struct diff_options *options)
@@ -4525,14 +4575,13 @@ static void diffcore_apply_filter(struct diff_options *options)
 	int i;
 	struct diff_queue_struct *q = &diff_queued_diff;
 	struct diff_queue_struct outq;
-	const char *filter = options->filter;
 
 	DIFF_QUEUE_CLEAR(&outq);
 
-	if (!filter)
+	if (!options->filter)
 		return;
 
-	if (strchr(filter, DIFF_STATUS_FILTER_AON)) {
+	if (filter_bit_tst(DIFF_STATUS_FILTER_AON, options)) {
 		int found;
 		for (i = found = 0; !found && i < q->nr; i++) {
 			if (match_filter(options, q->queue[i]))
diff --git a/diff.h b/diff.h
index 78b4091..a367207 100644
--- a/diff.h
+++ b/diff.h
@@ -103,12 +103,15 @@ enum diff_words_type {
 };
 
 struct diff_options {
-	const char *filter;
 	const char *orderfile;
 	const char *pickaxe;
 	const char *single_follow;
 	const char *a_prefix, *b_prefix;
 	unsigned flags;
+
+	/* diff-filter bits */
+	unsigned int filter;
+
 	int use_color;
 	int context;
 	int interhunkcontext;
-- 
1.8.3.3-962-gf04df43
