From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] verify-tag: add --check-name flag
Date: Tue, 07 Jun 2016 14:50:23 -0700
Message-ID: <xmqq37oopt28.fsf@gitster.mtv.corp.google.com>
References: <20160607195608.16643-1-santiago@nyu.edu>
	<xmqq7fe0pv5b.fsf@gitster.mtv.corp.google.com>
	<20160607211707.GA7981@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: santiago@nyu.edu, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	Colin Walters <walters@verbum.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 07 23:51:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAOtV-0006wj-OI
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 23:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162338AbcFGVug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 17:50:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53524 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1162332AbcFGVuc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 17:50:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C180622537;
	Tue,  7 Jun 2016 17:50:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZzCeeVuBCniRZvmuxsSYWSA/VjU=; b=jJo2T3
	xw3yGs7kOWlknJggYitL5NptaxZUn5l7zRIQMFllmzyJfJHrsR+KUkjd80qv4HtH
	4icmijE6xkDpzgPYesu2J13r+FqDm9ajBNF3e3XX7nfqSZbBtrtObRNXdm8Vd9Pf
	CAjxg7lR3pLUUca9/sAz93LImGhvYUUZJUdwU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GmqkBJ/bGnkO8d0Rzwj9lCjj/lfYdz4X
	+CLyyLf2WBAthVaW2bveKx/yJD70S45FT/dfbjo0wb3cntlu5wJQXkcW2lOMCyxB
	MUee22IwZNIYWQwphSWtIUcQMiIeviIi2MfyYS+EVHSt24sR3jTpPliLBbKfBMeS
	N0XbhY7Rr/Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BA23222536;
	Tue,  7 Jun 2016 17:50:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3305522531;
	Tue,  7 Jun 2016 17:50:25 -0400 (EDT)
In-Reply-To: <20160607211707.GA7981@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 7 Jun 2016 17:17:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D75A05B0-2CF9-11E6-9F2C-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296730>

Jeff King <peff@peff.net> writes:

>   git tag -v --format='%(tag)%n%(tagger)'
>
> or similar. In fact you can already do that with a separate step (modulo
> %n, which we do not seem to understand here), but like your example:

Yes, "--format=%(tag)" is all that is needed to make the example work.

>> Or it could even do this:
>> 
>> 	tag="$1"
>> 	if ! git tag -v "$tag"
>> 	if ! git tag -v "$tag"
>>         then
>> 		echo >&2 "Bad tag."
>>                 exit 1
>> 	fi
>> +	tag=$(git tag --show-tagname $tag)
>> 	make dest=/usr/local/$package/$tag install
>
> It is racy. That probably doesn't matter for most callers, but it would
> be nice to be able to get a custom format out of the "-v" invocation.

Heh, you can do

-	tag="$1"
+	tag=$(git rev-parse --verify "$1")

upfront and it no longer is racy, no?
