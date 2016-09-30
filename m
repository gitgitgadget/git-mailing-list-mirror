Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC294207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 19:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750970AbcI3TT4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 15:19:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53211 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750703AbcI3TTz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 15:19:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 031623E6DF;
        Fri, 30 Sep 2016 15:19:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DhAiQmLdJdmusaykO0br0rmYv2c=; b=JFG974
        4P+KLg3tQmVKTAsUvCJ/PAWzQPpDWZodYyh0SYPw0L7xKHLXnovT2YQgoYa2cgHw
        Uu1IiNIgE8Nw+Aj3gSi84T7xrnyduzJeSGu/drXR+HSpA7zXVAkL+/TUXLLTevyZ
        9X2oouL/biY8AxKdh28yTmYojYChDDrqNmuiw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dOS2X1RRnBeYCztZTegCcfqPFRfEDe8Z
        Ufm1wkGb70LKAkbhj69pLw590XloitaJHt4ykBX54m+sLw4pJx+xr1WT55ry/kxs
        PDozizUBp5ybSm2rpWrfPs3oopnyNTwWa50SaLzAVobPFZhmEF++Djkwce5f9jll
        B3V/pkDc/Nk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EEFED3E6DE;
        Fri, 30 Sep 2016 15:19:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 71B6F3E6DD;
        Fri, 30 Sep 2016 15:19:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] diff_unique_abbrev(): document its assumtion and limitation
References: <xmqqvaxd9ssy.fsf@gitster.mtv.corp.google.com>
        <20160930180957.xj4jqoslbtevhqpb@sigill.intra.peff.net>
Date:   Fri, 30 Sep 2016 12:19:51 -0700
In-Reply-To: <20160930180957.xj4jqoslbtevhqpb@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 30 Sep 2016 14:09:57 -0400")
Message-ID: <xmqqd1jl9ovc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DD7B6512-8742-11E6-AAD2-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ... Now that function _would_
> want to be updated as a result of the other conversation (it would need
> to do something sensible with "-1", like turning it into "7", or
> whatever else is deemed reasonable outside of a repository).
>
> Anyway. I just wonder if you want to give it a better name while you are
> at it.

I'd say the patch to introduce the new function that makes the old
name potentially confusing is a good one to do the rename.  Until
then I do not think there is no need to rename the existing one ;-)

Related tangent about "like turning it into", I am thinking adding
something like this as a preparatory step to Linus's auto-sizing
serires.  That way, we do not have to spell "7"

Having to spell FALLBACK_DEFAULT_ABBREV over and over again would be
more irritating than having to spell "7" often, but I think it would
be a sign of a deeper problem if it turns out we have to repeat this
constant in many places, so an irritatingly long name may serve as a
canary in the coalmine ;-)

-- >8 --
Subject: abbrev: add FALLBACK_DEFAULT_ABBREV to prepare for auto sizing

We'll be introducing a new way to decide the default abbreviation
length by initialising DEFAULT_ABBREV to -1 to signal the first call
to "find unique abbreviation" codepath to compute a reasonable value
based on the number of objects we have to avoid collisions.

We have long relied on DEFAULT_ABBREV being a positive concrete
value that is used as the abbreviation length when no extra
configuration or command line option has overridden it.  Some
codepaths wants to use such a positive concrete default value
even before making their first request to actually trigger the
computation for the auto sized default.

Introduce FALLBACK_DEFAULT_ABBREV and use it to the code that
attempts to align the report from "git fetch".  For now, this
macro is also used to initialize the default_abbrev variable,
but the auto-sizing code will use -1 and then use the value of
FALLBACK_DEFAULT_ABBREV as the starting point of auto-sizing.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 builtin/fetch.c | 3 +++
 cache.h         | 3 +++
 environment.c   | 2 +-
 transport.h     | 3 +--
 4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index e4639d8eb1..5d6994d8e7 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -16,6 +16,9 @@
 #include "connected.h"
 #include "argv-array.h"
 
+#define TRANSPORT_SUMMARY(x) \
+	(int)(TRANSPORT_SUMMARY_WIDTH + strlen(x) - gettext_width(x)), (x)
+
 static const char * const builtin_fetch_usage[] = {
 	N_("git fetch [<options>] [<repository> [<refspec>...]]"),
 	N_("git fetch [<options>] <group>"),
diff --git a/cache.h b/cache.h
index 4ff196c259..677554c59f 100644
--- a/cache.h
+++ b/cache.h
@@ -1133,6 +1133,9 @@ static inline unsigned int hexval(unsigned char c)
 #define MINIMUM_ABBREV minimum_abbrev
 #define DEFAULT_ABBREV default_abbrev
 
+/* used when the code does not know or care what the default abbrev is */
+#define FALLBACK_DEFAULT_ABBREV 7
+
 struct object_context {
 	unsigned char tree[20];
 	char path[PATH_MAX];
diff --git a/environment.c b/environment.c
index 96160a75a5..c8860f722d 100644
--- a/environment.c
+++ b/environment.c
@@ -16,7 +16,7 @@ int trust_executable_bit = 1;
 int trust_ctime = 1;
 int check_stat = 1;
 int has_symlinks = 1;
-int minimum_abbrev = 4, default_abbrev = 7;
+int minimum_abbrev = 4, default_abbrev = FALLBACK_DEFAULT_ABBREV;
 int ignore_case;
 int assume_unchanged;
 int prefer_symlink_refs;
diff --git a/transport.h b/transport.h
index c68140892c..ea25e42317 100644
--- a/transport.h
+++ b/transport.h
@@ -135,8 +135,7 @@ struct transport {
 #define TRANSPORT_PUSH_CERT_IF_ASKED 4096
 #define TRANSPORT_PUSH_ATOMIC 8192
 
-#define TRANSPORT_SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
-#define TRANSPORT_SUMMARY(x) (int)(TRANSPORT_SUMMARY_WIDTH + strlen(x) - gettext_width(x)), (x)
+#define TRANSPORT_SUMMARY_WIDTH (2 * FALLBACK_DEFAULT_ABBREV + 3)
 
 /* Returns a transport suitable for the url */
 struct transport *transport_get(struct remote *, const char *);
