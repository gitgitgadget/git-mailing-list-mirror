From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] prune_object_dir(): verify that path fits in the
 temporary buffer
Date: Wed, 18 Dec 2013 15:00:43 -0500
Message-ID: <20131218200043.GA10244@sigill.intra.peff.net>
References: <1387287838-25779-1-git-send-email-mhagger@alum.mit.edu>
 <1387287838-25779-3-git-send-email-mhagger@alum.mit.edu>
 <xmqq8uvjmhu5.fsf@gitster.dls.corp.google.com>
 <20131217232231.GA14807@sigill.intra.peff.net>
 <xmqqa9fyhrzt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 18 21:00:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtNIY-000896-Ki
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 21:00:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060Ab3LRUAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 15:00:46 -0500
Received: from cloud.peff.net ([50.56.180.127]:46848 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750875Ab3LRUAp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 15:00:45 -0500
Received: (qmail 3172 invoked by uid 102); 18 Dec 2013 20:00:45 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Dec 2013 14:00:45 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Dec 2013 15:00:43 -0500
Content-Disposition: inline
In-Reply-To: <xmqqa9fyhrzt.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239476>

On Wed, Dec 18, 2013 at 11:35:34AM -0800, Junio C Hamano wrote:

> This function is called to remove
> 
>  * Any tmp_* found directly in .git/objects/
>  * Any tmp_* found directly in .git/objects/pack/
>  * Any tmp_obj_* found directly in .git/objects/??/
> 
> and shares the same expiration logic with prune_object().  The only
> difference from the other function is what the file is called in
> dry-run or verbose report ("stale temporary file" vs "<sha-1> <typename>").
> 
> We may want to rename it to prune_tmp_file(); its usage may have
> been limited to an unborn loose object file at some point in the
> history, but it does not look that way in today's code.

Yes, certainly the rename makes sense (and I think the history is as you
mentioned). I noticed the similarity between the two, as well. It might
be simple to refactor into a single function.

> > -			prune_object(path, de->d_name, sha1);
> > +			strbuf_addf(path, "/%s", de->d_name);
> > +			prune_object(path->buf, sha1);
> > +			path->len = baselen;
> 
> This is minor, but I prefer using strbuf_setlen() for this.

Good catch. I do not think it is minor at all; my version is buggy.
After the loop ends, path->len does not match the NUL in path->buf. That
is OK if the next caller is strbuf-aware, but if it were to pass
path->buf straight to a system call, that would be rather...confusing.

-Peff
