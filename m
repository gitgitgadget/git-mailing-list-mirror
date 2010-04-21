From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revision: --ancestry-path
Date: Wed, 21 Apr 2010 02:04:37 -0700
Message-ID: <7vy6ghb2hm.fsf@alter.siamese.dyndns.org>
References: <201004201649.31084.johan@herland.net>
 <4BCEADA3.7090504@viscovery.net> <7vochdcjz5.fsf@alter.siamese.dyndns.org>
 <201004211046.22643.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Apr 21 11:04:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4VrZ-0002WD-5V
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 11:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753223Ab0DUJEu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 05:04:50 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34400 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558Ab0DUJEs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 05:04:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DFCB4A9F7F;
	Wed, 21 Apr 2010 05:04:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O4CwWdaTs9TIlo8uSyILli/l8EU=; b=EyT6bJ
	Ny9H3GZ8q+2WZ79R2fWo9OglsAZ3/9clvvBKUL64R8htsrEOO855A9UPC6JtMZV6
	rHSNOWFnevkfacx+mEOnELvwsToRy+mJVdAxq/dXzFopP6wW4lFfSCxpnnvVUqVl
	Di8U6hyZMLja72e/W+GZqfr+YS6GaGqOexet8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eaq24tGQmeGa0GdXn2+hbJydA7WaD3T7
	NCfbf69GISN4VY+XvW+pQwrqTe+rHvpdkqJF6m3ommRiSlZj8K9Zxwoic60ZLuXA
	uoXpz6RObwtNWD+eAKfGK1gdsM5+lyckKQ8RkV1/ePW4rkIM7fbtk9ymk+emMsNs
	Rfo9ATRCod8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 88283A9F7E;
	Wed, 21 Apr 2010 05:04:43 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A8772A9F7C; Wed, 21 Apr
 2010 05:04:38 -0400 (EDT)
In-Reply-To: <201004211046.22643.johan@herland.net> (Johan Herland's message
 of "Wed\, 21 Apr 2010 10\:46\:22 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: ED06D2BE-4D24-11DF-9CFB-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145422>

Johan Herland <johan@herland.net> writes:

> I'm not very familiar with "rewrite_parents", nor do I know exactly how it 
> should affect/interoperate with --ancestry-path in all cases, but running
>
> 	git rev-list D..M -- M.t
>
> produces one commit (M), whereas
>
> 	git rev-list --ancestry-path D..M -- M.t
>
> produces nothing, so I suspect there is something not quite right here.

Merge simplification gets in our way big time.

          D---E-------F
         /     \       \
    B---C---G---H---I---J
   /                     \
  A-------K---------------L--M

While traversing the history from M, we notice that M's parent is L, and
then further we notice that neither the transition between J to L nor
between K to L change the named path M.t, so we simplify the merge L to
have K as its sole parent.  This makes M appear disconnected from D's
decendant chain, and causes the TMP_MARK reverse traversal not to work as
intended.
