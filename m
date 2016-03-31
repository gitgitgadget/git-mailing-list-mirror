From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 1/4] notes: don't leak memory in git_config_get_notes_strategy
Date: Wed, 30 Mar 2016 19:59:01 -0700
Message-ID: <xmqqegarqrnu.fsf@gitster.mtv.corp.google.com>
References: <1459357518-14913-1-git-send-email-sbeller@google.com>
	<1459357518-14913-2-git-send-email-sbeller@google.com>
	<CAPig+cTeVgyNHa5uHUMDZ6ifxyjk2wvm=jGd9tP1+BuBKKVR+g@mail.gmail.com>
	<xmqqegarsmil.fsf@gitster.mtv.corp.google.com>
	<20160331010604.GA23999@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Stefan Beller <sbeller@google.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 31 04:59:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alSpD-0008FR-Te
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 04:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755107AbcCaC7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 22:59:07 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:54980 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754373AbcCaC7F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 22:59:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9EB2952FFB;
	Wed, 30 Mar 2016 22:59:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SuCXGK0ExSTqH26eRAQriS63qTc=; b=eUJ47+
	j7hKWU5iroz4nTju8PV4Jttffr1Gqj6ZWFSUWLOjOFp341gbEA9rp4mnmdGdbvZo
	o4NogHUB9VskTfiAgtURFUU/QtDHiH3SVbN+C0tnDgfL8zbdg9RDsEoEVLBMR3Dz
	I5C1PjMjhFCxtN7fbEog63gMMHSbr1AZXUcX8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UHH1xFjGlzEyELQ3eTNwKVdn14setW5R
	RSUe0IEV6cCFnAzZ2E89bVzYuScdHqOSYn4EnzELcKB5ecjjuQy988bos3wIz+tR
	Xu2mMkeaIIqYq4Gq00qb9gUGLsalLVhwEWdbG+r6Nk0w49C5WyEzHNUO7/bIs9tj
	C/XDbMFdLAU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9536E52FFA;
	Wed, 30 Mar 2016 22:59:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1887852FF9;
	Wed, 30 Mar 2016 22:59:03 -0400 (EDT)
In-Reply-To: <20160331010604.GA23999@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 30 Mar 2016 21:06:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8656407C-F6EC-11E5-AFF0-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290370>

Jeff King <peff@peff.net> writes:

> On Wed, Mar 30, 2016 at 02:07:14PM -0700, Junio C Hamano wrote:
>
>> This is a tangent, but am I the only one who finds that the naming
>> of functions in config-get API is confusing?  Just wondering if we
>> should rename the ones that keeps the memory ownership to the config
>> subsystem with s/get/peek/ or something.
>
> You are definitely not the only one.
>
> I think the get/peek thing would help, but I also get confused between
> git_config_string() and git_config_get_string().

I actually do not have problems with the ones with names that do not
have "get" in.

git_config_$type() is always a helper function that are designed to
be called by config callback to parse (and complain) a <var, val>
pair that is expected to be of $type, and git_$family_config() is
always a helper function that are designed to be used as the
callback of git_config() to handle the configuration related to the
named command family.
