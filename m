Return-Path: <SRS0=5dtp=C4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B31C43463
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 00:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CABB221EC
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 00:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MoRj878X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgISACm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 20:02:42 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56117 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgISACm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 20:02:42 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A0147E2A47;
        Fri, 18 Sep 2020 20:02:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EN6iQW5h7jLbflz/5+ZADYCP6nk=; b=MoRj87
        8XCRa4o53HL9CL7AhMaQj5Jb4VN0zmTdm1irE8hFkHroQF4twdSm8XxC7tAPOxxU
        f9pLmpH4mGGz3mB3t8aSZzXvGV1H3FtsMmq9TA2p2nnxgM21BPUkQPvP9qpxqgBi
        6Mtkq3VLbKJ5c+isDEWG0LHa8U6iFdK4hCyC4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KcjkLjenxCLKBIpC2Yc/e1MjTFYhLbAf
        D2f1OaD9cpU4wom8vL4DgN/ETBsTKk3GOoEG/4FYwICKPAphpf/IEocoD9Z75X6D
        s5/hkQES6coQPzS6DgxOUtGYrHDmsW+s/Q3OBuBne+M9oN/ptmnizo/qGibsBiCG
        PUj367jI7ao=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 979C0E2A45;
        Fri, 18 Sep 2020 20:02:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.190.152.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E0A56E2A44;
        Fri, 18 Sep 2020 20:02:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han Xin <chiyutianyi@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Han Xin <hanxin.hx@alibaba-inc.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v2] send-pack: run GPG after atomic push checking
References: <xmqqv9gdthgj.fsf@gitster.c.googlers.com>
        <20200918045052.13022-1-hanxin.hx@alibaba-inc.com>
Date:   Fri, 18 Sep 2020 17:02:36 -0700
In-Reply-To: <20200918045052.13022-1-hanxin.hx@alibaba-inc.com> (Han Xin's
        message of "Fri, 18 Sep 2020 12:50:52 +0800")
Message-ID: <xmqqft7eljkz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6DA57EB8-FA0B-11EA-B85C-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han Xin <chiyutianyi@gmail.com> writes:

> The refs update commands can be sent to the server side in two different
> ways: GPG-signed or unsigned.  We should run these two operations in the
> same "Finally, tell the other end!" code block, but they are seperated
> by the "Clear the status for each ref" code block.  This will result in
> a slight performance loss, because the failed atomic push will still
> perform unnecessary preparations for shallow advertise and GPG-signed
> commands buffers.

I am not sure if that is a good justification for this patch. In the
context of a push that involves GPG signature, preparation of the
buffer contents to be signed can hardly be the performance
bottleneck.

Also, this change, if sold solely on the basis of performance, is
optimizing for the wrong case of the user _failing_ to propose a
push that is atomic.

The true value I see in this change is that the user won't have to
be bothered by the (possible) GPG passphrase input when there is
nothing to sign.  Let's sell the change as such instead.

> Add a new test case to t5534 to ensure GPG will not be called when the
> GPG-signed atomic push fails.

As I mentioned in the previous round of the review, I am not sure if
it is wise to expect that the exact phrasing of error messages like
"atomic push failed" and "non-fast-forward" to stay constant and the
output format of the "git push" to stay exactly the same in this
test.  

Wouldn't it be more robust to grep for a message that emitted from
the error codepath in sign_buffer(), e.g. "gpg failed to sign", in
order to ensure absense of the sign that GPG were attempted?

The replacement test I have in mind would look like the attached.

Thanks.


diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
index 030331f1c5..3eb3642abb 100755
--- a/t/t5534-push-signed.sh
+++ b/t/t5534-push-signed.sh
@@ -273,4 +273,17 @@ test_expect_success GPGSM 'fail without key and heed user.signingkey x509' '
 	test_cmp expect dst/push-cert-status
 '
 
+test_expect_success GPG 'failed atomic push does not execute GPG' '
+	prepare_dst &&
+	git -C dst config receive.certnonceseed sekrit &&
+	write_script gpg <<-EOF &&
+	# should check atomic push locally before running GPG.
+	exit 1
+	EOF
+	test_must_fail env PATH="$TRASH_DIRECTORY:$PATH" git push \
+			--signed --atomic --porcelain \
+			dst noop ff noff >out 2>&1 &&
+	test_i18ngrep ! "gpg failed to sign" out
+'
+
 test_done
