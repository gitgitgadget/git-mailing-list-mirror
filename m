From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] Add the --submodule-summary option to the diff option
 family
Date: Wed, 07 Oct 2009 21:32:54 +0200
Message-ID: <4ACCECE6.1030508@web.de>
References: <cover.1254668669u.git.johannes.schindelin@gmx.de> <67a884457aeaead275612be10902a80726b2a7db.1254668669u.git.johannes.schindelin@gmx.de> <7vbpkmn6oi.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0910051027010.4985@pacific.mpi-cbg.de> <7vr5thacb4.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0910052251190.4985@pacific.mpi-cbg.de> <4ACB22E9.3010001@web.de> <7vocok21pw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 07 21:38:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvcKr-0005iH-Qg
	for gcvg-git-2@lo.gmane.org; Wed, 07 Oct 2009 21:38:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759899AbZJGTdi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2009 15:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754376AbZJGTdi
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Oct 2009 15:33:38 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:48366 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759219AbZJGTdh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2009 15:33:37 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id DAB6912AD10C0;
	Wed,  7 Oct 2009 21:32:59 +0200 (CEST)
Received: from [80.128.125.80] (helo=[192.168.178.26])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #314)
	id 1MvcFu-0001xf-00; Wed, 07 Oct 2009 21:32:58 +0200
User-Agent: Thunderbird 2.0.0.23 (X11/20090812)
In-Reply-To: <7vocok21pw.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18kurKBB8i1+nQh/100mXAmdRwWteZlFMH/ZzUX
	aor0Y9ZO6EqEDBegsLO7jMbDrt175mWVkav3V4PNlI8PU7jFq9
	mVsHHyhUHJfsOvCKzCZQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129652>

Junio C Hamano schrieb:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>>> But I really, really, really want to avoid a fork() in the common case.  I 
>>> do have some users on Windows, and I do have a few submodules in that 
>>> project.  Having too many fork() calls there would just give Git a bad 
>>> reputation.  And it has enough of that, it does not need more.
>> Me too thinks performance matters here. We do have a repo at my dayjob
>> with more than a handful of submodules and its main target platform is
>> windows ... so having that perform nicely is a win for us.
> 
> Numbers?

Here they are:

First i did them with the repo at hand, current msysgit master with
Dscho's git-repo checked out:

  without fork : real	0m0.672s
  with fork    : real	0m0.781s

So here it's a about 16% slower when using fork() (and both are
generating about 7270 shortlog entries).

But i thought this to be a rather unusual situation, having only one
submodule being changed by 7270 commits ...

So i took a live repo from my dayjob containing 8 submodules. In each
submodule i did a "git checkout HEAD^" to simulate one change. And
then i got:

  without fork : real	0m0.203s
  with fork    : real	0m0.453s

This is a degradation of more than 120% because of the fork()s. And
just for fun i ran the scripted submodule summary too:

  scripted     : real	0m3.437s

So the forked version outperforms the scripted version by a factor of
7, while the speedup from Dscho's original proposal is almost 17fold.
(If i did my computations right, the extra costs for each changed
submodule are a bit more than 30ms when fork()ing. Dscho's version
doesn't seem to suffer from changed submodules at all, i measured
0.203s for both versions before i did the submodule init and update).

(Best of three, "time git diff --submodule-summary". My system is an
Athlon64x2 4600+ with WindowsXP)


Jens
