From: Paul J R <me@pjr.cc>
Subject: Re: git clone over http with basic auth bug?
Date: Sun, 23 Sep 2012 06:43:24 +1000
Message-ID: <505E22EC.1060208@pjr.cc>
References: <505CFA42.9090504@pjr.cc> <20120922050935.GA4542@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 22 22:43:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFWY6-0008B3-2V
	for gcvg-git-2@plane.gmane.org; Sat, 22 Sep 2012 22:43:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753244Ab2IVUnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Sep 2012 16:43:25 -0400
Received: from pjr.cc ([173.230.145.154]:41663 "EHLO ln.pjr.cc"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751825Ab2IVUnY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2012 16:43:24 -0400
Received: from iron.pjr.cc (unknown [10.10.0.2])
	by ln.pjr.cc (Postfix) with ESMTP id 4BD941804A
	for <git@vger.kernel.org>; Sat, 22 Sep 2012 20:43:23 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by iron.pjr.cc (Postfix) with SMTP id B6A4330AD59
	for <git@vger.kernel.org>; Sun, 23 Sep 2012 06:43:20 +1000 (EST)
Received: from [10.10.0.13] (desk01.pjr.cc [10.10.0.13])
	by iron.pjr.cc (Postfix) with ESMTP id 11CB330AD53;
	Sun, 23 Sep 2012 06:43:18 +1000 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <20120922050935.GA4542@sigill.intra.peff.net>
X-DSPAM-Result: Whitelisted
X-DSPAM-Processed: Sun Sep 23 06:43:20 2012
X-DSPAM-Confidence: 0.9955
X-DSPAM-Probability: 0.0000
X-DSPAM-Signature: 505e22e820672864810877
X-DSPAM-Factors: 27,
	git, 0.00052,
	git, 0.00052,
	User-Agent*x86_64, 0.00084,
	backend, 0.00097,
	backend, 0.00097,
	repository, 0.00116,
	problem?, 0.00132,
	(but, 0.00190,
	Subject*git, 0.00215,
	References*sigill.intra.peff.net>, 0.00272,
	To*Jeff, 0.00534,
	In-Reply-To*sigill.intra.peff.net>, 0.00535,
	Peff, 0.00546,
	CC*git, 0.00579,
	CC*vger.kernel.org, 0.00615,
	repo, 0.00624,
	repo, 0.00624,
	refs, 0.00650,
	To*King, 0.00655,
	To*<peff, 0.00660,
	To*peff.net>, 0.00660,
	auth, 0.00686,
	auth, 0.00686,
	logs, 0.00737,
	all), 0.00747,
	User-Agent*Linux, 0.00773,
	there), 0.00847
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206215>

Indeed, thats correct, i should have tried a newer version really before 
i posted cause i do pull the main git repo and it would have been 
relatively easy.

Newer version did indeed fix the problem.

It hadnt occured to me that git-http-backend behaves differently to the 
"dumb" http protocol on read (though that was from reading the git 
source so i obviously missed what was going on there). Ultimately im 
writing a little webapp that wraps around git-http-backend for some git 
repository management and on reads i've been just "acting like 
webserver" but on writes i throw off to git-http-backend. But seeing it 
do authenticated reads properly via git-http-backend im going to change 
how it functions, cause that does work with older clients.

Thanks!

On 22/09/12 15:09, Jeff King wrote:
> On Sat, Sep 22, 2012 at 09:37:38AM +1000, Paul J R wrote:
>
>> Im not sure if this is a bug, or just "as implemented". But when
>> cloning from a repo sitting on a web site that uses basic auth, the
>> git client appears to forget its authentication info and ignores the
>> 401's the server is sending back. It appears to initially login and
>> get refs and HEAD ok, but after that it never authenticates again.
>> Using a .netrc file this will work (or a url of the form
>> http://user:pass@host though http://user@host wont), but i'm curious
>> if theres a way of doing this without having to expose the password
>> in some way?
>>
>> Im using git 1.7.9.5 and when i clone i get the following:
>> [...]
>  From your logs, it looks like you are using the "dumb" http protocol
> (wherein the server does not have to understand git at all). In this
> protocol, we end up making multiple simultaneous requests for objects
> with different curl handles. We had a bug where not all handles are told
> about the credential (but it doesn't always happen; it depends on the
> exact pattern of requests).
>
> This was fixed by dfa1725 (fix http auth with multiple curl handles,
> 2012-04-10), which is in git v1.7.10.2 and higher.
>
> Can you try upgrading to see if that fixes your problem?
>
> -Peff
>
