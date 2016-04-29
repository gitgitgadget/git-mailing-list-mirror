From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 2/3] connect: group CONNECT_DIAG_URL handling code
Date: Fri, 29 Apr 2016 10:13:45 -0700
Message-ID: <xmqqvb30z6ba.fsf@gitster.mtv.corp.google.com>
References: <20160428232936.GA8663@glandium.org>
	<1461890625-23222-1-git-send-email-mh@glandium.org>
	<1461890625-23222-2-git-send-email-mh@glandium.org>
	<xmqqeg9o1k40.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Apr 29 19:13:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awBzF-0005gU-J1
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 19:13:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752418AbcD2RNu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 13:13:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59596 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751980AbcD2RNt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 13:13:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 077591755F;
	Fri, 29 Apr 2016 13:13:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dOmLQ2JuatFhDSXb6ji6s2Kkre8=; b=PcZyBZ
	valoVldVJWsLTcrhZQXlZVqgxQn5SZ0GVZ+E/xGQGiPxQf9nxM3iCZjcP1TKMjnN
	FqPRvwE42N6Ot3qpeo3T9EabrejrqYuvxxg/JlC+EZU62YvgxyglvZA5grR26BMp
	SERUGuO5Ou/sAIixrLqzl8akQORTpFdwqvs2k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QD9PAhTqeqjvMTtGZJeWRGtcV7ov5zwy
	Vfqnl05tmQcnjjRwWrRAE2R/6vedVVBQvvqJcZ1AxCEtG0bTm32RkdbsHAPI8llu
	yTC8zwXw849R7k31I6exEbRZu2CgCrkvH5RObYxqTXXiJtehwFR30HXMnfPeIZvG
	5rlMzhc2m14=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F056D1755E;
	Fri, 29 Apr 2016 13:13:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 541311755D;
	Fri, 29 Apr 2016 13:13:47 -0400 (EDT)
In-Reply-To: <xmqqeg9o1k40.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 29 Apr 2016 08:59:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BC1ADEB8-0E2D-11E6-AD73-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293028>

Junio C Hamano <gitster@pobox.com> writes:

> Mike Hommey <mh@glandium.org> writes:
>
>> Signed-off-by: Mike Hommey <mh@glandium.org>
>
> I feel that this commit is under-explained.  I think you should feel
> entitled to boast the goodness this brings to us louder in the log
> message.
>
> It bothers me somewhat that this ended up copying, not moving, a bit
> of code to call get-host-and-port helper, but I do not think it is a
> problem and it makes the codeflow easier to follow.  Attempt to
> refactor it to reduce the duplication is likely to make it worse.
>

I hate to add a noise to the list, but while re-re-re-editing this
message before sending it out, I accidentally dropped an important
line here.  I said (and then removed by mistake):

	I like what this patch does.

> We used to allocate and prepare the child process structure 'conn',
> then realized that we are not going to use it anyway and discarded,
> only because the DIAG_URL check for SSH transport was done way too
> late.  That wastage is removed by this change as well.
>
> Another change I notice is that DIAG_URL code for PROTO_SSH did not
> even kick in if transport_check_allowed("ssh") said no, but with
> this new code Diag is always given, which makes it consistent with
> PROTO_GIT codepath.
