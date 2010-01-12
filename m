From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] grep: do not do external grep on skip-worktree entries
Date: Tue, 12 Jan 2010 11:21:54 -0500
Message-ID: <20100112162154.GA25092@coredump.intra.peff.net>
References: <7v3a2mzzg4.fsf@alter.siamese.dyndns.org>
 <20100104053125.GA5083@coredump.intra.peff.net>
 <7vbphaquwl.fsf@alter.siamese.dyndns.org>
 <20100104064408.GA7785@coredump.intra.peff.net>
 <alpine.LFD.2.00.1001040659150.3630@localhost.localdomain>
 <fc339e4a1001040757n31298f3h724eacfafb68c63e@mail.gmail.com>
 <alpine.LFD.2.00.1001040801290.3630@localhost.localdomain>
 <7vvdf9402f.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001110739280.13040@localhost.localdomain>
 <alpine.LFD.2.00.1001110748560.13040@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Miles Bader <miles@gnu.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jan 12 17:22:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUjVS-0002g6-Qk
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 17:22:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754139Ab0ALQWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 11:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754037Ab0ALQWF
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 11:22:05 -0500
Received: from peff.net ([208.65.91.99]:33226 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753997Ab0ALQWE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 11:22:04 -0500
Received: (qmail 8328 invoked by uid 107); 12 Jan 2010 16:26:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 12 Jan 2010 11:26:52 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jan 2010 11:21:54 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1001110748560.13040@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136735>

On Mon, Jan 11, 2010 at 07:59:18AM -0800, Linus Torvalds wrote:

> The meh news: this shows how grep is faster than regexec() due to being a 
> smarter algorithm. For the non-fixed case (I used "qwerty.*as"), the 
> numbers are
> 
>  - built-in:
> 	real	0m0.548s
> 	user	0m0.384s
> 	sys	0m0.152s
> 
>  - external:
> 	real	0m0.415s
> 	user	0m0.176s
> 	sys	0m0.160s
> 
> so it really is just 'strstr()' that is faster. But This is a 'meh', 
> because I don't really care, and the new code is still way faster than the 
> old one. And I'd be personally willing to just drop the external grep if 
> this is the worst problem.

Just for fun, I repeated my pcre tests on what's in pu (which has
Junio's lookahead patch now). Before they didn't show any improvement
because we wasted all of our time in non-regex code. There is some
improvement in just using pcre, but I didn't get any improvement by
tweaking it:

[pu]
$ time git grep 'qwerty.*as' >/dev/null
real    0m1.007s
user    0m0.752s
sys     0m0.252s

[pu + pcre]
$ time git grep --no-ext-grep 'qwerty.*as' >/dev/null
real    0m0.864s
user    0m0.648s
sys     0m0.212s

[pu + pcre_study]
$ time git grep --no-ext-grep 'qwerty.*as' >/dev/null
real    0m0.866s
user    0m0.628s
sys     0m0.200s

[pu + pcre_dfa_exec]
$ time git grep --no-ext-grep 'qwerty.*as' >/dev/null
real    0m0.868s
user    0m0.608s
sys     0m0.256s

So pcre seems to buy us about 15%, and tweaking it gets lost in the
noise (or I am tweaking it badly, which is entirely possible). I doubt
it's worth the trouble of supporting pcre for that much.

And let me add an additional vote against strstr:

$ time git grep --no-ext-grep qwerty >/dev/null
real    0m3.285s
user    0m3.032s
sys     0m0.252s

-Peff
