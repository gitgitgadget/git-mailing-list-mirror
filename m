From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC] git-am: support any number of signatures
Date: Thu, 12 Jun 2014 12:07:03 -0700
Message-ID: <xmqqioo654mg.fsf@gitster.dls.corp.google.com>
References: <1402589505-27632-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 21:07:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvALH-0006oQ-6P
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 21:07:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961AbaFLTHM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 15:07:12 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63456 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751896AbaFLTHK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 15:07:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D05181EBEF;
	Thu, 12 Jun 2014 15:07:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LctHeUhHTMoqWcwY7Cg/GcHe6E8=; b=K94wee
	YWWPO4j/CWsC3Vm2xP8mEf8h6EsImVBiCRBvK7XhThHzaT/iiUzGg9VD4218KEUW
	gdAYTAjfA0AOOiRPuNyWetlRyrbDD99Yc7EQ3oZw2a9AStuFSaoc/EK4W6TOSvxm
	5QsihiV5gDpoiPQMKt/d5KPMIycvqZLEt5eO0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JvFaALJOALqNzWzzesSciBJrIO4VQbFw
	BmrrkdAqA8E1FJaFn2VByW5mZkPJf828qClLikVSgu9kr2YEbuKNUbKJogVZrCgv
	PuP/Jz4fRC1PoiREAvW1HZxgB+ocMPrGSl7Hu9a7oVyDqtb9V5puHV6lWkg4UWFq
	VHDbmdi18XU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C3B1B1EBEE;
	Thu, 12 Jun 2014 15:07:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DC60A1EBE6;
	Thu, 12 Jun 2014 15:07:04 -0400 (EDT)
In-Reply-To: <1402589505-27632-1-git-send-email-mst@redhat.com> (Michael
	S. Tsirkin's message of "Thu, 12 Jun 2014 19:12:35 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BDF942CE-F264-11E3-A216-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251480>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> I'm using different signature tags for git am depending on the patch,
> project and other factors.
>
> Sometimes I add multiple tags as well, e.g. QEMU
> wants both Reviewed-by and Signed-off-by tags.
>
> This patch makes it easy to do so:
> 1.  new parameter am.signoff can be used any number
> 	of times:
>
> [am]
> 	signoff = "Reviewed-by: Michael S. Tsirkin <mst@redhat.com>"
> 	signoff = "Signed-off-by: Michael S. Tsirkin <mst@redhat.com>"
>
> 	if set all signatures are picked up when git am -s is used.

How does this interact with the logic to avoid appending the same
Signed-off-by: line as the last one the incoming message already
has?

> 2.  Any number of alternative signatures
>
> [am "a"]
> 	signoff = "Acked-by: Michael S. Tsirkin <mst@redhat.com>"
>
> 	if set the signature type can be specified by passing
> 	a parameter to the -s flag:
>
> 	git am -sa
>
> No docs or tests, sorry, so not yet ready for master, but I'm using this
> all the time without any issues so maybe ok for pu.
> Early flames/feedback/help welcome.

How does that "a" in [am "a"] work?  If it defines some kind of
scope (i.e. use am.a.* instead of am.* when I specify I am using "a"
set somehow), that might be something interesting, but if it applies
only to sign-off and other things, then I am not sure if I like it,
as that would invite confusions from end users.

> +		signoffs=("${signoffs[@]}" "${s[@]}") ;;

Is this a shell array?  It won't fly in our codebase if that is the
case.
