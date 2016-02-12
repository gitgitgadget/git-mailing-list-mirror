From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH] git-completion.bash: always swallow error output of
 for-each-ref
Date: Sat, 13 Feb 2016 00:21:22 +0100
Message-ID: <20160213002122.Horde.mxoPmZIuCikpV2PO97l11AI@webmail.informatik.kit.edu>
References: <56B32953.2010908@gmail.com>
 <20160204111307.GA30495@sigill.intra.peff.net>
 <alpine.DEB.2.20.1602041216240.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Cc: Jeff King <peff@peff.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	tr@thomasrast.ch
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 13 00:22:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUN2G-0004lF-36
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 00:22:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027AbcBLXVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2016 18:21:53 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:60864 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751965AbcBLXVv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Feb 2016 18:21:51 -0500
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1aUN24-0000lq-Np; Sat, 13 Feb 2016 00:21:48 +0100
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1aUN1e-00054V-FS; Sat, 13 Feb 2016 00:21:22 +0100
Received: from x590d742f.dyn.telefonica.de (x590d742f.dyn.telefonica.de
 [89.13.116.47]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Sat, 13 Feb 2016 00:21:22 +0100
In-Reply-To: <alpine.DEB.2.20.1602041216240.2964@virtualbox>
User-Agent: Horde Application Framework 5
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1455319308.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286082>


Quoting Johannes Schindelin <Johannes.Schindelin@gmx.de>:

> Hi Peff,
>
> On Thu, 4 Feb 2016, Jeff King wrote:

>> > diff --git a/contrib/completion/git-completion.bash  
>> b/contrib/completion/git-completion.bash
>> > index 15ebba5..7c0549d 100644
>> > --- a/contrib/completion/git-completion.bash
>> > +++ b/contrib/completion/git-completion.bash
>> > @@ -317,7 +317,7 @@ __git_heads ()
>> >  	local dir="$(__gitdir)"
>> >  	if [ -d "$dir" ]; then
>> >  		git --git-dir="$dir" for-each-ref --format='%(refname:short)' \
>> > -			refs/heads
>> > +			refs/heads 2>/dev/null
>> >  		return
>>
>> Not really related to your topic, but digging into it caused me to read
>> b7dd2d2 (for-each-ref: Do not lookup objects when they will not be used,
>> 2009-05-27), which is about making sure for-each-ref is very fast in
>> completion.
>>
>> It looks like %(refname:short) is actually kind of expensive:
>
> Yep, this was reported on the Git for Windows bug tracker, too:
>
> 	https://github.com/git-for-windows/git/issues/524
>
>> $ time git for-each-ref --format='%(refname)' refs/tags  >/dev/null
>>
>> real    0m0.004s
>> user    0m0.000s
>> sys     0m0.004s
>>
>> $ time git for-each-ref --format='%(refname:short)' refs/tags >/dev/null
>>
>> real    0m0.009s
>> user    0m0.004s
>> sys     0m0.004s
>
> And the timings in the ticket I mentioned above are not pretty small:
> 0.055s vs 1.341s

It's ironic that 'refname:short' came about because it was faster than
'refname' plus removing 'refs/{heads,tags,remotes}/' in a shell loop, at
least on Linux.

However, 'refname:short' performs a lot more stat() calls per ref to check
ambiguity, especially since many ref races got fixed.  In a repo with a
single master branch:

   $ strace git for-each-ref --format='%(refname)' refs/heads/master  
2>&1 |grep 'stat("\.git.*\(master\|packed-refs\)'
   stat(".git/refs/heads/master", {st_mode=S_IFREG|0644, st_size=41, ...}) = 0
   lstat(".git/refs/heads/master", {st_mode=S_IFREG|0644, st_size=41, ...}) = 0

   $ strace git for-each-ref --format='%(refname:short)'  
refs/heads/master 2>&1 |grep 'stat("\.git.*\(master\|packed-refs\)'
   stat(".git/refs/heads/master", {st_mode=S_IFREG|0644, st_size=41, ...}) = 0
   lstat(".git/refs/heads/master", {st_mode=S_IFREG|0644, st_size=41, ...}) = 0
   lstat(".git/master", 0x7fff6dac9610)    = -1 ENOENT (No such file  
or directory)
   stat(".git/packed-refs", 0x7fff6dac9460) = -1 ENOENT (No such file  
or directory)
   lstat(".git/refs/master", 0x7fff6dac9610) = -1 ENOENT (No such file  
or directory)
   stat(".git/packed-refs", 0x7fff6dac9460) = -1 ENOENT (No such file  
or directory)
   lstat(".git/refs/tags/master", 0x7fff6dac9610) = -1 ENOENT (No such  
file or directory)
   stat(".git/packed-refs", 0x7fff6dac9460) = -1 ENOENT (No such file  
or directory)
   lstat(".git/refs/remotes/master", 0x7fff6dac9610) = -1 ENOENT (No  
such file or directory)
   stat(".git/packed-refs", 0x7fff6dac9460) = -1 ENOENT (No such file  
or directory)
   lstat(".git/refs/remotes/master/HEAD", 0x7fff6dac9610) = -1 ENOENT  
(No such file or directory)
   stat(".git/packed-refs", 0x7fff6dac9460) = -1 ENOENT (No such file  
or directory)

Since stat()s were never a strong side of Windows, I'm afraid 'refname:short'
fired backwards and made things much slower over there.  Ouch.

I think in this case we should opt for performance instead of correctness,
and use Peff's 'refname:strip=2'.  Ambiguous refs will only hurt you, if,
well, your repo actually has ambiguous refs AND you happen to want to do
something with one of those refs.  I suspect that's rather uncommon, and
even then you could simply rename one of those refs.  OTOH, as shown in
the ticket, you don't need that many refs to make refs completion
unacceptably slow on Windows, and it will bite every time you attempt to
complete a ref.

Now, if 'git for-each-ref' could understand '**' globbing, not just
fnmatch...


>> The upcoming refname:strip does much better:
>>
>> $ time git for-each-ref --format='%(refname:strip=2)' refs/tags >/dev/null
>>
>> real    0m0.004s
>> user    0m0.000s
>> sys     0m0.004s
>
> This is funny: after reading the commit message at
> https://github.com/git/git/commit/0571979b it eludes me why strip=2 should
> be so much faster than short...
>
> Ciao,
> Dscho
