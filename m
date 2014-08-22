From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] upload-pack: keep poll(2)'s timeout to -1
Date: Fri, 22 Aug 2014 11:19:06 -0700
Message-ID: <xmqq1ts8peud.fsf@gitster.dls.corp.google.com>
References: <20140822151911.GA8531@debian> <20140822154445.GA19135@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Edward Thomson <ethomson@edwardthomson.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 22 20:19:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKtQn-0001NK-0c
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 20:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932634AbaHVSTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 14:19:17 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62110 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932410AbaHVSTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 14:19:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CDA0232A0A;
	Fri, 22 Aug 2014 14:19:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PVbUNktE7fYN4DmME7xds9zxg+g=; b=EzkV2K
	MqCyjlDXAXxp506iHBQ58bo6GdNe2DYpKiSKRn4e/hDpwkVJPIooWo563HFYC80k
	/2FqWJlybreLoh6viKC8RkB8Yv7gIVvmKzW5IfR/wTLyv7iGzQxPxg3yQRPklrnD
	yEoWtMoTWNgq+DDw19M2HObB+MxLwCT0Ix5sI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tnIr+wLvt4prH7JaN0kW0HJrjj2nk674
	F2TQ0z1xCxOpcj3IbKp9zQhtGoGxWQ4cy2VfuBEzi7IkmkFi+h2y5z1HNmjrVNcE
	vKvNWh+/CM/rNezJw+6ukt1VkJa77N0e2mj1Ob4OhyljcbCFk0jBC93xIlOOwo2P
	7YT24UscESM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C013232A09;
	Fri, 22 Aug 2014 14:19:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1627C329FD;
	Fri, 22 Aug 2014 14:19:08 -0400 (EDT)
In-Reply-To: <20140822154445.GA19135@peff.net> (Jeff King's message of "Fri,
	22 Aug 2014 11:44:45 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CE974BD4-2A28-11E4-8E35-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255688>

Jeff King <peff@peff.net> writes:

> On Fri, Aug 22, 2014 at 03:19:11PM +0000, Edward Thomson wrote:
>
>> Keep poll's timeout at -1 when uploadpack.keepalive = 0, instead of
>> setting it to -1000, since some pedantic old systems (eg HP-UX) and
>> the gnulib compat/poll will treat only -1 as the valid value for
>> an infinite timeout.
>
> That makes sense, and POSIX only specifies the behavior for -1 anyway.
> The patch itself looks obviously correct. Thanks.
>
> Since we're now translating the keepalive value, and since there's no
> way to set it to "0" (nor would that really have any meaning), I guess
> we could switch the internal "no keepalive" value to 0, and do:
>
>   ret = poll(pfd, pollsize, keepalive ? 1000 * keepalive : -1);
>
> which would let us avoid setting it to -1 in some other spots.  I dunno
> if that actually makes a real difference to maintainability, though.
> Either way:
>
>   Acked-by: Jeff King <peff@peff.net>
>
> -Peff

There is 1000 * wakeup in credential-cache--daemon.c, by the way.
