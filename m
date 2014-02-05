From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] repack.c: rename and unlink pack file if it exists
Date: Wed, 5 Feb 2014 15:37:40 -0500
Message-ID: <20140205203740.GA17077@sigill.intra.peff.net>
References: <xmqqwqha5twg.fsf@gitster.dls.corp.google.com>
 <20140205011632.GA3923@sigill.intra.peff.net>
 <xmqq1tzh494e.fsf@gitster.dls.corp.google.com>
 <20140205201243.GA16899@sigill.intra.peff.net>
 <xmqqsirx2teh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 05 21:37:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB9EK-0007vd-Jt
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 21:37:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbaBEUhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 15:37:46 -0500
Received: from cloud.peff.net ([50.56.180.127]:45284 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755617AbaBEUhm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 15:37:42 -0500
Received: (qmail 17191 invoked by uid 102); 5 Feb 2014 20:37:42 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Feb 2014 14:37:42 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Feb 2014 15:37:40 -0500
Content-Disposition: inline
In-Reply-To: <xmqqsirx2teh.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241656>

On Wed, Feb 05, 2014 at 12:31:34PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The minimal fix you posted below does make sense to me as a stopgap, and
> > we can look into dropping the code entirely during the next cycle. It
> > would be nice to have a test to cover this case, though.
> 
> Sounds sensible.  Run "repack -a -d" once, and then another while
> forcing it to be single threaded, or something?

Certainly that's the way to trigger the code, but doing this:

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index b45bd1e..6647ba1 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -162,7 +162,12 @@ test_expect_success 'objects made unreachable by grafts only are kept' '
 	git reflog expire --expire=$test_tick --expire-unreachable=$test_tick --all &&
 	git repack -a -d &&
 	git cat-file -t $H1
-	'
+'
+
+test_expect_success 'repack can handle generating the same pack again' '
+	git -c pack.threads=1 repack -ad &&
+	git -c pack.threads=1 repack -ad
+'
 
 test_done
 

...does not seem to fail, and it does not seem to leave any cruft in
place. So maybe I am misunderstanding the thing the patch is meant to
fix. Is it that we simply do not replace the pack in this instance?

I guess we would have to generate a pack with the identical set of
objects, then, but somehow different in its pack parameters (perhaps
turning off deltas?).

-Peff
