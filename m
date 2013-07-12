From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] config: add support for http.<url>.* settings
Date: Fri, 12 Jul 2013 11:48:08 -0700
Message-ID: <7vbo67limv.fsf@alter.siamese.dyndns.org>
References: <a2ef80fd50c466e5c69726a1968f8ad@f74d39fa044aa309eaea14b9f57fe79>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Jeff King <peff@peff.net>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 20:48:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxiO7-0001g3-O6
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 20:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933266Ab3GLSsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 14:48:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43409 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933247Ab3GLSsK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 14:48:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5120A30599;
	Fri, 12 Jul 2013 18:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6qphNydnU09DQniCVClqGTsLcwY=; b=WyHnE6
	GFQLJL2gceotG3xLTO/9HYJRu6MaQBcDs1Pbcgf+BpLpbowMFsvcIA/lSwvCrpME
	8DiG8FvY+r0b/5vzPcQZMvT+FKfVNmuZF8ZANGb1xLDatmiyTK3yCCHVrkSbYhge
	IlzTA9oCCRItYkY23xzXnTh+dFvrs9WgOPm/k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rro4OTah7bok5LCHw/+FYjvYUorGvb9r
	iIxI0BvCJzBAZkSAt6VvusWGXKjPVtYsw+1hah7W+ylp/3GIvmNvXaBxc1gbE9bF
	MD2yjunbMEArUm4kwEt17PPVE3qJpGoaNFPE2ECWKRWSJ7CoyWVOpY1M/KkLM2fr
	+hLIAuA6OS0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4492630598;
	Fri, 12 Jul 2013 18:48:10 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 709DD30597;
	Fri, 12 Jul 2013 18:48:09 +0000 (UTC)
In-Reply-To: <a2ef80fd50c466e5c69726a1968f8ad@f74d39fa044aa309eaea14b9f57fe79>
	(Kyle J. McKay's message of "Fri, 12 Jul 2013 04:20:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 98E14EBC-EB23-11E2-8F06-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230236>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> +	if (!strcmp("sslcertpasswordprotected", key)) {
> +		if (check_matched_len(opt_passwd_req, matchlen))
> +			return 0;
>  		if (git_config_bool(var, value))
>  			ssl_cert_password_required = 1;
>  		return 0;
>  	}

This is not a new problem, but I think the existing code is wrong.
There is no way to countermand an earlier

	[http]
        	sslcertpasswordprotected

in a more generic configuration file with


	[http]
        	sslcertpasswordprotected = no

in a repository specific configuration file.

Perhaps we should fix it as a preparatory patch (1/2) before the
main "feature addition" patch.

> -	if (!strcmp("http.ssltry", var)) {
> +	if (!strcmp("ssltry", key)) {
> +		if (check_matched_len(opt_ssl_try, matchlen))
> +			return 0;
>  		curl_ssl_try = git_config_bool(var, value);
>  		return 0;
>  	}
