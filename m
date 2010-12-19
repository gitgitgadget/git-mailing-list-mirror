From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] convert filter: supply path to external driver
Date: Sun, 19 Dec 2010 13:59:50 -0800
Message-ID: <7vzks1e84p.fsf@alter.siamese.dyndns.org>
References: <20101218223822.GA18902@arf.padd.com>
 <20101219212925.GA7393@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sun Dec 19 23:00:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PURId-0000GX-2B
	for gcvg-git-2@lo.gmane.org; Sun, 19 Dec 2010 23:00:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269Ab0LSWAD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Dec 2010 17:00:03 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40091 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932144Ab0LSWAC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Dec 2010 17:00:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 59E813E81;
	Sun, 19 Dec 2010 17:00:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o9c7yviGu+gNPZTlWJm0NCw1cJU=; b=kTI1r0
	txErrzeThC7aSq1OjjbXAUR/DcyuOZ6TNhIl3nTxuXrxmp/yn1OGfp1vF4vRNphK
	999sB3mXltAjb4fMtvpOhOk2gkgLwlPxuj2DMVef2HebIdjcJHiv4FcKzuuNikwo
	Wvio9QMD2+2Xm/X0RHEZnX2aREGYoa+Fir3yQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D8CeJXwbpP/v+6v1LWxysL4eiHIjri+t
	bjFu4dCFszUmABFZpH9QbPJwUQLRyxaZitDkiggRdoG5JAXrvEwKqxm970L+tfIL
	Ef0n/9jLr9rLReVeP2yez9EcBijYWbYv76dIEdvD6VWlfm0H7N8vNtFy4tvZYZoX
	eOy5GotDpu8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 23B893E7C;
	Sun, 19 Dec 2010 17:00:26 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CA0B53E7A; Sun, 19 Dec 2010
 17:00:21 -0500 (EST)
In-Reply-To: <20101219212925.GA7393@arf.padd.com> (Pete Wyckoff's message of
 "Sun\, 19 Dec 2010 16\:29\:25 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 62791840-0BBB-11E0-A51A-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163970>

Pete Wyckoff <pw@padd.com> writes:

> Filtering to support keyword expansion may need the name of
> the file being filtered.  In particular, to support p4 keywords
> like
>
>     $File: //depot/product/dir/script.sh $
>
> the smudge filter needs to know the name of the file it is
> smudging.
>
> Add a "%s" conversion specifier to the gitattribute for filter.
> It will be expanded with the path name to the file when invoking
> the external filter command.
>
> Signed-off-by: Pete Wyckoff <pw@padd.com>
> ---
>
> pw@padd.com wrote on Sat, 18 Dec 2010 17:38 -0500:
>> I'm using git-p4 to import and work with upstream p4
>> repositories.  Some of the files are ktext, meaning they expect
>> expansion of $Id$ and similar identifiers.
>> 
>> Using the filter driver for this file, I can do the "clean" part
>> easily, but to calculate the "smudge" correctly, I need to know
>> the filename inside the filter driver.
>
> This works fine for me.  It is backward compatible, and leaves
> open the possibility of adding other % modifiers if we find
> a need later.

This is not backward compatible for people who wanted to use '%' literal
on their filter command line for whatever reason, so please do not
advertise as such.  A fair argument you could make is "Even though this is
not strictly backward compatible, it is very unlikely that people passed a
literal % to their filter command line, and the benefit of being able to
give the pathname information would outweigh the downside of not being
compatible", and people can agree or disagree.

I am personally moderately negative about $any expansion$ (I don't use it
myself, and I don't think sane people use it either).  As far as I can
tell, this should has no impact on the correctness and very little impact
on the performance for people who do not use $any expansion$, so I am Ok
with the patch.

Modulo one worry.  Don't we have, or don't we at least plant to allow us
to have, a facility to cache expensive blob conversion result, similar to
the textconv caching?  How would this change interact with two blobs that
live in different paths?
