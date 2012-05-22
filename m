From: Jeff King <peff@peff.net>
Subject: Re: remove_duplicates() in builtin/fetch-pack.c is O(N^2)
Date: Mon, 21 May 2012 20:07:47 -0400
Message-ID: <20120522000747.GA8920@sigill.intra.peff.net>
References: <4FB9F92D.8000305@alum.mit.edu>
 <20120521174525.GA22643@sigill.intra.peff.net>
 <20120521221417.GA22664@sigill.intra.peff.net>
 <20120521235219.GA5589@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin Fick <mfick@codeaurora.org>,
	git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 22 02:08:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWcdo-000301-R4
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 02:07:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756755Ab2EVAHv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 20:07:51 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51282
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751993Ab2EVAHu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 20:07:50 -0400
Received: (qmail 8637 invoked by uid 107); 22 May 2012 00:08:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 May 2012 20:08:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 May 2012 20:07:47 -0400
Content-Disposition: inline
In-Reply-To: <20120521235219.GA5589@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198164>

On Mon, May 21, 2012 at 07:52:19PM -0400, Jeff King wrote:

> Try doing "git fetch . refs/*:refs/*" in a repository with a large
> number of refs (e.g., 400K). With git v1.7.10, this takes about 9.5s on
> my machine. But using the version of git in "next" takes about 16.5s.
> Bisection points to your 432ad41 (refs: store references hierarchically,
> 2012-04-10). Perf shows sort_ref_dir and msort_with_tmp as hot spots.

A few more facts:

  - I usually compile with -O0 because I am debugging so frequently.
    With -O3, those numbers become 6.0s and 11.2s, respectively. Much
    faster, but there is still a performance regression.

  - Almost all of the refs are packed. IIRC, the packed-refs file should
    already be sorted. I wonder if we did not bother double-checking
    that before your patch, and now we do. That could explain the
    difference.

  - I don't compile with INTERNAL_QSORT. So mentioning msort_with_tmp is
    slightly confusing, as it is actually the version from libc, not
    ours IOW, it is really just qsort. But the primary culprit remains
    sort_ref_dir.

-Peff
