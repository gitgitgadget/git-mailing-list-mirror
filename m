From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH nd/attr-match-optim-more 2/2] attr: more matching
 optimizations from .gitignore
Date: Mon, 08 Oct 2012 23:47:26 -0700
Message-ID: <7vvcekgn0h.fsf@alter.siamese.dyndns.org>
References: <1349749445-25397-1-git-send-email-pclouds@gmail.com>
 <1349749445-25397-2-git-send-email-pclouds@gmail.com>
 <7vd30si665.fsf@alter.siamese.dyndns.org> <5073BFDE.60707@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Oct 09 08:47:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLTbR-0000So-Qu
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 08:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752363Ab2JIGrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 02:47:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42664 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751089Ab2JIGra (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 02:47:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E3D725A79;
	Tue,  9 Oct 2012 02:47:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=47sRoGMG6B+On8529BfysxEKMsY=; b=OU5+JG
	73h2a8fqu3jhWUceq853IrG3UN21KHUlyJVh7hCi6tD3KWCYgvK5SN1Juc1lFYvh
	vlLaZBGWNez5bJUjF7ciKyzvNskPgwV42OsP8LV1mmdk/WbSHWAoMbi8oyiAfCSb
	B1jJMbJ5xWLYBTW8XVytJIAFFpf1wIJuIYCso=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u3LDwy/jrYLWfnEf/rQzOwoXi4xCFKUZ
	Hj2QJjchWe8mf810GnO0HmPTlm3/vYyFgmmfgaXrPQp4i9gYuPaOcGIced/RbkaQ
	o3dcMfoxUQy5hPSE780eI8/R1RO4wOeyDrUpuxYtVC3A/vQgSRTSPErhj50S0caE
	ApLqIoEi9u8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D14A55A78;
	Tue,  9 Oct 2012 02:47:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5044B5A77; Tue,  9 Oct 2012
 02:47:29 -0400 (EDT)
In-Reply-To: <5073BFDE.60707@viscovery.net> (Johannes Sixt's message of "Tue,
 09 Oct 2012 08:10:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 31AC7EDA-11DD-11E2-BE3F-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207304>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 10/9/2012 7:08, schrieb Junio C Hamano:
>> Imagine if we allowed only one attribute per line, instead of
>> multiple attributes on one line.
>>     
>>  - If you want to unset the attribute, you would write "path -attr".
>> 
>>  - If you want to reset the attribute to unspecified, you would
>>    write "path !attr".
>> 
>> Both are used in conjunction with some other (typically more
>> generic) pattern that sets, sets to a value, and/or unsets the
>> attribute, to countermand its effect.
>> 
>> If you were to allow "!path attr", what does it mean?  It obviously
>> is not about setting the attr to true or to a string value, but is
>> it countermanding an earlier set and telling us to unset the attr,
>> or make the attr unspecified?
>
> If I have at the toplevel:
>
>   *.txt  whitespace=tabwidth=4
>
> and in a subdirectory
>
>   *.txt  whitespace=tabwidth=8
>   !README.txt
>
> it could be interpreted as "do not apply *.txt to REAME.txt in this
> subdirectory". That is, it does not countermand some _particular_
> attribute setting, but says "use the attributes collected elsewhere".

It makes it unclear what "elsewhere" means, though (besides, it does
not match the way the matching logic works at all).
