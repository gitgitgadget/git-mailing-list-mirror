From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] http: support sending custom HTTP headers
Date: Tue, 26 Apr 2016 13:12:38 -0400
Message-ID: <20160426171238.GA7609@sigill.intra.peff.net>
References: <abe253758829795c285c2036196ebe7edd9bab34.1461589951.git.johannes.schindelin@gmx.de>
 <921e007f445476b27325c12a9e92fdd169a073b7.1461685158.git.johannes.schindelin@gmx.de>
 <xmqq8u00i9pp.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 19:12:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av6XY-0007Dx-So
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 19:12:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752143AbcDZRMm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 13:12:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:56633 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751974AbcDZRMm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 13:12:42 -0400
Received: (qmail 4508 invoked by uid 102); 26 Apr 2016 17:12:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 26 Apr 2016 13:12:41 -0400
Received: (qmail 15940 invoked by uid 107); 26 Apr 2016 17:12:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 26 Apr 2016 13:12:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Apr 2016 13:12:38 -0400
Content-Disposition: inline
In-Reply-To: <xmqq8u00i9pp.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292620>

On Tue, Apr 26, 2016 at 10:03:14AM -0700, Junio C Hamano wrote:

> > +http.extraHeader::
> > +	Pass an additional HTTP header when communicating with a server.  If
> > +	more than one such entry exists, all of them are added as extra headers.
> > +	This feature is useful e.g. to increase security, or to allow
> > +	time-limited access based on expiring tokens.
> > +
> 
> I think one-time/short-lived use case does not want to have this in
> a configuration file, and instead want to do the command line thing
> you illustrated in the proposed log message.  I however wonder if
> there are other use cases where having this in $GIT_DIR/config for
> repeated use is useful.  If there is, not being able to override a
> configured value per invocation would become a problem.
> 
> Peff, what do you think?  I vaguely recollect that you did a hack to
> one variable that declares "an empty value means discard accumulated
> values so far" or something like that, and this variable deserves a
> mechanism like that, too.

Yes, it was for credential.helper. I think the _implementation_ is a
hack (because each callback has to handle it individually), but the
user-facing part is reasonably elegant, given the constraint of not
introducing new syntax.

In this case it would be something like:

diff --git a/http.c b/http.c
index 3d662bb..a7a4be5 100644
--- a/http.c
+++ b/http.c
@@ -325,8 +325,13 @@ static int http_options(const char *var, const char *value, void *cb)
 	}
 
 	if (!strcmp("http.extraheader", var)) {
-		extra_http_headers =
-			curl_slist_append(extra_http_headers, value);
+		if (*value)
+			extra_http_headers =
+				curl_slist_append(extra_http_headers, value);
+		else {
+			curl_slist_free_all(extra_http_headers);
+			extra_http_headers = NULL;
+		}
 		return 0;
 	}
 

But I think this block (even before my patch) also needs to handle the
case where "value" is NULL (presumably by complaining with
config_error_nonbool).

-Peff
