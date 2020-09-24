Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891D8C4363D
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 19:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4049320878
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 19:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="o6qnj9Hk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbgIXTZp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 15:25:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65136 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbgIXTZp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 15:25:45 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E48592F49;
        Thu, 24 Sep 2020 15:25:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rhdefLd6Jc3tHARDETbqTN1uXNs=; b=o6qnj9
        Hk2eY9VLAkTRB96kbf13O8F4SeB556+kMU74lUw6h3yZdGiJkMY6yte6YRuXvZTv
        zfB/F7m5CaNXGhElnJaixk5gRorBTyER20WMxTC9HHPJQIw8PHOZl+AOuEuwVg67
        of05PiBb3YAkVYO6/IeDCqq5ibWX2Pe1FOQrY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ii9Jszhwgdv1bMWEavkqBVD5Wgf9bchq
        fXVJ1+VA2ZzjL0wPAjLDK/ydnPKBoenMLit9RR91ntIir0pDXG+M0gPG82F9L4/T
        M8Evm1p4cPobN+ISDisdI3IpSfCGlBc1BEutTaomPErzsqME0zQHoBDUBWs66Hlm
        G0Q7Ngae+zk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 504AB92F48;
        Thu, 24 Sep 2020 15:25:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C646E92F47;
        Thu, 24 Sep 2020 15:25:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] bisect: don't use invalid oid as rev when starting
References: <20200923170915.21748-1-chriscool@tuxfamily.org>
        <20200924060344.15541-1-chriscool@tuxfamily.org>
        <xmqqsgb7m2bq.fsf@gitster.c.googlers.com>
Date:   Thu, 24 Sep 2020 12:25:40 -0700
In-Reply-To: <xmqqsgb7m2bq.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 24 Sep 2020 11:55:53 -0700")
Message-ID: <xmqqo8lvm0y3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BB8EAB74-FE9B-11EA-8179-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> We may need to audit recent additions of get_oid_committish() calls
> in our codebase.  I suspect there may be other instances of the same
> mistake.
>
> Other than that, the code structure does look more straight-forward
> compared to the previous round.  A fix on this version would involve
> peeling what is in oid down to commit, and you need to handle errors
> during that process, so it may not stay pretty with a fix, though.
> I dunno.

I'll queue it with this band-aid on top for now.

Thanks.

 builtin/bisect--helper.c    | 7 ++++---
 t/t6030-bisect-porcelain.sh | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index a1f97e3f6c..2fcc023a3b 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -474,13 +474,14 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 		} else if (starts_with(arg, "--") &&
 			 !one_of(arg, "--term-good", "--term-bad", NULL)) {
 			return error(_("unrecognized option: '%s'"), arg);
-		} else if (!get_oid_committish(arg, &oid))
+		} else if (!get_oidf(&oid, "%s^{commit}", arg)) {
 			string_list_append(&revs, oid_to_hex(&oid));
-		else if (has_double_dash)
+		} else if (has_double_dash) {
 			die(_("'%s' does not appear to be a valid "
 			      "revision"), arg);
-		else
+		} else {
 			break;
+		}
 	}
 	pathspec_pos = i;
 
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 94179b6acf..4dbfa63ca1 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -82,7 +82,7 @@ test_expect_success 'bisect fails if given any junk instead of revs' '
 	git bisect bad $HASH4
 '
 
-test_expect_success 'bisect start without -- uses unknown arg as path restriction' '
+test_expect_success 'bisect start without -- takes unknown arg as pathspec' '
 	git bisect reset &&
 	git bisect start foo bar &&
 	grep foo ".git/BISECT_NAMES" &&
