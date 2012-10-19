From: Jeff King <peff@peff.net>
Subject: Re: Fix potential hang in https handshake.
Date: Fri, 19 Oct 2012 16:27:23 -0400
Message-ID: <20121019202723.GA24184@sigill.intra.peff.net>
References: <5080761e.IEDySUuQzlCwL6fM%szager@google.com>
 <7vd30fl736.fsf@alter.siamese.dyndns.org>
 <20121019103627.GA29366@sigill.intra.peff.net>
 <CAJo=hJvWV0WPN5rCYK-JxfaEPWp7syUM1H0w4=Eb27=50+pXjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, szager@google.com,
	git@vger.kernel.org, sop@google.com
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 22:27:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPJAQ-0006It-P7
	for gcvg-git-2@plane.gmane.org; Fri, 19 Oct 2012 22:27:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932879Ab2JSU11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2012 16:27:27 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39898 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932743Ab2JSU11 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2012 16:27:27 -0400
Received: (qmail 18479 invoked by uid 107); 19 Oct 2012 20:28:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 19 Oct 2012 16:28:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Oct 2012 16:27:23 -0400
Content-Disposition: inline
In-Reply-To: <CAJo=hJvWV0WPN5rCYK-JxfaEPWp7syUM1H0w4=Eb27=50+pXjg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208059>

On Fri, Oct 19, 2012 at 07:10:46AM -0700, Shawn O. Pearce wrote:

> > IOW, it seems like we are _already_ following the advice referenced in
> > curl's manpage. Is there some case I am missing? Confused...
> 
> The issue with the current code is sometimes when libcurl is opening a
> CONNECT style connection through an HTTP proxy it returns a crazy high
> timeout (>240 seconds) and no fds. In this case Git waits forever.
> Stefan observed that using a timeout of 50 ms in this situation to
> poll libcurl is better, as it figures out a lot more quickly that it
> is connected to the proxy and can issue the request.

Ah. That sounds like a bug in curl to me. But either way, if we want to
work around it, wouldn't the right thing be to override curl's timeout
in that instance? Like:

diff --git a/http.c b/http.c
index df9bb71..cd07cdf 100644
--- a/http.c
+++ b/http.c
@@ -631,6 +631,19 @@ void run_active_slot(struct active_request_slot *slot)
 			FD_ZERO(&excfds);
 			curl_multi_fdset(curlm, &readfds, &writefds, &excfds, &max_fd);
 
+			/*
+			 * Sometimes curl will give a really long timeout for a
+			 * CONNECT when there are no fds to read, but we can
+			 * get better results by running curl_multi_perform
+			 * more frequently.
+			 */
+			if (maxfd < 0 &&
+			    (select_timeout.tv_sec > 0 ||
+			     select_timeout.tv_usec > 50000)) {
+				select_timeout.tv_sec = 0;
+				select_timeout.tv_usec = 50000;
+			}
+
 			select(max_fd+1, &readfds, &writefds, &excfds, &select_timeout);
 		}
 	}

-Peff
