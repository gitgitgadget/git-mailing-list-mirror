From: =?ISO-8859-2?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: obnoxious CLI complaints
Date: Sat, 12 Sep 2009 00:01:50 +0200
Message-ID: <4AAAC8CE.8020302@lsrfire.ath.cx>
References: <ef38762f0909091427m5b8f3am72c88fd4dbfebc59@mail.gmail.com> <m3fxavvl5k.fsf@localhost.localdomain> <ef38762f0909091709t7336d86dkd2f175e5b3a6a3f@mail.gmail.com> <200909101116.55098.jnareb@gmail.com> <4AA97B61.6030301@lsrfire.ath.cx> <alpine.LFD.2.01.0909110744030.3654@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Brendan Miller <catphive@catphive.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Sep 12 00:02:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmEBu-0003ld-3S
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 00:02:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756906AbZIKWBx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Sep 2009 18:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756882AbZIKWBx
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 18:01:53 -0400
Received: from india601.server4you.de ([85.25.151.105]:56243 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756850AbZIKWBw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 18:01:52 -0400
Received: from [10.0.1.101] (p57B7BDDB.dip.t-dialin.net [87.183.189.219])
	by india601.server4you.de (Postfix) with ESMTPSA id 919A72F8076;
	Sat, 12 Sep 2009 00:01:54 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <alpine.LFD.2.01.0909110744030.3654@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128224>

Am 11.09.2009 16:47, schrieb Linus Torvalds:
>
>
> On Fri, 11 Sep 2009, Ren=E9 Scharfe wrote:
>>
>> Using zlib directly avoids the overhead of a pipe and of buffering t=
he
>> output for blocked writes; surprisingly (to me), it isn't any faster=
=2E
>
> In fact, it should be slower.
>
> On SMP, you're quite likely better off using the pipe, and compressin=
g on
> another CPU. Of course, it's usually the case that the compression is=
 _so_
> much slower than generating the tar-file (especially for the hot-cach=
e
> case) that it doesn't matter or the pipe overhead is even a slowdown.
>
> But especially if generating the tar-file has some delays in it
> (cold-cache object lookup, whatever), the "compress in separate proce=
ss"
> is likely simply better, because you can compress while the other pro=
cess
> is looking up data for the tar.

Yes, that makes sense and can be seen here (quad core, Fedora 11, best
of five consecutive runs, Linux kernel repo):

	# git v1.6.5-rc0
	$ time git archive --format=3Dtar v2.6.31 | gzip -6 >/dev/null

	real	0m16.591s
	user	0m19.769s
	sys	0m0.474s

	# git v1.6.5-rc0 + patch
	$ time ../git/git archive --format=3Dtar.gz -6 v2.6.31 >/dev/null

	real	0m20.390s
	user	0m20.299s
	sys	0m0.088s

User time is quite similar, real time is lower when using a pipe.

But what has bugged me since I added zip support is this result:

	# git v1.6.5-rc0
	$ time git archive --format=3Dzip -6 v2.6.31 >/dev/null

	real	0m16.471s
	user	0m16.340s
	sys	0m0.128s

I'd have expected this to be the slowest case, because it's compressing
all files separately, i.e. it needs to create and flush the compression
context lots of times instead of only once as in the two cases above.
And it's sequential and uses zlib, just like the tar.gz format.  I
suspect the convenience function gzwrite() adds this overhead.


Oh, I just discovered pigz (http://zlib.net/pigz/), a parallel gzip:

	# git v1.6.5-rc0, pigz 2.1.5
	$ time git archive --format=3Dtar v2.6.31 | pigz -6 >/dev/null

	real	0m6.251s
	user	0m21.383s
	sys	0m0.547s

So pipes win. :)  Still need to investigate why zip is as (relatively)
fast as it is, though.

Ren=E9
