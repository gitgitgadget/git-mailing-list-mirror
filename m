From: Jeff King <peff@peff.net>
Subject: Re: error: git-remote-https died of signal 13
Date: Mon, 25 Nov 2013 09:46:11 -0500
Message-ID: <20131125144611.GA23802@sigill.intra.peff.net>
References: <5290D994.9040505@googlemail.com>
 <20131124065400.GB5535@sigill.intra.peff.net>
 <5291F70A.7070508@googlemail.com>
 <20131124133356.GA3507@sigill.intra.peff.net>
 <529214D7.1030203@googlemail.com>
 <20131124155439.GA8047@sigill.intra.peff.net>
 <52922A22.2090109@googlemail.com>
 <20131125063945.GA16313@sigill.intra.peff.net>
 <alpine.DEB.2.00.1311250815150.27300@tvnag.unkk.fr>
 <20131125143213.GA22642@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Mon Nov 25 15:46:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VkxQm-0002rl-Q0
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 15:46:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756700Ab3KYOqP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 09:46:15 -0500
Received: from cloud.peff.net ([50.56.180.127]:45333 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754021Ab3KYOqN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 09:46:13 -0500
Received: (qmail 11626 invoked by uid 102); 25 Nov 2013 14:46:12 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Nov 2013 08:46:12 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Nov 2013 09:46:11 -0500
Content-Disposition: inline
In-Reply-To: <20131125143213.GA22642@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238311>

On Mon, Nov 25, 2013 at 09:32:13AM -0500, Jeff King wrote:

> > But I then decided that if a 3rd library has one way to generate
> > SIGPIPE it may very well have another in a separate spot so I decided
> > to do the wrap at the top level immediately in the entry point when
> > getting called by the application. Following that, the SIGPIPE
> > ignore/restore should rather be made in curl_multi_cleanup.
> 
> Unfortunately, we need an actual SessionHandle to know whether it is OK
> to reset signals at all. There may be a more elegant way of checking
> that, but here's the patch series I came up with.

Scratch that.  I had originally written something like:

  if (conn->data)
    sigpipe_ignore(conn->data, &pipe);
  Curl_disconnect(conn, ...);
  sigpipe_restore(&pipe);

but while sending it out, I realized that the "data" we attach to each
connection when we close it is just the multi->closure_handle. So I was
able to hoist the check out to curl_multi_cleanup (and that's what I
just sent).

-Peff
