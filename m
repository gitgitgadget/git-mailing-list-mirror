From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH 0/6] address packed-refs speed regressions
Date: Mon, 06 Apr 2015 00:39:15 +0200
Message-ID: <5521B993.1080202@web.de>
References: <20150405010611.GA15901@peff.net> <55213B93.9050207@web.de> <20150405185259.GB13096@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 06 00:40:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YetD3-0004Ol-JJ
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 00:40:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752576AbbDEWj4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Apr 2015 18:39:56 -0400
Received: from mout.web.de ([212.227.17.12]:52961 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752561AbbDEWjz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2015 18:39:55 -0400
Received: from [192.168.178.27] ([79.250.182.13]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0Ls8xf-1ZQM353t0h-013t4u; Mon, 06 Apr 2015 00:39:53
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <20150405185259.GB13096@peff.net>
X-Provags-ID: V03:K0:Z3UvRYTiBoNmwLT2TKWgakYKK3AZ7GKBlw901xGRGaA3PeKhm2W
 HGE/iE3e0Qjy9pIUJFR0W2NJ6B2vcitLfIfbObwS/4yp/yszkwKHtUzm0bu7qrB2rU+5bxG
 Gb7shc8PwMTg5DphAdburHhz+gZrRbhURLsXpu8Mj41oZkM4a6+lIvNFvbSC8kPVzMC+Oss
 IR7Ke06tIbdJ/8Mip9OMg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266822>

Am 05.04.2015 um 20:52 schrieb Jeff King:
> On Sun, Apr 05, 2015 at 03:41:39PM +0200, Ren=C3=A9 Scharfe wrote:
>> I wonder if pluggable reference backends could help here.  Storing r=
efs
>> in a database table indexed by refname should simplify things.
>
> ...this. I think that effort might be better spent on a ref storage
> format that's more efficient, simpler (with respect to subtle races a=
nd
> such), and could provide other features (e.g., transactional atomicit=
y).

Such as a DBMS? :-)  Leaving storage details to SQLite or whatever=20
sounds attractive to me because I'm lazy.

> The big plus side of packed-refs improvements is that they "just work=
"
> without worrying about compatibility issues. But ref storage is local=
,
> so I'm not sure how big a deal that is in practice.

Adding a dependency is a big step, admittedly, so native improvements=20
might be a better fit.  There's a chance that we'd run into issues=20
already solved by specialized database engines long ago, though.

>> Short-term, can we avoid the getc()/strbuf_grow() dance e.g. by mapp=
ing
>> the packed refs file?  What numbers do you get with the following pa=
tch?
>
> It's about 9% faster than my series + the fgets optimization I posted
> (or about 25% than using getc).  Which is certainly nice, but I was
> really hoping to just make strbuf_getline faster for all callers, rat=
her
> than introducing special code for one call-site.  Certainly we could
> generalize the technique (i.e., a struct with the mmap data), but the=
n I
> feel we are somewhat reinventing stdio. Which is maybe a good thing,
> because stdio has a lot of rough edges (as seen here), but it does fe=
el
> a bit like NIH syndrome.

=46orgot to say: I like your changes.  But if strbuf_getline can only b=
e=20
made fast enough beyond that by duplicating stdio buffering then I feel=
=20
it's better to take a different way.  E.g. dropping the requirement to=20
handle NUL chars and basing it on fgets as Junio suggested in his reply=
=20
to patch 3 sounds good.

In any case, the packed refs file seems special enough to receive=20
special treatment.  Using mmap would make the most sense if we could=20
also avoid copying lines to a strbuf for parsing, though.

Ren=C3=A9
