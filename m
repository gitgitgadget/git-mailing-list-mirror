From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/22] Refactor to accept NUL in commit messages
Date: Sat, 22 Oct 2011 15:09:15 -0400
Message-ID: <20111022190914.GA1785@sigill.intra.peff.net>
References: <1319277881-4128-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 22 21:09:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHgwg-00017w-Aq
	for gcvg-git-2@lo.gmane.org; Sat, 22 Oct 2011 21:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080Ab1JVTJW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Oct 2011 15:09:22 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39586
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751792Ab1JVTJV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Oct 2011 15:09:21 -0400
Received: (qmail 30124 invoked by uid 107); 22 Oct 2011 19:09:29 -0000
Received: from mc64036d0.tmodns.net (HELO sigill.intra.peff.net) (208.54.64.198)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 22 Oct 2011 15:09:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 22 Oct 2011 15:09:15 -0400
Content-Disposition: inline
In-Reply-To: <1319277881-4128-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184110>

On Sat, Oct 22, 2011 at 09:04:19PM +1100, Nguyen Thai Ngoc Duy wrote:

> This series helps pass commit message size up to output functions,
> though it does not change any output functions to print ^@.

Can we take a step back for a second and discuss what git _should_ do
with commits that contain NUL?

If all of the pretty-print functions are just going consider "foo\0bar"
to be "foo^@bar", then maybe it would be much simpler to just
"normalize" the commit message into a C string at a lower level, and
pass it around as a string as we currently do.

On the other hand, if we are eventually looking to add an option like
"--include-NUL-in-commit-message", then it would make sense for the
real contents and size to get passed around.

> All functions up to the last patch learn to accept a string as a pair
> <const char *start, const char *end> as a preparation step. These
> changes are relatively simple. Or it could have been so if I did not
> attempt to reduce some code duplication found while working on this
> series.

Great. Reducing code duplication is always a plus.

> The last patch turns commit_buffer field in struct commit to "struct
> strbuf *". This approach costs us 12 bytes more each commit. We can
> choose not to use strbuf to save memory.

I think 12 bytes in the commit struct might be noticeable. But it looks
like you've done the sane thing, and replaced the pointer-to-char with a
pointer-to-strbuf. And that I don't think should be a big deal. The
buffer itself is way bigger than 12 bytes, so we don't care so much
about the "we have a buffer" case, but more about the 100,000 other
commits that we're not currently printing right now.

Of course, some timings on things like "rev-list" and "pack-objects"
would be nice to double-check.

-Peff
