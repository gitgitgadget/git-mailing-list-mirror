Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27DDF20756
	for <e@80x24.org>; Fri, 20 Jan 2017 23:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752247AbdATXUH (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 18:20:07 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51823 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752125AbdATXUG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 18:20:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0F4CB63B27;
        Fri, 20 Jan 2017 18:20:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ubQQW+eZAi2TPZc3hvYvmT0NG5s=; b=mvpWgp
        ByEWn1oHvPIQjh4kGmarji2p1UquuPblqhQTzO/cBmCYB1x3GTMcPncH8d8j4/10
        Jjzh33gl/1x9lfMr7AbginzIMDGn+NiY2DLdv+Iit7ZhO9RwQ7HIDRwZGuIi8Qlt
        zXmk8c/u/VSYI3q8ZN3G8QxhbWp2L3JKd0dcc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RQ7PppOX1/T1OcMl8e1hOxtaD3Cs9TxT
        uKZXP5HKywpLMJLt6pynSBiPq778EDPQxSvb5Csbsved3zOFt8SJ8Qz8H55Asoks
        YVpL0ORkOx+GLCjY7xt1T5myEbwmQ7gd+M+dIO7JKno6E/NnzbusmYvO4ANMOgqv
        fmmV3PKCJxs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CD0AD63B26;
        Fri, 20 Jan 2017 18:20:04 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AE90663B23;
        Fri, 20 Jan 2017 18:20:02 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vladimir Panteleev <thecybershadow@gmail.com>
Cc:     Vladimir Panteleev <git@thecybershadow.net>, git@vger.kernel.org
Subject: Re: [PATCH] show-ref: Allow --head to work with --verify
References: <20170120155015.4360-1-git@thecybershadow.net>
        <xmqqa8aly2o4.fsf@gitster.mtv.corp.google.com>
        <3b1d2717-dd7f-2add-b935-3ace6063b258@gmail.com>
Date:   Fri, 20 Jan 2017 15:20:00 -0800
In-Reply-To: <3b1d2717-dd7f-2add-b935-3ace6063b258@gmail.com> (Vladimir
        Panteleev's message of "Fri, 20 Jan 2017 22:55:12 +0000")
Message-ID: <xmqqshoduxnj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F86AC576-DF66-11E6-94E0-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vladimir Panteleev <thecybershadow@gmail.com> writes:

> --quiet will still work correctly with the current patch, because
> show_ref already checks quiet. Granted, the original --verify code
> used show_one and not show_ref; however, I don't see a meaningful
> difference between calling show_ref and show_one for HEAD, other than
> a bit of overhead, so adding a new function may not be worthwhile. I
> will still add tests for this; however, in light of this, would you
> still like me to perform the change you requested?

If two codepaths are called "I don't see a meaningful difference",
then it is really better to share the same code.  Today, they may
happen to behave identically.  When we need to update the behaviour
of one, we'd be forced to update the other one to match.

IOW, something along this line, perhaps (not even compile tested so
take it with grain of salt).

Thanks.

 builtin/show-ref.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 6d4e669002..57491152b7 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -202,7 +202,8 @@ int cmd_show_ref(int argc, const char **argv, const char *prefix)
 		while (*pattern) {
 			struct object_id oid;
 
-			if (starts_with(*pattern, "refs/") &&
+			if (((show_head && !strcmp(*pattern, "HEAD")) ||
+			     starts_with(*pattern, "refs/")) &&
 			    !read_ref(*pattern, oid.hash)) {
 				if (!quiet)
 					show_one(*pattern, &oid);



