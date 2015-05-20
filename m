From: Jeff King <peff@peff.net>
Subject: [PATCH v2 0/3] fix http deadlock on giant ref negotiations
Date: Wed, 20 May 2015 03:35:26 -0400
Message-ID: <20150520073526.GA16784@peff.net>
References: <20150515062901.GA30768@peff.net>
 <20150515063339.GB30890@peff.net>
 <xmqqegmhhf9p.fsf@gitster.dls.corp.google.com>
 <55563AD5.4090105@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dennis Kaarsemaker <dennis@kaarsemaker.net>, gitster@pobox.com,
	git@vger.kernel.org
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
X-From: git-owner@vger.kernel.org Wed May 20 09:35:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuyXQ-0000oE-Ao
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 09:35:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946AbbETHfb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 03:35:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:33028 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751182AbbETHfa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 03:35:30 -0400
Received: (qmail 18880 invoked by uid 102); 20 May 2015 07:35:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 May 2015 02:35:30 -0500
Received: (qmail 21438 invoked by uid 107); 20 May 2015 07:35:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 May 2015 03:35:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 May 2015 03:35:26 -0400
Content-Disposition: inline
In-Reply-To: <55563AD5.4090105@linuxfoundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269442>

On Fri, May 15, 2015 at 02:28:37PM -0400, Konstantin Ryabitsev wrote:

> On 15/05/15 02:22 PM, Junio C Hamano wrote:
> > Also, is it worth allocating small and then growing up to the maximum?
> > I think this only relays one request at a time anyway, and I suspect
> > that a single 1MB allocation at the first call kept getting reused
> > may be sufficient (and much simpler).
> 
> Does it make sense to make that configurable via an env variable at all?
> I suspect the vast majority of people would not hit this bug unless they
> are dealing with repositories polluted with hundreds of refs created by
> automation (like the codeaurora chromium repo).
> 
> E.g. can be set via an Apache directive like
> 
> SetEnv FOO_MAX_SIZE 2048
> 
> The backend can then be configured to emit an error message when the
> spool size is exhausted saying "foo exhausted, increase FOO_MAX_SIZE to
> allow for moar foo."

Yeah, that was the same conclusion I came to elsewhere in the thread.
Here's a re-roll:

  [1/3]: http-backend: fix die recursion with custom handler
  [2/3]: t5551: factor out tag creation
  [3/3]: http-backend: spool ref negotiation requests to buffer

It makes the size configurable (either through the environment, which is
convenient for setting via Apache; or through the config, which is
convenient if you have one absurdly-sized repo). It mentions the
variable name when it barfs into the Apache log. I also bumped the
default to 10MB, which I think should be enough to handle even
ridiculous cases.

I also adapted Dennis's test into the third patch. Beware that it's
quite slow to run (and is protected by the "EXPENSIVE" prerequisite).
Patch 2 is new, and just refactors the script to make adding the new
test easier.

I really wanted to add a test like:

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index e2a2fa1..1fff812 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -273,6 +273,16 @@ test_expect_success 'large fetch-pack requests can be split across POSTs' '
 	test_line_count = 2 posts
 '
 
+test_expect_success 'http-backend does not buffer arbitrarily large requests' '
+	test_when_finished "(
+		cd \"$HTTPD_DOCUMENT_ROOT_PATH/repo.git\" &&
+		test_unconfig http.maxrequestbuffer
+	)" &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" \
+		config http.maxrequestbuffer 100 &&
+	test_must_fail git clone $HTTPD_URL/smart/repo.git foo.git
+'
+
 test_expect_success EXPENSIVE 'http can handle enormous ref negotiation' '
 	(
 		cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&

to test that the maxRequestBuffer code does indeed work. Unfortunately,
even though the server behaves reasonably in this case, the client ends
up hanging forever. I'm not sure there is a simple solution to that; I
think it is a protocol issue where remote-http is waiting for fetch-pack
to speak, but fetch-pack is waiting for more data from the remote.

Personally, I think I'd be much more interested in pursuing a saner,
full duplex http solution like git-over-websockets than trying to iron
out all of the corner cases in the stateless-rpc protocol.

-Peff
