From: Bernhard Reiter <ockham@raz.or.at>
Subject: Re: [PATCH/RFC] git-imap-send: use libcurl for implementation
Date: Sun, 17 Aug 2014 14:56:10 +0200
Message-ID: <53F0A66A.9000909@raz.or.at>
References: <53EA8C3E.1080500@raz.or.at> <20140813015917.GA30756@google.com> <20140817083022.GJ23808@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, 434599@bugs.debian.org
To: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 17 14:56:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJ00V-0003wJ-AN
	for gcvg-git-2@plane.gmane.org; Sun, 17 Aug 2014 14:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbaHQM4Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2014 08:56:16 -0400
Received: from mhub.domainplanet.at ([92.43.99.119]:34310 "EHLO
	mhub.domainplanet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbaHQM4P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2014 08:56:15 -0400
Received: from smtp.domainplanet.at (smtp.domainplanet.at [92.43.99.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mhub.domainplanet.at (Postfix) with ESMTPS id 2F0119D4507;
	Sun, 17 Aug 2014 14:56:11 +0200 (CEST)
Received: from [10.0.0.88] (213-33-4-254.adsl.highway.telekom.at [213.33.4.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.domainplanet.at (Postfix) with ESMTPSA id 4BCB6BF7FE;
	Sun, 17 Aug 2014 14:56:20 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <20140817083022.GJ23808@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255366>

Am 2014-08-17 um 10:30 schrieb Jeff King:
> On Tue, Aug 12, 2014 at 06:59:17PM -0700, Jonathan Nieder wrote:
> 
>>> +		curl_socket_t sockfd = tunnel.out; // what about tunnel.in ?
>>
>> Hmm.  curl expects to get a socket it can send(), recv(), setsockopt(),
>> etc on instead of a pair of fds to read() and write().
> 
> I wonder if we could teach run_command to optionally use socketpair()
> instead of pipe(). 

That sounds like a good idea to me.

> I'm not sure if that would cause problems on Windows,
> though.

Apparently socketpair is not available there. Googling "socketpair
windows" yields, among a lot of other useful resources, the following
relatively actively maintained ~150 LOC, BSD-3-clause-licensed,
implementation:

https://github.com/ncm/selectable-socketpair

That license is GPL compatible, so should we consider including that
implementation with git? That's the kind of stuff that goes to
compat/win32, right?

One thing to consider: seems like socketpair() gives AF_LOCAL sockets,
so I've asked [1] on the curl ML if that would work or if libcurl needs
an AF_INET one.

>> I wonder why someone would want to use SSL through a tunnel, though.
>> Currently it's impossible to get to the SSL codepath when a tunnel is
>> active (it's in the 'else' block an 'if (srvc->tunnel)').  If that
>> property is preserved, then we should be safe.
> 
> I'm not sure I understand this comment. Even if SSL is not in use,
> wouldn't we be passing a regular pipe to curl, which would break?

Yeah, we can't do that, and thus would have to keep the handwritten IMAP
implementation just for the tunnel case (allowing to drop only the
OpenSSL specific stuff), see my other email:
http://www.mail-archive.com/git@vger.kernel.org/msg56791.html (the
relevant part is pretty far down at the bottom).

Bernhard

[1] http://curl.haxx.se/mail/lib-2014-08/0131.html
