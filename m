From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] compat: Fix read() of 2GB and more on Mac OS X
Date: Mon, 19 Aug 2013 09:33:04 -0700
Message-ID: <7veh9pmyin.fsf@alter.siamese.dyndns.org>
References: <1376894300-28929-1-git-send-email-prohaska@zib.de>
	<1376900499-662-1-git-send-email-prohaska@zib.de>
	<CAPig+cTr_B+vtN4sFzepWeW4TpRPD9eKnjy08yJ2pf3KfVU1XA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>, Git List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Aug 19 18:33:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBSOK-0003Hd-2B
	for gcvg-git-2@plane.gmane.org; Mon, 19 Aug 2013 18:33:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966Ab3HSQdM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Aug 2013 12:33:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58673 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750796Ab3HSQdL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Aug 2013 12:33:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DBC7E399B8;
	Mon, 19 Aug 2013 16:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Xo4IH3dNI0LSjqp0gBE8mryy/Bc=; b=BwZEpm
	sfsadKBuFPddVbKsm/6fvS7s+5IXUpX3UBe2hP1hphhHCNLHCgwMtCfGcnZarTl/
	Yih5jdX+jWrOzKCo/IXK0R5QBY1sSaCvwGlrnpOG+UTMIwm270etkMBkGX8igI5+
	fVR0ueEjvU8hk4nJG2gVGbsCoD0QLNPbQoGuc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uVb+HnoKNZkeI9Us42lJ+IsdpDB8jUP1
	DYPj4fj4CjvhtZ7OJIqZLCZOCwWLrX6oA4SK44hnW/UWYwpaUl+mNnqLsGPz20gv
	v5i0rEGWY4uzb50uu8iMqT4QAJ+7/9wF/s7YXhfpSIiQu/OuY2T7brMRDfJfwvNh
	US49Jf89yw8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD9F2399B7;
	Mon, 19 Aug 2013 16:33:07 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6BE0D399B6;
	Mon, 19 Aug 2013 16:33:06 +0000 (UTC)
In-Reply-To: <CAPig+cTr_B+vtN4sFzepWeW4TpRPD9eKnjy08yJ2pf3KfVU1XA@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 19 Aug 2013 09:59:57 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 06EBF31C-08ED-11E3-BE22-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232550>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +# Define NEEDS_CLIPPED_READ if your read(2) cannot read more than
>> +# INT_MAX bytes at once (e.g. MacOS X).
>> +#
>>  # Define NEEDS_CLIPPED_WRITE if your write(2) cannot write more than
>>  # INT_MAX bytes at once (e.g. MacOS X).
>
> Is it likely that we would see a platform requiring only one or the
> other CLIPPED? Would it make sense to combine these into a single
> NEEDS_CLIPPED_IO?

I am slightly negative to that suggestion for two reasons.

 - Does MacOS X clip other IO operations?  Do we need to invent yet
   another NEEDS_CLIPPED, e.g. NEEDS_CLIPPED_LSEEK?

   A single NEEDS_CLIPPED_IO may sound attractive for its simplicity
   (e.g. on a system that only needs NEEDS_CLIPPED_WRITE, we will
   unnecessarily chop a big read into multiple reads, but that does
   not affect the correctness of the operation, only performance but
   the actual IO cost will dominate it anyway).  If we know there
   are 47 different IO operations that might need clipping, that
   simplicity is certainly a good thing to have.  I somehow do not
   think the set of operations will grow that large, though.

 - NEEDS_CLIPPED_IO essentially says "only those who clip their
   writes would clip their reads (and vice versa)", which is not all
   that different from saying "only Apple would clip their IO",
   which in turn defeats the notion of "let's use a generic
   NEEDS_CLIPPED without limiting the workaround to specific
   platforms" somewhat.
