Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D71EE499B
	for <git@archiver.kernel.org>; Sat, 19 Aug 2023 00:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242973AbjHRX7w (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Aug 2023 19:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243121AbjHRX7l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2023 19:59:41 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2974B2D65
        for <git@vger.kernel.org>; Fri, 18 Aug 2023 16:59:40 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B9A1B29F1E;
        Fri, 18 Aug 2023 19:59:39 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=YcJQSY2cSsifL3D6Hwv2rdWGh
        CQ4ncvWoxyj2sX3vCc=; b=AS4Hbvovvp4UWj1WbArnWedgeQXLKKRI8p4JOCQMm
        LSHg0TFVJm0J/sLHUByaHV1Lr/IJYiEpaBhQULB6EUXMlm59ENGWeBUm6qMAaHFV
        QDLy4+QbftEEquGWNVw4fSRYfdf9h8ECloOIwhf+tm5ZtbFOGWuKp5hm2TAE29SS
        ug=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B146529F1D;
        Fri, 18 Aug 2023 19:59:39 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 647E329F17;
        Fri, 18 Aug 2023 19:59:36 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v3 1/5] diff: move the fallback "--exit-code" code down
Date:   Fri, 18 Aug 2023 16:59:28 -0700
Message-ID: <20230818235932.3253552-2-gitster@pobox.com>
X-Mailer: git-send-email 2.42.0-rc2-7-gf9972720e9
In-Reply-To: <20230818235932.3253552-1-gitster@pobox.com>
References: <20230817222949.3835424-1-gitster@pobox.com>
 <20230818235932.3253552-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 48FB318E-3E23-11EE-A774-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When "--exit-code" is asked and the code cannot just answer by
comparing the object names on both sides but needs to inspect and
compare the contents, there are two ways that the result is found
out.

Some output modes, like "--stat" and "--patch", inherently have to
inspect the contents in order to show the differences in the way
they do.  The codepaths for these modes set the .found_changes bit
as they compute what to show.

However, other output modes do not need to inspect the contents to
show the differences in the way they do.  The most notable example
is "--quiet", which does not need to compute any output to show.
When they are asked to report "--exit-code", they run the codepaths
for the "--patch" output with their output redirected to "/dev/null",
only to set the .found_changes bit.

Currently, this fallback invocation of "--patch" output is done
after the "--stat" output format and its friends and before the
"--patch" and internal callback logic.  Move it to the end of
the sequence to clarify the fallback status of this code block.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/diff.c b/diff.c
index d52db685f7..0ce678fc06 100644
--- a/diff.c
+++ b/diff.c
@@ -6551,6 +6551,21 @@ void diff_flush(struct diff_options *options)
 		separator++;
 	}
=20
+	if (output_format & DIFF_FORMAT_PATCH) {
+		if (separator) {
+			emit_diff_symbol(options, DIFF_SYMBOL_SEPARATOR, NULL, 0, 0);
+			if (options->stat_sep)
+				/* attach patch instead of inline */
+				emit_diff_symbol(options, DIFF_SYMBOL_STAT_SEP,
+						 NULL, 0, 0);
+		}
+
+		diff_flush_patch_all_file_pairs(options);
+	}
+
+	if (output_format & DIFF_FORMAT_CALLBACK)
+		options->format_callback(q, options, options->format_callback_data);
+
 	if (output_format & DIFF_FORMAT_NO_OUTPUT &&
 	    options->flags.exit_with_status &&
 	    options->flags.diff_from_contents) {
@@ -6572,21 +6587,6 @@ void diff_flush(struct diff_options *options)
 		}
 	}
=20
-	if (output_format & DIFF_FORMAT_PATCH) {
-		if (separator) {
-			emit_diff_symbol(options, DIFF_SYMBOL_SEPARATOR, NULL, 0, 0);
-			if (options->stat_sep)
-				/* attach patch instead of inline */
-				emit_diff_symbol(options, DIFF_SYMBOL_STAT_SEP,
-						 NULL, 0, 0);
-		}
-
-		diff_flush_patch_all_file_pairs(options);
-	}
-
-	if (output_format & DIFF_FORMAT_CALLBACK)
-		options->format_callback(q, options, options->format_callback_data);
-
 	for (i =3D 0; i < q->nr; i++)
 		diff_free_filepair(q->queue[i]);
 free_queue:
--=20
2.42.0-rc2-7-gf9972720e9

