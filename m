From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/8] apply: fall back on three-way merge
Date: Thu, 10 May 2012 14:06:23 -0700
Message-ID: <7vaa1fn3u8.fsf@alter.siamese.dyndns.org>
References: <1336629745-22436-1-git-send-email-gitster@pobox.com>
 <1336629745-22436-7-git-send-email-gitster@pobox.com>
 <20120510203113.GB18276@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 10 23:06:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSaZD-0005Du-3h
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 23:06:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755135Ab2EJVG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 17:06:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65316 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753566Ab2EJVG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 17:06:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51B876D3B;
	Thu, 10 May 2012 17:06:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hebinh7C4eFcZd3l5wtsXFhnPdw=; b=EUYG+X
	VxmlWMzHd+JiIR+mR/i/CGECj+rjQtL7P2MDTI9z9hX8E/0oAv/ZXchYMavvB3s5
	13HNgMruOsg5XHD1WTDs3P59ts0TjyQ1Gy69P5ToQAD/zI0AeseFtv9iDoQXbKTc
	5a+Gc+AMMRIH5xh9gm40kaAbs5tqcGMU+iA08=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wLhOPvpoYFl9Oaa5e8NOsxT6DJPzBCRx
	XWC74h54VPDp9CEMVnFHXvZzzT2VmE1hwXi0tnmr1JFRWZ9rghsNSdRqsh2+7tpi
	pY8uV8mc7+s445lZMy74GloSoc+f13pmXd+v12Dn81zc1WI4rTmGqQSFkcZy05ir
	6TFprRdTIZQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 494EB6D3A;
	Thu, 10 May 2012 17:06:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A306A6D36; Thu, 10 May 2012
 17:06:24 -0400 (EDT)
In-Reply-To: <20120510203113.GB18276@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 10 May 2012 16:31:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0057696E-9AE4-11E1-8206-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197634>

Jeff King <peff@peff.net> writes:

> On Wed, May 09, 2012 at 11:02:23PM -0700, Junio C Hamano wrote:
> ...
>> +	/* No point falling back to 3-way merge in these cases */
>> +	if (patch->is_binary || patch->is_new || patch->is_delete ||
>> +	    S_ISGITLINK(patch->old_mode) || S_ISGITLINK(patch->new_mode))
>> +		return -1;
>
> Is it true that there is no point in doing a 3-way fallback when
> patch->is_binary? What if the user has a custom merge driver?
> ...
> It seems like we should just keep the logic here as stupid as possible,

Actually, the motivation behind that "No point" is to keep the logic as
stupid as possible.

We had a history of setting up logic that covers cases far wider than we
originally designed the behaviours for, leaving the corner case behaviour
of the code "undefined", without saying exactly what is and what is not
the defined use case, which lead users to try unexpected (possibly but not
necessarily stupid) things and getting a random "you get whatever the code
happens to do" results. The above is an attempt to limit the scope of the
initial implementation to a narrow, well defined, and commonly occurring
subset of the problem space.

I can buy that lifting "must not be binary" would be very cheap, but
adding support for new/delete case would mean the index-stuffing part
needs to gain more code, so removing the "not new, not delete"
conditionals actually goes against keeping the logic as stupid as
possible.
