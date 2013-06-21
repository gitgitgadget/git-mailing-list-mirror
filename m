From: Jeff King <peff@peff.net>
Subject: Re: [BUG] clone: regression in error messages in master
Date: Fri, 21 Jun 2013 03:05:39 -0400
Message-ID: <20130621070539.GA31552@sigill.intra.peff.net>
References: <CALkWK0n7S8s-ABQ1qV5JSsyhYo6=rmK1UT+uYW9hjjeWjambug@mail.gmail.com>
 <20130620133422.GA18200@sigill.intra.peff.net>
 <CALkWK0k8-go979S9sMytBpqs_C9Jm6q6thqwHa4-GX-e5Czx=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 21 09:05:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpvPo-0007rR-Oy
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 09:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758678Ab3FUHFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 03:05:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:35852 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751631Ab3FUHFo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 03:05:44 -0400
Received: (qmail 20524 invoked by uid 102); 21 Jun 2013 07:06:43 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 21 Jun 2013 02:06:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Jun 2013 03:05:39 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0k8-go979S9sMytBpqs_C9Jm6q6thqwHa4-GX-e5Czx=g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228581>

On Fri, Jun 21, 2013 at 12:14:33PM +0530, Ramkumar Ramachandra wrote:

> Jeff King wrote:
> > So I'm not sure if there is a better option than reverting 81d340d4 and
> > living with the lesser of two evils (no good message when the helper
> > dies silently).
> 
> I dug around, but I still can't justify that there is no better
> option.  Could you write a commit message for this?

I think it is something like this:

-- >8 --
Subject: [PATCH] transport-helper: be quiet on read errors from helpers

Prior to commit 81d340d4, we did not print any error message
if a remote transport helper died unexpectedly. If a helper
did not print any error message (e.g., because it crashed),
the user could be left confused. That commit tried to
rectify the situation by printing a note that the helper
exited unexpectedly.

However, this makes a much more common case worse: when a
helper does die with a useful message, we print the extra
"Reading from 'git-remote-foo failed" message. This can also
end up confusing users, as they may not even know what
remote helpers are (e.g., the fact that http support comes
through git-remote-https is purely an implementation detail
that most users do not know or care about).

Since we do not have a good way of knowing whether the
helper printed a useful error, and since the common failure
mode is for it to do so, let's default to remaining quiet.
Debuggers can dig further by setting GIT_TRANSPORT_HELPER_DEBUG.

Signed-off-by: Jeff King <peff@peff.net>
---
Note that I haven't thought too hard about this; there may be a way to
detect for specific operations that we were expecting more data from the
helper and didn't get it. But even if we do want to go that route, I
think reverting the change to recvline_fh is probably going to be the
first step.

 t/t5801-remote-helpers.sh | 4 +---
 transport-helper.c        | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 4899af3..8c4c539 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -210,9 +210,7 @@ test_expect_success 'proper failure checks for pushing' '
 	(GIT_REMOTE_TESTGIT_FAILURE=1 &&
 	export GIT_REMOTE_TESTGIT_FAILURE &&
 	cd local &&
-	test_must_fail git push --all 2> error &&
-	cat error &&
-	grep -q "Reading from helper .git-remote-testgit. failed" error
+	test_must_fail git push --all
 	)
 '
 
diff --git a/transport-helper.c b/transport-helper.c
index 06c08a1..db9bd18 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -56,7 +56,7 @@ static int recvline_fh(FILE *helper, struct strbuf *buffer, const char *name)
 	if (strbuf_getline(buffer, helper, '\n') == EOF) {
 		if (debug)
 			fprintf(stderr, "Debug: Remote helper quit.\n");
-		die("Reading from helper 'git-remote-%s' failed", name);
+		exit(128);
 	}
 
 	if (debug)
-- 
1.8.3.rc2.14.g7eee6b3
