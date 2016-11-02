Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B89F720229
	for <e@80x24.org>; Wed,  2 Nov 2016 01:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754937AbcKBBdm (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 21:33:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58196 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754910AbcKBBdl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 21:33:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E9594C408;
        Tue,  1 Nov 2016 21:33:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WCRGJh3UTLLvwsFof3rsw7H1FGI=; b=HXXR4G
        51rkSNU34/ZCZBO11X5SCWN8/eMcQRHdPgC8fpgPo3+Som8CaJeT0bgxlfo3PPhQ
        6qCdHtzntdwzpayKKhBAopHfvmHWIcOS6psCQEqGfHlhHDfRbvM3auD5mVfZLmfi
        cgI0XIIwdxhr9t5WVLRQNj0joQ3V4JU3gSSYM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RqHtFW6JlK3Sg5OUvTO0uIAzZuMlCvFG
        Q8/mQvvabdIIFgn1CuUia1IubOnam0TITFoKE216hSIzIdCpnUjEoL+Y/X4KHyom
        MqSUpU5+V5mj3S3vq0a7qwZdkYSJq7/GP1YVbEry5zy/WbvXS+vfOfBrHASFdfnM
        pbPQmRyQucE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 35B724C407;
        Tue,  1 Nov 2016 21:33:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8F8EC4C406;
        Tue,  1 Nov 2016 21:33:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/3] abbrev: auto size the default abbreviation
References: <20161001001937.10884-1-gitster@pobox.com>
        <20161001001937.10884-4-gitster@pobox.com>
        <20161003222701.za5njew33rqc5b6g@sigill.intra.peff.net>
Date:   Tue, 01 Nov 2016 18:33:38 -0700
In-Reply-To: <20161003222701.za5njew33rqc5b6g@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 3 Oct 2016 18:27:02 -0400")
Message-ID: <xmqqmvhimzrh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 61B61D28-A09C-11E6-86C1-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Sep 30, 2016 at 05:19:37PM -0700, Junio C Hamano wrote:
>
>> Introduce a mechanism, where we estimate the number of objects in
>> the repository upon the first request to abbreviate an object name
>> with the default setting and come up with a sane default for the
>> repository.  Based on the expectation that we would see collision in
>> a repository with 2^(2N) objects when using object names shortened
>> to first N bits, use sufficient number of hexdigits to cover the
>> number of objects in the repository.  Each hexdigit (4-bits) we add
>> to the shortened name allows us to have four times (2-bits) as many
>> objects in the repository.

I was idly browsing the draft release notes and then documentation
and noticed that, even though the new default is to auto-scale,
there is no mention of that in the documentation and there is no way
to explicitly ask for auto-scaling.

I wonder if we want to have something like this.  I actually am
inclined to drop the change to config.c and remove the new mention
of "auto" in the documentation.

 Documentation/config.txt |  9 +++++----
 config.c                 | 14 ++++++++++----
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index a0ab66aae7..b02f8a4025 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -783,10 +783,11 @@ core.sparseCheckout::
 	linkgit:git-read-tree[1] for more information.
 
 core.abbrev::
-	Set the length object names are abbreviated to.  If unspecified,
-	many commands abbreviate to 7 hexdigits, which may not be enough
-	for abbreviated object names to stay unique for sufficiently long
-	time.
+	Set the length object names are abbreviated to.  If
+	unspecified or set to "auto", an appropriate value is
+	computed based on the approximate number of packed objects
+	in your repository, which hopefully is enough for
+	abbreviated object names to stay unique for some time.
 
 add.ignoreErrors::
 add.ignore-errors (deprecated)::
diff --git a/config.c b/config.c
index 83fdecb1bc..c363cca4a9 100644
--- a/config.c
+++ b/config.c
@@ -834,10 +834,16 @@ static int git_default_core_config(const char *var, const char *value)
 	}
 
 	if (!strcmp(var, "core.abbrev")) {
-		int abbrev = git_config_int(var, value);
-		if (abbrev < minimum_abbrev || abbrev > 40)
-			return -1;
-		default_abbrev = abbrev;
+		if (!value)
+			return config_error_nonbool(var);
+		if (!strcasecmp(value, "auto"))
+			default_abbrev = -1;
+		else {
+			int abbrev = git_config_int(var, value);
+			if (abbrev < minimum_abbrev || abbrev > 40)
+				return -1;
+			default_abbrev = abbrev;
+		}
 		return 0;
 	}
 
