Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09A2D1F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 02:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388790AbfJWCZG (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 22:25:06 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63783 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729994AbfJWCZG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 22:25:06 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ED77A8B2A9;
        Tue, 22 Oct 2019 22:25:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0jpALkW8pdUZBlY9ioYpM09UY2c=; b=SKmHWb
        fIBXKKpqBVKVTOMt9wp5wRP5RJQECjUvcUDsNlVSuFTxgrynn4suhZFUA+ySF3go
        WBbmE1kmn6dppXOHfLan4Bu2dr+Wd4rMKZjdgiN/2N9e9Fq01WkmgEl163g6zQcr
        qwR3fMbWVx7c07lVjdASTZNCZabAd/6hnVS2c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JTzjMZjzgmOUB9USMvtw8GDg09ze0svI
        06ZK0PnFhHpdvC3NjJMRCBMNbZOgaXoaIrHRyJDRz2n5vuHN++I7Sq35h5ycRXvs
        gekXJ3uSlQTr+n8RAPqBNRQCd+x8NPeNSMB4fJjc4p6lR7kc4sJabnQA3D/9YXwQ
        vsaOI5Si9lc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E63888B2A8;
        Tue, 22 Oct 2019 22:25:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EFCAC8B2A3;
        Tue, 22 Oct 2019 22:25:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jerome Pouiller <Jerome.Pouiller@silabs.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [BUG] "--show-current-patch" return a mail instead of a patch
References: <2154192.LVDMpRDY2h@pc-42>
Date:   Wed, 23 Oct 2019 11:24:58 +0900
In-Reply-To: <2154192.LVDMpRDY2h@pc-42> (Jerome Pouiller's message of "Tue, 22
        Oct 2019 10:18:03 +0000")
Message-ID: <xmqqzhhsi4g5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 509F346E-F53C-11E9-8657-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jerome Pouiller <Jerome.Pouiller@silabs.com> writes:

> Hello all,
>
> I try to use "git am" to apply a patch sent using "git send-email". This
> patch does not apply properly. I try to use "git am --show-current-patch"
> to understand the problem. However, since original mail is encoded in quoted-
> printable, data returned by --show-current-patch is not a valid patch.

I agree that --show-current-patch is a misdesigned feature.  We'd be
doing a better service to our users if we documented that the patch
and log message are found at .git/rebase-apply/{patch,msg} instead
of trying to hide the path.

Unfortunately, it is likely that those who added that feature have
built their tooling around it to depend on its output being the full
e-mail message "am" was fed (and split by "git mailsplit").  So I do
not think we will be changing the output to the patch file only.

But even then, the documentation can be fixed without any backward
compatibility issues.  Perhaps like this?

 Documentation/git-am.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 6f6c34b0f4..f63b70325c 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -172,7 +172,7 @@ default.   You can use `--no-utf8` to override this.
 	untouched.
 
 --show-current-patch::
-	Show the patch being applied when "git am" is stopped because
+	Show the entire e-mail message "git am" has stopped at, because
 	of conflicts.
 
 DISCUSSION

