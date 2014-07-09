From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 1/2] add `config_set` API for caching config-like files
Date: Wed, 09 Jul 2014 10:44:18 -0700
Message-ID: <xmqq38ea77gt.fsf@gitster.dls.corp.google.com>
References: <1404903454-10154-1-git-send-email-tanayabh@gmail.com>
	<1404903454-10154-2-git-send-email-tanayabh@gmail.com>
	<vpq61j6d92z.fsf@anie.imag.fr> <53BD3805.40504@gmail.com>
	<vpqion68viq.fsf@anie.imag.fr>
	<xmqqmwci7e9p.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jul 09 19:44:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4vv3-0002Zh-06
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 19:44:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755082AbaGIRod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 13:44:33 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63477 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751742AbaGIRoc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 13:44:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 58874276A9;
	Wed,  9 Jul 2014 13:44:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=amwGpH+4bc2NUP8BQXQxejOPTJE=; b=nHlNM3
	7JynebDpC+8NuD2w3sXwMxpRek/DybNBDjyp6+IXRXW7CY0x64uU+nBbfYKfszzD
	rWP/rpqnpyMy9VdPcOMP3vOcx12zwbHRy+ugSTJlOObQKV+KCAC/cIPGJHeACypM
	JNPpntSiINRxFRQ9E3HiGuAYxMJ9FjD0MVbLk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WSgmMXsBuDAl1HgVTgzkivtbKCud5by2
	wNfaoH6MEuvxrQ20fGD8d5jvatdhbI9VTwQeiIWezGluc5gP+TnQZ1FdxaKvhG8I
	Vm6r9C+39DgM2zmS5EBC7/XbWe4DaEF60Kjgny99BvlIblmIKR0oBxxF+Z/YAdWR
	Qcgq312BIQ0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4CCA1276A8;
	Wed,  9 Jul 2014 13:44:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DED04276A0;
	Wed,  9 Jul 2014 13:44:04 -0400 (EDT)
In-Reply-To: <xmqqmwci7e9p.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 09 Jul 2014 08:17:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9ED2B790-0790-11E4-84A5-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253136>

Junio C Hamano <gitster@pobox.com> writes:

>> * Still, making sure that the (file, line) is doable later without too
>>   much change is good. So, if indeed, moving all code to another file is
>>   required, then it may make sense to do it now to avoid code move
>>   later.
>
> Good thinking.  As long as the code is prepared, it is a good idea
> to start small and bite off only we can chew at once, do things
> incrementally.

After thinking about it a bit more, I think <file, line> support
needs to be done not as a mere client of the generic, uncached
git_config() API that we have had for forever, like the current
iteration, but needs to know a bit more about the state the caller
of the callback (namely, git_parse_source()), and we obviously do
not want to expose that machinery to anybody other than the
implementation of the config subsystem (to which the new facility
this GSoC project adds belongs to), so in that sense you have to
have your code in the same config.c file anyway.

It is somewhat dissapointing that this initial implementation was
done as a client of the traditional git_config(), by the way.  I
would have expected that it would be the other way around, in that
the traditional callers of git_config() would behefit automatically
by having the cache layer below it.

But we have to start from somewhere.  Perhaps the round after this
one can rename the exisiting implementation of git_config() to
something else internal to the caching layer and give the existing
callers a compatible interface that is backed by this new caching
layer in a transparent way.
