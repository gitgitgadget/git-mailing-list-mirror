From: Jerry Qassar <jqassar@gmail.com>
Subject: Re: [PATCH] http.c: Add config options/parsing for SSL engine vars
Date: Tue, 30 Apr 2013 14:05:22 -0700
Message-ID: <CAJC3a=qu8jxJ2pD=4kbPVqQDBgv6vxXVXkt6ezqRoPdtMEfjRA@mail.gmail.com>
References: <1366758207-7724-1-git-send-email-jqassar@gmail.com>
	<7v61z4ezlz.fsf@alter.siamese.dyndns.org>
	<20130430182732.GB1972@sigill.intra.peff.net>
	<CAJC3a=pU2m8LpUh0u0XXXgOiDiPo-QAdA471orGs9jcyDJTU5g@mail.gmail.com>
	<7vzjwfbwow.fsf@alter.siamese.dyndns.org>
	<20130430202908.GB3247@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 30 23:05:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXHjs-0001zn-Vi
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 23:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933738Ab3D3VFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 17:05:25 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:59263 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933613Ab3D3VFY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 17:05:24 -0400
Received: by mail-la0-f52.google.com with SMTP id fd20so840296lab.39
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 14:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=l/2+phn/cBt66xGWpO062ycuxZJ8CM9wwIoeWQJA8Mo=;
        b=VTharwKi4K36MVbtdLVsk+/l2fdvIK7RoASzQIWPcjm2BlB1dxtu1K6m/LHYouZu54
         rGU9OI34+xZycLouG04dWbSvRAHLGIkXSTHqtiScCVVRHKaf44O32mFNcL7AlfVmjfN2
         ZODp9mrPDnKu262d289837EI9JRn042V72Cl+dJY+I3rdTLE0Y+DGLXThEvyZrd8Sbio
         ueezZ3oh1Q/cB1vtBuhqft1AKO3BCcGIyloPKN3hmB+Y/DHO0gtKva+vdG6wtSlxY76C
         iVZM9c2JFkUhxnEZc9QB+Jn2A/nwCgCYg5QfS/hUquBDkYC6zJ970f81KYLgxv9PKSYW
         +wSA==
X-Received: by 10.152.19.10 with SMTP id a10mr33579lae.8.1367355922552; Tue,
 30 Apr 2013 14:05:22 -0700 (PDT)
Received: by 10.112.21.230 with HTTP; Tue, 30 Apr 2013 14:05:22 -0700 (PDT)
In-Reply-To: <20130430202908.GB3247@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223010>

On Tue, Apr 30, 2013 at 1:29 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Apr 30, 2013 at 01:17:03PM -0700, Junio C Hamano wrote:
>
>> Jerry Qassar <jqassar@gmail.com> writes:
>>
>> > Curl already does support engine-based certificates (in code and
>> > help).  Its problem is that a) it doesn't yet read your engine
>> > defs out of OpenSSL config, and b) a bug in copying the engine
>> > data, once that's patched, to the handle that calling apps use.
>>
>> So once the problem (a) is fixed, if the user has OpenSSL config
>> then the user doesn't need configuration from setopt() side?  That
>> makes it sound like you do not need to patch us at all, but there
>> must be something else going on...
>
> My understanding is that we first have to tell curl "yes, use the
> engine", and then the engine-specific OpenSSL config can be loaded by
> curl. But I am just guessing from the conversation up until now; I know
> nothing about ssl crypto engines.

That's correct.  Putting the engine definitions into OpenSSL
configuration makes them available to OpenSSL only.  I made changes to
have curl/libcurl read the config files (it didn't before).  git needs
changes to let it set the appropriate libcurl parameters to set the
engine and key/cert type.  Otherwise libcurl has the capability but
git can't utilize it.

>
> As an aside, curl can be linked against gnutls, too. Does any of this
> work with gnutls? I think we don't have to care; curl abstracts all of
> that away from us, and it is up to the user to choose an engine that
> matches their library versions. But it might be a good point of
> reference when somebody later comes to the list and says "I followed the
> documentation, but it doesn't work".

gnutls doesn't let you specify an 'engine' per se and the underlying
engine calls return CURLE_NOT_BUILT_IN, so these changes would have no
effect.  That doesn't mean that gnutls can't work (I know for a fact
that it's possible for it to speak CAC), but I'm not sure that
anything git does internally matters to it.

Maybe the documentation also needs to say specifically that it is for OpenSSL?

>> > Errors are handled by curl (up to this point):
>> >
>> > 1) Setting the cert type to FOO:
>> > error: not supported file type 'FOO' for certificate...
>> > fatal: HTTP request failed
>> >
>> > 2) Setting the key type to FOO:
>> > error: not supported file type for private key...
>> > fatal: HTTP request failed
>> >
>> > 3) Setting engine type to something invalid:
>> >  * SSL Engine 'pkcsfoo' not found (only with GIT_CURL_VERBOSE set)
>> > error: crypto engine not set, can't load certificate...
>> > fatal: HTTP request failed
>>
>> Where do "error:" and "fatal:" happen in the codeflow?
>>
>> I am guessing that "error:" may come from these easy_setopt() calls, but
>> the "fatal: HTTP request failed" come from us, much later in the
>> callpath when we actually make http request.
>
> Those are almost certainly from curl_errorstr() when we make the
> info/refs http request.
>
>> Between these two times, aren't we throwing user data at the cURL
>> library and possibly over the wire to the remote side (with a SSL
>> configuration that is different from what the user intended to use),
>> no?
>
> I assume that curl is smart enough not to send any data over the wire,
> and that it is noticing early in the process that something is wrong and
> is barfing there.
>
> It would be nicer to notice earlier (when we are setting up the handle),
> but in practice I don't think it matters. We start off all http
> conversations by making a short GET, and we don't do any significant
> work beforehand. So as long as curl does not do significant work before
> hitting those errors internally, it probably does not matter much either
> way.
>
> -Peff

 Your surmise is correct here; you don't make it past the handshake.

--Jerry
