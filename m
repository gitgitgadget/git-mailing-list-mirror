From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 06/10] fast-export: add new --refspec option
Date: Wed, 06 Nov 2013 14:41:46 -0800
Message-ID: <xmqqmwlh6tlh.fsf@gitster.dls.corp.google.com>
References: <1383212197-14259-1-git-send-email-felipe.contreras@gmail.com>
	<1383212197-14259-6-git-send-email-felipe.contreras@gmail.com>
	<xmqq61sd70vw.fsf@gitster.dls.corp.google.com>
	<CAMP44s246M5DaeX80tqzfjRWnbE4vKh-vp_tLW-qAQUFFPsP0Q@mail.gmail.com>
	<xmqq38n98cud.fsf@gitster.dls.corp.google.com>
	<20131106221427.GB13258@sigill.intra.peff.net>
	<xmqqr4at6u24.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 06 23:42:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeBnU-0008W4-Eb
	for gcvg-git-2@plane.gmane.org; Wed, 06 Nov 2013 23:42:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822Ab3KFWlu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Nov 2013 17:41:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63259 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750717Ab3KFWlt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Nov 2013 17:41:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BDE5B509ED;
	Wed,  6 Nov 2013 17:41:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f/43e3Z7o2JhJBvFrj7OewYKAwo=; b=YWX8+p
	0lOuo7BX+9mK9FYQgODKAWMGRZ7YS400yt0ljLZa/WRH2ECVIGz4t4vehE6XKoMA
	aZzmT7EGXMY+3ZTN6sFckki0z5t7TwgwX7WzmgGVKBkjLTDdolxZAebiS2lD53tb
	7d+eYzyR75Ryf+OimotAZDWM/r0wlTB5O3p8o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sA/r6W6j14CywMWq1EG7Yr3BjZQmdomT
	8qkOQ+IlKO0G8AMFs4c+h4kR8fiKi/WFybTdxvcniyw2ftaY3rdxf7XdFaVuleeZ
	xEMmYtNz5MLbY79hDQfnmKu5iHybSwwnzRH30pWnO+tiJrR8dE14lL4/wrRuD9n2
	K65WZ45kQP0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0090509EC;
	Wed,  6 Nov 2013 17:41:48 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1D7A8509E7;
	Wed,  6 Nov 2013 17:41:48 -0500 (EST)
In-Reply-To: <xmqqr4at6u24.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 06 Nov 2013 14:31:47 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9EEAC0B4-4734-11E3-AF2D-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237377>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> I think that is much nicer for the simple cases, but how do we handle
>> more complex rev expressions? One can say:
>>
>>   git fast-export master ^origin
>>
>> or even:
>>
>>   git fast-export origin..master
>>
>> The "^origin" is not a refspec, and finding the refspec in the
>> dot-expression would involve parsing it into two components. I think you
>> can come up with a workable system by parsing the arguments as revision
>> specifiers and then applying some rules. E.g., a positive ref "foo" is a
>> refspec "foo:foo", but negative "^bar" does not impact refspecs at all,
>> and the same rules are applied for "bar..foo". There is a syntactic
>> conflict where "foo:bar" would be interpreted as a tree:path by the
>> revision code, though, whereas in this context it means a refspec.
>>
>> So I think it is possible to go that route (and perhaps preferable,
>> even, because it keeps the simple and common cases easy for the user),
>> but the implementation is not as simple as just treating the arguments
>> as refspecs.
>
> I forgot about the ranges, but thinking about it further, I think ...

And I am an idiot; you've spelled out everything I wanted to say, so
I should have just dropped this ;-)
