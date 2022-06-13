Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE422C43334
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 22:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbiFMWI4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 18:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbiFMWIy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 18:08:54 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75990101DB
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 15:08:53 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A54391A82D2;
        Mon, 13 Jun 2022 18:08:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ktgew/hS8/S85vQQnpf83LulYRBLDmwkWH3SGf
        5Atxc=; b=k7gatj7JNDzoDwRmNihdDll9FPUyNwohi7MvRCwNtfpiij4RmkQU7r
        Wx93h7GYldRyVRPUXGc+NffACyrh6rDHiCI55aR7Z0iN1rjJY2jhextyeMLkpGxY
        Vm2czkfByj1D0NgaLBtOSxrKhtPX5+XPTzJ7RBW7dhGQ9vRhlKk3U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9DD221A82D1;
        Mon, 13 Jun 2022 18:08:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3763A1A82CE;
        Mon, 13 Jun 2022 18:08:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>, Li Linchao <lilinchao@oschina.cn>
Subject: Re: [PATCH v3] remote-curl: send Accept-Language header to server
References: <pull.1251.v2.git.1654756523475.gitgitgadget@gmail.com>
        <pull.1251.v3.git.1655054421697.gitgitgadget@gmail.com>
        <xmqq1qvs5jx4.fsf@gitster.g>
Date:   Mon, 13 Jun 2022 15:08:47 -0700
In-Reply-To: <xmqq1qvs5jx4.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        13 Jun 2022 14:32:23 -0700")
Message-ID: <xmqqedzs43o0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 66E8C92A-EB65-11EC-B837-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +	accept_language = http_get_accept_language_header();
>> +	if (accept_language)
>> +		rpc.hdr_accept_language = xstrfmt("%s", accept_language);
>
> Isn't rpc.hdr_accept_language left uninitialized garbage if
> accept_language is NULL?  It is the same bug I pointed out earlier,
> whose fix may have to be different.
>
> Has this been tested?  I got immediate segfault with this patch in
> 'seen'.

Having said all that, I wonder if we want to use something like this
to make it hard to use an uninitialized data.

The smart-http is quite outside of my area of expertise, and I do
not know what Shawn was thinking when de1a2fdd (Smart push over
HTTP: client side, 2009-10-30) was written (it could be that filling
all members explicitly was the more prevalent stype back then?).
I'd appreciate input from folks who regularly deal with smart-http
on the approach.

Thanks.

 remote-curl.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git i/remote-curl.c w/remote-curl.c
index 251d4ee64f..ba6f76a0c1 100644
--- i/remote-curl.c
+++ w/remote-curl.c
@@ -608,6 +608,8 @@ struct rpc_state {
 	unsigned flush_read_but_not_sent : 1;
 };
 
+#define RPC_STATE_INIT { 0, }
+
 /*
  * Appends the result of reading from rpc->out to the string represented by
  * rpc->buf and rpc->len if there is enough space. Returns 1 if there was
@@ -1161,7 +1163,7 @@ static int fetch_dumb(int nr_heads, struct ref **to_fetch)
 static int fetch_git(struct discovery *heads,
 	int nr_heads, struct ref **to_fetch)
 {
-	struct rpc_state rpc;
+	struct rpc_state rpc = RPC_STATE_INIT;
 	struct strbuf preamble = STRBUF_INIT;
 	int i, err;
 	struct strvec args = STRVEC_INIT;
@@ -1307,7 +1309,7 @@ static int push_dav(int nr_spec, const char **specs)
 
 static int push_git(struct discovery *heads, int nr_spec, const char **specs)
 {
-	struct rpc_state rpc;
+	struct rpc_state rpc = RPC_STATE_INIT;
 	int i, err;
 	struct strvec args;
 	struct string_list_item *cas_option;
@@ -1406,7 +1408,7 @@ static void parse_push(struct strbuf *buf)
 static int stateless_connect(const char *service_name)
 {
 	struct discovery *discover;
-	struct rpc_state rpc;
+	struct rpc_state rpc = RPC_STATE_INIT;
 	struct strbuf buf = STRBUF_INIT;
 	const char *accept_language;
 
