From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] attr: "binary" attribute should choose built-in
 "binary" merge driver
Date: Wed, 12 Sep 2012 09:17:02 -0400
Message-ID: <20120912131702.GA13710@sigill.intra.peff.net>
References: <7v392twlnm.fsf@alter.siamese.dyndns.org>
 <1347165639-12149-1-git-send-email-gitster@pobox.com>
 <1347165639-12149-3-git-send-email-gitster@pobox.com>
 <20120910140317.GA7906@sigill.intra.peff.net>
 <7vk3vzfwme.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Stephen Bash <bash@genarts.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 12 15:17:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBmok-0005PK-4R
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 15:17:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758271Ab2ILNRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 09:17:12 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:42304 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753748Ab2ILNRK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 09:17:10 -0400
Received: (qmail 23233 invoked by uid 107); 12 Sep 2012 13:17:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Sep 2012 09:17:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Sep 2012 09:17:02 -0400
Content-Disposition: inline
In-Reply-To: <7vk3vzfwme.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205286>

On Wed, Sep 12, 2012 at 01:55:53AM -0700, Junio C Hamano wrote:

> > Yeah, that seems like the obviously correct thing to do. In practice,
> > most files would end up in the first few lines of ll_xdl_merge checking
> > buffer_is_binary anyway, so I think this would really only make a
> > difference when our "is it binary?" heuristic guesses wrong.
> 
> You made me look at that part again and then made me notice
> something unrelated.
> 
> 	if (buffer_is_binary(orig->ptr, orig->size) ||
> 	    buffer_is_binary(src1->ptr, src1->size) ||
> 	    buffer_is_binary(src2->ptr, src2->size)) {
> 		warning("Cannot merge binary files: %s (%s vs. %s)",
> 			path, name1, name2);
> 		return ll_binary_merge(drv_unused, result,
> 				       path,
> 				       orig, orig_name,
> 				       src1, name1,
> 				       src2, name2,
> 				       opts, marker_size);
> 	}
> 
> Given that we now may know how to merge these things, the
> unconditional warning feels very wrong.
> 
> Perhaps something like this makes it better.
> 
> A path that is explicitly marked as binary did not get any such
> warning, but it will start to get warned just like a path that was
> auto-detected to be a binary.
> 
> It is a behaviour change, but I think it is a good one that makes
> two cases more consistent.
> 
> And we won't see the warning when -Xtheirs/-Xours large sledgehammer
> is in use, which tells us how to resolve these things "cleanly".

Yeah, I think it is the right thing to do. I noticed that the warning
would not trigger in the "-merge" case and wondered if it should, but
figured it was not a big deal either way.

However, I agree it is very bad for it to trigger with -Xours/theirs,
and that is worth fixing.  That it triggers in the "-merge" case
afterwards is a slight bonus.

-Peff
