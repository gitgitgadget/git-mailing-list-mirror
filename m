Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E00891FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 21:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753999AbcLNVTN (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 16:19:13 -0500
Received: from cloud.peff.net ([104.130.231.41]:56689 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752823AbcLNVTN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 16:19:13 -0500
Received: (qmail 23431 invoked by uid 109); 14 Dec 2016 21:12:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Dec 2016 21:12:32 +0000
Received: (qmail 29098 invoked by uid 111); 14 Dec 2016 21:13:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Dec 2016 16:13:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Dec 2016 16:12:29 -0500
Date:   Wed, 14 Dec 2016 16:12:29 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, bburky@bburky.com,
        gitster@pobox.com, jrnieder@gmail.com
Subject: Re: [PATCH v9 5/5] transport: add from_user parameter to
 is_transport_allowed
Message-ID: <20161214211229.mpgu3hahlfbdxys6@sigill.intra.peff.net>
References: <1480636862-40489-1-git-send-email-bmwill@google.com>
 <1481679637-133137-1-git-send-email-bmwill@google.com>
 <1481679637-133137-6-git-send-email-bmwill@google.com>
 <20161214164050.uxk434kzhw6au4c2@sigill.intra.peff.net>
 <20161214201323.GC20063@google.com>
 <20161214203349.6ym3v2ny2gonovx2@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161214203349.6ym3v2ny2gonovx2@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 14, 2016 at 03:33:49PM -0500, Jeff King wrote:

> One other "simple" fix is at the moment we parse http-alternates, to
> parse the URL ourself and check the policy. Like:
> [...]
> I may have convinced myself this is a reasonable approach.

So here it is in patch form, with a test.

I also took a look at how bad it would be to plumb through the "this is
an alternate" flag. And it's actually a little nasty, because the
http-walker isn't calling get_active_slot() itself. It's relying on
http_get_file() and other wrappers. The recent http_get_options makes
this slightly less terrible, but I'd still rather avoid infecting the
general http code that is used for the smart-http code paths.

So I think this patch on top of your series, plus the other minor fixes
we've discussed, the topic should be ready for 'next'.

-- >8 --
Subject: http: respect protocol.*.allow=user for http-alternates

The http-walker may fetch the http-alternates (or
alternates) file from a remote in order to find more
objects. This should count as a "not from the user" use of
the protocol. But because we implement the redirection
ourselves and feed the new URL to curl, it will use the
CURLOPT_PROTOCOLS rules, not the more restrictive
CURLOPT_REDIR_PROTOCOLS.

The ideal solution would be for each curl request we make to
know whether or not is directly from the user or part of an
alternates redirect, and then set CURLOPT_PROTOCOLS as
appropriate. However, that would require plumbing that
information through all of the various layers of the http
code.

Instead, let's check the protocol at the source: when we are
parsing the remote http-alternates file. The only downside
is that if there's any mismatch between what protocol we
think it is versus what curl thinks it is, it could violate
the policy.

To address this, we'll make the parsing err on the picky
side, and only allow protocols that it can parse
definitively. So for example, you can't elude the "http"
policy by asking for "HTTP://", even though curl might
handle it; we would reject it as unknown. The only unsafe
case would be if you have a URL that starts with "http://"
but curl interprets as another protocol. That seems like an
unlikely failure mode (and we are still protected by our
base CURLOPT_PROTOCOL setting, so the worst you could do is
trigger one of https, ftp, or ftps).

Signed-off-by: Jeff King <peff@peff.net>
---
I actually do reject "HTTP://" here, though I suspect curl does take it.
I notice that you cannot ask to clone "HTTP://..." in the first place,
as our remote-helper interface is case sensitive (or maybe it would even
respect "HTTP://" on a case-insensitive file system!).

Possibly we should be more consistent about down-casing protocols when
comparing them, but I'm not sure if anybody actually cares in practice.

 http-walker.c              | 52 ++++++++++++++++++++++++++++++++++++----------
 t/t5550-http-fetch-dumb.sh | 10 +++++++++
 2 files changed, 51 insertions(+), 11 deletions(-)

diff --git a/http-walker.c b/http-walker.c
index c2f81cd6a..b34b6ace7 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -3,6 +3,7 @@
 #include "walker.h"
 #include "http.h"
 #include "list.h"
+#include "transport.h"
 
 struct alt_base {
 	char *base;
@@ -160,6 +161,32 @@ static void prefetch(struct walker *walker, unsigned char *sha1)
 #endif
 }
 
+static int is_alternate_allowed(const char *url)
+{
+	const char *protocols[] = {
+		"http", "https", "ftp", "ftps"
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(protocols); i++) {
+		const char *end;
+		if (skip_prefix(url, protocols[i], &end) &&
+		    starts_with(end, "://"))
+			break;
+	}
+
+	if (i >= ARRAY_SIZE(protocols)) {
+		warning("ignoring alternate with unknown protocol: %s", url);
+		return 0;
+	}
+	if (!is_transport_allowed(protocols[i], 0)) {
+		warning("ignoring alternate with restricted protocol: %s", url);
+		return 0;
+	}
+
+	return 1;
+}
+
 static void process_alternates_response(void *callback_data)
 {
 	struct alternates_request *alt_req =
@@ -274,17 +301,20 @@ static void process_alternates_response(void *callback_data)
 				struct strbuf target = STRBUF_INIT;
 				strbuf_add(&target, base, serverlen);
 				strbuf_add(&target, data + i, posn - i - 7);
-				warning("adding alternate object store: %s",
-					target.buf);
-				newalt = xmalloc(sizeof(*newalt));
-				newalt->next = NULL;
-				newalt->base = strbuf_detach(&target, NULL);
-				newalt->got_indices = 0;
-				newalt->packs = NULL;
-
-				while (tail->next != NULL)
-					tail = tail->next;
-				tail->next = newalt;
+
+				if (is_alternate_allowed(target.buf)) {
+					warning("adding alternate object store: %s",
+						target.buf);
+					newalt = xmalloc(sizeof(*newalt));
+					newalt->next = NULL;
+					newalt->base = strbuf_detach(&target, NULL);
+					newalt->got_indices = 0;
+					newalt->packs = NULL;
+
+					while (tail->next != NULL)
+						tail = tail->next;
+					tail->next = newalt;
+				}
 			}
 		}
 		i = posn + 1;
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 22011f0b6..c0ee29c65 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -360,5 +360,15 @@ test_expect_success 'http-alternates cannot point at funny protocols' '
 		clone "$HTTPD_URL/dumb/evil.git" evil-file
 '
 
+test_expect_success 'http-alternates triggers not-from-user protocol check' '
+	echo "$HTTPD_URL/dumb/victim.git/objects" \
+		>"$evil/objects/info/http-alternates" &&
+	test_config_global http.followRedirects true &&
+	test_must_fail git -c protocol.http.allow=user \
+		clone $HTTPD_URL/dumb/evil.git evil-user &&
+	git -c protocol.http.allow=always \
+		clone $HTTPD_URL/dumb/evil.git evil-user
+'
+
 stop_httpd
 test_done
-- 
2.11.0.341.g202cd3142

