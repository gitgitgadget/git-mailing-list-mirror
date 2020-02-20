Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0780BC11D24
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 22:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDFB8206F4
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 22:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="s9wTOYXz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgBTWWq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 17:22:46 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51890 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbgBTWWp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 17:22:45 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C5501AEF68;
        Thu, 20 Feb 2020 17:22:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PZnNwNa2G6vFtWszWfE1SJqe/AI=; b=s9wTOY
        Xz0UffIkzUIHxuU2MVfvRFzsVJaF+mw8bNSBq8+Ou29ELDSjXIyfqZF2q5C8T2Sr
        8m1rk7swqvCiHvyIbAYkKReonnjZA4g7bjKS8ExCH3HHy5NBY9zHa/mXJjeS/2z4
        V6AZxiy8sToY/jTaCV1FQiiQNPoL04heMSLN0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dnK3CDryK162QCGdJF6I7xtTj3F3Mra8
        nsqPJ7feM3mo4K1rm33XjgPg0vNEOtaWtvABiZ3VbtJQVyyi3JFEeXRLeVIfqYoi
        EmlRX493q/07vwqCAS7IptrUSuzWDnhUL2KzS1bS/MPBRfPaZbyL36v40f3qlxY7
        9AwU0OJeJFE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BC7B0AEF67;
        Thu, 20 Feb 2020 17:22:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 25EC2AEF64;
        Thu, 20 Feb 2020 17:22:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 15/15] bugreport: summarize contents of alternates file
References: <20200220015858.181086-1-emilyshaffer@google.com>
        <20200220015858.181086-16-emilyshaffer@google.com>
Date:   Thu, 20 Feb 2020 14:22:36 -0800
In-Reply-To: <20200220015858.181086-16-emilyshaffer@google.com> (Emily
        Shaffer's message of "Wed, 19 Feb 2020 17:58:58 -0800")
Message-ID: <xmqqsgj499w3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 80585F4E-542F-11EA-9E29-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> +static void get_alternates_summary(struct strbuf *alternates_info, int nongit)
> +{
> +	struct strbuf alternates_path = STRBUF_INIT;
> +	struct strbuf alternate = STRBUF_INIT;
> +	FILE *file;
> +	size_t exists = 0, broken = 0;
> +
> +	if (nongit) {
> +		strbuf_addstr(alternates_info,
> +			"not run from a git repository - alternates unavailable\n");
> +		return;
> +	}
> +
> +	strbuf_addstr(&alternates_path, get_object_directory());
> +	strbuf_complete(&alternates_path, '/');
> +	strbuf_addstr(&alternates_path, "info/alternates");

git_path()?

> +	file = fopen(alternates_path.buf, "r");
> +	if (!file) {
> +		strbuf_addstr(alternates_info, "No alternates file found.\n");
> +		strbuf_release(&alternates_path);
> +		return;
> +	}
> +
> +	while (strbuf_getline(&alternate, file) != EOF) {
> +		if (!access(alternate.buf, F_OK))
> +			exists++;

F_OK reported as "exists" makes quite a lot of sense.

> +		else
> +			broken++;

So, shouldn't this rather be "missing"?

> +	}
> +
> +	strbuf_addf(alternates_info,
> +		    "%zd alternates found (%zd working, %zd broken)\n",
> +		    exists + broken,
> +		    exists,
> +		    broken);

I don't see the point of using size_t for this.  Just use int for
both, like you did for object count in the step that counds loose
and packed objects.

> +	fclose(file);
> +	strbuf_release(&alternate);
> +	strbuf_release(&alternates_path);
> +}
> +
>  static const char * const bugreport_usage[] = {
>  	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>]"),
>  	NULL
> @@ -355,6 +397,9 @@ int cmd_main(int argc, const char **argv)
>  	get_header(&buffer, "Object Info Summary");
>  	get_object_info_summary(&buffer, nongit_ok);
>  
> +	get_header(&buffer, "Alternates");
> +	get_alternates_summary(&buffer, nongit_ok);
> +
>  	report = fopen_for_writing(report_path.buf);
>  
>  	if (report == NULL) {
