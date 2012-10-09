From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH nd/attr-match-optim-more 2/2] attr: more matching
 optimizations from .gitignore
Date: Tue, 09 Oct 2012 09:40:20 -0700
Message-ID: <7vhaq3ha4r.fsf@alter.siamese.dyndns.org>
References: <1349749445-25397-1-git-send-email-pclouds@gmail.com>
 <1349749445-25397-2-git-send-email-pclouds@gmail.com>
 <7vd30si665.fsf@alter.siamese.dyndns.org> <5073BFDE.60707@viscovery.net>
 <7vvcekgn0h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Oct 09 18:40:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLcrD-00045w-OF
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 18:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752178Ab2JIQk0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 12:40:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56219 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751208Ab2JIQkY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 12:40:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE20B98AF;
	Tue,  9 Oct 2012 12:40:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ndAVvOHHlv/Tq4Pcx3ssLCpVK2A=; b=n9Vj8m
	0XaQdr4nLptARaw5nEaYuNaqZrBs5NeHUFt/mKDTTPyrPueDPdpOcU5ipy3AGVSB
	gxNy6SoGOlZ+zPGBi3ZAvnVuH1ci2D8jVUHVvn02YT4HEqueCSXHbWVVrX1xdAuL
	b4L32Pyv6syg/haD+6z1n8mKKKstLMwo72/KI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KXnxKuhSwFTr+LM+9yEABfXbzYizBGnP
	4NmOYYWU8jSnje/57jbBVsc1nGPm2mQfOKgux1Xfuyr5D7yY0R1NaVn+PEMVST+z
	gcSQGBjyNBy37Z8o5nNGXc7FjviTrDRWgWrLIUExTClEJkeCc3hcCyA7zh+yHJ+n
	yAIDPSBkoLY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC56298AE;
	Tue,  9 Oct 2012 12:40:23 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3EE8998AB; Tue,  9 Oct 2012
 12:40:22 -0400 (EDT)
In-Reply-To: <7vvcekgn0h.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 08 Oct 2012 23:47:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 04CAB0E6-1230-11E2-8414-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207325>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Sixt <j.sixt@viscovery.net> writes:
>
>> Am 10/9/2012 7:08, schrieb Junio C Hamano:
>>> Imagine if we allowed only one attribute per line, instead of
>>> multiple attributes on one line.
>>>     
>>>  - If you want to unset the attribute, you would write "path -attr".
>>> 
>>>  - If you want to reset the attribute to unspecified, you would
>>>    write "path !attr".
>>> 
>>> Both are used in conjunction with some other (typically more
>>> generic) pattern that sets, sets to a value, and/or unsets the
>>> attribute, to countermand its effect.
>>> 
>>> If you were to allow "!path attr", what does it mean?  It obviously
>>> is not about setting the attr to true or to a string value, but is
>>> it countermanding an earlier set and telling us to unset the attr,
>>> or make the attr unspecified?
>>
>> If I have at the toplevel:
>>
>>   *.txt  whitespace=tabwidth=4
>>
>> and in a subdirectory
>>
>>   *.txt  whitespace=tabwidth=8
>>   !README.txt
>>
>> it could be interpreted as "do not apply *.txt to REAME.txt in this
>> subdirectory". That is, it does not countermand some _particular_
>> attribute setting, but says "use the attributes collected elsewhere".
>
> It makes it unclear what "elsewhere" means, though (besides, it does
> not match the way the matching logic works at all).

Ignoring the current implementation, I find the suggested semantics
somewhat intriguing.  It is something we may want to look into in
the future.
