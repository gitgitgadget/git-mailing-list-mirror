From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] push: fix local refs update if already up-to-date
Date: Tue, 4 Nov 2008 09:56:30 +0100
Message-ID: <20081104085630.GA22530@localhost>
References: <20081104000745.GA28480@localhost> <20081104042643.GA31276@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 04 09:57:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxHjF-0004Ba-9z
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 09:57:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753520AbYKDI4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 03:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753516AbYKDI4W
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 03:56:22 -0500
Received: from postman.fh-hagenberg.at ([193.170.124.96]:40412 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753414AbYKDI4V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 03:56:21 -0500
Received: from darc.dyndns.org ([84.154.77.179]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 4 Nov 2008 09:56:18 +0100
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1KxHiA-0005xT-J2; Tue, 04 Nov 2008 09:56:30 +0100
Content-Disposition: inline
In-Reply-To: <20081104042643.GA31276@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 04 Nov 2008 08:56:19.0804 (UTC) FILETIME=[345A29C0:01C93E5B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100061>

On Mon, Nov 03, 2008 at 11:26:44PM -0500, Jeff King wrote:
> > The hashcpy for new_ref is now executed more often than absolutely
> > necessary. But this is not a critical path, right? So I decided to keep
> > things simple.
> 
[...]
> Your patch makes ref->new_sha1 "valid" for every status case. Ordinarily
> I would be in favor of that, since it reduces coupling with other parts
> of the code (which have to know _which_ status flags provide a useful
> value in ->new_sha1). But in this case, I think the value we would be
> sticking in is not necessarily useful for every status flag we end up
> setting; so any consumers of the ref structure still need to know which
> flags set it. So even though it has a defined value, it is not really
> "valid" in all cases.

The other status flags are REF_STATUS_REJECT_NODELETE and
REF_STATUS_REJECT_NONFASTFORWARD. So in these cases the "new sha1" is going
to be the "old sha1". The default for new_sha1 is the null sha1. So while
the sha1 we're trying to push may not be more valid than the null sha1, it's
not less valid either, is it? And it even makes sense if you interpret
new_sha1 as the sha1 the client attempts to push.

> Hmm. I was hoping to see more in update_tracking_ref. With your patch,
> we end up calling update_ref for _every_ uptodate ref, which results in
> writing a new unpacked ref file for each one. And that _is_ a
> performance problem for people with large numbers of refs.
> 
> So I think we need a check to make sure we aren't just updating with the
> same value. Something like:

I think update_ref already takes care of that. See this check in
write_ref_sha1:

        if (!lock->force_write && !hashcmp(lock->old_sha1, sha1)) {
                unlock_ref(lock);
                return 0;
        }

> Though I am not happy that we have to look up the tracking ref for every
> uptodate ref. I think it shouldn't be a big performance problem with
> packed refs, though, since they are cached (i.e., we pay only to compare
> the hashes, not touch the filesystem for each ref).

I don't think we can avoid that, though.

I agree with your other comments.
