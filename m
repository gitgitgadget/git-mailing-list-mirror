From: Zubin Mithra <zubin.mithra@gmail.com>
Subject: Re: Certificate validation vulnerability in Git
Date: Mon, 25 Feb 2013 21:12:42 +0530
Message-ID: <CAA5xPpmBWLRXs_SfwOAkps8fTeFUW3bEnrDQE_FXjXhmBbC4MA@mail.gmail.com>
References: <CAA5xPpmmZuMK7q3-pTOx4L6DxFtyw5HWYdH7kHEsK=96KM5kAQ@mail.gmail.com>
	<20130225031648.GA31988@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, "Dhanesh K." <dhanesh1428@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 25 16:43:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA0Cx-0005FX-QO
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 16:43:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759931Ab3BYPmp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 10:42:45 -0500
Received: from mail-da0-f53.google.com ([209.85.210.53]:45392 "EHLO
	mail-da0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759925Ab3BYPmm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 10:42:42 -0500
Received: by mail-da0-f53.google.com with SMTP id n34so803974dal.12
        for <git@vger.kernel.org>; Mon, 25 Feb 2013 07:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=CylbuXnSxepBNAaC1PCDMHZgRaSwKvsyNDmRrP+PRdM=;
        b=YL7rZapXpDKT8PzhFBG+OiGX4RpKWZxY1xmsizW68OG9HyPyKj5qnx7m9mLxwcFJzY
         1dFbRTsTiOQMgiEVuvt+FFfjHMBQbOBn3du4nyUrFX3oyWjVBQh3cVW2bXJPmEFEaSIh
         LUg71fPFM3Eb6fnrX584U6QHhV+gBluPQW7U5WUl3rACkEU1uwB0elY6Kpgpamihnvwi
         w+rSPS0KzzXlBTsknUOs0FEUe5gPz0IyIU+pGFcPd1F0k+STaczadrvXRiSHNxm6jgqu
         1dQTZRaw8RzVhMQxbHaM+trkSa9oE7QFne8Tscb6DAeV72FpsDJEIvitv6xUHxK9AdpN
         ngeA==
X-Received: by 10.66.13.136 with SMTP id h8mr18439941pac.204.1361806962506;
 Mon, 25 Feb 2013 07:42:42 -0800 (PST)
Received: by 10.68.42.36 with HTTP; Mon, 25 Feb 2013 07:42:42 -0800 (PST)
In-Reply-To: <20130225031648.GA31988@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217061>

On Mon, Feb 25, 2013 at 8:46 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Feb 24, 2013 at 11:01:50PM +0530, Zubin Mithra wrote:
>
>> There seems to be a security issue in the way git uses openssl for
>> certificate validation. Similar occurrences have been found and
>> documented in other open source projects, the research can be found at
>> [1].
>>
>> -=========]
>> - imap-send.c
>>
>> Line 307
>>
>>  307   ret = SSL_connect(sock->ssl);
>>  308   if (ret <= 0) {
>>  309     socket_perror("SSL_connect", sock, ret);
>>  310     return -1;
>>  311   }
>>  312
>>
>> Certificate validation errors are signaled either through return
>> values of SSL_connect or by setting internal flags. The internal flags
>> need to be checked using the SSL_get_verify_result function. This is
>> not performed.
>
> I'm not sure what you mean. We use SSL_CTX_set_verify to turn on peer
> certificate verification, which will cause SSL_connect to return
> failure if the certificate signature cannot be traced back to a CA cert
> from our local store.
>
> Is there some case where this does not happen properly? If so, can you
> give an example? The paper you referenced says only that there are some
> special cases where SSL_connect does not notice the error, but then
> gives an example where the application does not turn on SSL_VERIFY_PEER.
> But git does. Are there are other cases that SSL_VERIFY_PEER does not
> handle?

Indeed -- it appears that I was mistaken. I had a quick look at the
openssl source code and it does seem that SSL_VERIFY_PEER is
equivalent to SSL_get_verify_result.

Thank you for your time!

- Zubin

>
> There is a _different_ problem not handled by the code you show above,
> which is that SSL_connect does not verify that the hostname we connected
> to matches the signed certificate. But that was fixed already by b62fb07
> (imap-send: the subject of SSL certificate must match the host,
> 2013-02-15), which is in git v1.8.1.4.
>
> -Peff
