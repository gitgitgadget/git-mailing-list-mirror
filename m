From: Jeff King <peff@peff.net>
Subject: Re: fatal output from git-show really wants a terminal
Date: Thu, 11 Dec 2008 16:55:55 -0500
Message-ID: <20081211215554.GA11565@sigill.intra.peff.net>
References: <ghop5d$qud$1@ger.gmane.org> <200812101624.11255.bss03@volumehost.net> <alpine.DEB.1.00.0812111015140.18321@eeepc-johanness> <200812111051.20322.bss03@volumehost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Boyd Stephen Smith Jr." <bss03@volumehost.net>
X-From: git-owner@vger.kernel.org Thu Dec 11 22:57:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAtX3-0008V6-UU
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 22:57:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757441AbYLKV4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 16:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757425AbYLKV4A
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 16:56:00 -0500
Received: from peff.net ([208.65.91.99]:1731 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757380AbYLKVz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 16:55:59 -0500
Received: (qmail 29462 invoked by uid 111); 11 Dec 2008 21:55:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 11 Dec 2008 16:55:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Dec 2008 16:55:55 -0500
Content-Disposition: inline
In-Reply-To: <200812111051.20322.bss03@volumehost.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102828>

On Thu, Dec 11, 2008 at 10:51:15AM -0600, Boyd Stephen Smith Jr. wrote:

> Initially, I was looking for 'stdout' or 'stderr', and found many unrelated 
> commits.  I then figured it was part of the PAGER support, and began 

Try looking for isatty, which takes the numeric fd. I think the behavior
you asked about would be this:

diff --git a/pager.c b/pager.c
index aa0966c..19f8856 100644
--- a/pager.c
+++ b/pager.c
@@ -42,7 +42,7 @@ void setup_pager(void)
 {
 	const char *pager = getenv("GIT_PAGER");
 
-	if (!isatty(1))
+	if (!isatty(0) || !isatty(2))
 		return;
 	if (!pager) {
 		if (!pager_program)

which is what is mentioned in POSIX:

  http://www.opengroup.org/onlinepubs/009695399/utilities/sh.html

But I don't think that makes sense here. We are not talking about
interactivity, but rather about where the output is going. So your test
would consider this interactive:

  $ git log >foo.out

and start a pager, which makes no sense.

Now if you proposed checking stderr and stdin _in addition_ to stdout,
that might make more sense, but I haven't thought too hard about any
implications.

And FWIW, I don't recall this ever being discussed before, but then I
have not been involved with git since the very beginning.

-Peff
