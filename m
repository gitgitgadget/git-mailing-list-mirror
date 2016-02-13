From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH] git-completion.bash: always swallow error output of
 for-each-ref
Date: Sat, 13 Feb 2016 02:07:12 +0100
Message-ID: <20160213020712.Horde.SM-rQbc5Jx1UwdYxdvNFNJx@webmail.informatik.kit.edu>
References: <56B32953.2010908@gmail.com>
 <20160204111307.GA30495@sigill.intra.peff.net>
 <alpine.DEB.2.20.1602041216240.2964@virtualbox>
 <20160213002122.Horde.mxoPmZIuCikpV2PO97l11AI@webmail.informatik.kit.edu>
 <20160212234041.GA15688@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	tr@thomasrast.ch
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 13 02:07:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUOgc-0002xr-76
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 02:07:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbcBMBHm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Feb 2016 20:07:42 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:33648 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750853AbcBMBHl convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 20:07:41 -0500
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1aUOgU-0001Tq-FG; Sat, 13 Feb 2016 02:07:38 +0100
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1aUOg4-0008MC-56; Sat, 13 Feb 2016 02:07:12 +0100
Received: from x590d742f.dyn.telefonica.de (x590d742f.dyn.telefonica.de
 [89.13.116.47]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Sat, 13 Feb 2016 02:07:12 +0100
In-Reply-To: <20160212234041.GA15688@sigill.intra.peff.net>
User-Agent: Horde Application Framework 5
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1455325658.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286102>


Quoting Jeff King <peff@peff.net>:

> On Sat, Feb 13, 2016 at 12:21:22AM +0100, SZEDER G=C3=A1bor wrote:
>
>> I think in this case we should opt for performance instead of correc=
tness,
>> and use Peff's 'refname:strip=3D2'.  Ambiguous refs will only hurt y=
ou, if,
>> well, your repo actually has ambiguous refs AND you happen to want t=
o do
>> something with one of those refs.  I suspect that's rather uncommon,=
 and
>> even then you could simply rename one of those refs.  OTOH, as shown=
 in
>> the ticket, you don't need that many refs to make refs completion
>> unacceptably slow on Windows, and it will bite every time you attemp=
t to
>> complete a ref.
>
> I'm not even sure that this is a correctness tradeoff at all. For
> example, in the function __git_heads(), we are asking for-each-ref to
> tell us about everything under refs/heads/. If you have a refs/heads/=
foo
> and refs/tags/foo, we don't care; we are trying to print the unqualif=
ied
> branch names. And in fact having refname:short print "heads/foo" in t=
his
> case may be actively wrong. For instance, in _git_branch(), you canno=
t
> use the resulting completion of "heads/foo", as that command wants
> unqualified names in "refs/heads/", and you do not have
> "refs/heads/heads/foo".
>
> So I think switching to :strip is an improvement in both correctness
> _and_ performance.

Right.  I was more worried about __git_refs(), because it asks for
everything under refs/heads/, refs/tags/ and refs/remotes/, and its
output is used in a lot more places and fed to a lot more commands than
the output of __git_heads() (or __git_tags(), for that matter).  But I
thought that a branch-tag ambiguity would cause git to error out
complaining, just like in the case of ref-path ambiguity.  Successfully
avoiding ambiguous refs for many years, I wasn't aware that 'git
rev-parse' doesn't barf, but only warns and resolves the ambiguity in
favor of the tag.


>> Now, if 'git for-each-ref' could understand '**' globbing, not just
>> fnmatch...
>
> I think it does already, since 4917e1e (Makefile: promote wildmatch t=
o
> be the default fnmatch implementation, 2013-05-30).

Things are looking up!

A single 'master' branch and 10 remotes with 10k remote branches each,
i.e. a total of 100001 refs, all packed.  To uniquely complete
'master ' after 'git checkout m<TAB>' on Linux in current git.git, i.e.
with 'refname:short':

   $ cur=3Dm ; time __gitcomp_nl "$(__git_refs '' 1)"

   real  0m7.641s
   user  0m5.888s
   sys   0m1.832s

Using 'refname:strip=3D2' for both 'git for-each-ref' in __git_refs():

   $ cur=3Dm ; time __gitcomp_nl "$(__git_refs '' 1)"

   real  0m2.848s
   user  0m2.308s
   sys   0m0.596s

Quick'n'dirty PoC using 'refname:strip', '**' globbing and a few more
tricks to let 'git for-each-ref' do the filtering instead of the
shell loop behind __gitcomp_nl():

   $ cur=3Dm ; time IFS=3D$'\n' COMPREPLY=3D( $(__git_refs_PoC '' 1) )

   real  0m0.247s
   user  0m0.208s
   sys   0m0.032s

Not bad for a Friday night, huh? :)
