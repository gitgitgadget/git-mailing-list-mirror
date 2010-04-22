From: Chris Johnsen <chris_johnsen@pobox.com>
Subject: Re: [PATCH] Documentation/Makefile: fix interrupted builds of
 user-manual.xml
Date: Thu, 22 Apr 2010 01:13:15 -0500
Message-ID: <FA4A6177-AB3E-4C5C-8042-1BFBAE09528B@pobox.com>
References: <20100422011820.GA30355@progeny.tock>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 22 08:13:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4pfU-0006R6-B7
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 08:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845Ab0DVGNW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Apr 2010 02:13:22 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64508 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815Ab0DVGNV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 02:13:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 13047ACB9D;
	Thu, 22 Apr 2010 02:13:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=in-reply-to
	:references:mime-version:content-type:message-id:cc
	:content-transfer-encoding:from:subject:date:to; s=sasl; bh=a0Lw
	ZpJXD1//D49MG5wdCtl1aFs=; b=H/ruCIrqkZ8LbR2q7CAEE0Q3psnz8Dm5P20B
	3vM4jodWwZGy2u/UsZCVHq84J9Y6ApcoPRwbjumNb5Eh70VofVaC3YEp8TrdwZO0
	xCqzYqw9UfaR1M6eMtScggrkDptbQvi0mOcBJzrLbM22VjzSxCcfYMWWQIq9/GYf
	R1GjXl8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=in-reply-to
	:references:mime-version:content-type:message-id:cc
	:content-transfer-encoding:from:subject:date:to; q=dns; s=sasl; b=
	WWQlLCn6UnppileTljO/7AY/9yACyYvypSkqfhQJBDqFtJvAq2GiYTwkpvP990GS
	OVJQbA02iCiUdlCS7LtTQ7Q+W70944pQR6B0XEiqs9eH3shAXQN8BEWrOzvrwH7D
	cL0G0BjExP6GLBPRYbf2s/hLJHep8HvyBtj/HsiuOUw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E0E6CACB9A;
	Thu, 22 Apr 2010 02:13:17 -0400 (EDT)
Received: from [192.168.1.241] (unknown [75.53.32.78]) (using TLSv1 with
 cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 696BDACB99; Thu, 22 Apr
 2010 02:13:15 -0400 (EDT)
In-Reply-To: <20100422011820.GA30355@progeny.tock>
X-Mailer: Apple Mail (2.753.1)
X-Pobox-Relay-ID: 24B9E636-4DD6-11DF-BFF3-D033EE7EF46B-07245699!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145503>

(Resend, including the all original recipients. Sorry for the dupe,  
Jonathan.)

On 2010 Apr 21, at 20:18, Jonathan Nieder wrote:
> Unlike gcc, asciidoc does not atomically write its output file or
> delete it when interrupted.  If it is interrupted in the middle of
> writing an XML file, the result will be truncated input for xsltproc.
>
> 	XSLTPROC user-manual.html
> 	user-manual.xml:998: parser error : Premature end of data in t
>
> Take care of this case by writing to a temporary and renaming it when
> finished.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Based on a true story.
>

For what it is worth, the changes seem reasonable to me. There may be  
a few other places that could use the same treatment, though maybe  
not all the other documentation tools suffer to the same degree as  
asciidoc.


> @@ -278,7 +280,9 @@ XSLT = docbook.xsl
>  XSLTOPTS = --xinclude --stringparam html.stylesheet docbook-xsl.css
>
>  user-manual.html: user-manual.xml
> -	$(QUIET_XSLTPROC)xsltproc $(XSLTOPTS) -o $@ $(XSLT) $<
> +	$(QUIET_XSLTPROC)$(RM) $@+ $@ && \
> +	xsltproc $(XSLTOPTS) -o $@+ $(XSLT) $< && \
> +	mv $@+ $@
>
>  git.info: user-manual.texi
>  	$(QUIET_MAKEINFO)$(MAKEINFO) --no-split -o $@ user-manual.texi
>

I suppose it is obvious enough what is going on in this in this  
second hunk, but there is no mention of this change in the commit  
message. Is this hunk due to a similar problem with xsltproc? Or  
maybe this is just "defensive coding"?

-- 
Chris
