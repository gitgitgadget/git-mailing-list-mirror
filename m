From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [bug report] git-am applying maildir patches in reverse
Date: Fri, 01 Mar 2013 16:08:04 -0800
Message-ID: <7v1ubyek9n.fsf@alter.siamese.dyndns.org>
References: <20130301222018.GA839@WST420>
 <7vwqtqeox7.fsf@alter.siamese.dyndns.org>
 <20130301225231.GB862@sigill.intra.peff.net>
 <20130301230508.GC862@sigill.intra.peff.net>
 <7vlia6em9x.fsf@alter.siamese.dyndns.org>
 <20130301233548.GA13422@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: William Giokas <1007380@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 02 01:08:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBa0E-0000qy-S9
	for gcvg-git-2@plane.gmane.org; Sat, 02 Mar 2013 01:08:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691Ab3CBAII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Mar 2013 19:08:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58952 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751381Ab3CBAIH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Mar 2013 19:08:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88963AB9E;
	Fri,  1 Mar 2013 19:08:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e090dZNKQm+PupV2p2Itd5ODNIY=; b=m4Fn7s
	+AHyNokghNXz+sbF59LB+vFrDU14v1RDOC+toG+AD0ervbo3TMtl8Y8cei3DBsnF
	WHy5S5r2ey4M+hd1p3d+FZU+VGanR6sDviRLD9Q38bhsiH4CfSdjLvC9D0W3p1iK
	2gIIuVscc7iNp/cFPlP97VJrKMyXerOqRbdLU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PsgSX/UPnMrVKR59uV/AeUHy8w94M0eo
	g2cuL2TiWmtE0fIAcRJQYUrY1esJOE5RS5UMEKPmc9x25WPqy+RVLWFo2gEfLTiM
	FV0D+NbKu8pcFDPpTE33KfTnl7vqOZARbRnjK2U5kDjQzhzaIe15IzsDLPBeTFbQ
	BHcN1sLFx9Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CEC6AB9B;
	Fri,  1 Mar 2013 19:08:06 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DC284AB97; Fri,  1 Mar 2013
 19:08:05 -0500 (EST)
In-Reply-To: <20130301233548.GA13422@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 1 Mar 2013 18:35:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 41D7B5AC-82CD-11E2-93B1-7FA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217311>

Jeff King <peff@peff.net> writes:

> diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
> index 2d43278..772c668 100644
> --- a/builtin/mailsplit.c
> +++ b/builtin/mailsplit.c
> @@ -130,6 +130,26 @@ static int populate_maildir_list(struct string_list *list, const char *path)
>  	return 0;
>  }
>  
> +static int maildir_filename_cmp(const char *a, const char *b)
> +{
> +	while (1) {

It is somewhat funny that we do not need to check !*a or !*b in this
loop.  As long as readdir() does not return duplicates, we won't be
comparing the same strings with this function, and we won't read
past '\0' at the end of both a and b at the same time.

> +		if (isdigit(*a) && isdigit(*b)) {
> +			long int na, nb;
> +			na = strtol(a, (char **)&a, 10);
> +			nb = strtol(b, (char **)&b, 10);
> +			if (na != nb)
> +				return na - nb;
> +			/* strtol advanced our pointers */
> +		}
> +		else {
> +			if (*a != *b)
> +				return *a - *b;
> +			a++;
> +			b++;
> +		}
> +	}
> +}
