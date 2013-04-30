From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http.c: Add config options/parsing for SSL engine vars
Date: Tue, 30 Apr 2013 13:17:03 -0700
Message-ID: <7vzjwfbwow.fsf@alter.siamese.dyndns.org>
References: <1366758207-7724-1-git-send-email-jqassar@gmail.com>
	<7v61z4ezlz.fsf@alter.siamese.dyndns.org>
	<20130430182732.GB1972@sigill.intra.peff.net>
	<CAJC3a=pU2m8LpUh0u0XXXgOiDiPo-QAdA471orGs9jcyDJTU5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Jerry Qassar <jqassar@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 22:17:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXGzB-0006Oc-6w
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 22:17:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933058Ab3D3URI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 16:17:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64900 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932813Ab3D3URH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 16:17:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E82841BF7F;
	Tue, 30 Apr 2013 20:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KMGK4OpmcCyhQTMhoRXMYbZCAbs=; b=SsKTFr
	b4sQoYPmn/siiPh8EWKtQ+gHw+TXxCXuS3t4MsYLFm1hi2OOSKCF3aOdhyeFBfOq
	23aHZm1P0i0DuvXUACmOf72HSown8hTMLgH5XpZALVNImx87+W5uNsyTYvH1oR7k
	fBqKYobCZNjn6d4aFmgi6TLkM2Ge2cSAwzuLU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QYpGt7LpVVj5NQI2sfo1py4GHNepismm
	/qe8tJHkPVsWOltboffU/GKFWCMdNtBTQgxBtVgkVtELIVWe7D/UHuT0RoDMmPAN
	Y5k1sF2+Ti9nQu4jSCk8MFQXBiJ8f8B6Nzhhk+dA8TSIIN+758ticEsS/S6qohfO
	y2DsnDKL1r4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC04B1BF7E;
	Tue, 30 Apr 2013 20:17:05 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 314861BF7B;
	Tue, 30 Apr 2013 20:17:05 +0000 (UTC)
In-Reply-To: <CAJC3a=pU2m8LpUh0u0XXXgOiDiPo-QAdA471orGs9jcyDJTU5g@mail.gmail.com>
	(Jerry Qassar's message of "Tue, 30 Apr 2013 13:04:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ED0203C2-B1D2-11E2-9EA2-A3355732AFBB-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223004>

Jerry Qassar <jqassar@gmail.com> writes:

> Curl already does support engine-based certificates (in code and
> help).  Its problem is that a) it doesn't yet read your engine
> defs out of OpenSSL config, and b) a bug in copying the engine
> data, once that's patched, to the handle that calling apps use.

So once the problem (a) is fixed, if the user has OpenSSL config
then the user doesn't need configuration from setopt() side?  That
makes it sound like you do not need to patch us at all, but there
must be something else going on...

> On git's side we just need to expose the proper options for setopt
> configuration.  No special work is needed to support them
> otherwise.

... I am somewhat puzzled.

>>> > +   if (ssl_keytype != NULL)
>>> > +           curl_easy_setopt(result, CURLOPT_SSLKEYTYPE, ssl_keytype);
>>> > +   if (ssl_certtype != NULL)
>>> > +           curl_easy_setopt(result, CURLOPT_SSLCERTTYPE, ssl_certtype);
>>
>> Shouldn't we be checking the result of curl_easy_setopt for errors here
>> (and when the engine cannot be loaded)?  I think we should probably die
>> if the engine can't be loaded, but at the very least we'd want to warn
>> the user that their settings are being ignored.
>
> Errors are handled by curl (up to this point):
>
> 1) Setting the cert type to FOO:
> error: not supported file type 'FOO' for certificate...
> fatal: HTTP request failed
>
> 2) Setting the key type to FOO:
> error: not supported file type for private key...
> fatal: HTTP request failed
>
> 3) Setting engine type to something invalid:
>  * SSL Engine 'pkcsfoo' not found (only with GIT_CURL_VERBOSE set)
> error: crypto engine not set, can't load certificate...
> fatal: HTTP request failed

Where do "error:" and "fatal:" happen in the codeflow?

I am guessing that "error:" may come from these easy_setopt() calls, but
the "fatal: HTTP request failed" come from us, much later in the
callpath when we actually make http request.

Between these two times, aren't we throwing user data at the cURL
library and possibly over the wire to the remote side (with a SSL
configuration that is different from what the user intended to use),
no?

That does not sound like a "managed by cURL" solution to me.
Shouldn't we notice the first error and abort without doing any
further damage?

>> Overall, I think it is looking good. Aside from a few style/cleanup
>> issues, my only real complaint is the lack of error-checking from
>> curl_easy_setopt.
>>
>> And of course adding some tests while you are working in the area would
>> be very nice. :)
> ...
> I guess my open question is, if you wish to wrap the
> prop setting in a curl version #if, what version is desired?

https://github.com/bagder/curl/blob/master/docs/libcurl/symbols-in-versions

says that SSLKEYTYPE, SSLCERTTYPE, etc. come from 7.9.3, so it would
be 

        #if LIBCURL_VERSION_NUM >= 0x070903
            ...
        #endif

Thanks.
