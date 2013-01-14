From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Make git selectively and conditionally ignore certain
 stat fields
Date: Mon, 14 Jan 2013 14:08:04 -0800
Message-ID: <7vip6z8lkr.fsf@alter.siamese.dyndns.org>
References: <50C0475F.1030206@viscovery.net>
 <1358197878-36736-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, j.sixt@viscovery.net
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 23:08:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TusCj-0004RC-Ez
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 23:08:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757295Ab3ANWII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 17:08:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40872 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756763Ab3ANWIH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 17:08:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DA2BA06A;
	Mon, 14 Jan 2013 17:08:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vyHHgW3kgFDZw94ceLqMs4bRQ4k=; b=L4xv91
	i3/7DCAvZe1LZJl8R/02UULTmYDdHD3V5VOZLJrtTspa8aZ7Z22RbeoaeNHPf7Pd
	3f1PyMC83UeUJFcnXULRo3uWB1VYPI15f711XkhvMYJF7dQbp2tBMrjzQJE6gWPn
	cp0BHjsAIR7ksKLRVdo3MbUKtEHUTgG3sN+VI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UeMES09nMUnJ0j095HlggpBQK8bWtorv
	fqAr2AAVm28S1/6DYujYpUCzNk5Fn89LTPREH2/O2eWV9mmv+qHG5IFaRTITfKzr
	wOW1HqXtrY0T6YWTnEs/CO3SAPWkcGLkc15SKB93GB3hcbZHaDB/MmPbzg4axavh
	rOv/XoxBaO4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7177EA069;
	Mon, 14 Jan 2013 17:08:06 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B62C1A067; Mon, 14 Jan 2013
 17:08:05 -0500 (EST)
In-Reply-To: <1358197878-36736-1-git-send-email-robin.rosenberg@dewire.com>
 (Robin Rosenberg's message of "Mon, 14 Jan 2013 22:11:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DF368590-5E96-11E2-A632-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213536>

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> @@ -566,6 +566,31 @@ static int git_default_core_config(const char *var, const char *value)
>  		trust_ctime = git_config_bool(var, value);
>  		return 0;
>  	}
> +	if (!strcmp(var, "core.ignorezerostat")) {
> +		char *copy, *tok;
> +		git_config_string(&copy, "core.ignorezerostat", value);
> +		check_nonzero_stat = CHECK_NONZERO_STAT_MASK;
> +		tok = strtok(value, ",");
> +		while (tok) {
> +			if (strcasecmp(tok, "uid") == 0)
> +				check_nonzero_stat &= ~CHECK_NONZERO_STAT_UID;
> +			else if (strcasecmp(tok, "gid") == 0)
> +				check_nonzero_stat &= ~CHECK_NONZERO_STAT_GID;
> +			else if (strcasecmp(tok, "ctime") == 0) {
> +				check_nonzero_stat &= ~CHECK_NONZERO_STAT_CTIME;
> +				trust_ctime = 0;
> +			} else if (strcasecmp(tok, "ino") == 0)
> +				check_nonzero_stat &= ~CHECK_NONZERO_STAT_INO;
> +			else if (strcasecmp(tok, "dev") == 0)
> +				check_nonzero_stat &= ~CHECK_NONZERO_STAT_DEV;
> +			else
> +				die_bad_config(var);
> +			tok = strtok(NULL, ",");
> +		}
> +		if (check_nonzero_stat >= CHECK_NONZERO_STAT_MASK)
> +			die_bad_config(var);
> +		free(copy);
> +	}

Also I am getting these:

config.c: In function 'git_default_core_config':
config.c:571: error: passing argument 1 of 'git_config_string' from incompatible pointer type
config.c:540: note: expected 'const char **' but argument is of type 'char **'
config.c:573: error: passing argument 1 of 'strtok' discards qualifiers from pointer target type
