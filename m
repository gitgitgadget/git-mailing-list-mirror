From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git 1.7.8.rc0
Date: Wed, 02 Nov 2011 12:13:48 -0700
Message-ID: <7vwrbiibgz.fsf@alter.siamese.dyndns.org>
References: <7vfwi9rc0g.fsf@alter.siamese.dyndns.org>
 <4EAEAE13.50101@atlas-elektronik.com> <4EAFC18A.1070502@atlas-elektronik.com>
 <7vmxcfn23i.fsf@alter.siamese.dyndns.org>
 <loom.20111101T205618-231@post.gmane.org>
 <loom.20111101T211624-511@post.gmane.org>
 <20111102180327.GA30668@sigill.intra.peff.net>
 <20111102181041.GA5366@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Naewe <stefan.naewe@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 02 20:14:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLgG4-0004dJ-9w
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 20:13:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933422Ab1KBTNw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 15:13:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59965 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932164Ab1KBTNv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 15:13:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 568A96048;
	Wed,  2 Nov 2011 15:13:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vDW6cW7GXOGko3gLZj4cdGeuY4A=; b=Ku1Goj
	HE1qRtqsxc5Wjf7Ss4v55BGGOgfGIJi0qxnMpBbs64UGHEyqNOTp1FLju7ocUjGq
	xeTU5XdQyXvhsVBCQYHt8Pn8jEgxPiI70EhS2uKkQa+Qf2VZA+gTTO2bvhmtmZAE
	YDud6XyGdl0IQYJ2yIdoUucKu5JQ7T0TcGt7E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wfzLK6dgunNP8w9mU2yO8DvnIClI43mZ
	erKzHl6b5kTzuEY7PFj9ct9EaaKWL4P821F0iDk25VCuB05K2qMlN4Fu2x3XS5+a
	o5nQvfsZAs/TTOHpfhAp2Wnq14vr2FIqCoiXh1j6vtRlptK2Xw/R0h83nvmqfCz9
	KsoO47OAgbk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D81B6047;
	Wed,  2 Nov 2011 15:13:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C86A36046; Wed,  2 Nov 2011
 15:13:49 -0400 (EDT)
In-Reply-To: <20111102181041.GA5366@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 2 Nov 2011 14:10:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CBA755AA-0586-11E1-ADDB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184657>

Jeff King <peff@peff.net> writes:

> So the ideal logic is:
>
>   1. look in netrc
>
>   2. If we have a username and no password, ask for password
>
>   3. Otherwise, try it and see if we get a 401.
>
> But we can't do that, because (1) and (3) happen atomically inside of
> curl.
>
> The simplest thing is to just drop the behavior in (2), and let it drop
> to a 401. The extra round trip probably isn't that big a deal.

That is essentially what Stefan's fix is about.

The cases we have "extra" roundtrip are:

 - when you have username@ in URL but no password is stored in .netrc;
 - when you have username@ in URL and no $HOME/.netrc file.

and in such a case using URL without username@ in it as a workaround would
save the roundtrip but forces you to type your username@ over and over
again, which is _not_ a real workaround.

A workaround for people who want ultimate convenience is to use .netrc to
have both username:password, but that is at the cost of potentially
reduced security. Having username@ in URL and typing password
interactively, if it worked properly, would have been the best of both
worlds.

> The other option is to start parsing netrc ourselves, or do the extra
> round trip if we detect ~/.netrc or something. But that last one is
> getting pretty hackish.

I tend to agree that we wouldn't want to parse netrc ourselves (that is
what library support e.g. CURLOPT_NETRC is for). The latter is hackish but
on the other hand it is a cheap, simple and useful hack.

How would the upcoming keystore support fit in this picture, by the way?
