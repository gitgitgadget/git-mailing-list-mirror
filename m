Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CD1C678DF
	for <git@archiver.kernel.org>; Thu, 17 Aug 2023 22:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355745AbjHQWaU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Aug 2023 18:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355734AbjHQW37 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2023 18:29:59 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EDF3590
        for <git@vger.kernel.org>; Thu, 17 Aug 2023 15:29:57 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9373B377CB;
        Thu, 17 Aug 2023 18:29:57 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=mNbnbnacm4FQet3iaLcy/AVc8
        Q1/OhqyYLRtkqX4Rak=; b=TueJMsBSQ3rWNJNp8+L8Qc1wTcIeXrrMw+cV/s74P
        SfpUxQ9pjVXeZxSQ0F5t/w3MCMF1G4ANGGKtD7iIlQVtVKXNBCHIyqraRo6R87i5
        WeeuValczmi/NXHDVG1xcUQCSCzGH+K9P1mnjZs9kKdmQI6r7kVswX/2X83ObiTj
        bY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8D2A3377CA;
        Thu, 17 Aug 2023 18:29:57 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C5056377C9;
        Thu, 17 Aug 2023 18:29:53 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 2/5] diff: move the fallback "--exit-code" code down
Date:   Thu, 17 Aug 2023 15:29:46 -0700
Message-ID: <20230817222949.3835424-3-gitster@pobox.com>
X-Mailer: git-send-email 2.42.0-rc2
In-Reply-To: <20230817222949.3835424-1-gitster@pobox.com>
References: <xmqqttsxbfyw.fsf@gitster.g>
 <20230817222949.3835424-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 96496F9A-3D4D-11EE-BD9B-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When "--exit-code" is asked and the code cannot just answer by
comparing the object names on both sides but need to inspect and
compare the contents, there are two ways that the result is found
out.

Some output modes, like "--stat" and "--patch", inherently have to
inspect the contents in order to _show_ the differences in the way
they do.  The codepaths for these modes set the .found_changes bit
as they compute what to show.

However, other output modes do not need to inspect the contents to
show the differences in the way they do.  The most notable example
is "--quiet", which does not need to compute any output.  When they
are asked to report "--exit-code", they run the codepaths for the
"--patch" output with their output redirected to "/dev/null", only
to set the .found_changes bit.

Currently, this fallback invocation of "--patch" output is done
after the "--stat" output format and its friends and before the
"--patch" and internal callback logic.  Move it to the end of
the sequence to clarify the fallback status of this code block.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/diff.c b/diff.c
index 03d0cfc700..ce9c8272c7 100644
--- a/diff.c
+++ b/diff.c
@@ -6555,6 +6555,21 @@ void diff_flush(struct diff_options *options)
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
@@ -6576,21 +6591,6 @@ void diff_flush(struct diff_options *options)
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
2.42.0-rc2

