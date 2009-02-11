From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/6] remote prune: warn dangling symrefs
Date: Wed, 11 Feb 2009 13:42:05 -0500
Message-ID: <20090211184205.GA27859@coredump.intra.peff.net>
References: <1234170565-6740-1-git-send-email-gitster@pobox.com> <1234170565-6740-2-git-send-email-gitster@pobox.com> <1234170565-6740-3-git-send-email-gitster@pobox.com> <1234170565-6740-4-git-send-email-gitster@pobox.com> <1234170565-6740-5-git-send-email-gitster@pobox.com> <20090209191526.GC27037@coredump.intra.peff.net> <7vhc30g9ub.fsf@gitster.siamese.dyndns.org> <20090211183547.GB21122@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 19:43:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXK3f-0006AZ-9X
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 19:43:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756874AbZBKSmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 13:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756765AbZBKSmJ
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 13:42:09 -0500
Received: from peff.net ([208.65.91.99]:49114 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755181AbZBKSmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 13:42:09 -0500
Received: (qmail 32667 invoked by uid 107); 11 Feb 2009 18:42:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 11 Feb 2009 13:42:24 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Feb 2009 13:42:05 -0500
Content-Disposition: inline
In-Reply-To: <20090211183547.GB21122@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109495>

On Wed, Feb 11, 2009 at 01:35:47PM -0500, Jeff King wrote:

> Is the special case really about "this is HEAD", or is it about writing
> versus reading? For example, in an empty repo, without this patch I now
> get:
> 
>   $ git init && git show
>   warning: ignoring dangling symref HEAD.
>   fatal: bad default revision 'HEAD'
> 
> which makes a lot of sense. But _writing_ to any dangling symref
> shouldn't trigger a warning.
> 
> Admittedly, we have gotten by without this warning until now, and I
> doubt anyone will want to write to other symrefs that are branches to be
> born, so I think in practice your patch is fine.

I looked into what it would take to fix this, and it's a little hairy.
"git commit" calls:

  if (get_sha1("HEAD", head_sha1))
          initial_commit = 1;

So it is fine with HEAD not resolving, but that intent is not passed to
lower-level code. So we could add a "flags" field, but the callstack
looks like:

  dwim_ref
  get_sha1_basic
  get_sha1_1
  get_sha1_with_mode
  get_sha1

all of which would need to pass the flag through, and all of which have
tons of callers (though we could do the get_sha1_with_flags trick).

I don't know if it's worth it.

-Peff
