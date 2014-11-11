From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] Clean stale environment pointer in finish_command()
Date: Tue, 11 Nov 2014 07:55:43 -0800
Message-ID: <xmqqr3x97mv4.fsf@gitster.dls.corp.google.com>
References: <cover.1415368490.git.johannes.schindelin@gmx.de>
	<cover.1415630072.git.johannes.schindelin@gmx.de>
	<df1b16208e443416f7185c8c8c110e637ea97ac4.1415630072.git.johannes.schindelin@gmx.de>
	<alpine.DEB.1.00.1411101539091.13845@s15462909.onlinehome-server.info>
	<20141111031636.GE21328@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 11 16:55:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoDnJ-0007er-NV
	for gcvg-git-2@plane.gmane.org; Tue, 11 Nov 2014 16:55:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652AbaKKPzq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2014 10:55:46 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62181 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751306AbaKKPzp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2014 10:55:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C7CC91B378;
	Tue, 11 Nov 2014 10:55:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NwTh84u2YUcWjWobr44HiawbkcE=; b=d4nTTy
	I4TCvStNnagx0JMJ6BP5MkN6+Jbs/Qzn+NCuiDJixS2H7Jrk8OCaHEsjJvAmJJHB
	ml+BPMxhUJHC9pJ9t9oqreulqwP58rEOX55gdKqQglBmDZx3aezwc6ds0bOO6zne
	Wp7yfFR0jWzwho5elgHChNeHeMV8dus7SIHcI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uQL1EMd1Lu9U2JXevAt6jvLvW2V1aADI
	Oe22NB7ZBxvVnIKRHvIjk14Un7me2KoL+EJV+Favn5jgBCq8DCP0ijLbAHlfAUd0
	9+hDGCFGuAuQIPf0FQSH0Mw59vas8pIvP6ZsqWxn2Y8SHPNEpPq47kWGVu+zAO9L
	AnfhJ31IjIY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B3EC81B377;
	Tue, 11 Nov 2014 10:55:44 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 34A501B376;
	Tue, 11 Nov 2014 10:55:44 -0500 (EST)
In-Reply-To: <20141111031636.GE21328@peff.net> (Jeff King's message of "Mon,
	10 Nov 2014 22:16:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 31BD4976-69BB-11E4-9F5F-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I don't think this is "unfortunately"; freeing the memory was the entire
> purpose in adding env_array. If you want to easily reuse the same
> environment in multiple commands, it is still perfectly fine to use
> "env" directly, like:
>
>   struct argv_array env = ARGV_ARRAY_INIT;
>   struct child_process one = CHILD_PROCESS_INIT;
>   struct child_process two = CHILD_PROCESS_INIT;
>
>   ... setup env with argv_array_push ...
>
>   one.argv = foo;
>   one.env = env.argv;
>   run_command(&one);
>
>   two.argv = bar;
>   two.env = env.argv;
>   run_command(&two);
>
>   argv_array_clear(&env);
>
> You do not get the benefit of the auto-cleanup (you have to call
> argv_array_clear yourself), but that is less bad than repeating the
> setup of "env" twice.

Yeah, the above looks like the best option, better than using a
single child_process and having to re-initialize fds and envs.

Thanks for helping.
