From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] separate quoting and relative path generation
Date: Thu, 03 Jun 2010 15:16:33 -0700
Message-ID: <7vocfr7oe6.fsf@alter.siamese.dyndns.org>
References: <7v4ohlatwn.fsf@alter.siamese.dyndns.org>
 <20100603133631.GA31565@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Fri Jun 04 00:16:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKIiX-0003ZH-FI
	for gcvg-git-2@lo.gmane.org; Fri, 04 Jun 2010 00:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510Ab0FCWQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 18:16:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56959 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617Ab0FCWQn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 18:16:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 39776B9285;
	Thu,  3 Jun 2010 18:16:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5ALD1W+e3aio5ZI48pM5PaABSAU=; b=Vyvh1W
	0rS3y3v0NDgptQ4e69Kme9cdCRsxabEqOmdDXamcvhOSDw/0bMMwX7qiBPuCR0kX
	b5SVYRU4uoxy8PZ8uy8pMwGf0DXD0H4C2wgwtyM+QVtM42ZWAVE5yqqMV0tqlH//
	vZlP9kdD3qsbV1xn9ssapwWVXH8jDTAlEsChk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w1kahDbflzZXQy9OCPz8Ws3WslpZHz4n
	Hxqluh+KYN35cni7wgBX43kG/ns+zfdVf8Jk5MB+dQdSwgbdZ9Pc02uo4hHF6N4l
	Zz/5A05tSKev2FNj8px+FuKsuyiQqa5J1HOvR0m0YEkYilvT0pfrbQmLhNbSN30T
	lDo2AhXx8oA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 14155B9283;
	Thu,  3 Jun 2010 18:16:38 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4365DB927C; Thu,  3 Jun
 2010 18:16:35 -0400 (EDT)
In-Reply-To: <20100603133631.GA31565@localhost> (Clemens Buchacher's message
 of "Thu\, 3 Jun 2010 15\:36\:31 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: ADA7C140-6F5D-11DF-8682-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148368>

Clemens Buchacher <drizzd@aon.at> writes:

> +/* give path as relative to prefix */
> +char *path_relative(const char *in, int len,
> +		    struct strbuf *out, const char *prefix, int prefix_len)
> +{
>  	if (len < 0)
>  		len = strlen(in);
> +	if (prefix && prefix_len < 0)
> +		prefix_len = strlen(prefix);
>  
>  	strbuf_setlen(out, 0);
>  	strbuf_grow(out, len);
>  
> +	if (prefix_len > 0) {
> +		int off = 0, i = 0;
> +		while (i < prefix_len && i < len && prefix[i] == in[i]) {
> +			if (prefix[i] == '/')
> +				off = i + 1;
> +			i++;
> +		}
> +		in += off;
> +		len -= off;
> +
> +		while (i < prefix_len) {
> +			if (prefix[i] == '/')
>  				strbuf_addstr(out, "../");
> +			i++;
> +		}
>  	}
> +	strbuf_add(out, in, len);
> +
> +	return out->buf;
> +}

Hmm...  I wonder if we really want to always make a copy of the string in
the majority of the case where there is no need to add ../ and the path
does not have any funny characters that needs quoting.  In such a case,
shouldn't write_name() be just moving the pointers into the original
string to skip the $(cwd) part and writing the remainder of the string
out, without any extra allocation nor copy?  IIUC, that is what the
original did using write_name_quoted().
