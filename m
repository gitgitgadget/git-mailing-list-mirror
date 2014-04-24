From: Jeff King <peff@peff.net>
Subject: Re: error: git-remote-https died of signal 13
Date: Thu, 24 Apr 2014 00:15:04 -0400
Message-ID: <20140424041504.GA17398@sigill.intra.peff.net>
References: <CAEHyFQLmu4GWHcd+Xd6MOikf_LJgK0dGM7VXk6h6OLsud+-Wgw@mail.gmail.com>
 <20140423065938.GB20675@sigill.intra.peff.net>
 <CAEHyFQLPYh2b5CsmadazDJG3paHL7JDY4JhT=xf=wHXhLd=EkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Stenberg <daniel@haxx.se>, git@vger.kernel.org
To: Greg M <morenzg@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 06:15:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdB47-0007Pi-DJ
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 06:15:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbaDXEPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 00:15:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:37280 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750703AbaDXEPH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 00:15:07 -0400
Received: (qmail 22467 invoked by uid 102); 24 Apr 2014 04:15:06 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 23 Apr 2014 23:15:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Apr 2014 00:15:04 -0400
Content-Disposition: inline
In-Reply-To: <CAEHyFQLPYh2b5CsmadazDJG3paHL7JDY4JhT=xf=wHXhLd=EkQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246935>

On Wed, Apr 23, 2014 at 07:49:09AM -0400, Greg M wrote:

> > The easiest way to find it is probably to attach a debugger to the
> > running git-remote-https, and get a backtrace when it dies from SIGPIPE.
> > You'll probably want to install your system's debug packages for curl,
> > too.
> >
> 
> The backtrace:
> 
> Program received signal SIGPIPE, Broken pipe.
> 0x00007fdcfd511a2d in write () from /usr/lib/libpthread.so.0
> (gdb) bt
> #0  0x00007fdcfd511a2d in write () from /usr/lib/libpthread.so.0
> #1  0x00007fdcfd81a0f6 in sock_write () from /usr/lib/libcrypto.so.1.0.0
> #2  0x00007fdcfd817edb in BIO_write () from /usr/lib/libcrypto.so.1.0.0
> #3  0x00007fdcfc662902 in ssl3_write_pending () from /usr/lib/libssl.so.1.0.0
> #4  0x00007fdcfc664b77 in ssl3_dispatch_alert () from /usr/lib/libssl.so.1.0.0
> #5  0x00007fdcfc660822 in ssl3_shutdown () from /usr/lib/libssl.so.1.0.0
> #6  0x00007fdcfd2e944e in Curl_ossl_close () from /usr/lib/libcurl.so.4
> #7  0x00007fdcfd2b6459 in Curl_disconnect () from /usr/lib/libcurl.so.4
> #8  0x00007fdcfd2c8131 in curl_multi_cleanup () from /usr/lib/libcurl.so.4
> #9  0x000000000040764b in ?? ()
> #10 0x0000000000404e4d in ?? ()
> #11 0x00007fdcfcf0fb05 in __libc_start_main () from /usr/lib/libc.so.6
> #12 0x000000000040552e in ?? ()

Thanks, that's very helpful. I wasn't able to reproduce your problem
locally, but I suspect the curl patch below may fix it:

diff --git a/lib/multi.c b/lib/multi.c
index bc93264..72e4825 100644
--- a/lib/multi.c
+++ b/lib/multi.c
@@ -1804,10 +1804,13 @@ static void close_all_connections(struct Curl_multi *multi)
 
   conn = Curl_conncache_find_first_connection(multi->conn_cache);
   while(conn) {
+    SIGPIPE_VARIABLE(pipe_st);
     conn->data = multi->closure_handle;
 
+    sigpipe_ignore(conn->data, &pipe_st);
     /* This will remove the connection from the cache */
     (void)Curl_disconnect(conn, FALSE);
+    sigpipe_restore(&pipe_st);
 
     conn = Curl_conncache_find_first_connection(multi->conn_cache);
   }

Let me know if you need any pointers on getting curl built or tested
with git.

Daniel, I think the similar fix to curl_multi_cleanup in commit a900d45
missed this code path, and we need something like the above patch. I
know you were trying to keep the SIGPIPE mess at the entrance-points to
the library, and this works against that. But we need a SessionHandle to
pass to sigpipe_ignore to look at its "no_signal" flag, and of course in
the case of multi we may have several such handles. If there's a similar
flag we can check on the multi handle, we could just cover all of
curl_multi_cleanup with a single ignore/reset pair.

-Peff
