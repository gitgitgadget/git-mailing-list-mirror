From: Jeff King <peff@peff.net>
Subject: Re: remove_duplicates() in builtin/fetch-pack.c is O(N^2)
Date: Mon, 21 May 2012 19:52:19 -0400
Message-ID: <20120521235219.GA5589@sigill.intra.peff.net>
References: <4FB9F92D.8000305@alum.mit.edu>
 <20120521174525.GA22643@sigill.intra.peff.net>
 <20120521221417.GA22664@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin Fick <mfick@codeaurora.org>,
	git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 22 01:52:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWcOv-0006Bw-Oq
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 01:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932905Ab2EUXwY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 19:52:24 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51271
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932859Ab2EUXwW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 19:52:22 -0400
Received: (qmail 8502 invoked by uid 107); 21 May 2012 23:52:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 May 2012 19:52:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 May 2012 19:52:19 -0400
Content-Disposition: inline
In-Reply-To: <20120521221417.GA22664@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198163>

On Mon, May 21, 2012 at 06:14:17PM -0400, Jeff King wrote:

> The rails and git cases run in ~28s and ~37s, respectively, again mostly
> going to the actual object transfer. So I think this series removes all
> of the asymptotically bad behavior from this code path.
> 
> One thing to note about all of these repos is that they tend to have
> several refs pointing to a single commit. None of the speedups in this
> series depends on that fact, but it may be that on a repo with more
> independent refs, we may uncover other code paths (e.g., I know that my
> fix for mark_complete in ea5f220 improves the case with duplicate refs,
> but would not help if you really have 400K refs pointing to unique
> commits[1]).

Hmm. So I started to do some experimentation with this and noticed
something odd.

Try doing "git fetch . refs/*:refs/*" in a repository with a large
number of refs (e.g., 400K). With git v1.7.10, this takes about 9.5s on
my machine. But using the version of git in "next" takes about 16.5s.
Bisection points to your 432ad41 (refs: store references hierarchically,
2012-04-10). Perf shows sort_ref_dir and msort_with_tmp as hot spots.

-Peff
