Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09724C43334
	for <git@archiver.kernel.org>; Sat,  9 Jul 2022 20:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiGIUwZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jul 2022 16:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiGIUwX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jul 2022 16:52:23 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289C61C11A
        for <git@vger.kernel.org>; Sat,  9 Jul 2022 13:52:22 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5679514BF23;
        Sat,  9 Jul 2022 16:52:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kBJ+i9lRllu5++X07J31PPPFn5sqXFnK8yx6Xr
        cO4+8=; b=DZ8ee0shbbI3czD+cZDc8Nemrvf4jM9s8cABfaOaY5TsW9zzGXA0Ye
        yv6mqI/q/QiJmWTgPNdbGEMvxec8n2tfP9skn5fuDgJUezehlJ7N9QVU4pg8rADB
        Kp2on9V5Cz31A6HGpBpff6GtkYI5JD1Z+vybO5Uj+3Kn13jgt747o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4CE8514BF22;
        Sat,  9 Jul 2022 16:52:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B5BE414BF21;
        Sat,  9 Jul 2022 16:52:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jaydeep Das via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jaydeep Das <jaydeepjd.8914@gmail.com>
Subject: Re: [PATCH v2] gpg-interface: add function for converting trust
 level to string
References: <pull.1281.git.1657202265048.gitgitgadget@gmail.com>
        <pull.1281.v2.git.1657279447515.gitgitgadget@gmail.com>
        <CAPig+cTX76ZMG_S-qOX_JDxYVWXRvtP2Ref4k8uM1KJaDwX9=w@mail.gmail.com>
Date:   Sat, 09 Jul 2022 13:52:18 -0700
In-Reply-To: <CAPig+cTX76ZMG_S-qOX_JDxYVWXRvtP2Ref4k8uM1KJaDwX9=w@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 8 Jul 2022 20:58:22 -0400")
Message-ID: <xmqqwncmt3el.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 061B52F2-FFC9-11EC-9038-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Jul 8, 2022 at 7:28 AM Jaydeep Das via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> Add new helper function `gpg_trust_level_to_str()` which will
>> convert a given member of `enum signature_trust_level` to its
>> corresponding string(in lowercase). For example, `TRUST_ULTIMATE`
>
> s/g(/g (/
>
>> will yield the string "ultimate".
>>
>> This will abstract out some code in `pretty.c` relating to gpg
>> signature trust levels.
>>
>> Signed-off-by: Jaydeep Das <jaydeepjd.8914@gmail.com>
>> ---
>> diff --git a/gpg-interface.h b/gpg-interface.h
>> @@ -71,6 +71,14 @@ size_t parse_signed_buffer(const char *buf, size_t size);
>> +/*
>> + * Returns corresponding string in lowercase for a given member of
>> + * enum signature_trust_level. For example, `TRUST_ULTIMATE` will
>> + * return "ultimate".
>> + */
>> +char *gpg_trust_level_to_str(enum signature_trust_level level);
>
> It would be a good idea to update the function documentation to
> mention that the caller is responsible for freeing the returned
> string.

Given that there are small and fixed number of trust level strings,
I actually think that it would be more reasonable to return a static
string to the caller, something along the lines of the attached, so
that callers do not have to worry about freeing it.

Perhaps along the lines of ...

 gpg-interface.c | 19 ++++++++++++++++++-
 gpg-interface.h |  2 ++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git c/gpg-interface.c w/gpg-interface.c
index 947b58ad4d..4a5b9d0f3a 100644
--- c/gpg-interface.c
+++ w/gpg-interface.c
@@ -165,9 +165,10 @@ static struct {
 	{ 0, "TRUST_", GPG_STATUS_TRUST_LEVEL },
 };
 
-static struct {
+static struct sigcheck_gpg_trust_level {
 	const char *key;
 	enum signature_trust_level value;
+	const char *downcased;
 } sigcheck_gpg_trust_level[] = {
 	{ "UNDEFINED", TRUST_UNDEFINED },
 	{ "NEVER", TRUST_NEVER },
@@ -176,6 +177,22 @@ static struct {
 	{ "ULTIMATE", TRUST_ULTIMATE },
 };
 
+const char *gpg_trust_level_to_string(enum signature_trust_level level)
+{
+	struct sigcheck_gpg_trust_level *trust;
+
+	if (level < 0 || ARRAY_SIZE(sigcheck_gpg_trust_level) <= level)
+		BUG("invalid trust_level requested: %d", level);
+
+	trust = &sigcheck_gpg_trust_level[level];
+	if (trust->value != level)
+		BUG("sigcheck_gpg_trust_level[] unsorted");
+
+	if (!trust->downcased)
+		trust->downcased = xstrdup_tolower(trust->key);
+	return trust->downcased;
+}
+
 static void replace_cstring(char **field, const char *line, const char *next)
 {
 	free(*field);
diff --git c/gpg-interface.h w/gpg-interface.h
index b30cbdcd3d..2dffcb836d 100644
--- c/gpg-interface.h
+++ w/gpg-interface.h
@@ -85,4 +85,6 @@ int check_signature(struct signature_check *sigc,
 void print_signature_buffer(const struct signature_check *sigc,
 			    unsigned flags);
 
+const char *gpg_trust_level_to_string(enum signature_trust_level);
+
 #endif
