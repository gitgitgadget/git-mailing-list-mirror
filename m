Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F03520281
	for <e@80x24.org>; Tue, 31 Oct 2017 05:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752871AbdJaFXR (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 01:23:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64706 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752450AbdJaFXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 01:23:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E164CAB0A2;
        Tue, 31 Oct 2017 01:23:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hPQoC0WjIa3b7Ws++iS4AARqsKU=; b=vACqOv
        igGahkEq5LAhtihS1OIgl9iMe2D25+NB0SheBQvhhiTUEWXFTPTyMgNzGn1nZmS0
        NBsakfuClb/wZc7tTHb9RiMlOq7/hObrzg5Q4RpPhI5OGgPTUC1cS4eEeQt7U9yO
        GP+jT8MvegZKjl1rJzyv8rr8qcTkFk4Woasp4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=r13DlRDoUlJpf6B2U/QnaufsG3A/m59G
        r8439ES6avECccJ3Eb5Xy6E9TyQ4iQUGpW104MH+sEqVjY0bRcEiw6m2N5m5YXMh
        XVHWvT4g3oM0VLStw9ya/yqgTIx+GV2IlR36GfyJmTVt/tjR3OH6wHVeGyE8U3Vo
        1RHQiq12N+Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D70B9AB0A1;
        Tue, 31 Oct 2017 01:23:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4541CAB0A0;
        Tue, 31 Oct 2017 01:23:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: [PATCH 3.5/4] diff: set TEXTCONV_VIA_CMDLINE only when it is set to true
References: <20171027222853.180981-1-bmwill@google.com>
        <20171030194646.27473-1-bmwill@google.com>
        <20171030194646.27473-4-bmwill@google.com>
Date:   Tue, 31 Oct 2017 14:23:13 +0900
In-Reply-To: <20171030194646.27473-4-bmwill@google.com> (Brandon Williams's
        message of "Mon, 30 Oct 2017 12:46:45 -0700")
Message-ID: <xmqqvaiv28n2.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 989D6CD8-BDFB-11E7-AC29-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the meaning of the bit to "the user explicitly set the
allow-textconv bit to true from the command line".

The "touched" mechanism in the old code meant to express "the user
explicitly set the allow-textconv bit to something from the command
line" and recorded that fact upon "--no-textconv", too, by setting
the corresponding touched bit.  The code in the previous step to
clear the bit did not make much sense.

Again, this may want be squashed into the previous step, but its log
message needs to be adjusted somewhat (e.g. "s/is requested via/is
set to true via/").

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 8b700b1bd2..11fccbd107 100644
--- a/diff.c
+++ b/diff.c
@@ -4765,10 +4765,9 @@ int diff_opt_parse(struct diff_options *options,
 	else if (!strcmp(arg, "--textconv")) {
 		DIFF_OPT_SET(options, ALLOW_TEXTCONV);
 		DIFF_OPT_SET(options, TEXTCONV_SET_VIA_CMDLINE);
-	} else if (!strcmp(arg, "--no-textconv")) {
+	} else if (!strcmp(arg, "--no-textconv"))
 		DIFF_OPT_CLR(options, ALLOW_TEXTCONV);
-		DIFF_OPT_CLR(options, TEXTCONV_SET_VIA_CMDLINE);
-	} else if (!strcmp(arg, "--ignore-submodules")) {
+	else if (!strcmp(arg, "--ignore-submodules")) {
 		DIFF_OPT_SET(options, OVERRIDE_SUBMODULE_CONFIG);
 		handle_ignore_submodules_arg(options, "all");
 	} else if (skip_prefix(arg, "--ignore-submodules=", &arg)) {
-- 
2.15.0-224-g5109123e6a

