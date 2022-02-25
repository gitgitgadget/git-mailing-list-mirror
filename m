Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E79C433EF
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 00:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbiBYAeR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 19:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbiBYAeQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 19:34:16 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F97124FA1B
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 16:33:45 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A891F184CB6;
        Thu, 24 Feb 2022 19:33:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=M0A6Wv783CeIVDrVCUuQYmCLgeVs+GcH9kF7NM
        8Jq9A=; b=QKbDRkiED93Sr0gqwwxgZs33X6PxcRnJWGxjc0LhkV7nHwyEu1hMM2
        qBIHjytTcvdWhDhGfZBICmKblwaOJ7lePnaNWu6u0JM+0lGgMp9pVGE9MNhwBF1D
        eAGn56JDyNY3YSCxdSIpvv7xiVxUtMyMUYIVNZkPTc78mVK/pqH6k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A2050184CB5;
        Thu, 24 Feb 2022 19:33:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1D946184CB4;
        Thu, 24 Feb 2022 19:33:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v3 09/10] fetch: fetch unpopulated, changed submodules
References: <20220215172318.73533-1-chooglen@google.com>
        <20220224100842.95827-1-chooglen@google.com>
        <20220224100842.95827-10-chooglen@google.com>
Date:   Thu, 24 Feb 2022 16:33:41 -0800
In-Reply-To: <20220224100842.95827-10-chooglen@google.com> (Glen Choo's
        message of "Thu, 24 Feb 2022 18:08:41 +0800")
Message-ID: <xmqqsfs7hjiy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9540DC9C-95D2-11EC-9F5F-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:


> +static struct fetch_task *
> +get_fetch_task_from_changed(struct submodule_parallel_fetch *spf,
> +			    struct strbuf *err)
> +{
> +	for (; spf->changed_count < spf->changed_submodule_names.nr;
> +	     spf->changed_count++) {
> +		struct string_list_item item =
> +			spf->changed_submodule_names.items[spf->changed_count];
> +		struct changed_submodule_data *cs_data = item.util;
> +		struct fetch_task *task;
> +
> +		if (!is_tree_submodule_active(spf->r, cs_data->super_oid,cs_data->path))
> +			continue;

Where does this function come from?  I seem to be getting compilation errors.

> diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
> index ee4dd5a4a9..639290d30d 100755
> --- a/t/t5526-fetch-submodules.sh
> +++ b/t/t5526-fetch-submodules.sh
> @@ -15,8 +15,9 @@ pwd=$(pwd)
>  
>  check_sub() {

Style.  

	check_sub () {

>  	NEW_HEAD=$1 &&
> +	SUPER_HEAD=$2 &&
>  	cat <<-EOF >$pwd/expect.err.sub

Style.

	cat <<-EOF >"$pwd/expect.err.sub"

You may swap the order of redirection (having <<here-doc at the end
of the line might look more familiar to some people).  Try to do as
majority of surrounding code does.

Make sure you quote the redirection target filename if it involves
variable interpolation (see Documentation/CodingGuidelines, look for
"Redirection").

> +	cat <<-EOF > expect.err.combined &&

Style.

	cat <<-EOF >expect.err.combined &&

No SP between redirection operator and its target.

> +	sed -E "s/[0-9a-f]+\.\./OLD_HEAD\.\./" actual.err >actual.err.cmp &&

No ERE in sed.  "[0-9a-f][0-9a-f]*" instead of "[0-9a-f]+" should be
sufficient, I think.
