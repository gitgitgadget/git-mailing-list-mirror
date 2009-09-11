From: Jeff King <peff@peff.net>
Subject: Re: Cannot clone redirecting stdout
Date: Fri, 11 Sep 2009 12:20:13 -0400
Message-ID: <20090911162013.GA10939@coredump.intra.peff.net>
References: <fc8ab2ad0909101533l135c8003m80091cb40ec93f16@mail.gmail.com>
 <20090911102329.GA13044@sigill.intra.peff.net>
 <20090911135110.GA30860@coredump.intra.peff.net>
 <9e0f31700909110846h54959ae6u466ceda40799ba37@mail.gmail.com>
 <20090911160510.GA10848@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Aloisio <aloisiojr@gmail.com>, git@vger.kernel.org,
	support@gitorious.org
To: Johan =?utf-8?B?U8O4cmVuc2Vu?= <johan@johansorensen.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 18:20:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mm8rN-0002EE-Ma
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 18:20:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754577AbZIKQUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 12:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754553AbZIKQUR
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 12:20:17 -0400
Received: from peff.net ([208.65.91.99]:53239 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752179AbZIKQUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 12:20:16 -0400
Received: (qmail 8031 invoked by uid 107); 11 Sep 2009 16:20:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 11 Sep 2009 12:20:34 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Sep 2009 12:20:13 -0400
Content-Disposition: inline
In-Reply-To: <20090911160510.GA10848@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128204>

On Fri, Sep 11, 2009 at 12:05:10PM -0400, Jeff King wrote:

> Ah. I have a theory. If I do a clone of git://gitorious.org/qt/qt.git,
> the counting/compressing stages take a long time (I timed it at 1m40
> before it actually sends any data). And looking at upload-pack.c, we
> leave the 30-second alarm set while creating the pack. Meaning we die 30
> seconds into creating the pack.
> 
> When progress is being displayed, however, the progress timer actually
> uses SIGALRM, as well. So we are constantly resetting the timer and it
> never goes off.

Hmm. Actually, this is not quite right. It looks like we call out to
pack-objects as an external program, so there is no conflict with the
signal. And we do proxy the output of pack-objects, which will keep our
timer resetting every time we see a chunk of output. But pack-objects
produces no output during the deltification phase, unless progress is
turned on.  So we still hit our timeout in upload-pack during that
phase.

So our options are:

  1. Turn off the timer during deltification, which could mean that it
     would potentially go forever. But it's not controlled by the user.
     I think the 'timeout' feature is really about the client just
     opening the connection and sitting.

  2. Keep progress on during deltification, but just throw it away
     instead of relaying it if no-progress is in effect.

  3. Accept that hitting the timeout during deltification _should_ cause
     it to die. In that case, then the case with progress is wrong, and
     we should stop resetting the timer just because we got some
     progress output from pack-objects. But this may be redefining the
     intent of --timeout. I don't know what the original intent was, or
     what users of the feature are expecting.

-Peff
