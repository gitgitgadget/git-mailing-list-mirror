Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3501C433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 20:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4AB060E52
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 20:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbhINUXN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 16:23:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62849 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbhINUXM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 16:23:12 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E28ADEA5F;
        Tue, 14 Sep 2021 16:21:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Bis5kb6l9jbyWjuty0x4OkETETIJF4UItvoxp8
        lPGy4=; b=k1VOWDTxTSkW6z0k+qGkSf9OudZTozlZJJOYMmzIfE6fBciYykfRwS
        IT5Yim/AHt/xWSoqPPmup9NIwhSJUtfUEp0R9LtlW6iiTcKgBe5hYlQH3UtO0fBu
        UVAzbsyZTYWRzKdne4lRwFAKHkYmrtXcoJQjvqJ89a5WJP4F7pykw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 76B2EDEA5E;
        Tue, 14 Sep 2021 16:21:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 066E4DEA5D;
        Tue, 14 Sep 2021 16:21:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Git List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re* [PATCH v1] git-clone.txt: add the --recursive option
References: <20210913185941.6247-1-alban.gruin@gmail.com>
        <CAPig+cR=HUDgFctXzcigZ062c=QWYfGWUPuT7scc-xU_w3NT1w@mail.gmail.com>
        <26422bc7-f1d4-4959-ce30-b26d8fe61888@gmail.com>
        <CAPig+cRGzmN6tH-5DmtnbW2cMHSSQ2RS_6d=B0xJ7QWKtG6yug@mail.gmail.com>
        <d02c7f3b-221d-fbab-827a-a950bf28856c@gmail.com>
        <xmqqbl4v2gpu.fsf@gitster.g>
        <CAPig+cTQNkwWgpgu-Mw=Qd++cUVnFrrdnaQnaSZ79RexnNQFHg@mail.gmail.com>
        <xmqqtuin1019.fsf@gitster.g>
Date:   Tue, 14 Sep 2021 13:21:53 -0700
In-Reply-To: <xmqqtuin1019.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        14 Sep 2021 11:31:46 -0700")
Message-ID: <xmqq1r5q29i6.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 66CBBA1C-1599-11EC-8682-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Subject: parse-options: allow hidden aliases

When OPT_ALIAS() was introduced to mark one option is a mere synonym
for another option, we forgot to add support for a use case where an
option is made an alias with an intention to deprecat and eventually
remove it in the future, which usually means "git cmd -h" hides the
deprecated alias while "git cmd --help-all" shows it.

The "--recursive" option of "git clone" and the "--mailmap" option
of "git log" use the OPT_ALIAS mechansim to mark themselves as an
alias of another.  The former has been deprecated but "git clone -h"
still shows it.

Introduce OPT_HIDDEN_ALIAS() that hides the entry from "git cmd -h"
output and use it for "git clone --recursive".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * So here is to add support for hidden aliases and application of
   it on "git clone".  Perhaps everything except for the part that
   applies to "builtin/clone.c" should become [1/2] of a two-patch
   series, while the change to "builtin/clone.c", plus documentation
   updates to mention "--recursive" as a deprecated synonym, should
   become [2/2].

   But I do not have time to go that last mile right now ;-)

>>>  * adding the PARSE_OPT_HIDDEN bit to the OPT_ALIAS() element for
>>>    the deprecated "recurse" option.
>>
>> I was going to suggest this as a possible way forward to address
>> Alban's most recent response to my response. The lack of
>> PARSE_OPT_HIDDEN on OPT_ALIAS() almost seems like an oversight.
>
> You may have an alias with no intention to deprecate either, so it
> would make it cumbersome if OPT_ALIAS() always meant HIDDEN, just
> like it currently is cumbersome for an alias that is deprecated.

 builtin/clone.c               |  2 +-
 parse-options.c               |  4 +++-
 parse-options.h               |  3 +++
 t/helper/test-parse-options.c |  1 +
 t/t0040-parse-options.sh      | 13 ++++++++++++-
 5 files changed, 20 insertions(+), 3 deletions(-)

diff --git c/builtin/clone.c w/builtin/clone.c
index 66fe66679c..6fd4b41eb3 100644
--- c/builtin/clone.c
+++ w/builtin/clone.c
@@ -110,7 +110,7 @@ static struct option builtin_clone_options[] = {
 	{ OPTION_CALLBACK, 0, "recurse-submodules", &option_recurse_submodules,
 	  N_("pathspec"), N_("initialize submodules in the clone"),
 	  PARSE_OPT_OPTARG, recurse_submodules_cb, (intptr_t)"." },
-	OPT_ALIAS(0, "recursive", "recurse-submodules"),
+	OPT_HIDDEN_ALIAS(0, "recursive", "recurse-submodules"),
 	OPT_INTEGER('j', "jobs", &max_jobs,
 		    N_("number of submodules cloned in parallel")),
 	OPT_STRING(0, "template", &option_template, N_("template-directory"),
diff --git c/parse-options.c w/parse-options.c
index 2abff136a1..46af4eacdf 100644
--- c/parse-options.c
+++ w/parse-options.c
@@ -653,6 +653,7 @@ static struct option *preprocess_options(struct parse_opt_ctx_t *ctx,
 		int short_name;
 		const char *long_name;
 		const char *source;
+		int flags;
 		struct strbuf help = STRBUF_INIT;
 		int j;
 
@@ -662,6 +663,7 @@ static struct option *preprocess_options(struct parse_opt_ctx_t *ctx,
 		short_name = newopt[i].short_name;
 		long_name = newopt[i].long_name;
 		source = newopt[i].value;
+		flags = newopt[i].flags;
 
 		if (!long_name)
 			BUG("An alias must have long option name");
@@ -680,7 +682,7 @@ static struct option *preprocess_options(struct parse_opt_ctx_t *ctx,
 			newopt[i].short_name = short_name;
 			newopt[i].long_name = long_name;
 			newopt[i].help = strbuf_detach(&help, NULL);
-			newopt[i].flags |= PARSE_OPT_FROM_ALIAS;
+			newopt[i].flags |= PARSE_OPT_FROM_ALIAS | flags;
 			break;
 		}
 
diff --git c/parse-options.h w/parse-options.h
index a845a9d952..8ba72c7916 100644
--- c/parse-options.h
+++ w/parse-options.h
@@ -201,6 +201,9 @@ struct option {
 #define OPT_ALIAS(s, l, source_long_name) \
 	{ OPTION_ALIAS, (s), (l), (source_long_name) }
 
+#define OPT_HIDDEN_ALIAS(s, l, source_long_name)		\
+	{ OPTION_ALIAS, (s), (l), (source_long_name), NULL, NULL, PARSE_OPT_HIDDEN }
+
 /*
  * parse_options() will filter out the processed options and leave the
  * non-option arguments in argv[]. argv0 is assumed program name and
diff --git c/t/helper/test-parse-options.c w/t/helper/test-parse-options.c
index 2051ce57db..86c3eb1a29 100644
--- c/t/helper/test-parse-options.c
+++ w/t/helper/test-parse-options.c
@@ -154,6 +154,7 @@ int cmd__parse_options(int argc, const char **argv)
 		OPT_GROUP("Alias"),
 		OPT_STRING('A', "alias-source", &string, "string", "get a string"),
 		OPT_ALIAS('Z', "alias-target", "alias-source"),
+		OPT_HIDDEN_ALIAS(0, "hidden-alias", "alias-source"),
 		OPT_END(),
 	};
 	int i;
diff --git c/t/t0040-parse-options.sh w/t/t0040-parse-options.sh
index ad4746d899..4d31367b07 100755
--- c/t/t0040-parse-options.sh
+++ w/t/t0040-parse-options.sh
@@ -7,7 +7,7 @@ test_description='our own option parser'
 
 . ./test-lib.sh
 
-cat >expect <<\EOF
+cat >help-all.in <<\EOF
 usage: test-tool parse-options <options>
 
     A helper function for the parse-options API.
@@ -34,6 +34,7 @@ String options
     --string2 <str>       get another string
     --st <st>             get another string (pervert ordering)
     -o <str>              get another string
+#    --obsolete            no-op (backward compatibility)
     --list <str>          add str to list
 
 Magic arguments
@@ -55,10 +56,20 @@ Alias
                           get a string
     -Z, --alias-target <string>
                           alias of --alias-source
+#    --hidden-alias <string>
+#                          alias of --alias-source
 
 EOF
 
+test_expect_success 'hidden alias in test help' '
+	sed -e "s/^#//" help-all.in >expect &&
+	test_must_fail test-tool parse-options --help-all >output 2>output.err && 
+	test_must_be_empty output.err &&
+	test_cmp expect output
+'
+
 test_expect_success 'test help' '
+	sed -e "/^#/d" help-all.in >expect &&
 	test_must_fail test-tool parse-options -h >output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
