From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] completion: improve shell expansion of items
Date: Thu, 27 Sep 2012 02:43:38 -0400
Message-ID: <20120927064338.GA4789@sigill.intra.peff.net>
References: <20120926214653.GA18628@sigill.intra.peff.net>
 <20120926215119.GC18653@sigill.intra.peff.net>
 <20120927003751.GI10144@goldbirke>
 <20120927062855.GA22890@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Sep 27 08:43:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TH7p8-0006Sg-OX
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 08:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752417Ab2I0Gnl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 02:43:41 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60748 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752143Ab2I0Gnk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 02:43:40 -0400
Received: (qmail 31646 invoked by uid 107); 27 Sep 2012 06:44:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 27 Sep 2012 02:44:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Sep 2012 02:43:38 -0400
Content-Disposition: inline
In-Reply-To: <20120927062855.GA22890@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206466>

On Thu, Sep 27, 2012 at 02:28:55AM -0400, Jeff King wrote:

> Thanks for reminding me to time. I noticed your a31e626 while digging in
> the history, but forgot that I wanted to do a timing test. Sadly, the
> results are very discouraging. Doing a similar test to your 10,000-refs,
> I get:
> 
>   $ refs=$(seq 1 10000)
> 
>   $ . git-completion.bash.old
>   $ time __gitcomp_nl "$refs"
>   real    0m0.065s
>   user    0m0.064s
>   sys     0m0.004s
> 
>   $ . git-completion.bash.new
>   $ time __gitcomp_nl "$refs"
>   real    0m1.799s
>   user    0m1.828s
>   sys     0m0.036s
> 
> So, a 2700% slowdown. Yuck.
> 
> I also tried running it through sed instead of iterating in bash. I know
> that some people will not like the fork, but curiously enough, it was
> not that much faster. Which makes me wonder if part of the slowdown is
> actually bash unquoting the result in compgen.

Ah. The problem is that most of the load comes from my patch 4/3, which
does a separate iteration. Here are the numbers after just patch 3:

  $ time __gitcomp_nl "$refs"
  real    0m0.344s
  user    0m0.392s
  sys     0m0.040s

Slower, but not nearly as painful. Here are the numbers using sed[1]
instead:

  $ time __gitcomp_nl "$refs"
  real    0m0.100s
  user    0m0.084s
  sys     0m0.016s

So a little slower, but probably acceptable. We could maybe do the same
trick on the output side (although it is a little trickier there,
because we need it in a bash array). Of course, this is Linux; the fork
for sed is way more expensive on some systems.

Still, I'd be curious to see it with the callers (e.g., __git_refs)
doing their own quoting. I'd worry that it would become a maintenance
headache, but perhaps we don't have that many lists we feed (there are a
lot of calls to gitcomp_nl, but they are mostly feeding __git_refs).

-Peff

[1] For reference, that patch is:

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1fc43f7..5ff3742 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -225,16 +225,15 @@ __git_quote()
 fi
 fi
 
-# Quotes each element of an IFS-delimited list for shell reuse
+# Quotes each element of a newline-delimited list for shell reuse
 __git_quote()
 {
-	local i
-	local delim
-	for i in $1; do
-		local quoted=${i//\'/\'\\\'\'}
-		printf "${delim:+$IFS}'%s'" "$quoted"
-		delim=t
-	done
+	echo "$1" |
+	sed "
+	  s/'/'\\\\''/g
+	  s/^/'/
+	  s/$/'/
+	"
 }
 
 # Generates completion reply with compgen, appending a space to possible
