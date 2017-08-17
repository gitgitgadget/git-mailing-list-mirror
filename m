Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 625DD20899
	for <e@80x24.org>; Thu, 17 Aug 2017 17:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753149AbdHQR1c (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 13:27:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58956 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752536AbdHQR1b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 13:27:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CC761A712A;
        Thu, 17 Aug 2017 13:27:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=c
        i9uGtXu0W3tb6VX1/yi8MJpTZY=; b=qxyOTaxfADI/ODCgC8uqx6jVwzkY/exi2
        CVeWxmwy2XZrC2ST8Dgc2mB2b9EZFWVg+MyJBd9BcmbwBChAVM1tZ4lH+ykmCwHh
        LpUlgQSJM3L0T5rB2Znow02y1o0Dm8GyIK4BSx8BwuGtI3PxrZVnjXpCmpSZqIpX
        zev9P4q4X4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=Zfc
        k2osz1yHixN41Irf2nDUz2NCvuuAf/Y4y07i0eAOHhGly3jcVMrUlZEN0PvgkJQv
        c3BH3byHg5EHrxFa4NF5o5443dZk3Ugxnegil8lGnk4jNm2//YMdoa3POKGN/czn
        KPQQI8PpKL9ZFiKD1cR4nsynAb1y2/YatNchEK3s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BF4AFA7129;
        Thu, 17 Aug 2017 13:27:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2D8D4A7128;
        Thu, 17 Aug 2017 13:27:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] diff: retire sane_truncate_fn
Date:   Thu, 17 Aug 2017 10:27:28 -0700
Message-ID: <xmqq1soahzpb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 58C61F0C-8371-11E7-8176-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Long time ago, 23707811 ("diff: do not chomp hunk-header in the
middle of a character", 2008-01-02) introduced sane_truncate_line()
helper function to trim the "function header" line that is shown at
the end of the hunk header line, in order to avoid chomping it in
the middle of a single UTF-8 character.  It also added a facility to
define a custom callback function to make it possible to extend it
to non UTF-8 encodings.  

During the following 8 1/2 years, nobody found need for this custom
callback facility.

A custom callback function is a wrong design to use here anyway---if
your contents need support for non UTF-8 encoding, you shouldn't
have to write a custom function and recompile Git to plumb it in.  A
better approach would be to extend sane_truncate_line() function and
have a new member in emit_callback to conditionally trigger it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/diff.c b/diff.c
index a628ac3a95..4bdaed8197 100644
--- a/diff.c
+++ b/diff.c
@@ -408,8 +408,6 @@ static struct diff_tempfile {
 	struct tempfile tempfile;
 } diff_temp[2];
 
-typedef unsigned long (*sane_truncate_fn)(char *line, unsigned long len);
-
 struct emit_callback {
 	int color_diff;
 	unsigned ws_rule;
@@ -417,7 +415,6 @@ struct emit_callback {
 	int blank_at_eof_in_postimage;
 	int lno_in_preimage;
 	int lno_in_postimage;
-	sane_truncate_fn truncate;
 	const char **label_path;
 	struct diff_words_data *diff_words;
 	struct diff_options *opt;
@@ -1246,8 +1243,6 @@ static unsigned long sane_truncate_line(struct emit_callback *ecb, char *line, u
 	unsigned long allot;
 	size_t l = len;
 
-	if (ecb->truncate)
-		return ecb->truncate(line, len);
 	cp = line;
 	allot = l;
 	while (0 < l) {
