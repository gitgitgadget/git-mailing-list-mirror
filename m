From: Jeff King <peff@peff.net>
Subject: Re: [BUG?] "git submodule foreach" when command is ssh
Date: Wed, 5 Jan 2011 18:03:35 -0500
Message-ID: <20110105230334.GB9774@sigill.intra.peff.net>
References: <AANLkTi=x2i6NvDNRzbszhk-a-z5AYe46-iUBxQsxJJHC@mail.gmail.com>
 <AANLkTini=GaGSHDX4e1jhPVxKaSayUJoWa=w4u4Rz-+5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: GIT <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 06 00:03:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PacOK-0004nM-UD
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 00:03:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653Ab1AEXDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 18:03:37 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:47024 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751392Ab1AEXDh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 18:03:37 -0500
Received: (qmail 2092 invoked by uid 111); 5 Jan 2011 23:03:36 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 05 Jan 2011 23:03:36 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Jan 2011 18:03:35 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTini=GaGSHDX4e1jhPVxKaSayUJoWa=w4u4Rz-+5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164605>

On Thu, Jan 06, 2011 at 11:50:58AM +1300, Chris Packham wrote:

> Actually this might be a ssh/bash bug (feature?). There is different
> behaviour between
> 
>   find . -maxdepth 1 -type d -a ! -name '\.*' | while read; do echo
> $REPLY && ssh localhost ls /; done
> 
> and
> 
>   find . -maxdepth 1 -type d -a ! -name '\.*' | while read; do echo
> $REPLY && ls /; done

Ssh will opportunistically eat data on stdin to send to the other side,
even though the command on the other side ("ls" in this case) will never
read it. Because of course ssh has no way of knowing that, and is trying
to be an interactive terminal. So it ends up eating some random amount
of the data you expected to go to the "read" call.

You can use the "-n" option to suppress it. For example:

  $ (echo foo; echo bar) |
    while read line; do
      echo local $line
      ssh host "echo remote $line"
    done

produces:

  local foo
  remote foo

but:

  $ (echo foo; echo bar) |
    while read line; do
      echo local $line
      ssh -n host "echo remote $line"
    done

produces:

  local foo
  remote foo
  local bar
  remote bar

which is what you want.

-Peff
