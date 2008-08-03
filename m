From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: More on git over HTTP POST
Date: Sat, 2 Aug 2008 19:56:02 -0700
Message-ID: <20080803025602.GB27465@spearce.org>
References: <48938539.9060003@zytor.com> <20080802205702.GA24723@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Sun Aug 03 04:59:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPToT-0001WG-UG
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 04:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbYHCC4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 22:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751555AbYHCC4F
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 22:56:05 -0400
Received: from george.spearce.org ([209.20.77.23]:60290 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022AbYHCC4E (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 22:56:04 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 4010938419; Sun,  3 Aug 2008 02:56:02 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080802205702.GA24723@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91196>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> "H. Peter Anvin" <hpa@zytor.com> wrote:
> > I have investigated a bit what it would take to support git protocol  
> > (smart transport) over HTTP POST transactions.
> 
> I have started to think about this more myself, not just for POST
> put also for some form of GET that can return an efficient pack,
> rather than making the client walk the object chains itself.
...
> HTTP POST is actually trivial if you don't want to support the new
> tell-me-more extension that was added to git-push.  Hell, I could
> write the CGI in a few minutes I think.  Its really just a small
> wrapper around git-receive-pack.

So I have this draft of how smart push might work.  Its slated
for the Documentation/technical directory.  Thus far I have only
written about push support, but Ilari on #git has some ideas about
how to do a smart fetch protocol.

Implementation wise in C git I think this is just a new C
program (git-http-backend?) that turns around and proxies
into git-receive-pack, at least for the push support.

What I don't know is how we could configure URI translation from
/path/to/repository.git received out of the $PATH_INFO in the
CGI environment to a physical directory.  Should we rely on the
server's $PATH_TRANSLATED?


Smart HTTP transfer protocols
=============================

Git supports two HTTP based transfer protocols.  A "dumb" protocol
which requires only a standard HTTP server on the server end of the
connection, and a "smart" protocol which requires a Git aware CGI
(or server module).  This document describes the "smart" protocol.

Authentication
--------------

Standard HTTP authentication is used, and must be configured and
enforced by the HTTP server software.

Chunked Transfer Encoding
-------------------------

For performance reasons the HTTP/1.1 chunked transfer encoding is
used frequently to transfer variable length objects.  This avoids
needing to produce large results in memory to compute the proper
content-length.

Detecting Smart Servers
-----------------------

HTTP clients can detect a smart Git-aware server by sending the
show-ref request (below) to the server.  If the response has a
status of 200 and the magic x-application/git-refs content type
then the server can be assumed to be a smart Git-aware server.

If any other response is received the client must assume dumb
protocol support, as the server did not correctly response to
the request.


Show Refs
---------

Obtains the available refs from the remote repository.  The response
is a sequence of git "packet lines", one per ref, and a final flush
packet line to indicate the end of stream.

	C: GET /path/to/repository.git?show-ref HTTP/1.0

	S: HTTP/1.1 200 OK
	S: Content-Type: x-application/git-refs
	S: Transfer-Encoding: chunked
	S:
	S: 62
	S: 003e95dcfa3633004da0049d3d0fa03f80589cbcaf31 refs/heads/maint
	S: 
	S: 63
	S: 003fd049f6c27a2244e12041955e262a404c7faba355 refs/heads/master
	S: 
	S: 59
	S: 003b2cb58b79488a98d2721cea644875a8dd0026b115 refs/heads/pu
	S: 
	S: 4
	S: 0000
	S: 0

Push Pack
---------

Uploads a pack and updates refs.  The start of the stream is the
commands to update the refs and the remainder of the stream is the
pack file itself.  See git-receive-pack and its network protocol
in pack-protocol.txt, as this is essentially the same.

	C: POST /path/to/repository.git?receive-pack HTTP/1.0
	C: Content-Type: x-application/git-receive-pack
	C: Transfer-Encoding: chunked
	C:
	C: 103
	C: 006395dcfa3633004da0049d3d0fa03f80589cbcaf31 d049f6c27a2244e12041955e262a404c7faba355 refs/heads/maint
	C: 4
	C: 0000
	C: 12
	C: PACK
	...
	C: 0

	S: HTTP/1.0 200 OK
	S: Content-type: x-application/git-status
	S: Transfer-Encoding: chunked
	S:
	S: ...<output of receive-pack>...



-- 
Shawn.
