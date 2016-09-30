Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CD35207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 17:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933403AbcI3Ry6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 13:54:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54184 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932430AbcI3Ry5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 13:54:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EF40341418;
        Fri, 30 Sep 2016 13:54:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=P
        gZ8fGHiO8sFBpHwSjJceDWLmbo=; b=O2G8m9tCsAPa3YpYQD5OTb578DycoEinJ
        ryxVJU+Xf9kRZ3fybGW7NIMnh/1IEIgwhJDMC73KLL2ojX88bNmtXzE4TW04OR4i
        Myf/VbfDxPtG1vJV7ofjp0sXV0fvobRQIOmNowI8GxLi+E9Sn/wjtTjSruw7DMmt
        UyRM75f9T4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=Qrx
        EDewx+JLjF9BuYekg9CJlQe8j9a7tpchFoE7iXqj+5i+7fIRQpQkt3hridHbxzcA
        CZ62AUbAY13v613Z3W4vrzwsDMCQEldM5os30tIkfXYnU/h8qqr9kHabNatKJHco
        HUQ8PbOWZGlb+vnfOsVrgg7ElX36PAc5wWPB4TxY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E51E741417;
        Fri, 30 Sep 2016 13:54:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 61EE741416;
        Fri, 30 Sep 2016 13:54:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] diff_unique_abbrev(): document its assumtion and limitation
Date:   Fri, 30 Sep 2016 10:54:53 -0700
Message-ID: <xmqqvaxd9ssy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FECBC146-8736-11E6-9C42-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function is used to add "..." to displayed object names in
"diff --raw --abbrev[=<n>]" output.  It bases its behaviour on an
untold assumption that the abbreviation length requested by the
caller is "reasonble", i.e. most of the objects will abbreviate
within the requested length and the resulting length would never
exceed it by more than a few hexdigits (otherwise the resulting
columns would not align).  Explain that in a comment.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I had to scratch my head wondering what impact Linus's
   auto-abbrev change will have on this code, which I wrote many
   years ago in 47dd0d59 ("diff: --abbrev option", 2005-12-13).

 diff.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index cefc13eb8e..428ed4f4c9 100644
--- a/diff.c
+++ b/diff.c
@@ -4108,7 +4108,8 @@ void diff_free_filepair(struct diff_filepair *p)
 	free(p);
 }
 
-/* This is different from find_unique_abbrev() in that
+/*
+ * This is different from find_unique_abbrev() in that
  * it stuffs the result with dots for alignment.
  */
 const char *diff_unique_abbrev(const unsigned char *sha1, int len)
@@ -4120,6 +4121,26 @@ const char *diff_unique_abbrev(const unsigned char *sha1, int len)
 
 	abbrev = find_unique_abbrev(sha1, len);
 	abblen = strlen(abbrev);
+
+	/*
+	 * In well-behaved cases, where the abbbreviated result is the
+	 * same as the requested length, append three dots after the
+	 * abbreviation (hence the whole logic is limited to the case
+	 * where abblen < 37); when the actual abbreviated result is a
+	 * bit longer than the requested length, we reduce the number
+	 * of dots so that they match the well-behaved ones.  However,
+	 * if the actual abbreviation is longer than the requested
+	 * length by more than three, we give up on aligning, and add
+	 * three dots anyway, to indicate that the output is not the
+	 * full object name.  Yes, this may be suboptimal, but this
+	 * appears only in "diff --raw --abbrev" output and it is not
+	 * worth the effort to change it now.  Note that this would
+	 * likely to work fine when the automatic sizing of default
+	 * abbreviation length is used--we would be fed -1 in "len" in
+	 * that case, and will end up always appending three-dots, but
+	 * the automatic sizing is supposed to give abblen that ensures
+	 * uniqueness across all objects (statistically speaking).
+	 */
 	if (abblen < 37) {
 		static char hex[41];
 		if (len < abblen && abblen <= len + 2)
-- 
2.10.0-612-g22341905f2

