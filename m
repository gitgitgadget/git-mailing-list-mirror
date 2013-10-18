From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/9] http: update base URLs when we see redirects
Date: Fri, 18 Oct 2013 12:20:50 -0700
Message-ID: <xmqqbo2mwfl9.fsf@gitster.dls.corp.google.com>
References: <20130928082956.GA22610@sigill.intra.peff.net>
	<20130928083405.GA2782@sigill.intra.peff.net>
	<xmqqk3hawi5y.fsf@gitster.dls.corp.google.com>
	<20131018184250.GA11040@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Kyle J. McKay" <mackyle@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 18 21:21:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXFbc-0002A9-N6
	for gcvg-git-2@plane.gmane.org; Fri, 18 Oct 2013 21:21:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757222Ab3JRTUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Oct 2013 15:20:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61600 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757011Ab3JRTUx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Oct 2013 15:20:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BA094B464;
	Fri, 18 Oct 2013 19:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=00tKqtO9Vy9zIQSdQkInG9dK51o=; b=ti+eXh
	7PUADBkAlk2MxGfDj9g3pR3L5outf0WLnYRnzB5ZerQxD2N6HZQBy2XoJLdoI3IS
	0yzedzyB9kJREVVVxvsiC2kRyY6FA0idYqNneEIZwPHRhVZ/lltInmQluCSgxlv/
	5fLfy0Kikagnuyfny7vgx54BExKKibd2OC10Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jysxvMhuHJGO6vA5O4mGY76dfr7rX00Z
	Bpu2qTSZ8kKPJsj6KxJPEyhk5GpvjhHk0rPawSvJuV4rsiqPEsvuAl6qCnT2N0yz
	kRE69MCR/0hzrOdVGoH5/GzJp16Yon2FNkop+6YzMzcceXV79QZip5IMAtpqI+pd
	+j7r1lkS9Q4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DFC84B462;
	Fri, 18 Oct 2013 19:20:53 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 78A2D4B45F;
	Fri, 18 Oct 2013 19:20:52 +0000 (UTC)
In-Reply-To: <20131018184250.GA11040@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 18 Oct 2013 14:42:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 675AACEA-382A-11E3-9DB0-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236365>

Jeff King <peff@peff.net> writes:

> On Fri, Oct 18, 2013 at 11:25:13AM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > + * Our basic strategy is to compare "base" and "asked" to find the bits
>> > + * specific to our request. We then strip those bits off of "got" to yield the
>> > + * new base. So for example, if our base is "http://example.com/foo.git",
>> > + * and we ask for "http://example.com/foo.git/info/refs", we might end up
>> > + * with "https://other.example.com/foo.git/info/refs". We would want the
>> > + * new URL to become "https://other.example.com/foo.git".
>> 
>> Not "https://other.example.com/foo.git/info/refs"?
>
> I think my use of "the new URL" is ambiguous. I meant "the new base",
> from which one could then construct the new refs URL as you suggest.

Ahh, there is nothing we need to do to make the new URL to
"https://.../info/refs"; we already have it in "got".  And the
function resets "base" and then adds "got" excluding its tail part
to compute the new base.  So "s/new URL/new base/" would be all we
need to do, I think.

Thanks.
