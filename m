From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] commit.c: use skip_prefix() instead of starts_with()
Date: Tue, 04 Mar 2014 13:23:59 -0800
Message-ID: <xmqqzjl5iro0.fsf@gitster.dls.corp.google.com>
References: <1393967190-3181-1-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, max@quendi.de
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 22:24:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKwp4-0000OX-1R
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 22:24:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757340AbaCDVYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 16:24:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48251 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756391AbaCDVYL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 16:24:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B46DA7148E;
	Tue,  4 Mar 2014 16:24:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qVvQ5Suj2BIAa+ldMJZbQDr1hGQ=; b=kD55gU
	Xjtemjqb3AVlUhp47Ht1q3+s7GJIkv+6Rh3RBefQnbD6aEMQiH1oUuefECjonOVU
	WTDVxBd+sIziTW4p3n8JXTkrtb4wv5RISMgTnb6R4/Aa64UYe0jGcQxxu2pEln0T
	AbqHSpK/ScFRM1LaokmJol8WoFWJchtn6KQx0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jF51+75dGf5xk95weyvqCo9RQ011rENm
	mh8y6KaNU3xATlyROw9GmfgEiKMdpuOd4PbMN2FuQOzKLX9HCsOGkdhxf087j3yY
	CliRRZKa8te6EtcNJX3/muDBgtpCh/gA8hgViZPH33w3XooVzZWUetmLVWqFg7yn
	ifNzY4yv+d0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A0ADE7148D;
	Tue,  4 Mar 2014 16:24:10 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C86907148A;
	Tue,  4 Mar 2014 16:24:08 -0500 (EST)
In-Reply-To: <1393967190-3181-1-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Tue, 4 Mar 2014 13:06:30 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5280959E-A3E3-11E3-883C-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243393>

Tanay Abhra <tanayabh@gmail.com> writes:

> In record_author_date() & parse_gpg_output(), the callers of
> starts_with() not just want to know if the string starts with the
> prefix, but also can benefit from knowing the string that follows
> the prefix.
>
> By using skip_prefix(), we can do both at the same time.
>
> Helped-by: Max Horn <max@quendi.de>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Michael Haggerty <mhagger@alum.mit.edu>
> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Do not add the last when sending; I never signed-off this particular
version of this patch.

> diff --git a/commit.c b/commit.c
> index 6bf4fe0..01526f7 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -548,7 +548,7 @@ define_commit_slab(author_date_slab, unsigned long);
>  static void record_author_date(struct author_date_slab *author_date,
>  			       struct commit *commit)
>  {
> -	const char *buf, *line_end;
> +	const char *buf, *line_end, *ident_line;
>  	char *buffer = NULL;
>  	struct ident_split ident;
>  	char *date_end;
> @@ -566,14 +566,14 @@ static void record_author_date(struct author_date_slab *author_date,
>  	     buf;
>  	     buf = line_end + 1) {
>  		line_end = strchrnul(buf, '\n');
> -		if (!starts_with(buf, "author ")) {
> +		ident_line = skip_prefix(buf, "author ");
> +		if (!ident_line) {
>  			if (!line_end[0] || line_end[1] == '\n')
>  				return; /* end of header */
>  			continue;
>  		}
>  		if (split_ident_line(&ident,
> -				     buf + strlen("author "),
> -				     line_end - (buf + strlen("author "))) ||
> +				    		 ident_line, line_end - ident_line) ||

Funny indentation with some SP followed by HT followed by SP.

>  		    !ident.date_begin || !ident.date_end)
>  			goto fail_exit; /* malformed "author" line */
>  		break;
> @@ -1193,10 +1193,8 @@ static void parse_gpg_output(struct signature_check *sigc)
>  	for (i = 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
>  		const char *found, *next;
>  
> -		if (starts_with(buf, sigcheck_gpg_status[i].check + 1)) {
> -			/* At the very beginning of the buffer */
> -			found = buf + strlen(sigcheck_gpg_status[i].check + 1);
> -		} else {
> +		found = skip_prefix(buf, sigcheck_gpg_status[i].check + 1);
> +		if(!found) {
>  			found = strstr(buf, sigcheck_gpg_status[i].check);
>  			if (!found)
>  				continue;
