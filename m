Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123AEC433E0
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 05:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD98822B51
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 05:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731106AbhAZFFE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:05:04 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54196 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731896AbhAZCE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 21:04:56 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1C26A93F88;
        Mon, 25 Jan 2021 20:57:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fAa5993paE6l7uI8QjCreh1OwAw=; b=SSipUa
        a8zI79mlUzGc0Wa4vZhfsPQWvdFb06+SAqR+KtK+UjzpxG5y9UtQd8dbSAqgF+sO
        J81nkt3olLxFrXlNUFmytX4AroegeNwKBOVAMim3yBRL9hq5fkJGSAtjXGnR9lfx
        oSRdDniJvh7rJmaGokGysqmK00Uoi62312OM0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XuhmXgXRLEHSkVKExm9iwLKBpcKpV9L7
        ggAJUv5lQcyXXDO/HV8zImjl3mFHGTDMaZ5QKoA8sf37I0izNHT1agJvjwov1g+W
        XYYTc/plFM/+6aIVK5tgPeU85DXvYxqT74Re0+Wz/QXz5YCOiLrRU8Yr4AZqEGIK
        1V8frhq6aRs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 02C2393F86;
        Mon, 25 Jan 2021 20:57:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 76B3493F84;
        Mon, 25 Jan 2021 20:57:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/4] fetch-pack: print and use dangling .gitmodules
References: <20210115234300.350442-1-jonathantanmy@google.com>
        <cover.1611455251.git.jonathantanmy@google.com>
        <2d6d8c2671fe424c752994dcb5277d4d923e17a0.1611455251.git.jonathantanmy@google.com>
        <xmqqy2gizs1s.fsf@gitster.c.googlers.com>
Date:   Mon, 25 Jan 2021 17:57:55 -0800
In-Reply-To: <xmqqy2gizs1s.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Sat, 23 Jan 2021 23:56:47 -0800")
Message-ID: <xmqqmtwwwjbw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E8B84ED6-5F79-11EB-9381-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Tan <jonathantanmy@google.com> writes:
>
>> diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
>> index 7d5b17909b..8b8fb43dbc 100755
>> ...
>> +	sane_unset GIT_TEST_SIDEBAND_ALL &&
>> +	git -c protocol.version=2 -c transfer.fsckobjects=1 \
>> +		-c fetch.uriprotocols=http,https \
>> +		clone "$HTTPD_URL/smart/http_parent" http_child &&
>> +
>> +	# Ensure that there are exactly 4 files (2 .pack and 2 .idx).
>
> Ehh, please don't.  We may add multi-pack-index there, or perhaps
> reverse index files in the future.  If you care about having two
> packs logically because you are exercising the out-of-band
> prepackaged packfile plus the dynamic transfer, make sure you have
> two packs (and probably the idx files that go with them).  Don't
> assume there will be one .idx each for them *AND* nothing else
> there.
>
>> +	ls http_child/.git/objects/pack/* >filelist &&
>> +	test_line_count = 4 filelist
>> +'
>
> IOW,
>
> 	d=http_child/.git/objects/pack/
> 	ls "$d"/*.pack "$d"/*.idx >filelist &&
> 	test_line_count = 4 filelist
>
> or something like that.

FYI, I have the following queued to make the tip of 'seen' pass the
tests.

---- >8 -------- >8 -------- >8 -------- >8 -------- >8 -------- >8 ----
From: Junio C Hamano <gitster@pobox.com>
Date: Mon, 25 Jan 2021 17:27:10 -0800
Subject: [PATCH] SQUASH??? test fix

---
 t/t5702-protocol-v2.sh | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 8b8fb43dbc..b1bc73a9a9 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -847,8 +847,9 @@ test_expect_success 'part of packfile response provided as URI' '
 	test -f hfound &&
 	test -f h2found &&
 
-	# Ensure that there are exactly 6 files (3 .pack and 3 .idx).
-	ls http_child/.git/objects/pack/* >filelist &&
+	# Ensure that there are exactly 3 packfiles with associated .idx
+	ls http_child/.git/objects/pack/*.pack \
+	    http_child/.git/objects/pack/*.idx >filelist &&
 	test_line_count = 6 filelist
 '
 
@@ -901,8 +902,9 @@ test_expect_success 'packfile-uri with transfer.fsckobjects' '
 		-c fetch.uriprotocols=http,https \
 		clone "$HTTPD_URL/smart/http_parent" http_child &&
 
-	# Ensure that there are exactly 4 files (2 .pack and 2 .idx).
-	ls http_child/.git/objects/pack/* >filelist &&
+	# Ensure that there are exactly 2 packfiles with associated .idx
+	ls http_child/.git/objects/pack/*.pack \
+	    http_child/.git/objects/pack/*.idx >filelist &&
 	test_line_count = 4 filelist
 '
 
@@ -956,8 +958,9 @@ test_expect_success 'packfile-uri with transfer.fsckobjects succeeds when .gitmo
 		-c fetch.uriprotocols=http,https \
 		clone "$HTTPD_URL/smart/http_parent" http_child &&
 
-	# Ensure that there are exactly 4 files (2 .pack and 2 .idx).
-	ls http_child/.git/objects/pack/* >filelist &&
+	# Ensure that there are exactly 2 packfiles with associated .idx
+	ls http_child/.git/objects/pack/*.pack \
+	    http_child/.git/objects/pack/*.idx >filelist &&
 	test_line_count = 4 filelist
 '
 
-- 
2.30.0-509-gbbf2750a06

