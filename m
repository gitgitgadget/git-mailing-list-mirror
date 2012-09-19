From: Junio C Hamano <gitster@pobox.com>
Subject: Re: possible bug in autocompletion
Date: Wed, 19 Sep 2012 10:58:19 -0700
Message-ID: <7vipb9hp38.fsf@alter.siamese.dyndns.org>
References: <BLU0-SMTP405CDB35308082B180185A6B4DB0@phx.gbl>
 <20120717121232.GA32571@sigill.intra.peff.net>
 <CAMP44s2X5-BUyLtkTqGMa6w5K6uT25YLEp+Q2TdVR_qCObOpeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jeroen Meijer <jjgmeijer@hotmail.com>,
	git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 19:58:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEOXp-00007f-Vk
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 19:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932903Ab2ISR63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 13:58:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42172 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932821Ab2ISR6X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 13:58:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 58C5A80E3;
	Wed, 19 Sep 2012 13:58:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6q7Uh5qj+A5a0i0glj4WOTNQ8/g=; b=SU1itm
	25MBnY4gcbJXF4SUJhpEHuHG/LNhkmnXvUCSSaY1Je6KElgGfxUeKO63awA2tVfF
	jAy+mBqkJxwMCL7aE09TP9fPPhIuKSJHaxBuCJeOfa7GaWWdtj1w7LYBUMwXfM1/
	MO9oYWilpAWmOFvAvvquervox+ZFG3AfXQXIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K4zwPXNmaF7Q80bVot6ayt8Zinv8hcPC
	fd59pHoJ0dguxyKAk8LzskxS6lezvwIl5TYBTBXjfuv1q2197Dn4LOf3jYmtBY7Q
	aJSerjDYocvlobAUCx186oUeV5fZsruW18I89TqK066/L9YAQzi1q7O07Cus8iq4
	zh/BgSR9o9E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 45A4A80E2;
	Wed, 19 Sep 2012 13:58:21 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9BE6D80DF; Wed, 19 Sep 2012
 13:58:20 -0400 (EDT)
In-Reply-To: <CAMP44s2X5-BUyLtkTqGMa6w5K6uT25YLEp+Q2TdVR_qCObOpeA@mail.gmail.com> (Felipe
 Contreras's message of "Wed, 19 Sep 2012 19:08:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 990FFDA4-0283-11E2-AB62-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205964>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Tue, Jul 17, 2012 at 2:12 PM, Jeff King <peff@peff.net> wrote:
>
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -261,7 +261,12 @@ __gitcomp ()
>>  __gitcomp_nl ()
>>  {
>>         local IFS=$'\n'
>> -       COMPREPLY=($(compgen -P "${2-}" -S "${4- }" -W "$1" -- "${3-$cur}"))
>> +       local words=$1
>> +       words=${words//\\/\\\\}
>> +       words=${words//\$/\\\$}
>> +       words=${words//\'/\\\'}
>> +       words=${words//\"/\\\"}
>> +       COMPREPLY=($(compgen -P "${2-}" -S "${4- }" -W "$words" -- "${3-$cur}"))
>>  }
>
> What about something like this?
>
> local words
> printf -v words "%q" "$w"
> COMPREPLY=($(compgen -P "${2-}" -S "${4- }" -W "$words" -- "${3-$cur}"))

Both "printf -v" and "%q" are brilliant ;-)
