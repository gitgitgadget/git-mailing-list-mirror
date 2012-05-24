From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: credential-helpers + remote-helper, starting  point?
Date: Thu, 24 May 2012 22:23:07 +0200
Message-ID: <vpq8vghxr9w.fsf@bauges.imag.fr>
References: <b13df32797edbe8f71c796dbb4dc06a5@telesun.imag.fr>
	<20120524182110.GE3161@sigill.intra.peff.net>
	<vpq7gw1z8rb.fsf@bauges.imag.fr>
	<20120524200122.GA18936@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: roucherj <roucherj@telesun.imag.fr>, git@vger.kernel.org,
	kim-thuat.nguyen@ensimag.fr, pavel.volek@ensimag.fr,
	javier.roucher-iglesias@ensimag.fr
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 24 22:23:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXeZA-0000sG-Cq
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 22:23:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752230Ab2EXUXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 16:23:18 -0400
Received: from mx2.imag.fr ([129.88.30.17]:50454 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751344Ab2EXUXR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 16:23:17 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q4OKF3x8007478
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 24 May 2012 22:15:04 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SXeYu-0008B6-8m; Thu, 24 May 2012 22:23:08 +0200
In-Reply-To: <20120524200122.GA18936@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 24 May 2012 16:01:22 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 24 May 2012 22:15:04 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4OKF3x8007478
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1338495307.4184@P9BPD4l1ocaOed9KKJ/HcQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198416>

Jeff King <peff@peff.net> writes:

>> +When a function in Git or one of its remote-helpers needs to obtain
>> +credentials (either by asking the user or by fetching from a store),
>> +it can call the functions in the C API. These functions will fork a
>> +new process, and communicate with it by passing command-line arguments
>> +and then communicating through a pipe (see 'Credential Helpers'
>> +below).
>
> We might or might not fork a new process. It depends on which helpers
> are defined.

OK, so s/will fork/may fork/ may be more appropriate.

>> +For example, the execution of a command connecting to an HTTP server
>> +and using the credential helper "cache" will have the following
>> +structure:
>> +
>> +------------
>> ++-----+ -----> +-----------------+
>> +| git |  pipe  | git remote-http | --- to HTTP server --->
>> ++-----+ <----- +-----------------+
>> +                    ^      |
>> +                    | pipe |
>> +                    |      v
>> +             +----------------------+
>> +             | git credential-cache |
>> +             +----------------------+
>> +------------
>> +
>> +git remote-http will take care of contacting the HTTP server, do the
>> +actual authentication and see if it's accepted by the server. The
>> +credential helper will deal with the credential store (which can be
>> +done by contacting a keyring daemon) and the prompting if needed.
>
> I feel like adding remote-helpers into the mix just makes the situation
> more complex (and necessitates the diagram).

The helper is not strictly needed, but that seems to be a common
situation, so I thought describing the common case made sense.

I think it's important to show the difference between the actual
authentication process (e.g. HTTP) and the credential helper. I took
time to understand the example later:

	credential_fill(&c);
        /* [...] */
	status = send_foo_login(f, c.username, c.password);
	switch (status) {

then I understood that send_foo_login was the one doing the actual
authentication, and that further calls to the credential API was needed
to say how it went. Making explicit the fact that the Git code talks
both the helper and the server on which we are authenticating would have
helped me to understand at least.

I think mentionning the fact that a credential helper may connect to a
keyring daemon was important also. I first read some discussions about
credential helpers thinking that we would have to re-implement the
storing mechanism, and really understood what it was all about when I
saw patches for KDE support for example.

Other than that, I do like your wording. If it was just me, I'd take
your introduction, but keep my example + diagram.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
