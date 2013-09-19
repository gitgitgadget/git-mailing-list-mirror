From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-compat-util: Avoid strcasecmp() being inlined
Date: Thu, 19 Sep 2013 15:03:46 -0700
Message-ID: <xmqqy56sqxj1.fsf@gitster.dls.corp.google.com>
References: <523094F0.9000509@gmail.com> <20130911182921.GE4326@google.com>
	<20130911191620.GB24251@sigill.intra.peff.net>
	<CAA01CsrN+VLw4WQmObvh72_MoH1Lyh9dQbizJcVhqyJoRyms-Q@mail.gmail.com>
	<CAPc5daVt4Q9twub5KyOQqZHx9CwOnkuwA97sXV44fF2j1e5HVg@mail.gmail.com>
	<CAA01CspCWFMGxXs9M3A1mtTctiUCCeJ9pJjHt=auMjhHHJU3Dg@mail.gmail.com>
	<20130919211659.GB16556@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Junio C Hamano <junio@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 20 00:03:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMmKK-0006jj-Vh
	for gcvg-git-2@plane.gmane.org; Fri, 20 Sep 2013 00:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752925Ab3ISWDw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Sep 2013 18:03:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42280 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751797Ab3ISWDv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Sep 2013 18:03:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB22243354;
	Thu, 19 Sep 2013 22:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jptK4HZJbYtQeUK3DqKS77r2PjI=; b=TCr/Nk
	hcRKk4WkE/cFFPQEyyXG9qZZL1EncJ7kLyA8JnkSii4x5yj02u4CT9cnHLy5ao3B
	sXQns7ffwX7D/hjcjZHnMmuQLdZPCY90bmQokF9ht6cxFjnWHl4P7oBqGr2UpTVB
	vWB7VcnRGrC0LVh3fSZfBalbFVIKE6JLfJd7I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gb61bNPiHu5sPDrrmCK3XKJrdlDwdrL4
	ZTLE0vbmsmQqhY0QrxyDeKaEerL5aM51xmNgcyod4caYnqLLzjylvoVxYR+lxVBd
	MOA0sMtcb+th2ojqeNEfqvJEWxbRMFfAazBl+jL+t1fqvoQp6IUGq081GeftW/ja
	CRYf0eEpl5k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC30C4334E;
	Thu, 19 Sep 2013 22:03:50 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3174B4334D;
	Thu, 19 Sep 2013 22:03:50 +0000 (UTC)
In-Reply-To: <20130919211659.GB16556@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 19 Sep 2013 17:16:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5D6373A8-2177-11E3-A59D-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235033>

Jeff King <peff@peff.net> writes:

> On Thu, Sep 19, 2013 at 11:47:51AM +0200, Piotr Krukowiecki wrote:
>
>> >> > it still ends up as a single function call). The downside is that it has
>> >> > to be remembered at each site that uses strcasecmp, but we do not use
>> >> > pointers to standard library functions very often.
>> >>
>> >> Is it possible to add a test which fails if wrapper is not used?
>> >
>> > No test needed for this, as compilation or linkage will fail, I think.
>> 
>> But only when someone compiles on MinGW, no?
>
> Yeah. I think a more clear way to phrase the question would be: is there
> some trick we can use to booby-trap strcasecmp as a function pointer so
> that it fails to compile even on systems where it would otherwise work?

That line of thought nudges us toward the place Linus explicitly
said he didn't want to see us going, no?  We do not particularly
want to care the exact nature of the breakage on MinGW.  Do we
really want to set a booby-trap that intimately knows about how
their strcasecmp is broken, and possibly cover breakages of the same
kind but with other functions?

It isn't like "we are deliberately relying on this non-standard
behaviour we see on the system _we_ commonly use, and somebody on
a new strictly POSIX platform may be bitten by it", in which case it
would make sense to have a test that intimately knows about the
non-standard behaviour we rely on.  This case is a total opposite.
