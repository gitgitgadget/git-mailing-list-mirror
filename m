From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH/RFC] Allow curl to rewind the RPC read buffer at any
	time
Date: Tue, 1 Dec 2009 08:14:28 -0800
Message-ID: <20091201161428.GC21299@spearce.org>
References: <25718488.post@talk.nabble.com> <20091127234110.7b7e9993.rctay89@gmail.com> <alpine.DEB.2.00.0912011208160.5582@cone.home.martin.st> <alpine.DEB.2.00.0912011236360.5582@cone.home.martin.st>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org,
	Nicholas Miell <nmiell@gmail.com>, gsky51@gmail.com,
	Clemens Buchacher <drizzd@aon.at>,
	Mark Lodato <lodatom@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Martin Storsj? <martin@martin.st>
X-From: git-owner@vger.kernel.org Tue Dec 01 17:18:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFVNC-0002TX-2N
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 17:14:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754122AbZLAQOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 11:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754067AbZLAQOc
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 11:14:32 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:55729 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754028AbZLAQOb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 11:14:31 -0500
Received: by ywh12 with SMTP id 12so5290188ywh.21
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 08:14:37 -0800 (PST)
Received: by 10.101.185.39 with SMTP id m39mr2463379anp.164.1259684072173;
        Tue, 01 Dec 2009 08:14:32 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 8sm102370yxg.60.2009.12.01.08.14.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Dec 2009 08:14:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0912011236360.5582@cone.home.martin.st>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134220>

Martin Storsj? <martin@martin.st> wrote:
> When using multi-pass authentication methods, the curl library may
> need to rewind the read buffers used for providing data to HTTP POST,
> if data has been output before a 401 error is received.
> 
> This solution buffers all data read by the curl library, in order to allow
> it to rewind the reading buffer at any time later.

NAK.


In the case of git-upload-pack requests, we should fit into 1 MiB
almost all of the time, and thus not need to grow the http.postBuffer
to support a rewind.  The state data plus current have list isn't
all that large.  A 1 MiB request means we have over 20,900 commits
in common with the remote and still haven't been able to find a
sufficient cut point.  Or the remote has 20,000 active, unrelated
branches we are trying to fetch.  Either way, this is a really sick
and twisted situation.

In the case of git-receive-pack requests, we might be uploading an
entire project to an empty repository on the remote side.  This could
be 8 GiB worth of data if the project was something huge like KDE.
We can't assume that we should malloc 8 GiB of memory to buffer
the payload.

The *correct* way to support an arbitrary rewind is to modify the
outgoing channel from remote-curl to its protocol engine (client.in
within the rpc_service method) to somehow request the protocol engine
(aka git-send-pack or git-fetch-pack) to stop and regenerate the
current request.


Another approach would be to modify http-backend (and the protocol)
to support an "auth ping" request prior to spooling out the entire
payload if its more than an http.postBuffer size.  Basically we
do what the "Expect: 100-continue" protocol is supposed to do,
but in the application layer rather than the HTTP/1.1 layer, so
our CGI actually gets invoked.

This unfortunately still relies on the underlying libcurl to not
discard the authentication data after that initial "auth ping".
But to be honest, I think that is a reasonable expectation.  The
#@!*@!* library should be able to generate two requests back-to-back
to the same URL without needing to rewind the 2nd request.

-- 
Shawn.
