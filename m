From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] completion: improve shell expansion of items
Date: Thu, 27 Sep 2012 15:48:56 -0400
Message-ID: <20120927194856.GA10673@sigill.intra.peff.net>
References: <20120926214653.GA18628@sigill.intra.peff.net>
 <20120926215119.GC18653@sigill.intra.peff.net>
 <20120927003751.GI10144@goldbirke>
 <20120927062855.GA22890@sigill.intra.peff.net>
 <20120927064338.GA4789@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Sep 27 21:49:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THK57-0008UH-Jz
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 21:49:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754148Ab2I0Ts7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 15:48:59 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:33076 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753287Ab2I0Ts6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 15:48:58 -0400
Received: (qmail 5316 invoked by uid 107); 27 Sep 2012 19:49:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 27 Sep 2012 15:49:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Sep 2012 15:48:56 -0400
Content-Disposition: inline
In-Reply-To: <20120927064338.GA4789@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206514>

On Thu, Sep 27, 2012 at 02:43:38AM -0400, Jeff King wrote:

> Ah. The problem is that most of the load comes from my patch 4/3, which
> does a separate iteration. Here are the numbers after just patch 3:
> 
>   $ time __gitcomp_nl "$refs"
>   real    0m0.344s
>   user    0m0.392s
>   sys     0m0.040s
> 
> Slower, but not nearly as painful. Here are the numbers using sed[1]
> instead:
> 
>   $ time __gitcomp_nl "$refs"
>   real    0m0.100s
>   user    0m0.084s
>   sys     0m0.016s
> 
> So a little slower, but probably acceptable. We could maybe do the same
> trick on the output side (although it is a little trickier there,
> because we need it in a bash array). Of course, this is Linux; the fork
> for sed is way more expensive on some systems.

So something like the patch below does the quoting correctly (try
committing a file like "name with spaces" and doing "git show
HEAD:<TAB>"), and isn't too much slower:

  real    0m0.114s
  user    0m0.108s
  sys     0m0.004s

That's almost double the time without handling quoting, but keep in mind
this is on 10,000 entries (and the real sluggishness we are trying to
avoid is an order of magnitude). So it might be acceptable.

This is just a proof-of-concept patch. We'd probably want to replace the
perl below with a more complicated sed invocation  for portability (the
trickiness is that the output is shown to the user, so we very much
don't want to quote anything that does not have to be).

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index be800e0..20c09ef 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -225,6 +225,17 @@ fi
 fi
 fi
 
+# Quotes each element of a newline-delimited list for shell reuse
+__git_quote()
+{
+	echo "$1" |
+	sed "
+	  s/'/'\\\\''/g
+	  s/^/'/
+	  s/$/'/
+	"
+}
+
 # Generates completion reply with compgen, appending a space to possible
 # completion words, if necessary.
 # It accepts 1 to 4 arguments:
@@ -261,7 +272,10 @@ __gitcomp_nl ()
 __gitcomp_nl ()
 {
 	local IFS=$'\n'
-	COMPREPLY=($(compgen -P "${2-}" -S "${4- }" -W "$1" -- "${3-$cur}"))
+	COMPREPLY=($(
+	  compgen -P "${2-}" -S "${4- }" -W "$(__git_quote "$1")" -- "${3-$cur}" |
+	  perl -lne '/(.*?)( ?)$/; print quotemeta($1), $2'
+	))
 }
 
 __git_heads ()

-Peff
