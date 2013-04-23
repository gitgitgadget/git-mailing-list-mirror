From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] am: tighten a conditional that checks for $dotest
Date: Tue, 23 Apr 2013 09:45:34 -0700
Message-ID: <7v8v49jivl.fsf@alter.siamese.dyndns.org>
References: <1366725724-1016-1-git-send-email-artagnon@gmail.com>
	<1366725724-1016-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 18:45:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUgLf-0003zb-0s
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 18:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756757Ab3DWQpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 12:45:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62982 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755985Ab3DWQph (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 12:45:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3C271622B;
	Tue, 23 Apr 2013 16:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fjFuxlyxDbbOVfcMWcR2lWd6Axw=; b=Z567Lt
	uT1DgtBwa5xTsxVWKd2gzaCUE/0LYUoumRQxn+xZe495pYEG+hCuD8Zo5Svv9zEo
	rxchLw8JWpgW7HGQIUR/rnwF9fooV34sT3hM68FiANWmTFED61Rx33p5OgCzzpaa
	XWns3ZW3v+rkL6nmidn3R3lhH++brsYmo/BVg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VijDRMgTHGRqWnzO/zmvV+dkdVgOn2+2
	X9V2EdtGfBAgISs1VMgHdwGCZrmViFi4jHKKRVbHMwXW0Q5umWb7rjC2Fm4eIyS0
	Yd5iWZW265RgSwcr0UKDUcjS28WfUV49jg3Q3FidrAzKAjx0Y/iHMzJ3PRsuScTI
	0y2hEsXLpDg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB5881622A;
	Tue, 23 Apr 2013 16:45:36 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5553616221;
	Tue, 23 Apr 2013 16:45:36 +0000 (UTC)
In-Reply-To: <1366725724-1016-4-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Tue, 23 Apr 2013 19:32:00 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 38F830C4-AC35-11E2-9005-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222191>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> We currently assume that, if a $dotest directory exists, an am had
> been called earlier.  This assumption might get our conditional to
> match a stray $dotest directory created somewhere else,...

Hmm. that explanation sounds like that is sweeping a real issue
under the rug.  Shouldn't your patch fixing that creator of the
stray one?  That stray one that errorneously creates $dotest, even
when it is not applying patch messages, may create the directory
with 'last' but without 'next' or the messages, so checking only
'last' does not sound like solving any problem.

If this were done as a part of an addition that has to create
$dotest even when it does not (yet) deposit patches in there, the
way that particular addition creates and uses $dotest may justify
why testing only 'last' is sufficient.  But as a standalone change,
neither the patch text or the above explanation makes much sense to
me.

> diff --git a/git-am.sh b/git-am.sh
> index 88aa438..f4ef8fc 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -454,7 +454,7 @@ then
>     rm -fr "$dotest"
>  fi
>  
> -if test -d "$dotest"
> +if test -d "$dotest" && test -f "$dotest/last"

>  then
>  	case "$#,$skip$resolved$abort" in
>  	0,*t*)
