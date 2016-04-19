From: Jeff King <peff@peff.net>
Subject: [PATCH 0/5] fix deadlock in git-push
Date: Tue, 19 Apr 2016 18:39:46 -0400
Message-ID: <20160419223945.GA18055@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 00:42:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aseLH-0004r9-Ef
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 00:41:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932707AbcDSWle (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 18:41:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:52431 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932356AbcDSWjy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 18:39:54 -0400
Received: (qmail 27327 invoked by uid 102); 19 Apr 2016 22:39:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Apr 2016 18:39:48 -0400
Received: (qmail 20813 invoked by uid 107); 19 Apr 2016 22:39:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Apr 2016 18:39:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Apr 2016 18:39:46 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291941>

I ran across a deadlock today while pushing from a corrupted repository
where pack-objects fails. Obviously I don't expect this to succeed, but
it should not hang indefinitely.

The first patch below fixes the deadlock. Unfortunately, it turns it
into a likely SIGPIPE death. Which is an improvement, but not ideal.

Patches 2 and 3 address that by fixing the way we handle SIGPIPE in
async threads.

Patches 4 and 5 are cleanups to earlier topics that are enabled by the
new SIGPIPE handling.

  [1/5]: send-pack: close demux pipe before finishing async process
  [2/5]: run-command: teach async threads to ignore SIGPIPE
  [3/5]: send-pack: isolate sigpipe in demuxer thread
  [4/5]: fetch-pack: isolate sigpipe in demuxer thread
  [5/5]: t5504: drop sigpipe=ok from push tests

I confirmed that after this series we still pass the stress test I
outlined in

  http://article.gmane.org/gmane.comp.version-control.git/287176

So hopefully I haven't made anything worse (and that the tightening in
5/5 isn't just bringing back some test flakiness).

-Peff
