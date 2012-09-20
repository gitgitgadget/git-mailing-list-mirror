From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] remote-curl: let users turn off smart http
Date: Thu, 20 Sep 2012 17:30:58 -0400
Message-ID: <20120920213058.GA23904@sigill.intra.peff.net>
References: <20120920165938.GB18655@sigill.intra.peff.net>
 <20120920170517.GB18981@sigill.intra.peff.net>
 <7va9wkbmyc.fsf@alter.siamese.dyndns.org>
 <20120920181231.GA19204@sigill.intra.peff.net>
 <7vzk4ka6dp.fsf@alter.siamese.dyndns.org>
 <20120920205107.GB22284@sigill.intra.peff.net>
 <7vd31g9z13.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 23:31:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEoL3-0003nU-Aq
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 23:31:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755415Ab2ITVbE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 17:31:04 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51935 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753965Ab2ITVbB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 17:31:01 -0400
Received: (qmail 25881 invoked by uid 107); 20 Sep 2012 21:31:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Sep 2012 17:31:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Sep 2012 17:30:58 -0400
Content-Disposition: inline
In-Reply-To: <7vd31g9z13.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206096>

On Thu, Sep 20, 2012 at 02:15:20PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I'm half-tempted to just drop the config entirely, leave
> > GIT_SMART_HTTP=false as an escape hatch, and see if anybody even cares.
> 
> Sounds like a very attractive minimalistic way to go forward.  We
> can always add per-remote configuration when we find it necessary,
> but once we add support, we cannot easily yank it out.

Like this?

-- >8 --
Subject: [PATCH] remote-curl: let users turn off smart http

Usually there is no need for users to specify whether an
http remote is smart or dumb; the protocol is designed so
that a single initial request is made, and the client can
determine the server's capability from the response.

However, some misconfigured dumb-only servers may not like
the initial request by a smart client, as it contains a
query string. Until recently, commit 703e6e7 worked around
this by making a second request. However, that commit was
recently reverted due to its side effect of masking the
initial request's error code.

Since git has had that workaround for several years, we
don't know exactly how many such misconfigured servers are
out there. The reversion of 703e6e7 assumes they are rare
enough not to worry about. Still, that reversion leaves
somebody who does run into such a server with no escape
hatch at all. Let's give them an environment variable they
can tweak to perform the "dumb" request.

This is intentionally not a documented interface. It's
overly simple and is really there for debugging in case
somebody does complain about git not working with their
server. A real user-facing interface would entail a
per-remote or per-URL config variable.

Signed-off-by: Jeff King <peff@peff.net>
---
 remote-curl.c         |  3 ++-
 t/t5551-http-fetch.sh | 12 ++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/remote-curl.c b/remote-curl.c
index c0b98cc..7b19ebb 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -102,7 +102,8 @@ static struct discovery* discover_refs(const char *service)
 	free_discovery(last);
 
 	strbuf_addf(&buffer, "%sinfo/refs", url);
-	if (!prefixcmp(url, "http://") || !prefixcmp(url, "https://")) {
+	if ((!prefixcmp(url, "http://") || !prefixcmp(url, "https://")) &&
+	     git_env_bool("GIT_SMART_HTTP", 1)) {
 		maybe_smart = 1;
 		if (!strchr(url, '?'))
 			strbuf_addch(&buffer, '?');
diff --git a/t/t5551-http-fetch.sh b/t/t5551-http-fetch.sh
index 2db5c35..8427943 100755
--- a/t/t5551-http-fetch.sh
+++ b/t/t5551-http-fetch.sh
@@ -129,6 +129,18 @@ test_expect_success 'clone from auth-only-for-push repository' '
 	test_cmp expect actual
 '
 
+test_expect_success 'disable dumb http on server' '
+	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH/repo.git" \
+		config http.getanyfile false
+'
+
+test_expect_success 'GIT_SMART_HTTP can disable smart http' '
+	(GIT_SMART_HTTP=0 &&
+	 export GIT_SMART_HTTP &&
+	 cd clone &&
+	 test_must_fail git fetch)
+'
+
 test -n "$GIT_TEST_LONG" && test_set_prereq EXPENSIVE
 
 test_expect_success EXPENSIVE 'create 50,000 tags in the repo' '
-- 
1.7.11.7.15.g085c6bd
