Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D52A2036D
	for <e@80x24.org>; Wed, 22 Nov 2017 05:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751244AbdKVFD1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 00:03:27 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56342 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750959AbdKVFD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 00:03:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B3F28BC5DA;
        Wed, 22 Nov 2017 00:03:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wEn5cOE4vb3weO9/ypT06bt/UkY=; b=b6ytB/
        sTzbiBC9sIHQ6hIE4IX3H4zR8NRno77BpfZjVvaLtBoCCUWFAvjrWnHQGKU8z7hx
        02RINsRloRoOW2DTPnv16Gw9v255kNZTZI7XvthVGtutygKM97sE5y8RY7oJeI6v
        zc3jrtp1U2x3luyPYa1fx7POt5k9urVZjW3Pc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=arVBedDLqc+fMYY2Dm4HVuOiep0GAT0I
        oiMb2Gd7xRkGDKzo3cEK0EUHW75rAKlc6AtmaEyCBB+13r9H+5834CfqZQv6yeO9
        Rti0D/eUop1VsWIUC8Wb9ecCQ1O8hod7qcR9daW1UcHaRtuOUY+UMgitBonieAZ6
        I4bama0qH1s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AB85EBC5D9;
        Wed, 22 Nov 2017 00:03:25 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2956ABC5D8;
        Wed, 22 Nov 2017 00:03:25 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phil Hord <phil.hord@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: [PATCH] defer expensive load_ref_decorations until needed
References: <20171121234336.10209-1-phil.hord@gmail.com>
Date:   Wed, 22 Nov 2017 14:03:24 +0900
In-Reply-To: <20171121234336.10209-1-phil.hord@gmail.com> (Phil Hord's message
        of "Tue, 21 Nov 2017 15:43:36 -0800")
Message-ID: <xmqqbmjuvrab.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 78568F06-CF42-11E7-AE54-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phil Hord <phil.hord@gmail.com> writes:

> With many thousands of references, a simple `git rev-parse HEAD` may take
> more than a second to return because it first loads all the refs into
> memory even though it will never use them.
>
> Defer loading any references until we actually need them.
>
> Signed-off-by: Phil Hord <phil.hord@gmail.com>
> ---
>  log-tree.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/log-tree.c b/log-tree.c
> index 3b904f037..c1509f8b9 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -84,8 +84,10 @@ void add_name_decoration(enum decoration_type type, const char *name, struct obj
>  	res->next = add_decoration(&name_decoration, obj, res);
>  }
>  
> +static void maybe_load_ref_decorations();

I'll tweak that "()" and the other one we see below to "(void)"
while queuing.

I am not sure if "maybe_" is a good name here, though.  If anything,
you are making the semantics of "load_ref_decorations()" to "maybe"
(but I do not suggest renaming that one).

How about calling it to load_ref_decorations_lazily() or something?

I also wonder if decoration_loaded should now become function-scope
static in this new helper, but that can be left outside of the
topic.

Other than that, I like what this patch attempts to do.  A nicely
identified low-hanging fruit ;-).

Thanks.

>  const struct name_decoration *get_name_decoration(const struct object *obj)
>  {
> +	maybe_load_ref_decorations();
>  	return lookup_decoration(&name_decoration, obj);
>  }
>  
> @@ -150,10 +152,13 @@ static int add_graft_decoration(const struct commit_graft *graft, void *cb_data)
>  
>  void load_ref_decorations(int flags)
>  {
> -	if (!decoration_loaded) {
> +	decoration_flags = flags;
> +}
>  
> +static void maybe_load_ref_decorations()
> +{
> +	if (!decoration_loaded) {
>  		decoration_loaded = 1;
> -		decoration_flags = flags;
>  		for_each_ref(add_ref_decoration, NULL);
>  		head_ref(add_ref_decoration, NULL);
>  		for_each_commit_graft(add_graft_decoration, NULL);
