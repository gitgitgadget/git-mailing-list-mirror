From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH] git-completion.bash: always swallow error output of
 for-each-ref
Date: Sat, 13 Feb 2016 14:53:33 +0100
Message-ID: <20160213145333.Horde.ZTzk8ajnzz2uB2UcNeCdPtB@webmail.informatik.kit.edu>
References: <56B32953.2010908@gmail.com>
 <20160204111307.GA30495@sigill.intra.peff.net>
 <alpine.DEB.2.20.1602041216240.2964@virtualbox>
 <20160213002122.Horde.mxoPmZIuCikpV2PO97l11AI@webmail.informatik.kit.edu>
 <20160212234041.GA15688@sigill.intra.peff.net>
 <20160213020712.Horde.SM-rQbc5Jx1UwdYxdvNFNJx@webmail.informatik.kit.edu>
 <alpine.DEB.2.20.1602131021170.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	tr@thomasrast.ch
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 13 14:54:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUaeI-0004iy-Ou
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 14:54:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbcBMNyG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Feb 2016 08:54:06 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:33552 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751361AbcBMNyE convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2016 08:54:04 -0500
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1aUae7-0008P8-Rh; Sat, 13 Feb 2016 14:53:59 +0100
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1aUadh-0007Bi-5F; Sat, 13 Feb 2016 14:53:33 +0100
Received: from x4db01c8d.dyn.telefonica.de (x4db01c8d.dyn.telefonica.de
 [77.176.28.141]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Sat, 13 Feb 2016 14:53:33 +0100
In-Reply-To: <alpine.DEB.2.20.1602131021170.2964@virtualbox>
User-Agent: Horde Application Framework 5
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1455371639.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286109>


Quoting Johannes Schindelin <Johannes.Schindelin@gmx.de>:

> Hi G=C3=A1bor,
>
> On Sat, 13 Feb 2016, SZEDER G=C3=A1bor wrote:
>
>>  $ cur=3Dm ; time __gitcomp_nl "$(__git_refs '' 1)"
>>
>>  real  0m7.641s
>>  user  0m5.888s
>>  sys   0m1.832s
>>
>> Using 'refname:strip=3D2' for both 'git for-each-ref' in __git_refs(=
):
>>
>>  $ cur=3Dm ; time __gitcomp_nl "$(__git_refs '' 1)"
>>
>>  real  0m2.848s
>>  user  0m2.308s
>>  sys   0m0.596s

I timed this one using a version that already included one from those
"few more tricks", so the change from ':short' to ':strip=3D2' alone
doesn't bring quite as much:

   $ cur=3Dm ; time __gitcomp_nl "$(__git_refs '' 1)"

   real  0m3.645s
   user  0m3.140s
   sys   0m0.588s


>> Quick'n'dirty PoC using 'refname:strip', '**' globbing and a few mor=
e
>> tricks to let 'git for-each-ref' do the filtering instead of the
>> shell loop behind __gitcomp_nl():
>>
>>  $ cur=3Dm ; time IFS=3D$'\n' COMPREPLY=3D( $(__git_refs_PoC '' 1) )
>>
>>  real  0m0.247s
>>  user  0m0.208s
>>  sys   0m0.032s

And this one now looks like:

   $ cur=3Dm ; time __gitcomp_direct "$(__git_refs_PoC '' 1)"

The timing results are the same.


> May I have that patch, please? ;-)

It's early days, and when I say proof of concept I mean it :)
=46or now it only works for refs from the local repository, and only
when the ref to be completed is on its own on the command line (i.e.
not for 'git log master..<TAB>' or 'commit --fixup=3D<TAB>'), and the
trailing space is hardcoded, and ...  though, arguably, that already
covers the majority of the cases.  I only switched 'git checkout' to
use this optimized version, because that was the worst offender.

So I won't send patches to the list just now, but you or anyone
interested can take a peek at:

   https://github.com/szeder/git.git completion-PoC-refs-speedup

Maybe even run some numbers on Windows?


G=C3=A1bor
