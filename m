From: Junio C Hamano <gitster@pobox.com>
Subject: Re: No progress from push when using bitmaps
Date: Thu, 13 Mar 2014 15:23:15 -0700
Message-ID: <xmqqr465hh64.fsf@gitster.dls.corp.google.com>
References: <CAJo=hJth1YB+u2Y9S0X3xk7s2-HcPP4_k03qprHBU4A9721i8g@mail.gmail.com>
	<20140313212626.GA23618@sigill.intra.peff.net>
	<CAJo=hJu1WscibwectWzrUcoOV4-9xk4hBm1JA+RjONmgvZTXwQ@mail.gmail.com>
	<20140313220754.GA20173@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 13 23:23:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOE28-0004eG-FE
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 23:23:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754366AbaCMWXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 18:23:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50698 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754191AbaCMWXT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2014 18:23:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F2CA74277;
	Thu, 13 Mar 2014 18:23:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AFpAF4hsjMT+DWUtTX7wgrFfqn8=; b=HzZ79+
	nDCz01+RU3AoYYux4D4d2c2Xc9S174KbfVUWAByesoJ7ChiVWtbGNWAHfMussyU5
	QRrid/o4pSJ9ZC982k3X7TS/yhYAwJYqBZVMgw0LDBp2JB06nYyV9iQcUnHtyr64
	2EjLiPYNTIjdPM9a1MxDo/t0yVYAZMJY7nwcI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qiX9FqmSuGsNhQ6i0v1evikFlB39G1Jx
	rp1yIhv+rhtsUw/gDP8R4Phga5OabIP8GYapMAhpZniv45a4GO7vvjRcNyUGzBl5
	TG1u42G5JDNSYLYhVbxBiLJV4HEDrwdG0WHnmZ/bo5dTPVG17RHHL6y7OqBqYXLZ
	Km4ZHD5b3pA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CD7174276;
	Thu, 13 Mar 2014 18:23:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9B1F774274;
	Thu, 13 Mar 2014 18:23:17 -0400 (EDT)
In-Reply-To: <20140313220754.GA20173@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 13 Mar 2014 18:07:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 137AB27C-AAFE-11E3-9648-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244056>

Jeff King <peff@peff.net> writes:

> There are a few ways around this:
>
>   1. Add a new phase "Writing packs" which counts from 0 to 1. Even
>      though it's more accurate, moving from 0 to 1 really isn't that
>      useful (the throughput is, but the 0/1 just looks like noise).
>
>   2. Add a new phase "Writing reused objects" that counts from 0 bytes
>      up to N bytes. This looks stupid, though, because we are repeating
>      the current byte count both here and in the throughput.
>
>   3. Use the regular "Writing objects" progress, but fake the object
>      count. We know we are writing M bytes with N objects. Bump the
>      counter by 1 for every M/N bytes we write.
>
> The first two require some non-trivial surgery to the progress code. I
> am leaning towards the third. Not just because it's easy, but because I
> think it actually shows the most intuitive display. Yes, it's fudging
> the object numbers, but those are largely meaningless anyway (in fact,
> it makes them _better_ because now they're even, instead of getting 95%
> done and then hitting some blob that is as big as the rest of the repo
> combined).

I think the above argument, especially the "fudging but largely
meaningless anyway" part, makes perfect sense.

Thanks for looking into this.
