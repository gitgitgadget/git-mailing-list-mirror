From: Jeff King <peff@peff.net>
Subject: Re: GSS-Negotiate authentication requires that all data fit into
 postbuffer
Date: Mon, 7 Oct 2013 08:02:41 -0400
Message-ID: <20131007120241.GC5792@sigill.intra.peff.net>
References: <20131006004236.GB3460@vauxhall.crustytoothpaste.net>
 <20131006105013.GA24950@LK-Perkele-VII>
 <alpine.DEB.2.00.1310061658330.6366@tvnag.unkk.fr>
 <20131006152908.GD3460@vauxhall.crustytoothpaste.net>
 <alpine.DEB.2.00.1310061737000.6366@tvnag.unkk.fr>
 <20131006174959.GE3460@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Stenberg <daniel@haxx.se>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Oct 07 14:02:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VT9WX-0005to-8T
	for gcvg-git-2@plane.gmane.org; Mon, 07 Oct 2013 14:02:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756056Ab3JGMCp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Oct 2013 08:02:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:45106 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755212Ab3JGMCo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Oct 2013 08:02:44 -0400
Received: (qmail 29595 invoked by uid 102); 7 Oct 2013 12:02:43 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 07 Oct 2013 07:02:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Oct 2013 08:02:41 -0400
Content-Disposition: inline
In-Reply-To: <20131006174959.GE3460@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235759>

On Sun, Oct 06, 2013 at 05:50:00PM +0000, brian m. carlson wrote:

> On Sun, Oct 06, 2013 at 05:38:24PM +0200, Daniel Stenberg wrote:
> > On Sun, 6 Oct 2013, brian m. carlson wrote:
> > 
> > >If there's a way to make Apache with mod_auth_kerb do that with
> > >curl, then it doesn't require a change to git, and I'm happy to
> > >make it on my end. But using the curl command line client, I don't
> > >see an Expect: 100-continue anywhere during the connection using
> > >Debian's curl 7.32.0-1.  Do I need to send a certain amount of
> > >data to see that behavior?
> > 
> > Correct, curl will enable "Expect: 100-continue" if the post size is
> > > 1024 bytes.
> 
> I've been able to reproduce this behavior with the curl command line
> client, but it looks like we disable Expect: 100-continue in git since
> some proxy servers are too stupid to understand it, according to commit
> 959dfcf.

Yeah, instead we try to make two separate requests, and assume that the
first one clears the path for any further requests. Of course that
doesn't work for auth methods that actually negotiate for each request.

We should probably make the "Expect" suppression optional for people who
know they have working systems. It would be nice to trigger it
automatically when people are using something like GSS, but that
decision happens at the curl layer.

-Peff
