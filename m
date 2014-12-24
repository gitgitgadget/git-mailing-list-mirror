From: Brian Ericson <bericson@ptc.com>
Subject: Re: Cygwin sparse checkout degrades performance
Date: Wed, 24 Dec 2014 13:40:58 -0600
Message-ID: <549B16CA.3040107@ptc.com>
References: <549B0652.3020605@ptc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 24 20:41:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3roC-0003mE-3N
	for gcvg-git-2@plane.gmane.org; Wed, 24 Dec 2014 20:41:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbaLXTlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2014 14:41:10 -0500
Received: from mx2.ptc.com ([12.11.148.189]:40952 "EHLO mx2.ptc.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751386AbaLXTlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2014 14:41:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ptc.com; s=ptc; t=1419450069; x=1450986069;
  h=message-id:date:from:mime-version:to:subject:references:
   in-reply-to:content-transfer-encoding;
  bh=hiuJu1/LyvZxCX8rKmYh0QtJ3zc8a2ju5ZW9lRQ5+ew=;
  b=D/2F/nhA07tA/oOhvm9kgjcBM5YNUcceW9/8z0llpvqndByPfOg6yi2R
   MrvlbaN4lbaMl7oz6DBtuQxAKQQ0ZXPHp+2m2opfmY2YRyLzCAxeVC5jg
   JgDxpDzyJxnbo6vocsoOqSz24kBrIbtj/V/swQRR9e6Tiqmz7q61ZTxid
   g=;
X-IronPort-AV: E=Sophos;i="5.07,639,1413259200"; 
   d="scan'208";a="9270588"
Received: from hq-x10prdhub2.ptcnet.ptc.com ([132.253.198.28])
  by mx2-int.ptc.com with ESMTP; 24 Dec 2014 14:40:59 -0500
Received: from bericson.ptcnet.ptc.com (132.253.8.81) by
 HQ-X10PRDHUB2.ptcnet.ptc.com (132.253.201.252) with Microsoft SMTP Server
 (TLS) id 14.3.123.3; Wed, 24 Dec 2014 14:40:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <549B0652.3020605@ptc.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261809>

Huh.  The graphs (somehow) ended up incoherently reformatted...  Sorry 
about that!

Here's the raw data after a second run:

Linux:
100000 0.49
  90000 0.27
  80000 0.27
  70000 0.28
  60000 0.23
  50000 0.21
  40000 0.21
  30000 0.19
  20000 0.19
  10000 0.16
      1 0.14

Cygwin:
100000 4.72
  90000 4.28
  80000 4.41
  70000 4.43
  60000 4.67
  50000 5.04
  40000 6.24
  30000 7.28
  20000 7.88
  10000 8.96
      1 9.43



On 12/24/2014 12:30 PM, Brian Ericson wrote:
> Counter-intuitively, using sparse checkout in Cygwin degrades "status"
> times as status appears to "stat" non-existent files and directories.
>
> To demonstrate, I created a repo with 100k random files in a
> dir/dir/dir/file structure (on a linux box -- to do this in Cygwin
> requires piping the result of "openssl rand" to "dos2unix" as the output
> contains "\r") and cloned in a Cygwin shell:
>
> git init test
> cd test
> git commit --allow-empty -m 'Empty first commit'
> for i in {1..10}; do for j in {1..10000}; do file=$( openssl rand -hex
> 32 | sed 's,^\(.\)\(.\)\(.\),\1/\2/\3/,'); mkdir -p $( dirname $file );
> echo $file > $file ; done & done; wait
> git add .
> git commit -m '100000 files'
> git gc --prune=now --aggressive
>
> I then timed and plotted "git status" as sparse checkout step-wisely
> reduced the number of files in the working tree using the folllowing
> command:
>
> ( ( git status >& /dev/null; time -p git status > /dev/null ) |& sed -n
> '/real/{s/real/100000/p}'; git config core.sparseCheckout true; for i in
> $( seq 90000 -10000 10000 ) 1; do git ls-files | head -n $i | sed
> 's,^,/,' > .git/info/sparse-checkout; git read-tree -u -m HEAD; git
> status >& /dev/null; ( time -p git status > /dev/null ) |& sed -n
> "/real/{s/real/$i/p}"; done; echo '*' > .git/info/sparse-checkout; git
> read-tree -u -m HEAD; rm .git/info/sparse-checkout; git config --unset
> core.sparseCheckout ) | gnuplot -p -e "set terminal dumb; set xrange[]
> reverse; set style data dots; set nokey; plot '-' using 1:2"
>
> Vertical bar is time in seconds, horizontal the number of files in the
> working tree after the sparse checkout.
>
> Linux results (v2.1.0):
>    0.45
> .+-----+------+-----+------+------+------+------+-----+------+-----++
>         +      +      +     +      +      +      +      + +      +      +
> | |
>     0.4 ++ ++
> | |
>    0.35 ++ ++
> | |
> | |
>     0.3 ++ .                                                           ++
> | |
>         | .                                                     |
>    0.25 ++                  . .                                       ++
>         |                                 . .                          |
> | |
>     0.2 ++                                              . .            ++
> | |
>    0.15 ++                                                           . +.
> | |
>         +      +      +     +      +      +      +      + +      +      +
>     0.1
> ++-----+------+-----+------+------+------+------+-----+------+-----++
>       100000 90000  80000 70000  60000  50000  40000  30000 20000
> 10000    0
>
> Cygwin results (v2.1.1):
>    10
> ++-----+------+------+------+------+------+------+------+------+-----++
>       +      +      +      +      +      +      +      + +      +      +
> | .
>     9 ++ ++
> | .      |
> | |
>     8 ++ .            ++
> | |
> | |
>     7 ++ .                   ++
> | |
> | |
>       |                                  . .                           |
>     6 ++ ++
> | |
> | |
>     5 ++ .                                                             ++
>       .                    . .                                         |
>       +      +      .      +      +      +      +      + +      +      +
>     4
> ++-----+------+------+------+------+------+------+------+------+-----++
>     100000 90000  80000  70000  60000  50000  40000  30000  20000
> 10000    0
>
> Linux times do what I expect/want (they get better as the number of
> working tree files decrease), but Cygwin does the opposite: the worst
> times are in a working tree with only 1 (sparse) file, and it's double
> where I started with no sparse checkout!  I'd hoped sparse checkout
> would improve the too-slow status times when all files are present...
>
> Looking at strace with a working tree consisting of a single (sparse)
> file suggests Cygwin is attempting to access the non-existent files and
> directories whereas Linux does not appear to do so.  In fact, if I do
> nothing more than "mkdir -p $( git ls-files | cut -c1-5 | sort -u )"
> when looking at a single (sparse) file, I can drop status times below
> 3s, a 3-fold improvement and something at least better than where I
> started!
>
> Is there a way I can get improved status times using sparse checkout
> with Cygwin?
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> .
>
