From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] Extract function trim_url and optimize calls of it.
Date: Wed, 16 Feb 2011 17:44:00 -0800
Message-ID: <7vbp2bfna7.fsf@alter.siamese.dyndns.org>
References: <1297550311-17723-1-git-send-email-vvavrychuk@gmail.com>
 <1297550311-17723-3-git-send-email-vvavrychuk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vasyl' Vavrychuk <vvavrychuk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 17 02:44:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppsuk-0004mY-29
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 02:44:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755885Ab1BQBoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 20:44:10 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63539 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520Ab1BQBoI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 20:44:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BA372410B;
	Wed, 16 Feb 2011 20:45:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=VyJaSWfXzTeAjWjuIwmGnWgTp7M=; b=AqC3hlN6WGjbBSvHaGAIvLH
	hEJT2s7A3oRaHvg+tRtlwQuippVOcLxzWtxUyvZpADgeUlS1y7F/sMZ/vpVyrGQb
	8G7iqexOp4ymNH3+pZVfC0xPNLo4D6xwPR9ODhqiXiVaQvmOWZWrjmRHunST1wQ3
	9v5A/+6Y/c7sDyxcU4RI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=yV9lOemlsjBa2hrL9uXVA4Dtvs815MF2AaGxjA8+6+IhVIkRK
	v/aqtuyfCASgVAm9EL7ZfVLm3nqs+utsuEdvKzOITz9We1D3HC1r41B222Penmph
	os5TqoaeEXZKlDFFGzWLLMcFeRz1LBYCGxxn0XOusswf6NDToteodkji20=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 984D94109;
	Wed, 16 Feb 2011 20:45:12 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6A2094106; Wed, 16 Feb 2011
 20:45:09 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8F78AFAE-3A37-11E0-A559-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167027>

Vasyl' Vavrychuk <vvavrychuk@gmail.com> writes:

> Extract compact code into trim_url. Dont call it every iteration in the loop since no reason.

Too long a line; just drop " since no reason".

> @@ -379,14 +394,6 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
>  			what = rm->name;
>  		}
>  
> -		url_len = strlen(url);
> -		for (i = url_len - 1; url[i] == '/' && 0 <= i; i--)
> -			;
> -		url_len = i + 1;
> -		if (4 < i && !strncmp(".git", url + i - 3, 4))
> -			url_len = i - 3;
> -		url[url_len] = '\0';
> -
>  		note_len = 0;
>  		if (*what) {
>  			if (*kind)

We repeatedly called strlen(url) for each entry in the ref-map when we
know we do not have any more thing to do; silly.  This is probably a good
thing to do.
