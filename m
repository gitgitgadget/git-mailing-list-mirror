From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] general style: replaces memcmp() with proper starts_with()
Date: Wed, 12 Mar 2014 13:08:03 -0700
Message-ID: <xmqq61njkwnw.fsf@gitster.dls.corp.google.com>
References: <1394635434-44979-1-git-send-email-quintus.public@gmail.com>
	<20140312175624.GA7982@sigill.intra.peff.net>
	<xmqqiorjky0a.fsf@gitster.dls.corp.google.com>
	<20140312194943.GA2912@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Quint Guvernator <quintus.public@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 12 21:08:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNpRn-0002LV-AM
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 21:08:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752471AbaCLUIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 16:08:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64864 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752244AbaCLUII (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 16:08:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3E4773B7E;
	Wed, 12 Mar 2014 16:08:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jAsjIRY/KSmsfMlrN2qP3vVeNiA=; b=g+SlpU
	7LZY13eQkfyQgYexnCnC/KY3wjWEoVOgDdABHQlXZ9w0CRoHzlWxO0b7JC/CmUMa
	oGb4P5Bxht4x+mZmNIAemxfj4A9K1gSphkauBusdjD5vucJxFFgv7V92ZAoGEgtk
	nEb+hiaySHCVuQTjX2OgpaEPPIVh+9ndmTGHo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oCRQ/ZX7XauMQQdKATj1QggpDPjS9W5b
	EdRIcYe8qDnYNFfTpuRP7XocxvfLYt5zHshlA9+0fqcJtF5R8K2uqOgLjWpXUK1i
	a54+oQIkOVO07ZjdzDl8AtqRb6cnnG1iC+9ObRRyj/ST/TUsR/DnrCQKNN+fny1Q
	Bjlws+OVgQU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B376973B7B;
	Wed, 12 Mar 2014 16:08:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CC44573B79;
	Wed, 12 Mar 2014 16:08:06 -0400 (EDT)
In-Reply-To: <20140312194943.GA2912@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 12 Mar 2014 15:49:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 06A7041A-AA22-11E3-9F43-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243982>

Jeff King <peff@peff.net> writes:

>> Blindly replacing starts_with() with !memcmp() in the above part is
>> a readability regression otherwise.
>
> I actually think the right solution is:
>
>   static inline int standard_header_field(const char *field, size_t len)
>   {
>           return mem_equals(field, len, "tree ") ||
>                  mem_equals(field, len, "parent ") ||
>                  ...;
>   }
>
> and the caller should tell us it's OK to look at field[len]:
>
>   standard_header_field(line, eof - line + 1)
>
> We could also omit the space from the standard_header_field.

Yes, that was what I had in mind.  The only reason why the callee
(over-)optimizes the "SP must follow these know keywords" part by
using the extra "len" parameter is because the caller has to do a
single strchr() to skip an arbitrary field name anyway so computing
"len" is essentially free.

> The caller
> just ran strchr() looking for the space, so we know that either it is
> there, or we are at the end of the line/buffer. Arguably a string like
> "parent\n" should be "a parent header with no data" (but right now it is
> not matched by this function). I'm not aware of an implementation that
> writes such a thing, but it seems to fall in the "be liberal in what you
> accept" category.

It is _not_ a standard header field, so it will be read by the logic
in the caller as a non-standard header field without getting lost.
