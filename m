Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4AD620281
	for <e@80x24.org>; Tue,  3 Oct 2017 03:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751484AbdJCDOG (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 23:14:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62088 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751132AbdJCDOE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 23:14:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DFCF7A6FBE;
        Mon,  2 Oct 2017 23:14:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=k7S2EFm1tmNDxcnNBIw/IKwup94=; b=IzTUyt
        Dw/of5+9hN3ynbAILCGnYUjuqeybFpAOp1uh2Gs2kNuV1YScRC1X1mh17iEtI/4I
        7LsxGBNlOfLoLn/4kSJQQMJ1EGpbUo4pBe+mw4ZZmOOKNI1Et4FamNHodj9wK44t
        dov1P+EL9I/xPfFC3q3zEmp9XNwo5Q1qfdQ44=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HHCXA8/13I6uCeVBErkyxUQ1mVXDMCOA
        pytCUdI5cfyQpL2d2jybfRn1XGtFaJIiBxAoeSc2oLDEzE3Tm7yWs2hdE/HuwryG
        W6WMj3AobmjMMZQlXBFYM65Zuvr4nh2tebZH7ed99KwQphG8DvDfU3+lUwk4V6eh
        5dq+S22obG4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D8271A6FBD;
        Mon,  2 Oct 2017 23:14:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E6A26A6FBA;
        Mon,  2 Oct 2017 23:14:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Toni Uebernickel <tuebernickel@gmail.com>, git@vger.kernel.org,
        Tsvi Mostovicz <ttmost@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: Updated to v2.14.2 on macOS; git add --patch broken
References: <86D0A377-8AFD-460D-A90E-6327C6934DFC@gmail.com>
        <20171002230017.GT19555@aiede.mtv.corp.google.com>
        <xmqqpoa5kp0c.fsf@gitster.mtv.corp.google.com>
        <xmqqinfxklw7.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 03 Oct 2017 12:14:00 +0900
In-Reply-To: <xmqqinfxklw7.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 03 Oct 2017 11:25:44 +0900")
Message-ID: <xmqqefqkly87.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E84C3792-A7E8-11E7-AD1C-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> In any case, I think the first step may be to revert 136c8c8b from
> both 'master' and 2.14.x.  These alternative solutions can come on
> top.
>
> Thoughts?

With the attached patch, after reverting 136c8c8b ("color: check
color.ui in git_default_config()", 2017-07-13) from the tip of
'master', all tests seem to pass.  More importantly,

    git -c color.ui=always diff-files -p >not-a-tty

will not get colors on its output file, because it does not pay
attention to color.ui configuration.

Note that I haven't _decided_ that reverting is the best way to move
forward (yet).  I am just giving a datapoint for people to use when
they assess how painful each possible avenues proposed are.

 builtin/for-each-ref.c | 3 ++-
 builtin/tag.c          | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 5d7c921a77..238eb00e09 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -5,6 +5,7 @@
 #include "object.h"
 #include "parse-options.h"
 #include "ref-filter.h"
+#include "color.h"
 
 static char const * const for_each_ref_usage[] = {
 	N_("git for-each-ref [<options>] [<pattern>]"),
@@ -54,7 +55,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 
 	format.format = "%(objectname) %(objecttype)\t%(refname)";
 
-	git_config(git_default_config, NULL);
+	git_config(git_color_default_config, NULL);
 
 	parse_options(argc, argv, prefix, opts, for_each_ref_usage, 0);
 	if (maxcount < 0) {
diff --git a/builtin/tag.c b/builtin/tag.c
index c627794181..f8bc1393ed 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -158,7 +158,7 @@ static int git_tag_config(const char *var, const char *value, void *cb)
 
 	if (starts_with(var, "column."))
 		return git_column_config(var, value, "tag", &colopts);
-	return git_default_config(var, value, cb);
+	return git_color_default_config(var, value, cb);
 }
 
 static void write_tag_body(int fd, const struct object_id *oid)


