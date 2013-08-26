From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: search author pattern against mailmap
Date: Sun, 25 Aug 2013 22:27:52 -0700
Message-ID: <xmqq1u5hkomf.fsf@gitster.dls.corp.google.com>
References: <xmqqob8ml588.fsf@gitster.dls.corp.google.com>
	<1377424889-15399-1-git-send-email-apelisse@gmail.com>
	<20130825103041.GB12556@sigill.intra.peff.net>
	<CALWbr2zfpZYGri9aGL3DGhadnYF=0xx_h95ZjN7S4beoAES68A@mail.gmail.com>
	<20130825165153.GC21092@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Antoine Pelisse <apelisse@gmail.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 26 07:28:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDpLR-0001Vj-4t
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 07:28:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755627Ab3HZF17 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 01:27:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47656 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755200Ab3HZF17 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 01:27:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D7F837CC5;
	Mon, 26 Aug 2013 05:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uBHkhJsIO+teFSYScgsgQq/CgvM=; b=NO/wm9
	TBgwt5mRYUs7QyizyyOxZ4W56zKHl/ddyZd/kB7hWXhzDXhGARGDpjotWqyheIKT
	b5k5nvrr9OmSfOvLSavAetyyxlZXW6yBgpJON+Tb38jUEjY392C+wd/8k9FBbmbK
	WQX95Ih2tOd9vJLxR3R6wYaYqfMzpE33AR9ac=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qQ31I0e5+K36xElRV9tNIoWi0nd+fCes
	0E2p5j4O0JNw8l/0ijjzDQ+Rn+sODxK4AQiPKsK0wEgD6OFS9m2IMTMsWmHFuaXe
	+g83sxwQqwSj4oeegjM5apNMsTq05Tct+VXMNcoHJFUeO43e0UUq1Fw5RPI+LCBR
	wx+DbrFxjoI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3418A37CC3;
	Mon, 26 Aug 2013 05:27:58 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9421E37CC0;
	Mon, 26 Aug 2013 05:27:57 +0000 (UTC)
In-Reply-To: <20130825165153.GC21092@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 25 Aug 2013 12:51:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 441B6830-0E10-11E3-B034-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232972>

Jeff King <peff@peff.net> writes:

> Exactly. Sample (largely untested) patch is below if you want to use it
> as a starting point. There are probably a few additional cleanups on top
> (e.g., "git log" understands "--mailmap", which should probably be
> centralized to handle_revision_opt).
>
> I'm on the fence. It doesn't actually save that many lines of code, and
> I guess it's possible that somebody would want a custom mailmap in the
> future. Even though you can't do it right now, all it would take is
> exposing read_mailmap_file and read_mailmap_blob outside of mailmap.c.
> Of course, it would be easy to expose map_user_from at the same time.

I am of two minds on this, but if I were forced to pick one _today_,
I would have to say that I am moderately negative to the approach.

Having to always specify that you want to use mailmap and make sure
you read it is a bit cumbersome from callers' point of view, and
using a singleton global may be one attractive way to do so.

It however regresses the "you can choose which mailmap to apply"
structure we already have, it would make things less libifiable, and
will make it harder to allow a single Git process work on two or
more independent repositories (yes, we would need to restructure the
object API to allow us to manage multiple object stores, the ref
API, etc. in a way similar to how we weaned ourselves away from the
single "active_cache" abstraction in the index API). I am personally
OK to declare that we should _never_ touch more than one repository
in a single process, but submodule support already does this to some
extent, so...

I think it is a reasonable tentative solution to hook a singleton
instance to something that is commonly used, e.g. the rev_info
structure, for large subset of commands that do use the structure
chosen to host that singleton instance, but those that do not work
based on revision traversal (e.g. "grep") need to also honor mailmap
consistently, so we must keep the lower level API that takes an
explicit mailmap instance for them anyway.

So...
