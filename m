From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tag: implement --no-strip option
Date: Mon, 14 Nov 2011 12:26:17 -0800
Message-ID: <7v7h32jvrq.fsf@alter.siamese.dyndns.org>
References: <1321268902-2170-1-git-send-email-kirill@shutemov.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
X-From: git-owner@vger.kernel.org Mon Nov 14 21:26:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQ36o-0005tn-6q
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 21:26:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756198Ab1KNU0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 15:26:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51597 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754537Ab1KNU0U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 15:26:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8262760D4;
	Mon, 14 Nov 2011 15:26:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hci366ZikIAEHz1UPZ8NZU2lgAk=; b=hZAMz9
	h89cLUEh03HELP/vzMDSE/EXxfhVo+ickPiGCQFLg0wkkjYIHEIYFWKr+T/liHVu
	lSTruF6lAQhhMPHwJBjc9gKQgPi86tO+gEC/RwxmPtSAGqnO90dIn/tO7pcXk0yD
	xk1rNUSlf8B2AIn+URgwrIu3cdyuPvCpwNLgw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GsL7tcTy+XOhExF7k30ouC57WwXguLUn
	/MX6AwObohro1SsgE3zka7kE79TWuSXWTHD3o+tfWS+gOcPalNKXBTgZG/VPvZR+
	Q9cmCMRBA0aHA2nuOJ+VeBBd6uhM4gQ/zlq25Xi9tiO9zDPVChfKQuVmLO50FSa9
	8MQQXza6Vns=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69EC760D3;
	Mon, 14 Nov 2011 15:26:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DD85860D2; Mon, 14 Nov 2011
 15:26:18 -0500 (EST)
In-Reply-To: <1321268902-2170-1-git-send-email-kirill@shutemov.name> (Kirill
 A. Shutemov's message of "Mon, 14 Nov 2011 13:08:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E8DE1966-0EFE-11E1-9E00-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185399>

"Kirill A. Shutemov" <kirill@shutemov.name> writes:

> +-S::
> +--no-strip::
> +	Take tag message as-is. Do not strip any comments or empty lines.

Wrong naming convention.  Just introduce a boolean --strip option which is
on by default, without adding -S; use of parse-options will allow the user
to negate it from the command line with --no-strip for free.

> diff --git a/builtin/tag.c b/builtin/tag.c
> index 9b6fd95..427d646 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -320,7 +320,7 @@ static int build_tag_object(struct strbuf *buf, int sign, unsigned char *result)
>  }
>  
>  static void create_tag(const unsigned char *object, const char *tag,
> -		       struct strbuf *buf, int message, int sign,
> +		       struct strbuf *buf, int message, int sign, int nostrip,

Again, wrong naming convention. "int strip" would be fine but I think at
this point "message, sign, strip" tuple should become fields of "struct
create_tag_option" that is passed to this funciton.

>  		       unsigned char *prev, unsigned char *result)
>  {
>  	enum object_type type;
> @@ -356,7 +356,7 @@ static void create_tag(const unsigned char *object, const char *tag,
>  
>  		if (!is_null_sha1(prev))
>  			write_tag_body(fd, prev);
> -		else
> +		else if (!nostrip)

This double negation comes only because the argument is misnamed with negation.
