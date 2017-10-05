Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2612D1FA21
	for <e@80x24.org>; Thu,  5 Oct 2017 23:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752205AbdJEXCB (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 19:02:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51277 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752134AbdJEXB7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 19:01:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D1CE95E1B;
        Thu,  5 Oct 2017 19:01:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ldwpLjuo+elhHQ2ZuikHtW7Oh4s=; b=OE0udr
        TtYEbJ3wAXrReGq84w1O3LW5JuqTqXYPNkkgCmda5rgRrxse06s6gWtzFlRyHJ2U
        VTZxEk0gdNpPdBkeWw9yLNJ/x0MZVYYv+G61dvwxmrXq2oWs/XFJ1GyKjB4MNlsD
        P9eMLhGc4xNzws2LZx1NvGPiKjnGAm74yiDQc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hYZD9aEyDY45SOTAuEfey4Uz8fM7+pSm
        kMEvJKFbIItC3b3LbGPOVpBcfcg+te/SMGCIEw0fh9FrK+eJq8Z9qnH3NMsPgzgc
        K6F2Z3nj+E22wOSHDJjJmqmVLWMiMODJvbCuf0e0sXRW0WN7a0C+teK2w9Z30/7L
        20t+pvKmDa0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E9AC195E19;
        Thu,  5 Oct 2017 19:01:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6FD3395E12;
        Thu,  5 Oct 2017 19:01:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org,
        t.gummerer@gmail.com, jrnieder@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v1 1/2] entry.c: update cache entry only for existing files
References: <20171005104407.65948-1-lars.schneider@autodesk.com>
        <20171005104407.65948-2-lars.schneider@autodesk.com>
        <xmqqk2097sge.fsf@gitster.mtv.corp.google.com>
        <20171005112658.p7hohhtkdkcapwe6@sigill.intra.peff.net>
Date:   Fri, 06 Oct 2017 08:01:48 +0900
In-Reply-To: <20171005112658.p7hohhtkdkcapwe6@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 5 Oct 2017 07:26:58 -0400")
Message-ID: <xmqqefqh6vxf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B4FA792-AA21-11E7-8396-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Oct 05, 2017 at 08:19:13PM +0900, Junio C Hamano wrote:
>
>> This is unrelated to the main topic of this patch, but we see this
>> just before the precontext of this hunk:
>> 
>> 			if (dco && dco->state != CE_NO_DELAY) {
>> 				/* Do not send the blob in case of a retry. */
>> 				if (dco->state == CE_RETRY) {
>> 					new = NULL;
>> 					size = 0;
>> 				}
>> 				ret = async_convert_to_working_tree(
>> 					ce->name, new, size, &buf, dco);
>> 
>> Aren't we leaking "new" in that CE_RETRY case?
>
> Yes, it certainly looks like it. Wouldn't we want to avoid reading the
> file from disk entirely in that case?

Probably.  But that is more of a removal of pessimization than a fix ;-)

> I.e., I think free(new) is sufficient to fix the leak you
> mentioned.

In addition to keeping the new = NULL assignment, of course.

> But
> I think we'd want to protect the read_blob_entry() call at the top of
> the case with a check for dco->state == CE_RETRY.

Yeah, I think that makes more sense.

A patch may look like this on top of these two patches, but I'd
prefer to see Lars's eyeballing and possibly wrapping it up in an
applicable patch after taking the authorship.

I considered initializing new to NULL and size to 0 but decided
against it, as that would lose the justification to have an if
statement that marks that "dco->state == CE_RETRY" is a special
case.  I think explicit if() with clearing these two variables makes
it clearer to show what is going on.

By the way, the S_IFLNK handling seems iffy with or without this
change (or for that matter, I suspect this iffy-ness existed before
Lars's delayed filtering change).  On a platform without symlinks,
we do the same as S_IFREG, but obviously we do not want any content
conversion that happens to the regular files in such a case.  So we
may further want to fix that, but I left it outside the scope of
fixing the leak of NULL and optimizing the blob reading out.


 entry.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/entry.c b/entry.c
index cac5bf5af2..74e35f942c 100644
--- a/entry.c
+++ b/entry.c
@@ -274,14 +274,12 @@ static int write_entry(struct cache_entry *ce,
 	}
 
 	switch (ce_mode_s_ifmt) {
-	case S_IFREG:
 	case S_IFLNK:
 		new = read_blob_entry(ce, &size);
 		if (!new)
 			return error("unable to read sha1 file of %s (%s)",
 				path, oid_to_hex(&ce->oid));
-
-		if (ce_mode_s_ifmt == S_IFLNK && has_symlinks && !to_tempfile) {
+		if (has_symlinks && !to_tempfile) {
 			ret = symlink(new, path);
 			free(new);
 			if (ret)
@@ -289,18 +287,28 @@ static int write_entry(struct cache_entry *ce,
 						   path);
 			break;
 		}
-
+		/* fallthru */
+	case S_IFREG:
 		/*
 		 * Convert from git internal format to working tree format
 		 */
 		if (ce_mode_s_ifmt == S_IFREG) {
 			struct delayed_checkout *dco = state->delayed_checkout;
+
+			/* 
+			 * In case of a retry, we do not send blob, hence no
+			 * need to read it, either.
+			 */
+			if (dco && dco->state == CE_RETRY) {
+				new = NULL;
+				size = 0;
+			} else {
+				new = read_blob_entry(ce, &size);
+				if (!new)
+					return error("unable to read sha1 file of %s (%s)",
+						     path, oid_to_hex(&ce->oid));
+			}
 			if (dco && dco->state != CE_NO_DELAY) {
-				/* Do not send the blob in case of a retry. */
-				if (dco->state == CE_RETRY) {
-					new = NULL;
-					size = 0;
-				}
 				ret = async_convert_to_working_tree(
 					ce->name, new, size, &buf, dco);
 				if (ret && string_list_has_string(&dco->paths, ce->name)) {
