From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] completion: improve shell expansion of items
Date: Thu, 27 Sep 2012 02:28:55 -0400
Message-ID: <20120927062855.GA22890@sigill.intra.peff.net>
References: <20120926214653.GA18628@sigill.intra.peff.net>
 <20120926215119.GC18653@sigill.intra.peff.net>
 <20120927003751.GI10144@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Sep 27 08:29:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TH7at-0000GC-TG
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 08:29:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754815Ab2I0G26 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Sep 2012 02:28:58 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60732 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752823Ab2I0G25 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 02:28:57 -0400
Received: (qmail 31476 invoked by uid 107); 27 Sep 2012 06:29:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 27 Sep 2012 02:29:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Sep 2012 02:28:55 -0400
Content-Disposition: inline
In-Reply-To: <20120927003751.GI10144@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206462>

On Thu, Sep 27, 2012 at 02:37:51AM +0200, SZEDER G=C3=A1bor wrote:

> > +# Quotes each element of an IFS-delimited list for shell reuse
> > +__git_quote()
> > +{
> > +	local i
> > +	local delim
> > +	for i in $1; do
> > +		local quoted=3D${i//\'/\'\\\'\'}
> > +		printf "${delim:+$IFS}'%s'" "$quoted"
> > +		delim=3Dt
> > +	done
> > +}
> [...]
>
> Iterating through all possible completion words undermines the main
> reason for __gitcomp_nl()'s existence: to handle potentially large
> number of possible completion words faster than the old __gitcomp().
> If we really have to iterate in a subshell, then it would perhaps be
> better to drop __gitcomp_nl(), go back to using __gitcomp(), and
> modify that instead.

Thanks for reminding me to time. I noticed your a31e626 while digging i=
n
the history, but forgot that I wanted to do a timing test. Sadly, the
results are very discouraging. Doing a similar test to your 10,000-refs=
,
I get:

  $ refs=3D$(seq 1 10000)

  $ . git-completion.bash.old
  $ time __gitcomp_nl "$refs"
  real    0m0.065s
  user    0m0.064s
  sys     0m0.004s

  $ . git-completion.bash.new
  $ time __gitcomp_nl "$refs"
  real    0m1.799s
  user    0m1.828s
  sys     0m0.036s

So, a 2700% slowdown. Yuck.

I also tried running it through sed instead of iterating in bash. I kno=
w
that some people will not like the fork, but curiously enough, it was
not that much faster. Which makes me wonder if part of the slowdown is
actually bash unquoting the result in compgen.

> After all, anyone could drop a file called git-cmd-${meta} on his
> $PATH, and then get cmd- offered, because completion of git commands
> still goes through __gitcomp().

Yeah. I wasn't sure if __gitcomp() actually got used on any arbitrary
data, but that's a good example.

I'm not sure where to go next. I guess we could try pre-quoting via git
when generating the list of refs (or files, or whatever) and hope that
is faster.

With this patch as it is, I'm not sure the slowdown is worth it. Yes,
it's more correct in the face of metacharacters, but those are the
uncommon case by a large margin. I'd hate to have a performance
regression in the common case just for that.

-Peff
