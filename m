From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Converting merge to rebase in the presence of conflicts
Date: Tue, 12 Apr 2011 04:55:22 +0200
Message-ID: <4DA3BF1A.7030407@alum.mit.edu>
References: <BANLkTi=krC6JMEWj=a5CY1vRCcmh9b+BaQ@mail.gmail.com>	<4DA3182B.2030305@viscovery.net> <BANLkTinVUdmG56oPQXvMhFh6hLcFj3_jZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?SHJ2b2plIE5pa8WhacSH?= <hniksic@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 04:55:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9TlL-0003xr-OA
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 04:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756542Ab1DLCz1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Apr 2011 22:55:27 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:48472 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756195Ab1DLCz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 22:55:26 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.133] (p54BEA0B4.dip.t-dialin.net [84.190.160.180])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p3C2tNeV006601
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 12 Apr 2011 04:55:23 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.14) Gecko/20110223 Lightning/1.0b2 Thunderbird/3.1.8
In-Reply-To: <BANLkTinVUdmG56oPQXvMhFh6hLcFj3_jZg@mail.gmail.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171369>

On 04/11/2011 05:15 PM, Hrvoje Nik=C5=A1i=C4=87 wrote:
> [...]
> I still wonder why rerere is necessary here. After all, even without
> the rerere metadata, the information about conflict resolution is
> right there, in the merge commit, and rebase could conceivably make
> use of it. What am I missing?

In general, merge and rebase are quite different animals.  In the
example you provided, there was only one conflicting commit being
rebased, so the difference is not so apparent.

One commit merged:

*--*--a--m      "master"
    \   /
     b--

One commit rebased:

*--*--a                           *--*--a--b'        "master"
    \              ->
     b

In either case, "git diff a..master" is identical.  Therefore,
converting "one commit merged" into "one commit rebased" simply involve=
s
forgetting the second parent of commit "m".  The "rerere" facility will
indeed help you here, as other people have suggested.

But if more than one commit is being brought in from the branch, then
merge and rebase are more distinct.  Merge forces you to resolve the
conflicts only once, in a single merge commit, whereas rebase forces yo=
u
to resolve the conflicts one commit at a time.

Multiple commits merged:

*--*--a---M      "master"
    \    /
     b--c

Multiple commits rebased:

*--*--a                          *--*--a--b'--c'     "master"
    \              ->
     b--c

It should still be that "git diff a..master" gives identical results in
the two cases, but there is still a big difference--in the rebase
example, master after commit "b'" should be a functional state that can
be compiled and passes the unit tests.  The state at commit "b'"
includes a combination of the changes made in "a" plus the changes made
in the original "b".  In the merge example, there is no state of the
tree that is equivalent; there is only a+b+c.  This lack of intermediat=
e
conflict resolution is what makes merges problematic for "git bisect".

Now, you want a way to transform the merge into a rebase automatically.
 In other words, given the information in the "multiple commits merged"
example as raw material, how can you convert it into a rebase?  This is
only possible if you are willing to squash "b", "c", and "M" into a
single commit:

*--*--a--bcM

because you have only told git how to resolve the conflicts between "a"
and "b+c", not between "a" and "b" without "c".

This is why I have advocated "rebase with history" [1], which retains
both the intermediate conflict resolutions and also the merge informati=
on:

*--*--a--b'--c'     "master"
    \   /   /
     --b---c

Michael

[1]
http://softwareswirl.blogspot.com/2009/04/truce-in-merge-vs-rebase-war.=
html

--=20
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
