From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] http: add option to enable 100 Continue responses
Date: Wed, 9 Oct 2013 17:37:42 -0400
Message-ID: <20131009213742.GA8362@sigill.intra.peff.net>
References: <1381265287-39331-1-git-send-email-sandals@crustytoothpaste.net>
 <1381265287-39331-2-git-send-email-sandals@crustytoothpaste.net>
 <20131009193054.GA3767@sigill.intra.peff.net>
 <CAJo=hJvyorMjFYZnVwz4iZr88ewor6LuqOE-mpt4LsPyoddBqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 09 23:37:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VU1S2-00065g-3w
	for gcvg-git-2@plane.gmane.org; Wed, 09 Oct 2013 23:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753951Ab3JIVhp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Oct 2013 17:37:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:46554 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752090Ab3JIVho (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Oct 2013 17:37:44 -0400
Received: (qmail 15344 invoked by uid 102); 9 Oct 2013 21:37:44 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 09 Oct 2013 16:37:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Oct 2013 17:37:42 -0400
Content-Disposition: inline
In-Reply-To: <CAJo=hJvyorMjFYZnVwz4iZr88ewor6LuqOE-mpt4LsPyoddBqg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235844>

On Wed, Oct 09, 2013 at 02:19:36PM -0700, Shawn O. Pearce wrote:

> > I'd be more comfortable defaulting this to "on" if I understood more
> > about the original problem that led to 959dfcf and 206b099. It sounds
> > like enabling this all the time will cause annoying stalls in the
> > protocol, unless the number of non-crappy proxy implementations has
> > gotten smaller over the past few years.
> 
> It actually hasn't, not significantly.

Thanks for update; my pessimistic side assumed this was the case, but it
is always good to check. :)

> 206b099 was written because the Google web servers for
> android.googlesource.com and code.google.com do not support
> 100-continue semantics. This caused the client to stall a full 1
> second before each POST exchange. If ancestor negotiation required
> O(128) have lines to be advertised I think this was 2 or 4 POSTs,
> resulting in 2-4 second stalls above the other latency of the network
> and the server.

Yuck.

> If "Expect: 100-continue" is required for GSS-Negotiate to work then
> Git should only enable the option if the server is demanding
> GSS-Negotiate for authentication. Per 206b099 the default should still
> be off for anonymous and HTTP basic, digest, and SSL certificate
> authentication.

Part of the problem is that curl is the one handling the negotiation.
When we get a 401, I think we can ask curl_easy_getinfo to tell us which
auth methods are available (via CURLINFO_HTTPAUTH_AVAIL). But I don't
know how we decide that GSS is what's going to be used. I guess if it is
the only option, and there is no basic-auth offered?

And then in that case turn on "Expect" (or more accurately, stop
disabling it).

I don't have a GSS-enabled server to test on. Brian, can you try the
patch at the end of this message on your non-working server and see what
it outputs?

> >> +     headers = curl_slist_append(headers, http_use_100_continue ?
> >> +             "Expect: 100-continue" : "Expect:");
> >
> > Is there any point in sending the Expect: header in cases where curl
> > would not send it, though? It seems like we should assume curl does the
> > right thing most of the time, and have our option only be to override
> > curl in the negative direction.
> 
> Adding a header of "Expect:" causes curl to disable the header and
> never use it. Always supplying the header with no value prevents
> libcurl from using 100-continue on its own, which is what I fixed in
> 959dfcf.

Right. What I meant is that we do not want to unconditionally send the
"Expect: 100-continue" in the other case. IOW, we would just want:

  if (!http_use_100_continue)
          headers = curl_slist_append(headers, "Expect:");

-Peff

-- >8 --
diff --git a/http.c b/http.c
index f3e1439..e7257d7 100644
--- a/http.c
+++ b/http.c
@@ -889,6 +889,12 @@ static int http_request(const char *url, struct strbuf *type,
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
 		ret = handle_curl_result(&results);
+		if (ret == HTTP_REAUTH) {
+			long auth_avail;
+			curl_easy_getinfo(slot->curl, CURLINFO_HTTPAUTH_AVAIL,
+					  &auth_avail);
+			fprintf(stderr, "offered auth: %ld\n", auth_avail);
+		}
 	} else {
 		snprintf(curl_errorstr, sizeof(curl_errorstr),
 			 "failed to start HTTP request");
