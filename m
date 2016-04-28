From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 1/2] http.c: implement the GIT_TRACE_CURL environment variable
Date: Thu, 28 Apr 2016 10:35:59 -0700
Message-ID: <xmqqfuu563gg.fsf@gitster.mtv.corp.google.com>
References: <20160428115748.37177-1-gitter.spiros@gmail.com>
	<20160428115748.37177-2-gitter.spiros@gmail.com>
	<20160428144710.GD25364@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org,
	tboegi@web.de, ramsay@ramsayjones.plus.com, sunshine@sunshineco.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 28 19:36:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avprW-0000xo-Pf
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 19:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465AbcD1RgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 13:36:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53150 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753440AbcD1RgD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 13:36:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 698621450F;
	Thu, 28 Apr 2016 13:36:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8DOJpBFm1hXA4j9jcVzfK0Ypyk4=; b=R6A8To
	xpB5Tfqzy/UxydUkAvQgnmbYXrlh4JSgexqL7Iz0TDmqEIhnwDvdMm74o5ZIN7fq
	yQnFeGOiGuExilSjj4p8mWSJJ9tPx8TIh4TuxnrWbrOv7o0X3ZF1C6a3AinDPgtd
	Ne2EOXS5L9Rfu5EioAXGjSEPfZ9Li211wEE4E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LpDRTY3yvlex6Bzznzm7Ce3UvPxqh5Rp
	0KoJi6yKu4m7eE3a24/bkizq0sdYlyKuYCwkscNfO9WlUiPs35xXSxVbg+BoUweI
	M8//djv8+vbfWUF2sF8w5FmsskeqCbi4+ivcZkb2/mvmrgSeXMXerNBT6fjGx+cm
	ObYE9MfNg6k=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 619FF1450D;
	Thu, 28 Apr 2016 13:36:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 52ADC1450A;
	Thu, 28 Apr 2016 13:36:01 -0400 (EDT)
In-Reply-To: <20160428144710.GD25364@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 28 Apr 2016 10:47:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: ACD309A6-0D67-11E6-BBFF-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292926>

Jeff King <peff@peff.net> writes:

>> +		 for (w = 0; (w < width) && (i + w < size); w++) {
>> +			   if (nohex && (i + w + 1 < size) && ptr[i + w] == '\r'
>> +				&& ptr[i + w + 1] == '\n') {
>> +				    i += (w + 2 - width);
>> +				    break;
>> +			   }
>
> This loop puzzled me for a bit. When we end early due to a newline, we
> subtract out the width here. I guess that's to accomodate the "i +=
> width" that the outer for-loop is going to do.

I think I essentially said the same thing on the previous round and
I thought I suggested to restructure the loop to primarily aim to
split at line-end (instead of the above which primarily aims to
split at width but line-end may cause a premature split).
