Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE14EB64DD
	for <git@archiver.kernel.org>; Tue, 18 Jul 2023 22:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjGRW6L (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jul 2023 18:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGRW6J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2023 18:58:09 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B959EC
        for <git@vger.kernel.org>; Tue, 18 Jul 2023 15:58:05 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BD83528F7E;
        Tue, 18 Jul 2023 18:58:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=I0a26QKF8XpDp4eNRBs9QPHRAkNqkyssnHC7PM
        21hXE=; b=Wf2P8gctE3+ihxx3LgZ2ZQQhTTMYAH6NZ4Sp7LvhxFQJjRknfDp9z1
        BYHXBLVseboSGSSaBV8HYQwEC2cg2u7L6Ew5uxoS+gLAIkScYm+ciDisvHmbmkG+
        V56qUnv5zFUA2oheNs6ZoPBGQg+OXvr4iFXouG1AExeHLZ772dWVI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B712D28F7D;
        Tue, 18 Jul 2023 18:58:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3C94128F70;
        Tue, 18 Jul 2023 18:58:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [RFC] short help: allow a gap smaller than USAGE_GAP
References: <xmqq5y6gg8fn.fsf@gitster.g> <xmqqttu0esqb.fsf@gitster.g>
Date:   Tue, 18 Jul 2023 15:58:00 -0700
In-Reply-To: <xmqqttu0esqb.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        18 Jul 2023 15:54:04 -0700")
Message-ID: <xmqqlefcesjr.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8BAFA30C-25BE-11EE-9C3B-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The parse-options API responds to "git cmd -h" by listing the option
flag (padded to the USAGE_OPTS_WIDTH column), followed by USAGE_GAP
(set to 2) whitespaces, followed by the help text.  If the flags
part does not fit within the USAGE_OPTS_WIDTH, the help text is given
on its own line.  Imagine that "@" below depicts the USAGE_OPTS_WIDTH'th
column, and "#" are for the usage help text, the output may look
like this:

    @@@@@@@@@@@@@  ########################################
    -f		   description of the flag '-f' comes here
    --short=<num>  description of the flag '--short'
    --very-long-option=<number>
                   description of the flag '--very-long-option'

This is all good and nice in principle, but it becomes awkward when
the flags part is just one column over the limit and forces a line
break.  See the description of the "--almost" option below:

    @@@@@@@@@@@@@  ########################################
    -f		   description of the flag '-f' comes here
    --short=<num>  description of the flag '--short'
    --almost=<num>
                   description of the flag '--almost'
    --very-long-option=<number>
                   description of the flag '--very-long-option'

If we allow shrinking the gap to a single whitespace only in such a
case, we would instead get:

    @@@@@@@@@@@@@  ########################################
    -f		   description of the flag '-f' comes here
    --short=<num>  description of the flag '--short'
    --almost=<num> description of the flag '--almost'
    --very-long-option=<number>
                   description of the flag '--very-long-option'

and the boundary between the flags and their descriptions does not
become any harder to see, while saving precious vertical screen real
estate.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * This makes "git remote add -h" a bit easier to read, because
   there is one such option whose flag part is exactly 24-columns
   long.  Also the changes to t0040 illustrates the effect.

 parse-options.c               | 4 +++-
 t/helper/test-parse-options.c | 2 ++
 t/t0040-parse-options.sh      | 3 +--
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 817416db99..87c9fae634 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1146,7 +1146,9 @@ static enum parse_opt_result usage_with_options_internal(struct parse_opt_ctx_t
 		    !(opts->flags & PARSE_OPT_NOARG))
 			pos += usage_argh(opts, outfile);
 
-		if (pos <= USAGE_OPTS_WIDTH)
+		if (pos == USAGE_OPTS_WIDTH + 1)
+			pad = -1;
+		else if (pos <= USAGE_OPTS_WIDTH)
 			pad = USAGE_OPTS_WIDTH - pos;
 		else {
 			fputc('\n', outfile);
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index 00fa281a9c..a4f6e24b0c 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -133,6 +133,8 @@ int cmd__parse_options(int argc, const char **argv)
 		OPT_STRING(0, "st", &string, "st", "get another string (pervert ordering)"),
 		OPT_STRING('o', NULL, &string, "str", "get another string"),
 		OPT_NOOP_NOARG(0, "obsolete"),
+		OPT_SET_INT_F(0, "longhelp", &integer, "help text of this entry\n"
+			      "spans multiple lines", 0, PARSE_OPT_NONEG),
 		OPT_STRING_LIST(0, "list", &list, "str", "add str to list"),
 		OPT_GROUP("Magic arguments"),
 		OPT_NUMBER_CALLBACK(&integer, "set integer to NUM",
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 83e5d4eeb6..e19a199636 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -30,8 +30,7 @@ usage: test-tool parse-options <options>
     -F, --file <file>     set file to <file>
 
 String options
-    -s, --string <string>
-                          get a string
+    -s, --string <string> get a string
     --string2 <str>       get another string
     --st <st>             get another string (pervert ordering)
     -o <str>              get another string
-- 
2.41.0-376-gcba07a324d

