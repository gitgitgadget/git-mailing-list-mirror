From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] "git config --get-urlmatch $section.$key $url"
Date: Wed, 31 Jul 2013 12:31:55 -0700
Message-ID: <7vzjt2ttjo.fsf@alter.siamese.dyndns.org>
References: <7vli4v66b3.fsf@alter.siamese.dyndns.org>
	<1375138150-19520-1-git-send-email-gitster@pobox.com>
	<51F9509F.60402@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Kyle J. McKay" <mackyle@gmail.com>,
	Jeff King <peff@peff.net>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Jul 31 21:32:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4c7y-0001aA-8E
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 21:32:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757401Ab3GaTcB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 15:32:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57981 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754297Ab3GaTcA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 15:32:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6950635B3F;
	Wed, 31 Jul 2013 19:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OXmyoRi1ZoEtbOsQhZXdro91gy0=; b=oNXmKc
	Rmt92AMyaY3vEIxX4Fv10M8CIFYPeCwxyXBHcgtdvlr6KexApBRP7C2xxs5+cN7S
	pXxarNsF6UfYlVqJiV8IJz3nFRhJoB4Dxfs5RVo9U6vuGNPEMlNuqzuAgLj/4Q4+
	enijgENIsctZR/aWJ8HAmnGMoR1kSLQf1B9Ko=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TFIIQfPYBkeHL/kkX90oYpH2UhP2TOmt
	SB2Ex4YcRP8j5mgdfH1+Lyq4Mg25QaoeFKvrT6W6RR8Tnju14qd9krGwMBguCE9S
	MbJL1pyYOaa8TGh0Aq2QJYjo86uvmHZFdS5g193RluB7l2PUSikqt7QbC8RSOEyk
	6BLzwaCDBpw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CEBA35B3D;
	Wed, 31 Jul 2013 19:31:59 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0458635B38;
	Wed, 31 Jul 2013 19:31:56 +0000 (UTC)
In-Reply-To: <51F9509F.60402@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Wed, 31 Jul 2013 18:59:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DCD8205C-FA17-11E2-BB0C-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231450>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> Junio C Hamano wrote:
>> So here is a bit of refactoring to extract the logic to find the
>> entry $section.<urlpattern>.$key from the configuration that best
>> matches the given $url to answer "what value $section.$key should be
>> for $url?" out of http.c (primarily because we never want to link
>> "git cofnig" with the cURL library), and use it from "git config" to
>> implement Peff's idea to extend "git config".
>> 
>> The first step is a pure code movement, plus some renaming of the
>> functions.
>> 
>> The second step is to factor out the code to handle --bool, --int, etc.
>> as a helper so that the new codepath can use it.
>> 
>> The last step currently duplicates the logic in http_options(), but
>> we might want to refactor it further so that the two functions can
>> share more code.  We hopefully can get rid of test-url-normalize and
>> instead use "git config --get-urlmatch" in the tests that protect
>> the http.<url>.config topic.
>
> I haven't been following this topic too closely and I don't have any
> feel for how long it will take to get to the end-game. However, unless
> the removal of test-url-normalize is coming soon, could I request that
> you apply my patch (or squash it into this series)? At present, I have
> to apply the patch before building the next and pu branches; OK it's not
> too onerous, but still ... :-P

Will squash in.  Thanks for a reminder.
