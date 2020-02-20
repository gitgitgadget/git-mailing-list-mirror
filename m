Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EFAC11D00
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 22:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A3720801
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 22:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ycPFOhCc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbgBTWS5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 17:18:57 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50876 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbgBTWS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 17:18:57 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BA37951972;
        Thu, 20 Feb 2020 17:18:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=n5IXSMtfwz1Wjtsmi7vFSfDsdhQ=; b=ycPFOh
        CcNiZGuHbooB3Z0w2AEvPTKSWsG1o+dtRjfLj49hc72pgwQ3/Yv/147VfpFU30j3
        R5Hj72oAab2OUkdCHh8m7VP3585SjQjLaGZZqu5lLkVO+OEJdHf+caKal8+g/Gvh
        WDhJIKp29Bh2wotsHn1UBvPxqk2dOYirclWYo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UBjW60oz1O9PcCipW+xZBQwY6Z8oMJyn
        VAbZw8x/j1OAQgbmCQs5epjqc0ALFtkFNh7y1Mwnv8LbavqcOzcvtRzOf4rxxTb1
        UAUi2YKVSHUnDbRSAehWfHDEhByk0pndVMsD7cpcL2cshiEmxcLouHSLsobLH+dE
        rABz1mKidDk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B1A4F51971;
        Thu, 20 Feb 2020 17:18:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 226F451970;
        Thu, 20 Feb 2020 17:18:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 14/15] bugreport: list contents of $OBJDIR/info
References: <20200220015858.181086-1-emilyshaffer@google.com>
        <20200220015858.181086-15-emilyshaffer@google.com>
Date:   Thu, 20 Feb 2020 14:18:53 -0800
In-Reply-To: <20200220015858.181086-15-emilyshaffer@google.com> (Emily
        Shaffer's message of "Wed, 19 Feb 2020 17:58:57 -0800")
Message-ID: <xmqqwo8g9a2a.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FAD27B98-542E-11EA-8A87-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> +static void list_contents_of_dir_recursively(struct strbuf *contents,
> +					     struct strbuf *dirpath)
> +{
> +	struct dirent *d;
> +	DIR *dir;
> +	size_t path_len;
> +
> +	dir = opendir(dirpath->buf);
> +	if (!dir)
> +		return;

No error detected?

> +	strbuf_complete(dirpath, '/');
> +	path_len = dirpath->len;
> +
> +	while ((d = readdir(dir))) {
> +		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
> +			continue;
> +
> +		strbuf_addbuf(contents, dirpath);
> +		strbuf_addstr(contents, d->d_name);
> +		strbuf_complete_line(contents);
> +
> +		if (d->d_type == DT_DIR) {
> +			strbuf_addstr(dirpath, d->d_name);
> +			list_contents_of_dir_recursively(contents, dirpath);
> +		}
> +		strbuf_setlen(dirpath, path_len);

Shouldn't we be sorting the output?

> +	}
> +
> +	closedir(dir);
> +}

Hmph, it is somewhat sad that we have to reinvent a degraded copy of
"ls -aR" like this.

> +static void get_object_info_summary(struct strbuf *obj_info, int nongit)
> +{
> +	struct strbuf dirpath = STRBUF_INIT;
> +
> +	if (nongit) {
> +		strbuf_addstr(obj_info,
> +			"not run from a git repository - object info unavailable\n");
> +		return;
> +	}
> +
> +	strbuf_addstr(&dirpath, get_object_directory());
> +	strbuf_complete(&dirpath, '/');
> +	strbuf_addstr(&dirpath, "info/");

Would it help to use git_path() for this, perhaps like
git_path("objects/info/")?

By the way, do we store anything worth knowing in $GIT_DIR/info too?
Perhaps the per-repo attributes and excludes files whose presence
may hint at another question to ask when a user reports unexpected
behaviour from .gitignore?

> +	list_contents_of_dir_recursively(obj_info, &dirpath);
> +	strbuf_release(&dirpath);
> +}
> +
>  static const char * const bugreport_usage[] = {
>  	N_("git bugreport [-o|--output-directory <file>] [-s|--suffix <format>]"),
>  	NULL
> @@ -301,6 +352,9 @@ int cmd_main(int argc, const char **argv)
>  	get_header(&buffer, "Packed Object Summary");
>  	get_packed_object_summary(&buffer, nongit_ok);
>  
> +	get_header(&buffer, "Object Info Summary");
> +	get_object_info_summary(&buffer, nongit_ok);
> +
>  	report = fopen_for_writing(report_path.buf);
>  
>  	if (report == NULL) {
