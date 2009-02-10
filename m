From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/6] receive-pack: receive.denyDeleteCurrent
Date: Tue, 10 Feb 2009 07:07:53 -0500
Message-ID: <20090210120753.GB15491@coredump.intra.peff.net>
References: <1234170565-6740-1-git-send-email-gitster@pobox.com> <1234170565-6740-2-git-send-email-gitster@pobox.com> <1234170565-6740-3-git-send-email-gitster@pobox.com> <1234170565-6740-4-git-send-email-gitster@pobox.com> <20090209185310.GB27037@coredump.intra.peff.net> <20090209192210.GD27037@coredump.intra.peff.net> <7veiy7thnv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 13:09:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWrQa-0003FS-5Y
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 13:09:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753099AbZBJMH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 07:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752580AbZBJMH4
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 07:07:56 -0500
Received: from peff.net ([208.65.91.99]:35143 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752491AbZBJMHz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 07:07:55 -0500
Received: (qmail 13137 invoked by uid 107); 10 Feb 2009 12:08:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 10 Feb 2009 07:08:11 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Feb 2009 07:07:53 -0500
Content-Disposition: inline
In-Reply-To: <7veiy7thnv.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109220>

On Mon, Feb 09, 2009 at 01:38:28PM -0800, Junio C Hamano wrote:

> > Should the denyCurrentBranch code be triggering at all on a deletion?
> >
> > That is, if I have:
> >
> >   [receive]
> >     denyCurrentBranch = refuse
> >     denyDeleteCurrent = ignore
> >
> > should such a deletion be refused or allowed?
> 
> I think denyCurrentBranch means do not touch the currently checked out
> branch, so 'refuse' there should trump whatever denyDeleteCurrent says as
> long as the repository has a work tree.

I'm not sure "trump" is the right behavior. How would I specify "it is
OK to update this branch, but not to delete it, because I have installed
a hook that deals with the former but not the latter".

It seems like "delete" is a subset of "touch", so I think you probably
want to refuse if _either_ is refuse. Which I think maybe is what you
are saying here:

> Perhaps the logic needs to be restructured to:
> 
> 	if (the push affects the current branch) {
> 		if (in a repository with a work tree) {
>                         decide if we want to refuse or allow;
>                 	decide what message to issue;
> 		}
> 		if (deletion and we decided not to refuse) {
>                 	decide if we want to refuse or allow;
>                         decide what message to issue;
>                 }
>                 give message(s), possibly with a paragraph break in between;
>                 if (refuse)
>                 	refuse;
> 	}

but it was not immediately clear to me.

-Peff
