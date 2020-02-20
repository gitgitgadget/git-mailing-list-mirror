Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EB9C11D20
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 21:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A60208E4
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 21:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zs1esa5R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbgBTVEk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 16:04:40 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63651 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728582AbgBTVEk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 16:04:40 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BCA8A51083;
        Thu, 20 Feb 2020 16:04:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JDS+yH26cZ3sJamMrofJvncEMXw=; b=Zs1esa
        5RcMjkZserT7biMHO8uo0rchTLoC3VidaZG/aEZQy2nC6cZUA2e57U0IioaxzA3f
        sRX5/PQJT6V2Ch8vDoWHtaF+Ns6RVuFxKkf2ZYw9P4L4G+g9zO0zxHFMDXTPg7F5
        PYpbghZVIsDuZwRyxYnnplqZyt21srGf7dOGE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Iexp4Y51MEJ70GZHAsRdmJAxPNa+taEn
        E3rKXvM2SZX4eepHCZoVARWUReCUUvfDO3fiwfWlgCgGKGNz0NXKyyydWbdutwHC
        GGUtDfPFNb6cgzuzoBUXCEYER2Uzr/oHCLaInaS8ZIg08szHRe49OSgV/hpGlG+V
        widWCXMalnQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B4C6451082;
        Thu, 20 Feb 2020 16:04:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1F24A51081;
        Thu, 20 Feb 2020 16:04:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v8 12/15] bugreport: count loose objects
References: <20200220015858.181086-1-emilyshaffer@google.com>
        <20200220015858.181086-13-emilyshaffer@google.com>
Date:   Thu, 20 Feb 2020 13:04:33 -0800
In-Reply-To: <20200220015858.181086-13-emilyshaffer@google.com> (Emily
        Shaffer's message of "Wed, 19 Feb 2020 17:58:55 -0800")
Message-ID: <xmqqa75d9di6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 99A3FFB8-5424-11EA-A6CE-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> The number of unpacked objects in a user's repository may help us
> understand the root of the problem they're seeing, especially if a
> command is running unusually slowly.
>
> Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  Documentation/git-bugreport.txt |  1 +
>  bugreport.c                     | 52 +++++++++++++++++++++++++++++++++
>  2 files changed, 53 insertions(+)
>
> diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
> index 4d01528540..4fe1c60506 100644
> --- a/Documentation/git-bugreport.txt
> +++ b/Documentation/git-bugreport.txt
> @@ -32,6 +32,7 @@ The following information is captured automatically:
>   - $SHELL
>   - Selected config values
>   - A list of enabled hooks
> + - The number of loose objects in the repository
>  
>  This tool is invoked via the typical Git setup process, which means that in some
>  cases, it might not be able to launch - for example, if a relevant config file
> diff --git a/bugreport.c b/bugreport.c
> index b5a0714a7f..fb7bc72723 100644
> --- a/bugreport.c
> +++ b/bugreport.c
> @@ -10,6 +10,7 @@
>  #include "bugreport-config-safelist.h"
>  #include "khash.h"
>  #include "run-command.h"
> +#include "object-store.h"
>  
>  static void get_git_remote_https_version_info(struct strbuf *version_info)
>  {
> @@ -128,6 +129,54 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
>  	}
>  }
>  
> +static int loose_object_cb(const struct object_id *oid, const char *path,
> +			   void *data) {
> +	int *loose_object_count = data;
> +
> +	if (loose_object_count) {
> +		(*loose_object_count)++;
> +		return 0;
> +	}
> +
> +	return 1;

What is the point of returning 1 here to abort the iteration early?
Wouldn't it be a BUG() if this callback ends up gettting called with
NULL in data?

> +}
> +
> +static void get_loose_object_summary(struct strbuf *obj_info, int nongit) {
> +
> +	int local_loose_object_count = 0, total_loose_object_count = 0;
> +	int local_count_questionable = 0, total_count_questionable = 0;
> +
> +	if (nongit) {
> +		strbuf_addstr(obj_info,
> +			"not run from a git repository - no objects to show\n");
> +		return;
> +	}
> +
> +	local_count_questionable = for_each_loose_object(
> +					loose_object_cb,
> +					&local_loose_object_count,
> +					FOR_EACH_OBJECT_LOCAL_ONLY);
> +
> +	total_count_questionable = for_each_loose_object(
> +					loose_object_cb,
> +					&total_loose_object_count,
> +					0);
> +	strbuf_addf(obj_info, "%d local loose objects%s\n",
> +		    local_loose_object_count,
> +		    local_count_questionable ? " (problem during count)" : "");
> +
> +	strbuf_addf(obj_info, "%d alternate loose objects%s\n",
> +		    total_loose_object_count - local_loose_object_count,
> +		    (local_count_questionable || total_count_questionable)
> +			? " (problem during count)"
> +			: "");
> +
> +	strbuf_addf(obj_info, "%d total loose objects%s\n",
> +		    total_loose_object_count,
> +		    total_count_questionable ? " (problem during count)" : "");
> +}
> +
>  static const char * const bugreport_usage[] = {
>  	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>]"),
>  	NULL
> @@ -219,6 +268,9 @@ int cmd_main(int argc, const char **argv)
>  	get_header(&buffer, "Enabled Hooks");
>  	get_populated_hooks(&buffer, nongit_ok);
>  
> +	get_header(&buffer, "Loose Object Counts");
> +	get_loose_object_summary(&buffer, nongit_ok);
> +
>  	report = fopen_for_writing(report_path.buf);
>  
>  	if (report == NULL) {
