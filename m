From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH 3/3] config: --get-urlmatch
Date: Tue, 30 Jul 2013 12:14:03 -0700
Message-ID: <C34D29B7-055D-4D82-B9FE-27150E51FF79@gmail.com>
References: <7vli4v66b3.fsf@alter.siamese.dyndns.org> <1375138150-19520-1-git-send-email-gitster@pobox.com> <1375138150-19520-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 30 21:14:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4FNJ-0004Ru-HC
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 21:14:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756140Ab3G3TOT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jul 2013 15:14:19 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:52826 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754613Ab3G3TOH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 15:14:07 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj1so5959505pad.28
        for <git@vger.kernel.org>; Tue, 30 Jul 2013 12:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mauler;
        bh=1f4fmR7xiMs4Xs1uyWYCnWdqQGmKHrR99H6SBNZ/uDY=;
        b=RstTLZzZ6JDnQOGhLqZkC1lEpuYBafXmgA3bbVS17Ltgtz5XzVglTo7ef1BtxE+/Sy
         vYoELdi9xIO983gT6gUxOLqJun3A6F51nN14HmWR3EOZgdS6VQwVBgvngsEGspwsNAqa
         1+MwFC5iBdT3cycev203AQAsFdbSUyPHfgOXLlcaHrzWGSEh/x1ZPySuuQyzYoB3h9eV
         ZW73Xojtq88BpdI3y4+1iD7a109mDo7Ox2NvmYMlqXPNFby42Fw1k8Mi52r3gTQMH0hu
         jpV2yydHNw/vEobpVhcDwdjy+65k16UN4eDKxPQu7SNVdtKo9mb29yNKqEToLP5CRMgS
         7IhA==
X-Received: by 10.66.171.204 with SMTP id aw12mr46016517pac.7.1375211647002;
        Tue, 30 Jul 2013 12:14:07 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id ib9sm84515889pbc.43.2013.07.30.12.14.05
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 30 Jul 2013 12:14:06 -0700 (PDT)
In-Reply-To: <1375138150-19520-4-git-send-email-gitster@pobox.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231377>

On Jul 29, 2013, at 15:49, Junio C Hamano wrote:

> "git config --get-urlmatch $section[.$variable] $url" is a way to
> learn what the configured value for $section.$variable is for the
> given URL, using the logic introduced by the http.<url>.config
> topic.  In addition to $section.$variable, entries in the
> configuration file(s) that match $section.<urlpattern>.$variable are
> looked up and the one with <urlpattern> that matches the given $url
> the best is used to answer the query.
>
> This can still be further refactored to remove code from  
> http_options()
> in http.c, I think.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> builtin/config.c | 141 ++++++++++++++++++++++++++++++++++++++++++++++ 
> +++++++++
> 1 file changed, 141 insertions(+)
>
> diff --git a/builtin/config.c b/builtin/config.c
> index 12c5073..c1d32ae 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
[...]
> +static int get_urlmatch(const char *var, const char *url)
> +{
> +	const char *section_tail;
> +	struct string_list_item *item;
> +	struct urlmatch_collect collect = { STRING_LIST_INIT_DUP };
> +
> +	if (!url_normalize(url, &collect.url))
> +		die(collect.url.err);

The value now stored in collect.url.url is never freed.

> +
> +	section_tail = strchr(var, '.');
> +	if (section_tail) {
> +		collect.section = xmemdupz(var, section_tail - var);
> +		collect.key = strrchr(var, '.') + 1;
> +		show_keys = 0;
> +	} else {
> +		collect.section = var;
> +		collect.key = NULL;
> +		show_keys = 1;
> +	}
> +
> +	git_config_with_options(urlmatch_collect, &collect,
> +				given_config_file, respect_includes);
> +
> +	for_each_string_list_item(item, &collect.vars) {
> +		struct urlmatch_item *matched = item->util;
> +		struct strbuf key = STRBUF_INIT;
> +		struct strbuf buf = STRBUF_INIT;
> +
> +		strbuf_addstr(&key, collect.section);
> +		strbuf_addch(&key, '.');
> +		strbuf_addstr(&key, item->string);
> +		format_config(&buf, key.buf,
> +			      matched->value_is_null ? NULL : matched->value.buf);
> +		fwrite(buf.buf, 1, buf.len, stdout);
> +		strbuf_release(&key);
> +		strbuf_release(&buf);
> +
> +		strbuf_release(&matched->value);
> +	}
> +	string_list_clear(&collect.vars, 1);

Needs something like this here:

+	free(collect.url.url);

> +
> +	/*
> +	 * section name may have been copied to replace the dot, in which
> +	 * case it needs to be freed.  key name is either NULL (e.g. 'http'
> +	 * alone) or points into var (e.g. 'http.savecookies'), and we do
> +	 * not own the storage.
> +	 */
> +	if (collect.section != var)
> +		free((void *)collect.section);
> +	return 0;
> +}

Still needed after 4/3 except it's now config.url.url instead.
