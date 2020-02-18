Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD24FC34026
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 19:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A551B24125
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 19:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qwsLIpby"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgBRTbm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:31:42 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59351 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgBRTbm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 14:31:42 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 90AA15C6B9;
        Tue, 18 Feb 2020 14:31:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=d/z2AN71UeA1mnzzmysKqzmr3zw=; b=qwsLIp
        bySJAaiLOanz4zqylePMdmUloitFDtgDjjL2zhOdUtkkVuJR9xkXESgTKk3WqxK3
        nEj/cfQlQ4DhKBCaQP8+o2FG9a8E5TXMn3Dh/wn03Kc0ZOfPJ5hggRAGC+MYFwi7
        bF/04lZc8TzcNHKc6Cc6STL8vKEaaJWWBu/VU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BcSq2PrR2kuVofvHYhN+hdpzjRAzY57Z
        mshYOWA0W1l34ynjdc+1FyNAri3A62qkRfgVcV4qN8OJxUUM0caBn5A+ymfMBIUS
        TjkgAeqv7Y0R2AqnJqmOD0z1/EDBEynblEVAu+Kgi/8p+VnUS2swPRdOUI9YJVOw
        WRgZ+2LMU/k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 884365C6B8;
        Tue, 18 Feb 2020 14:31:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E88295C6B7;
        Tue, 18 Feb 2020 14:31:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org,
        rhi@pengutronix.de
Subject: Re: [PATCH] describe: output tag's ref instead of embedded name
References: <xmqqd0ahp0na.fsf@gitster-ct.c.googlers.com>
        <fcf19a46b80322c5579142efe4ec681a4dcbdd28.1581802264.git.matheus.bernardino@usp.br>
        <20200216065101.GA2937208@coredump.intra.peff.net>
Date:   Tue, 18 Feb 2020 11:31:35 -0800
In-Reply-To: <20200216065101.GA2937208@coredump.intra.peff.net> (Jeff King's
        message of "Sun, 16 Feb 2020 01:51:01 -0500")
Message-ID: <xmqqd0abk7zc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 475E13E2-5285-11EA-BCE1-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think the conversion of the die() to warning() makes sense here. Do we
> want to cover that with a test?

I presume that you are talking about this case.

>  	if (n->tag && !n->name_checked) {
>  		if (!n->tag->tag)
> -			die(_("annotated tag %s has no embedded name"), n->path);
> +			warning(_("annotated tag %s has no embedded name"), n->path);

The attached is my attempt to craft such a test.  It turns out that
it is tricky to trigger this die/warning.  I haven't dug deeply
enough, but I suspect this might be a dead code now.

A few curious points about the attached *test* that does not work.

 * "git tag -a" cannot create a tag without tagname.  We need to
   resort to "git hash-object -t tag".

 * "git hash-object -t tag" has internal consistency check, and
   rejects input that lack the tagname.  We need to resort to the
   --literally option.

 * Instead of "cat U.objname >.git/refs/tags/U", the method that is
   agnostic to the ref backend implementation, such as "git tag U
   $(cat U.objname)" or "git update-ref refs/tags/U $(cat
   U.objname)" should be usable and should be used.  But they
   complain that the object whose name is $(cat U.objname) does
   *NOT* exist.  I suspect we are triggering an error return from
   parse_tag_buffer() and parse_tag(), which tells
   parse_object_buffer() to return NULL, which in turn means there
   is no such object to its caller.

And of course, "check_describe U A^1" does not even see "U" and does
not complain.  I think that happens way before this part of the
code.  add_to_known_names() calls replace_name() that in turn calls
parse_tag() and a malformed annotated tag there won't even become
a candidate to describe the given commit, I think.

So, we might want to revisit this, analyze what happens fully, and
replace it die/warning with a BUG(), if it turns out to be a dead
code.

 t/t6120-describe.sh | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 960fd99bb1..7544278782 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -6,7 +6,7 @@ test_description='test describe
         .--------------o----o----o----x
        /                   /    /
  o----o----o----o----o----.    /
-       \        A    c        /
+       \   U    A    c        /
         .------------o---o---o
                    D,R   e
 '
@@ -140,6 +140,20 @@ test_expect_success 'rename tag Q back to A' '
 	mv .git/refs/tags/Q .git/refs/tags/A
 '
 
+test_expect_success 'warn for annotated tag without tagname' '
+	git cat-file tag A >A.txt &&
+	sed -e "s/object .*/object $(git rev-parse A^1)/" \
+	    -e "/^tag A/d" A.txt |
+	git hash-object -w --literally --stdin -t tag >U.objname &&
+	cat U.objname >.git/refs/tags/U &&
+
+	check_describe U A^1 &&
+	cat >err.expect <<-\EOF &&
+	warning: annotated tag U has no embedded name
+	EOF
+	test_i18ncmp err.expect err.actual
+'
+
 test_expect_success 'pack tag refs' 'git pack-refs'
 check_describe A-* HEAD
 
