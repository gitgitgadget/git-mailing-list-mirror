From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] clone --local fixes
Date: Mon, 28 May 2012 01:36:03 -0400
Message-ID: <20120528053602.GA11174@sigill.intra.peff.net>
References: <20120526034226.GA14287@sigill.intra.peff.net>
 <7vsjemp20j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Emeric Fermas <emeric.fermas@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 28 07:43:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYsjb-0001Zh-5b
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 07:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752939Ab2E1FnH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 May 2012 01:43:07 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:33967
	"EHLO peff.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752736Ab2E1FnG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 01:43:06 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 May 2012 01:43:06 EDT
Received: (qmail 5566 invoked by uid 107); 28 May 2012 05:36:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 May 2012 01:36:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 May 2012 01:36:03 -0400
Content-Disposition: inline
In-Reply-To: <7vsjemp20j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198627>

On Sat, May 26, 2012 at 11:32:44PM -0700, Junio C Hamano wrote:

> So your example "file:///" should *not* work even if --local is given,
> unless you happen to have a directory called "file:" in your current
> directory and it has path/to/repo subdirectory, which is a git repository.
> Specifically, the repository at /path/to/repo is not what the command line
> is naming.

I think it depends on the definition of "--local". If it means "when we
are cloning without a URL, turn on the local optimizations", then yes,
"file://" should not work. If it means "turn on local optimizations if
this destination supports it", then it should.

The current behavior is ambiguous as to whether it is the first case, or
whether it is the second, and it was simply buggy. The history you gave
argues that the original intent was the former. But to me that is much
less important than what is useful and least surprising to users.

There are basically three sane behaviors for "git clone --local
file://":

  1. --local is silently ignored, because it means "if we are local,
     turn on optimizations" (though it has a horrible name, in that case)

  2. it's an error; you should not use --local with a URL

  3. it should use local optimizations (because file:// is local)

Is there a compelling reason not to do (3)? It seems to be the
friendliest and least surprising to me.

I'll admit I don't care too much about this use case. People don't
tend to type "file://..." when they could type the simpler thing, so I
doubt anyone is hurting. I just don't see a reason not to make it work,
besides the usual "it is a non-zero amount of code".

> I think we probably should stop advertising --local in the documentation
> and help text.

I kind of agree, and that was what I was going to do originally (instead
of making it work). But I do think that "--no-local" (from my patch 3)
is actually useful in practice, so I'd rather not drop the option from
the documentation entirely.

-Peff
