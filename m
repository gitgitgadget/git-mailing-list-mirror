Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 671401F667
	for <e@80x24.org>; Wed, 16 Aug 2017 18:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752529AbdHPSes (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 14:34:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57200 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752450AbdHPSer (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 14:34:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D5613AEC9E;
        Wed, 16 Aug 2017 14:34:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=OioDtqdOvKHwfduKOlNwsNO+Qh8=; b=ngCLk1p3kEEeFap9Yznb
        PUp7U/Gi3+oVsxUwNvct2loYDqj8ze4S5AilZatFwthrgouBuSDK7JBvu4pKQoqO
        X27Db95b5EBERimOjlj1uKzjT63nZo1vWxuL2ql6IHeCYjErwYxniDP00LrmU9R5
        PjhoWymTk0EACvZct2EaWfY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=DaYm4ifDUCwH/RHV3iJ/xZqWrpwK2uy8vSv1HqdBUb4ize
        EhMOHBWm9qslT8Z8DimQAA+7D9RRQaCnXtCcAxpEEwAIgVWMlvaXx+k1tX2/Vwbv
        dXFakeJnnPHh1oHD4DsF4qdDbZwzzGmklRcKqpxL3wPlwUHadRrWbng2QCB0Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CC56FAEC9D;
        Wed, 16 Aug 2017 14:34:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3BE62AEC9B;
        Wed, 16 Aug 2017 14:34:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org, asottile@umich.edu
Subject: [PATCH/FIXUP 6/2] apply: clarify read_old_data() is about no-index case
References: <xmqq4ltpsn42.fsf@gitster.mtv.corp.google.com>
        <20170813085106.1731-1-tboegi@web.de>
Date:   Wed, 16 Aug 2017 11:34:45 -0700
Message-ID: <xmqqbmnfl5tm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 940A9B94-82B1-11E7-B0E9-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With the previous fixes to CRLF handling in place, read_old_data()
knows what it wants convert_to_git() to do with respect to CRLF.  In
fact, this codepath is about applying a patch to a file in the
filesystem, which may not exist in the index, or may exist but may
not match what is recorded in the index, or in the extreme case, we
may not even be in a Git repository.  If convert_to_git() peeked at
the index while doing its work, it *would* be a bug.

Pass NULL instead of &the_index to the function to make sure we
catch future bugs to clarify this.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * NOTE NOTE NOTE: This is not a part of the "squashed diff" I sent
   earlier, and with this applied, you will see failure in t0020.

   The breakage is because convert_to_git(), with your [PATCH 1/2],
   is not yet prepared to be told "there is no need for safe-crlf
   processing, so do not even look at the index".  You either need
   to invent yet another flag similar to SAFE_CRLF_KEEP_CRLF that is
   different from SAFE_CRLF_FALSE to tell the machinery never to
   look at the index, or fix SAFE_CRLF_FALSE itself so that the
   index is not checked when the caller knows safe-crlf processing
   is not needed.

 apply.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index c06f7014a2..ad58cd1c77 100644
--- a/apply.c
+++ b/apply.c
@@ -2301,7 +2301,15 @@ static int read_old_data(struct stat *st, const char *path, struct strbuf *buf,
 	case S_IFREG:
 		if (strbuf_read_file(buf, path, st->st_size) != st->st_size)
 			return error(_("unable to open or read %s"), path);
-		convert_to_git(&the_index, path, buf->buf, buf->len, buf, safe_crlf);
+		/*
+		 * "git apply" without "--index/--cached" should never look
+		 * at the index; the target file may not have been added to
+		 * the index yet, and we may not even be in any Git repository.
+		 * Pass NULL to convert_to_git() to stress this; the function
+		 * should never look at the index when explicit crlf option
+		 * is given.
+		 */
+		convert_to_git(NULL, path, buf->buf, buf->len, buf, safe_crlf);
 		return 0;
 	default:
 		return -1;
-- 
2.14.1-331-g7631d96230

