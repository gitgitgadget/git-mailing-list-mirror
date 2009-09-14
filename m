From: Jeff King <peff@peff.net>
Subject: Re: could not detach HEAD error didn't identify the cause of the
 issue
Date: Mon, 14 Sep 2009 18:39:41 -0400
Message-ID: <20090914223941.GA20036@coredump.intra.peff.net>
References: <4AAD8AE0.9070305@catalyst.net.nz>
 <20090914112211.GC9216@sigill.intra.peff.net>
 <4AAEAE15.7050607@catalyst.net.nz>
 <4AAEAF28.2050604@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ben Bradshaw <ben@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Tue Sep 15 00:39:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnKDA-0000qL-Tq
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 00:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757449AbZINWjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2009 18:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757402AbZINWjn
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 18:39:43 -0400
Received: from peff.net ([208.65.91.99]:58866 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757347AbZINWjn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2009 18:39:43 -0400
Received: (qmail 27491 invoked by uid 107); 14 Sep 2009 22:40:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 14 Sep 2009 18:40:04 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Sep 2009 18:39:41 -0400
Content-Disposition: inline
In-Reply-To: <4AAEAF28.2050604@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128500>

[Please don't top-post; the usual etiquette on this list is to reply
in-line].

On Tue, Sep 15, 2009 at 09:01:28AM +1200, Ben Bradshaw wrote:

> I'm using git version 1.5.6.5 - I think I can elaborate on the issue
> some more though. I'll step through the process that got me to the point
> of failure.

Thanks for following up. I was able to reproduce your problem. The more
complex setup you described is not necessary to reproduce (though thank
you for providing it, as it eliminated one possible source of
variation). It really is just about having an untracked file 'foo' in
your working tree, and the thing you are trying to rebase on top of also
has 'foo' as a tracked file.

The good news is that it has already been fixed. I bisected it down to:

  commit 324c2c3177ca5b62b12029ce8821542fc29a2733
  Author: Junio C Hamano <gitster@pobox.com>
  Date:   Mon Jul 14 14:05:35 2008 -0700

      git-rebase: report checkout failure

      When detaching the HEAD to the base commit, the "git checkout"
      command could fail if, for example, upstream contains a file that
      would overrwrite a local, untracked file.  Unconditionally
      discarding the standard error stream was done to squelch the
      progress and notices back when checkout did not have -q option,
      but there is no reason to keep doing it anymore.

      Noticed by Robert Shearman.

which sounds about right. :)

It made it into git v1.6.0, but not into any of the v1.5.x maintenance
series. I would suggest upgrading if you can.

-Peff
