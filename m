From: Jeff King <peff@peff.net>
Subject: Re: git-fetch in 1.5.4 fails versus 1.5.3.8
Date: Thu, 7 Feb 2008 19:32:39 -0500
Message-ID: <20080208003239.GA18856@coredump.intra.peff.net>
References: <pan.2008.02.04.18.25.26@progsoc.org> <20080205050741.GA4624@coredump.intra.peff.net> <pan.2008.02.06.21.56.35@progsoc.org> <20080207042332.GA7632@sigill.intra.peff.net> <pan.2008.02.07.10.15.05@progsoc.org> <20080207110601.GA8488@coredump.intra.peff.net> <20080207121042.GA10210@glandium.org> <20080207122842.GA17184@coredump.intra.peff.net> <20080207220243.GA7237@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Anand Kumria <wildfire@progsoc.org>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Feb 08 01:33:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNHBg-0004E0-2r
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 01:33:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934553AbYBHAcr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 19:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763263AbYBHAcp
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 19:32:45 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2367 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934553AbYBHAco (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 19:32:44 -0500
Received: (qmail 22576 invoked by uid 111); 8 Feb 2008 00:32:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 07 Feb 2008 19:32:41 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Feb 2008 19:32:39 -0500
Content-Disposition: inline
In-Reply-To: <20080207220243.GA7237@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73023>

On Thu, Feb 07, 2008 at 11:02:43PM +0100, Mike Hommey wrote:

> Sorry, I've had trouble opening my eyes and actually reading messages I
> reply to... anyways, I tried to reproduce with curl-gnutls and...
> couldn't... How did you manage that ? Is the server you were trying on
> public ? Do you have any http.ssl* variables set in your configuration ?

No, my test repo is not public. I have no special ssl configuration
(though I do use GIT_SSL_NO_VERIFY=1 since I just had a test self-signed
cert). The exact recipe on my Debian system is:

1. Build broken git on client

  client$ apt-get install libcurl4-gnutls-dev
  client$ cd ~/compile/git && make install

2. On server with ssl-enabled webserver (I am using lighttpd, but
   I don't think that it matters), make a small repo.

  server$ cd /var/www
  server$ mkdir foo && cd foo && git init
  server$ echo one >file && git add file && git commit -m one
  server$ git update-server-info

3. On client, clone repo, which should work ok

  client$ export GIT_SSL_NO_VERIFY=1 ;# if necessary
  client$ git clone https://yourserver.com/foo/.git

4. make a new commit in parent repo

  server$ echo two >file && git commit -a -m two
  server$ git update-server-info

5. fetch from client (this output is with GIT_SSL_NO_VERIFY=1; you get
   slightly different output if verification is on)

  client$ git fetch
  error: gnutls_handshake() failed: ASN1 parser: Element was not found.
  (curl_result = 35, http_code = 0, sha1 =
  07ac7bd2edd32a5818d719145910119ab72c9dd4)
  Getting pack list for https://peff.net/git/foo/.git
  error: gnutls_handshake() failed: ASN1 parser: Element was not found.
  Getting alternates list for https://peff.net/git/foo/.git
  error: Unable to find 07ac7bd2edd32a5818d719145910119ab72c9dd4 under
  https://peff.net/git/foo/.git
  Cannot obtain needed object 07ac7bd2edd32a5818d719145910119ab72c9dd4
  fatal: Fetch failed.

6. On client, rebuild with libcurl4-openssl-dev

  client$ apt-get install libcurl4-openssl-dev
  client$ cd ~/compile/git && make clean install

7. On client, do the fetch, which now works

  client$ cd ~/foo && git fetch

-Peff
