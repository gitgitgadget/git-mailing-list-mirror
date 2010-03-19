From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Prompt for a username when an HTTP request 401s
Date: Fri, 19 Mar 2010 12:27:14 -0700
Message-ID: <7vr5ngkt7x.fsf@alter.siamese.dyndns.org>
References: <d411cc4a1003182041p67a93bf6i1528a8eaaab5c805@mail.gmail.com>
 <20100319143205.GB16211@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>, git list <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Mar 19 20:27:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nshr3-000665-3Y
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 20:27:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330Ab0CST11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 15:27:27 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35022 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913Ab0CST10 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 15:27:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 25164A3FDD;
	Fri, 19 Mar 2010 15:27:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=utBLQ4NjNoIuoxHmOUrv9JFy8Pc=; b=GUSiXc
	O1xc3PHKU2mszNGNOSiwRZFiNO1p+BcOwDTDg6QYKeo3IQtBxIzpbVMm9/nGeGAq
	g5i927sMvUI3TDWAJEHEXopBQkq7csSIK/3boldyBWZXU19XbPrr4/i2sEGM0sVX
	7NhN+KsWBmldC2I0uX7WPX/opPva1hXfRdPGA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bONVJH/EW/yr4k7+3oedFTNGHsXYOtXT
	4BKQ+q3sgJKILIy+9TITyUpUq2zlM63oa44GU42K418pvM0sK9R1j/UKyaQjXief
	l4g6KYSVv08pWUBQKvN+CfLaD3X9HoXAmx8wF6zy0ChLpGQ2raRBIcp3VW00KSFO
	R3JGBOuElAk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E67FEA3FDB;
	Fri, 19 Mar 2010 15:27:19 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3F740A3FD5; Fri, 19 Mar
 2010 15:27:16 -0400 (EDT)
In-Reply-To: <20100319143205.GB16211@spearce.org> (Shawn O. Pearce's message
 of "Fri\, 19 Mar 2010 07\:32\:05 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6F8A776A-338D-11DF-B80E-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142639>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Scott Chacon <schacon@gmail.com> wrote:
>> @@ -815,7 +815,18 @@ static int http_request(const char *url, void
>> *result, int target, int options)
>>  			ret = HTTP_OK;
>>  		else if (missing_target(&results))
>>  			ret = HTTP_MISSING_TARGET;
>> -		else
>> +		else if (results.http_code == 401) {
>> +			if (user_name) {
>> +				ret = HTTP_NOAUTH;
>> +			} else {
>> +				// it is neccesary to use getpass here because
>> +				// there appears to be no other clean way to
>> +				// read/write stdout/stdin
>> +				user_name = xstrdup(getpass("Username: "));
>
> No, getpass is needed here because its very likely stdin/stdout are
> pipes to our parent process.  So we instead need to use /dev/tty,
> but that is non-portable.  Using getpass() can at least be stubbed
> on other platforms with a different implementation if/when necessary.

In addition to the obligatory "no C++/C99 double-slash comments, please ",
I think by the time this gets into an applicable shape, Frank's f206063
(git-core: Support retrieving passwords with GIT_ASKPASS, 2010-03-04) will
have graduated to the 'master'.  It would be a good idea to build this
change on top of that one.
