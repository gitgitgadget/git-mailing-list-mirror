From: Jeff King <peff@peff.net>
Subject: Re: error: git-remote-https died of signal 13
Date: Sun, 24 Nov 2013 10:54:39 -0500
Message-ID: <20131124155439.GA8047@sigill.intra.peff.net>
References: <5290D994.9040505@googlemail.com>
 <20131124065400.GB5535@sigill.intra.peff.net>
 <5291F70A.7070508@googlemail.com>
 <20131124133356.GA3507@sigill.intra.peff.net>
 <529214D7.1030203@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Stenberg <daniel@haxx.se>,
	GIT Mailing-list <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Nov 24 16:55:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vkc1V-0005pO-L8
	for gcvg-git-2@plane.gmane.org; Sun, 24 Nov 2013 16:55:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752650Ab3KXPyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Nov 2013 10:54:41 -0500
Received: from cloud.peff.net ([50.56.180.127]:44850 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752427Ab3KXPyl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Nov 2013 10:54:41 -0500
Received: (qmail 11774 invoked by uid 102); 24 Nov 2013 15:54:40 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 24 Nov 2013 09:54:40 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Nov 2013 10:54:39 -0500
Content-Disposition: inline
In-Reply-To: <529214D7.1030203@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238262>

[+cc Daniel, who worked on the curl fix]

On Sun, Nov 24, 2013 at 04:01:43PM +0100, Stefan Beller wrote:

> On 24.11.2013 14:33, Jeff King wrote:
> > On Sun, Nov 24, 2013 at 01:54:34PM +0100, Stefan Beller wrote:
> > 
> >> Here is the output of 
> >> sb@sb:/tmp$ GIT_TRANSPORT_HELPER_DEBUG=1 git clone https://github.com/Bertram25/ValyriaTear.git tmp
> > 
> > Thanks. I think I see what is going on.
> > 
> > We finish the helper conversation here:
> > 
> >> Checking connectivity... done.
> >> Debug: Disconnecting.
> >> error: git-remote-https died of signal 13
> >> sb@sb:/tmp$ 
> > 
> > which means that remote-https is trying to exit, and is cleaning up any
> > curl connections. The actual SIGPIPE in the strace is here:
> > 
> > [pid 28319] write(3, "\25\3\2\0...[binary goo]...", 27) = -1 EPIPE (Broken pipe)
> > 
> > and if you walk backwards, fd 3 is:
> > 
> >   [pid 28319] socket(PF_INET, SOCK_STREAM, IPPROTO_TCP) = 3
> >   ...
> >   [pid 28319] connect(3, {sa_family=AF_INET,
> >                           sin_port=htons(443),
> >                           sin_addr=inet_addr("192.30.252.131")}, 16
> >                           ) = -1 EINPROGRESS (Operation now in progress)
> > 
> > So it's sending binary junk to the https socket while trying to exit,
> > which makes me guess that it's something to do with terminating the SSL
> > session, but the server has already hung up. Which would make it a curl
> > problem.
> > 
> > Googling "curl sigpipe" seems to come up with a report of this exact
> > case:
> > 
> >   http://curl.haxx.se/mail/archive-2013-01/0003.html
> 
> I cannot reproduce the error using the curl command from that site.
> curl returns with 0.
> 
> > 
> > with a bug opened here:
> > 
> >   http://sourceforge.net/p/curl/bugs/1180/
> > 
> > Looks like the fix went into curl 7.32.0. I have 7.33.0, which seems
> > fine. Can you confirm that your libcurl is a bit older?
> > 
> 
> dpkg -l |grep curl
> ii  curl                                      7.32.0-1ubuntu1                            amd64        command line tool for transferring data with URL syntax
> ii  libcurl3:amd64                            7.32.0-1ubuntu1                            amd64        easy-to-use client-side URL transfer library (OpenSSL flavour)
> ii  libcurl3-gnutls:amd64                     7.32.0-1ubuntu1                            amd64        easy-to-use client-side URL transfer library (GnuTLS flavour)
> ii  libcurl4-openssl-dev                      7.32.0-1ubuntu1                            amd64        development files and documentation for libcurl (OpenSSL flavour)
> ii  python-pycurl                             7.19.0-5ubuntu8                            amd64        Python bindings to libcurl

Hmm. The fix in curl's 7d80ed64e435155 seems to involve strategically
placed calls to ignore SIGPIPE. I wonder if there is another spot that
needs similar treatment. It looks like curl_easy_cleanup is covered,
though, and that's where I would expect problem to come.

It would be interesting to see a backtrace from remote-curl when we get
the SIGPIPE. Doing so would be slightly tricky; instrumenting with the
patch below may be enough.

Another thought is that the curl fix seems to only kick in when built
with openssl support.  I'm not sure I understand how ubuntu's packaging
of curl uses gnutls versus openssl for the shared library. That may be
related.

-Peff

---
diff --git a/http.c b/http.c
index bcf54aa..ac709cc 100644
--- a/http.c
+++ b/http.c
@@ -473,13 +473,17 @@ void http_cleanup(void)
 {
 	struct active_request_slot *slot = active_queue_head;
 
+	warning("in http_cleanup");
 	while (slot != NULL) {
 		struct active_request_slot *next = slot->next;
 		if (slot->curl != NULL) {
 #ifdef USE_CURL_MULTI
+			warning("calling curl_multi_remove_handle");
 			curl_multi_remove_handle(curlm, slot->curl);
 #endif
+			warning("calling curl_easy_cleanup on slot");
 			curl_easy_cleanup(slot->curl);
+			warning("curl_easy_cleanup done");
 		}
 		free(slot);
 		slot = next;
@@ -487,13 +491,19 @@ void http_cleanup(void)
 	active_queue_head = NULL;
 
 #ifndef NO_CURL_EASY_DUPHANDLE
+	warning("calling curl_easy_cleanup on default");
 	curl_easy_cleanup(curl_default);
+	warning("curl_easy_cleanup done");
 #endif
 
 #ifdef USE_CURL_MULTI
+	warning("calling curl_multi_cleanup");
 	curl_multi_cleanup(curlm);
+	warning("curl_multi_cleanup done");
 #endif
+	warning("calling curl_global_cleanup");
 	curl_global_cleanup();
+	warning("curl_global_cleanup done");
 
 	curl_slist_free_all(pragma_header);
 	pragma_header = NULL;
