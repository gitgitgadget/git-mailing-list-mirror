From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] Fix --stat width calculations to handle --graph
Date: Tue, 20 Mar 2012 10:23:52 -0700
Message-ID: <7vaa3b6v9z.fsf@alter.siamese.dyndns.org>
References: <1332229097-19262-1-git-send-email-lucian.poston@gmail.com>
 <1332229097-19262-2-git-send-email-lucian.poston@gmail.com>
 <alpine.DEB.1.00.1203201109370.3340@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lucian Poston <lucian.poston@gmail.com>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Bo Yang <struggleyb.nku@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 20 18:24:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SA2mv-0001wT-LB
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 18:24:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965089Ab2CTRX4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Mar 2012 13:23:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46380 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964783Ab2CTRXy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2012 13:23:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 48FF97A49;
	Tue, 20 Mar 2012 13:23:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lnrgazNI/iBJpyhdlmilu9BHnak=; b=OEMjUG
	kwGjgm4+4XC9JXQPn+vAOnyCdQ8228gNRQH3nk7F73xwnZaC12mTDvCgDTlrI5tl
	M3lQ1dxt4GvSwfPXokqjLGpvJtGj8EbxjtiIqwltLgwy2Wtpyms/nyc5qG+N1P6r
	L5KtKgWksTe0Py27IhaHMX7TFa9todgSWS2j8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m/6jft4lfm4UGezHyvkWSHfSL+UJr5//
	pU9B+8GH/Nquy8kwdA1eZCz9wXL0irsH72oGJbGPxky2oTMPo9RiQi2/+DJnoKIe
	/xGmfb1mzLkTiUNBStaRur8WEzXt6DJlgBYpGr5HdnuQFCdeXEP7yRbnJ8ue9af6
	x9cTf+2PhxA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 40BCA7A48;
	Tue, 20 Mar 2012 13:23:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B9B767A47; Tue, 20 Mar 2012
 13:23:53 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.1203201109370.3340@s15462909.onlinehome-server.info>
 (Johannes Schindelin's message of "Tue, 20 Mar 2012 11:17:18 -0500 (CDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 77889B94-72B1-11E1-9D48-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193521>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> However, a little nit, since this list is so famous for "just a little
> nit": I'd prefer to factor-out the indent width measuring, like so:
>
> static int count_pipes_and_spaces(const char *string)
> {
> 	int count;
>
> 	for (count = 0; *string; string++)
> 		if (*string == '|' || *string == ' ')
> 			count++;
>
> 	return count;
> }
>

I agree that this is much better than the original by Lucian, but if we
were to go this route, I would prefer to see it *not* count pipes and
spaces, but actually measure the display width of the string.  Both the
name of the function and the implementation would have to change, of
course.

Even though I didn't look very closely, I do not think it should be too
hard for graph.c to tell the diff_options structure how wide a prefix it
placed in the output_prefix, so use of such a "display_columns()" function
would be wasteful for this particular case, but for a more general case,
it would come in handy as a helper function, and at that point, this
should not hide in diff.c as a static function.

Thanks.
