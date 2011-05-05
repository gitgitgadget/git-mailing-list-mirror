From: Jeff King <peff@peff.net>
Subject: Re: t5541: Bad file descriptor
Date: Thu, 5 May 2011 02:18:45 -0400
Message-ID: <20110505061845.GC29033@sigill.intra.peff.net>
References: <3340686A-18D8-4279-87F0-580262DD4DFA@gernhardtsoftware.com>
 <7voc3hbtgu.fsf@alter.siamese.dyndns.org>
 <20110505054611.GA29033@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 05 08:18:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHrtl-0000pE-HA
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 08:18:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623Ab1EEGSs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 02:18:48 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47658
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751550Ab1EEGSr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 02:18:47 -0400
Received: (qmail 27702 invoked by uid 107); 5 May 2011 06:20:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 05 May 2011 02:20:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 May 2011 02:18:45 -0400
Content-Disposition: inline
In-Reply-To: <20110505054611.GA29033@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172802>

[argh, resend, I meant to cc Johannes Sixt]

On Thu, May 05, 2011 at 01:46:11AM -0400, Jeff King wrote:

> On Wed, May 04, 2011 at 10:35:13PM -0700, Junio C Hamano wrote:
> 
> > Brian Gernhardt <brian@gernhardtsoftware.com> writes:
> > 
> > > I haven't had a lot of time to track down it down until today, but I've
> > > been getting failures in t5541-http-push-.sh.  Several tests fail with
> > > the error "fatal: write error: Bad file descriptor".
> > 
> > A wild guess.
> > 
> > Does it help if you cherry-picked 1e41827 (http: clear POSTFIELDS when
> > initializing a slot, 2011-04-26) on top of the faulty commit?
> 
> I think that 09c9957 (send-pack: avoid deadlock when pack-object dies
> early, 2011-04-25) is totally broken.
> 
> Looking back at my tests, I only tested the case where pack-objects
> fails. And it seems we totally broke the case where the push is supposed
> to succeed.
> 
> Still investigating...

OK, embarrassing. 09c9957 completely breaks smart http pushing. My
testing of Johannes' patch was completely focused on the error case, and
I didn't have a single test for the non-error case. And on top of that,
we _have_ nice tests in the test suite to catch this, but obviously
neither I, nor Johannes, nor Junio were running them (because they need
apache installed and GIT_TEST_HTTPD set).

Ugh.

This patch on top of 09c9957 should fix it.

-- >8 --
Subject: [PATCH] send-pack: unbreak push over stateless rpc

Commit 09c9957 (send-pack: avoid deadlock when pack-object
dies early, 2011-04-25) attempted to fix a hang in the
stateless rpc case by closing a file descriptor early, but
we still need that descriptor.

Basically the deadlock can happen when pack-objects fails,
and the descriptor to upstream is left open. We never send
the pack, so the upstream is left waiting for us to say
something, and we are left waiting for upstream to close the
connection.

In the non-rpc case, our descriptor points straight to the
upstream. We hand it off to run-command, which takes
ownership and closes the descriptor after pack-objects
finishes (whether it succeeds or not).

Commit 09c9957 tried to emulate that in the rpc case. That
isn't right, though. We actually have a descriptor going
back to the remote-helper, and we need to keep using it
after pack-objects is finished. Closing it early completely
breaks pushing via smart-http.

We still need to do something on error to signal the
remote-helper that we won't be sending any pack data
(otherwise we get the deadlock).  In an ideal world, we
would send a special packet back that says "Sorry, there was
an error". But the remote-helper doesn't understand any such
packet, so the best we can do is close the descriptor and
let it report that we hung up unexpectedly.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-send-pack.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 6516288..3e70795 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -97,7 +97,6 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
 		free(buf);
 		close(po.out);
 		po.out = -1;
-		close(fd);
 	}
 
 	if (finish_command(&po))
@@ -519,6 +518,8 @@ int send_pack(struct send_pack_args *args,
 		if (pack_objects(out, remote_refs, extra_have, args) < 0) {
 			for (ref = remote_refs; ref; ref = ref->next)
 				ref->status = REF_STATUS_NONE;
+			if (args->stateless_rpc)
+				close(out);
 			if (use_sideband)
 				finish_async(&demux);
 			return -1;
-- 
1.7.5.406.gfbb2

