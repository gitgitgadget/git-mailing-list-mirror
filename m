From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] refs: disallow ref components starting with hyphen
Date: Mon, 16 Jul 2012 10:06:07 -0700
Message-ID: <7v7gu34ow0.fsf@alter.siamese.dyndns.org>
References: <1342440781-18816-1-git-send-email-mschub@elegosoft.com>
 <1342440781-18816-2-git-send-email-mschub@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Mon Jul 16 19:06:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqokS-0004o7-T8
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 19:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753490Ab2GPRGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 13:06:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57596 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753284Ab2GPRGK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 13:06:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A9CAF874F;
	Mon, 16 Jul 2012 13:06:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WGilHBwoSM+W6JuDaKgBcd9/N4M=; b=h28LXI
	6jSVNi9HrG5F2gktH+xlXaYiEV/6BTR95vJl1s/HyRfFpQdSI5t4UlSyvmRH3tFU
	6TTyp58N7BGZanrdVRrcspHAVEmIMeYiMHm5vUW9qzWrWgpuspxXzSsgtwem511C
	vdt/Tnhu0kZcl/BvGtzedzXLOxkWSxgWOiKtk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X3Pgg04KovQX7E8xPv9+Z0Ca5kfcpqje
	CFVU1C8NQQjewiFa1oi/w4BwY4JrTpWzWjEleWDvSoa8y9PCE3jIY0fCFjszL29l
	psSxemDd2ZiHgzTpLw1R8QeSzpcsCdUne9wCG68MB+LbXZfJ2/x9XT86+NjBrdL7
	T6x9rnhpAj0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 97624874E;
	Mon, 16 Jul 2012 13:06:09 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EF180874C; Mon, 16 Jul 2012
 13:06:08 -0400 (EDT)
In-Reply-To: <1342440781-18816-2-git-send-email-mschub@elegosoft.com>
 (Michael Schubert's message of "Mon, 16 Jul 2012 14:13:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8998F5B8-CF68-11E1-8416-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201532>

Michael Schubert <mschub@elegosoft.com> writes:

> Currently, we allow refname components to start with a hyphen. There's
> no good reason to do so...

That is way too weak as a justification to potentially break
existing repositories.

Refusal upon attempted creation is probably OK, which is why the two
checks you removed in your patches are fine.  I do not know if it is
justifiable to do that in check_refname_component() that is used in
the reading codepath.

> diff --git a/builtin/tag.c b/builtin/tag.c
> index 7b1be85..c99fb42 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -403,9 +403,6 @@ static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
>  
>  static int strbuf_check_tag_ref(struct strbuf *sb, const char *name)
>  {
> -	if (name[0] == '-')
> -		return -1;
> -
>  	strbuf_reset(sb);
>  	strbuf_addf(sb, "refs/tags/%s", name);
>  
> diff --git a/refs.c b/refs.c
> index da74a2b..5714681 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -62,6 +62,8 @@ static int check_refname_component(const char *refname, int flags)
>  		if (refname[1] == '\0')
>  			return -1; /* Component equals ".". */
>  	}
> +	if (refname[0] == '-')
> +		return -1; /* Component starts with '-'. */
>  	if (cp - refname >= 5 && !memcmp(cp - 5, ".lock", 5))
>  		return -1; /* Refname ends with ".lock". */
>  	return cp - refname;
> diff --git a/sha1_name.c b/sha1_name.c
> index 5d81ea0..132d369 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -892,8 +892,6 @@ int strbuf_branchname(struct strbuf *sb, const char *name)
>  int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
>  {
>  	strbuf_branchname(sb, name);
> -	if (name[0] == '-')
> -		return -1;
>  	strbuf_splice(sb, 0, 0, "refs/heads/", 11);
>  	return check_refname_format(sb->buf, 0);
>  }
