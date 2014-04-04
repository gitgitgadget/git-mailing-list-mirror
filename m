From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pack-objects: do not reuse packfiles without --delta-base-offset
Date: Fri, 04 Apr 2014 15:28:48 -0700
Message-ID: <xmqqsipsohjz.fsf@gitster.dls.corp.google.com>
References: <20140402063916.GA1437@sigill.intra.peff.net>
	<xmqqfvlvvdfi.fsf@gitster.dls.corp.google.com>
	<20140404214848.GA23666@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 05 00:29:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWCc9-000307-Tg
	for gcvg-git-2@plane.gmane.org; Sat, 05 Apr 2014 00:29:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752427AbaDDW2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Apr 2014 18:28:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51028 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752064AbaDDW2w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2014 18:28:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49C3E7AFCC;
	Fri,  4 Apr 2014 18:28:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3TKA5BZyVO2feMwItE9181ccMek=; b=TMMoB6
	TNPFjO3Q+P5+uVU8LwjM7xcw7IEMYqiO7dtznw2qYm5ux4Gwh4YV3lxv0c4aoIoc
	yBWYl7/GmoQOQvBjmPSYEbDbTogRjp5hnezzWj0Y41g23JhSoK7C9aDVZTtuw22F
	A/arp4ffHy9tEtLU//45bioSRY8f+K9iO6uMc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W+/VYa4uGTzEB1g+Bnq4eFaUTHSgn0Sd
	fodrQh9KINXUf2q04+feIoD8cFOrIkU7Awr/YbVQMq6tu8cjMjqeCRFxyH3VRMel
	D8yFSe6dZxb8j6E+BI7oPCiF33Kedc06w9fm69bxqpYzn1dIsDzeyZCDvqa2gJuu
	u5EWG7WlC4M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39A7B7AFCB;
	Fri,  4 Apr 2014 18:28:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4690A7AFCA;
	Fri,  4 Apr 2014 18:28:50 -0400 (EDT)
In-Reply-To: <20140404214848.GA23666@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 4 Apr 2014 17:48:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7ED7D7F6-BC48-11E3-A25E-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245774>

Jeff King <peff@peff.net> writes:

> We could convert OFS_DELTA to REF_DELTA on the fly. That _may_ have a
> performance impact. Right now, we are basically doing the equivalent of
> sendfile(), and conversion would involve iterating through each object
> and examining the header.  I think that's probably not too bad, though.
> The most expensive part of that, stepping to the next object, requires
> scanning through the zlib packets, but we should be able to use the
> revidx to avoid that.
>
> I'm not sure it's even worth the code complexity, though. The non-reuse
> codepath is not that much slower, and it should be extremely rare for a
> client not to support OFS_DELTA these days.

OK, together with the fact that only ancient versions of fetcher
would trigger this "do not reuse" codepath, I agree that we should
go the simplest route this patch takes.

Thanks.
