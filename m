From: Junio C Hamano <gitster@pobox.com>
Subject: Re: submodule: if $command was not matched, don't parse other args
Date: Mon, 24 Sep 2012 09:17:40 -0700
Message-ID: <7v7grj1jkr.fsf@alter.siamese.dyndns.org>
References: <CALkWK0npySdS7FDt=6VKdtoNS2gqQH5WaTQ4H6TEmXdP9fuF=g@mail.gmail.com>
 <7v8vc13ilc.fsf@alter.siamese.dyndns.org> <505F489B.1000309@web.de>
 <50607748.6000204@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>
To: marcnarc@xiplink.com
X-From: git-owner@vger.kernel.org Mon Sep 24 18:17:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGBM0-0004in-2k
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 18:17:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756449Ab2IXQRn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 12:17:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43742 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753548Ab2IXQRm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 12:17:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 24340915A;
	Mon, 24 Sep 2012 12:17:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mW3gd+kkmN1WIvN9CXnIiZpjPwA=; b=c+ZysZ
	/EseqzsWgPxwpN0UlOqFvl6WFFf+Pq4sM96HDLI3LYaY7p4CjifKmuf3Vk41/A+T
	VUqQMeUxschn1kMES4R1LeF5jnk8CVFtWC36HyEeMRU3YLjHx1Q9YnJXGjV+5qfz
	Ac/qUUnIlVAh68CnFDCy/o8IeMD+CGQYAP0oU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tfCCAgieTlkrxkIZnujTXRzAQX4+032x
	l5vQXwisKv8F0hOeug4I2Pcf0/iYrop0pihzlhaKFmhGEOqCQamj2K8BxzoWBnJF
	B0KTfE3f75h8F3YhMNTysrBIZ3bNPBjVgoIt6EjSx+KyfG+Jcz8eIml+VavOYLkG
	NDQULtt07N8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0FFB69158;
	Mon, 24 Sep 2012 12:17:42 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8128F9157; Mon, 24 Sep 2012
 12:17:41 -0400 (EDT)
In-Reply-To: <50607748.6000204@xiplink.com> (Marc Branchaud's message of
 "Mon, 24 Sep 2012 11:07:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5D8EF29C-0663-11E2-AC11-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206292>

Marc Branchaud <mbranchaud@xiplink.com> writes:

> On 12-09-23 01:36 PM, Jens Lehmann wrote:
>> Am 22.09.2012 22:31, schrieb Junio C Hamano:
>>> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>>>> diff --git a/git-submodule.sh b/git-submodule.sh
>>>> index a7e933e..dfec45d 100755
>>>> --- a/git-submodule.sh
>>>> +++ b/git-submodule.sh
>>>> @@ -1108,7 +1108,15 @@ do
>>>>  done
>>>>
>>>>  # No command word defaults to "status"
>>>> -test -n "$command" || command=status
>>>> +if test -z "$command"
>>>> +then
>>>> +    if test $# = 0
>>>> +    then
>>>> +	command=status
>>>> +    else
>>>> +	usage
>>>> +    fi
>>>> +fi
>>>
>>> I personally feel "no command means this default" is a mistake for
>>> "git submodule", even if there is no pathspec or other arguments,
>>> but I am not a heavy user of submodules, so others should discuss
>>> this.
>> 
>> ... but I'd rather tend to not change that
>> behavior which has been there from day one for backward compatibility
>> reasons. But if many others see that as an improvement too I won't
>> object against changing it the way Ramkumar proposes (but he'd have
>> to change the documentation too ;-).
>> 
>> Since diff and status learned to display submodule status information
>> (except for a submodule being uninitialized) I almost never use this
>> option myself, so I'd be interested to hear what submodule users who
>> do use "git submodule [status]" frequently think.
>
> I also almost never use "git submodule [status]", and I also agree that
> git-submodule shouldn't have a default sub-command.

OK, I do not think Ramkumar's patch hurts anybody, but dropping the
"nothing on the command line defaults to 'status' action" could.  So
let's queue the patch as-is at least for now and leave the default
discussion to a separarte thread if needed.

Thanks.
