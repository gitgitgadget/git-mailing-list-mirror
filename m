From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] rm: better error message on failure for multiple files
Date: Tue, 11 Jun 2013 11:07:41 -0700
Message-ID: <7vli6gbjwy.fsf@alter.siamese.dyndns.org>
References: <1370962561-12519-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 11 20:07:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmSyy-0006E2-W1
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 20:07:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755784Ab3FKSHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 14:07:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62403 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754677Ab3FKSHo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 14:07:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62C2926BE3;
	Tue, 11 Jun 2013 18:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NT3DUoKvf1RVrjX3spKwrqc3gDE=; b=hL0nIQ
	xWx7GINN+UQYJ82HMH1v0aMOULY5tnX1dStJ8VOtdBDnR+FtYlisilXUmSR4v6Jc
	3P4I11KjFVGS9M5VQ654aMtgG813wtmT6L27fO1Uq97K/pjCbaNjm6SoUZnn96Io
	2pi+jGHA/QuPUtvRlH5bCCxJZNHKJ5H+t9JZA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QzXmS8n2efhme/JVqRxO/37pylOmPVbL
	qNMdxTFutZW/5Hxk0o3wbGq1bX09cKdz21tZP1OTOXsqfmGQ9+A9Ryaz9XUrE1am
	0Ivj0+6fFCvx7Zk6BM5NrguI0CnKkGAuXikpLlltbM3QyxuwM5gZFATEjdpagzke
	742liKa4GL4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 589A226BE2;
	Tue, 11 Jun 2013 18:07:43 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9D53526BDF;
	Tue, 11 Jun 2013 18:07:42 +0000 (UTC)
In-Reply-To: <1370962561-12519-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
	(Mathieu Lienard--Mayor's message of "Tue, 11 Jun 2013 16:56:00
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CF8334C8-D2C1-11E2-8042-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227480>

Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
writes:

> +static void print_error_files(struct string_list *files_list,
> +			      const char *main_msg,
> +			      const char *hints_msg,
> +			      int *errs)
> +{
> +	if (files_list->nr) {
> +		struct strbuf err_msg = STRBUF_INIT;
> +		int i;
> +		strbuf_addstr(&err_msg, main_msg);
> +		for (i = 0; i < files_list->nr; i++)
> +			strbuf_addf(&err_msg,
> +				    "\n    %s",
> +				    files_list->items[i].string);
> +		strbuf_addstr(&err_msg, hints_msg);
> +		*errs = error("%s", err_msg.buf);
> +		strbuf_release(&err_msg);
> +	}
> +}
> +
>  static int check_submodules_use_gitfiles(void)
>  {
>  	int i;
>  	int errs = 0;
>  
> +	struct string_list files = STRING_LIST_INIT_NODUP;
> +
>  	for (i = 0; i < list.nr; i++) {

The blank after the initialization lines before the first statement
is very much welcom, but please drop the blank line before this new
initialization, i.e.

	int i;
        int errs = 0;
        struct string_list files = STRING_LIST_INIT_NODUP;

	for (i = 0; i < list.nr; i++) {
		...

> @@ -61,11 +82,17 @@ static int check_submodules_use_gitfiles(void)
>  			continue;
>  
>  		if (!submodule_uses_gitfile(name))
> +			string_list_append(&files, name);
>  	}
> +	print_error_files(&files,
> +			  Q_("the following submodule (or one of its nested "
> +			     "submodules)\n uses a .git directory:",
> +			     "the following submodules (or one of its nested "
> +			     "submodules)\n use a .git directory:",
> +			     files.nr),
> +			  _("\n(use 'rm -rf' if you really want to remove "
> +			    "it including all of its history)"),
> +			  &errs);
>  
>  	return errs;

No string_list_clear() on files?

>  }
> @@ -82,6 +109,11 @@ static int check_local_mod(unsigned char *head, int index_only)
>  	int i, no_head;
>  	int errs = 0;
>  
> +	struct string_list files_staged = STRING_LIST_INIT_NODUP;
> +	struct string_list files_cached = STRING_LIST_INIT_NODUP;
> +	struct string_list files_submodule = STRING_LIST_INIT_NODUP;
> +	struct string_list files_local = STRING_LIST_INIT_NODUP;
> +
> ...
> +	print_error_files(&files_local,
> +			  Q_("the following file has local modifications:",
> +			     "the following files have local modifications:",
> +			     files_local.nr),
> +			  _("\n(use --cached to keep the file,"
> +			    " or -f to force removal)"),
> +			  &errs);
> +

No string_list_clear() on files_*?
