Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994E8C433DB
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 05:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4672D22CE3
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 05:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388371AbhALFZW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 00:25:22 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57660 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbhALFZW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 00:25:22 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3A278F9FA7;
        Tue, 12 Jan 2021 00:24:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bYirLoNZFuqyDV/25rkQdLhT9LA=; b=sAWNw7
        CPdyc/Fe+3ZWgz6CHasPOpmnkMFCi40Lbm9Fjvq6zLGAOrgVoHsEXRpNo4yhMqKa
        XDOlT6D67LhZimmmZonZe1wYhBTuqFdYLiGl/abpinGrZDM4kAbpYfDk7bloIGQ1
        VzYhdjjjtUpuQfWSLnzXX3EQS1L6AtPwnicyk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Cy58lUyT5qMGRa/Z5fYuZ8x7KPfyT/s0
        nXkLDppcEpGf4lNabNOv7UuJWeaTj5tziJ8cuG7u1HuIJ4jY0KtmALrY/Yny/+ma
        VU6/wj5bRiDtvMGrCwzDaX9StK7m6bfmYQ4yZTNl7yQQvU6IZ8fdzEPmyBqeazrE
        XhBtL0IOKEQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 32DFCF9FA6;
        Tue, 12 Jan 2021 00:24:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AF144F9FA5;
        Tue, 12 Jan 2021 00:24:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/5] gpg-interface: improve interface for parsing tags
References: <20210111003740.1319996-1-sandals@crustytoothpaste.net>
        <20210111035840.2437737-1-sandals@crustytoothpaste.net>
        <20210111035840.2437737-3-sandals@crustytoothpaste.net>
Date:   Mon, 11 Jan 2021 21:24:36 -0800
In-Reply-To: <20210111035840.2437737-3-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 11 Jan 2021 03:58:37 +0000")
Message-ID: <xmqq7doi682z.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 76A5732A-5496-11EB-BF9C-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> diff --git a/ref-filter.c b/ref-filter.c
> index aa260bfd09..8d8baec1b5 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1215,7 +1215,13 @@ static void find_subpos(const char *buf,
>  			unsigned long *nonsiglen,
>  			const char **sig, unsigned long *siglen)
>  {

I think a preliminary clean-up should look like this.

Tonight's tip of 'seen' contains this at the tip of your topic.

  https://github.com/git/git/actions/runs/479421349

Thanks.

diff --git a/ref-filter.c b/ref-filter.c
index 32ed4d5111..e6c8106377 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1210,10 +1210,10 @@ static void grab_person(const char *who, struct atom_value *val, int deref, void
 }
 
 static void find_subpos(const char *buf,
-			const char **sub, unsigned long *sublen,
-			const char **body, unsigned long *bodylen,
-			unsigned long *nonsiglen,
-			const char **sig, unsigned long *siglen)
+			const char **sub, size_t *sublen,
+			const char **body, size_t *bodylen,
+			size_t *nonsiglen,
+			const char **sig, size_t *siglen)
 {
 	struct strbuf payload = STRBUF_INIT;
 	struct strbuf signature = STRBUF_INIT;
@@ -1291,7 +1291,7 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
 {
 	int i;
 	const char *subpos = NULL, *bodypos = NULL, *sigpos = NULL;
-	unsigned long sublen = 0, bodylen = 0, nonsiglen = 0, siglen = 0;
+	size_t sublen = 0, bodylen = 0, nonsiglen = 0, siglen = 0;
 
 	for (i = 0; i < used_atom_cnt; i++) {
 		struct used_atom *atom = &used_atom[i];
