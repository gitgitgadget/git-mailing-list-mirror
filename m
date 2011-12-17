From: Jeff King <peff@peff.net>
Subject: [PATCH] make "git push -v" actually verbose
Date: Sat, 17 Dec 2011 04:37:15 -0500
Message-ID: <20111217093713.GA2073@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 17 10:37:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rbqhq-0006x4-NX
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 10:37:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751671Ab1LQJhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Dec 2011 04:37:22 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44741
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751241Ab1LQJhT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 04:37:19 -0500
Received: (qmail 11495 invoked by uid 107); 17 Dec 2011 09:44:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 17 Dec 2011 04:44:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Dec 2011 04:37:15 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187361>

Providing a single "-v" to "git push" currently does
nothing. Giving two flags ("git push -v -v") turns on the
first level of verbosity.

This is caused by a regression introduced in 8afd8dc (push:
support multiple levels of verbosity, 2010-02-24). Before
the series containing 8afd8dc, the verbosity handling for
fetching and pushing was completely separate. Commit bde873c
refactored the verbosity handling out of the fetch side, and
then 8afd8dc converted push to use the refactored code.

However, the fetch and push sides numbered and passed along
their verbosity levels differently. For both, a verbosity
level of "-1" meant "quiet", and "0" meant "default output".
But from there they differed.

For fetch, a verbosity level of "1" indicated to the "fetch"
program that it should make the status table slightly more
verbose, showing up-to-date entries. A verbosity level of
"2" meant that we should pass a verbose flag to the
transport; in the case of fetch-pack, this displays protocol
debugging information.

As a result, the refactored code in bde873c checks for
"verbosity >= 2", and only then passes it on to the
transport. From the transport code's perspective, a
verbosity of 0 or 1 both meant "0".

Push, on the other hand, does not show its own status table;
that is always handled by the transport layer or below
(originally send-pack itself, but these days it is done by
the transport code). So a verbosity level of 1 meant that we
should pass the verbose flag to send-pack, so that it knows
we want a verbose status table. However, once 8afd8dc
switched it to the refactored fetch code, a verbosity level
of 1 was now being ignored.  Thus, you needed to
artificially bump the verbosity to 2 (via "-v -v") to have
any effect.

We can fix this by letting the transport code know about the
true verbosity level (i.e., let it distinguish level 0 or
1).

We then have to also make an adjustment to any transport
methods that assumed "verbose > 0" meant they could spew
lots of debugging information. Before, they could only get
"0" or "2", but now they will also receive "1". They need to
adjust their condition for turning on such spew from
"verbose > 0" to "verbose > 1".

Signed-off-by: Jeff King <peff@peff.net>
---
This is an old bug, obviously, but it has been bugging me
off and on for the past year, so I finally decided to track
it down.

Sorry for the epic-length commit message. It was a subtle
bug, and the actual patch makes it very difficult to
understand why it works and doesn't regress the fetch case.
Hopefully it made sense. :)

 transport.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/transport.c b/transport.c
index 51814b5..48002b9 100644
--- a/transport.c
+++ b/transport.c
@@ -215,7 +215,7 @@ static struct ref *get_refs_via_rsync(struct transport *transport, int for_push)
 	rsync.argv = args;
 	rsync.stdout_to_stderr = 1;
 	args[0] = "rsync";
-	args[1] = (transport->verbose > 0) ? "-rv" : "-r";
+	args[1] = (transport->verbose > 1) ? "-rv" : "-r";
 	args[2] = buf.buf;
 	args[3] = temp_dir.buf;
 	args[4] = NULL;
@@ -268,7 +268,7 @@ static int fetch_objs_via_rsync(struct transport *transport,
 	rsync.argv = args;
 	rsync.stdout_to_stderr = 1;
 	args[0] = "rsync";
-	args[1] = (transport->verbose > 0) ? "-rv" : "-r";
+	args[1] = (transport->verbose > 1) ? "-rv" : "-r";
 	args[2] = "--ignore-existing";
 	args[3] = "--exclude";
 	args[4] = "info";
@@ -351,7 +351,7 @@ static int rsync_transport_push(struct transport *transport,
 	args[i++] = "-a";
 	if (flags & TRANSPORT_PUSH_DRY_RUN)
 		args[i++] = "--dry-run";
-	if (transport->verbose > 0)
+	if (transport->verbose > 1)
 		args[i++] = "-v";
 	args[i++] = "--ignore-existing";
 	args[i++] = "--exclude";
@@ -527,7 +527,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.lock_pack = 1;
 	args.use_thin_pack = data->options.thin;
 	args.include_tag = data->options.followtags;
-	args.verbose = (transport->verbose > 0);
+	args.verbose = (transport->verbose > 1);
 	args.quiet = (transport->verbose < 0);
 	args.no_progress = !transport->progress;
 	args.depth = data->options.depth;
@@ -981,7 +981,7 @@ int transport_set_option(struct transport *transport,
 void transport_set_verbosity(struct transport *transport, int verbosity,
 	int force_progress)
 {
-	if (verbosity >= 2)
+	if (verbosity >= 1)
 		transport->verbose = verbosity <= 3 ? verbosity : 3;
 	if (verbosity < 0)
 		transport->verbose = -1;
-- 
1.7.7.4.13.g57bf4
