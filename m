From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] drop some "int x = x" hacks to silence gcc warnings
Date: Thu, 21 Mar 2013 08:19:43 -0700
Message-ID: <7vhak4bx0w.fsf@alter.siamese.dyndns.org>
References: <20130321110338.GA18552@sigill.intra.peff.net>
 <514AF2E1.7020409@viscovery.net>
 <20130321115545.GB21319@sigill.intra.peff.net>
 <7vppysbxzo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 21 16:20:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIhHr-0005ec-6Y
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 16:20:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229Ab3CUPTr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 11:19:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58485 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751051Ab3CUPTr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 11:19:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6119CA603;
	Thu, 21 Mar 2013 11:19:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=26uQF86Uv0U7bvYQygdUWCDBJGk=; b=CdMl2a
	hExEpyludcehRl6WCUUnstTxmKhfWL8wK6n0OG98BW/g9xbzpdSy2b/VQR9zYwas
	7Os/MCZ3DHSo0wwJWhG0iqhiUJAbokvi9ukgGTyGX02l8v2LvyIMCArfJkQiiD16
	16g9tlxXr1XhGvVc+TKhfg+hmHkHATIFsfJKU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vUrZgeb+RS5Pvc5JJSb9hJ9SAVAnQY6g
	TsPWwOegdlQUkf69aArllG08vb5C1/dNn+1OxL1HD48q7+kdHARAn9611DMVuWny
	Lo3gMrECrowul8FWOLf3qrXqMx9z6+xPbtC6Rsn48/petJSSvHyqM7JiDeJEEkM5
	He0EtRmNOnw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55032A602;
	Thu, 21 Mar 2013 11:19:46 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AD739A5FC; Thu, 21 Mar 2013
 11:19:45 -0400 (EDT)
In-Reply-To: <7vppysbxzo.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 21 Mar 2013 07:58:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C35168FE-923A-11E2-A063-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218734>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> Git code was my introduction to it, too, and I was led to believe it was
>> idiomatic, so I can't speak further on that. I think it was Junio who
>> introduced me to it, so maybe he can shed more light on the history.
>
> I think we picked the convention up from the kernel folks.  At least
> that is how I first met the construct.  The uninitialized_var(x)
> macro was (and still is) used to mark these "The compiler is too
> dumb to realize, but we know what we are doing" cases:
>
>     $ git grep '#define uninitialized_var' include/
>     include/linux/compiler-gcc.h:#define uninitialized_var(x) x = x
>     include/linux/compiler-intel.h:#define uninitialized_var(x) x
>
> but they recently had a discussion, e.g.
>
>     http://thread.gmane.org/gmane.linux.kernel.openipmi/1998/focus=1383705
>
> so...

While flipping the paragraphs around before sending the message out
I managed to lose the important one.  Here is roughly what I wrote:

    I am for dropping "= x" and leaving it uninitialized at the
    declaration site, or explicitly initializing it to some
    reasonable starting value (e.g. NULL if it is a pointer) and
    adding a comment to say that the initialization is to squelch
    compiler warnings.
