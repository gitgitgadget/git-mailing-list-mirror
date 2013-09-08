From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/3] index-pack: add --unpack-limit to unpack objects
Date: Sun, 8 Sep 2013 02:35:34 -0400
Message-ID: <20130908063533.GA22949@sigill.intra.peff.net>
References: <1378091107-31682-1-git-send-email-pclouds@gmail.com>
 <1378428363-14086-1-git-send-email-pclouds@gmail.com>
 <20130908044417.GD14019@sigill.intra.peff.net>
 <CACsJy8DeJnwJ2hxbKs+ks3Rp6h+uedFA+qt8JTTwyen8sF7XMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 08 08:35:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIYb1-0001sJ-1W
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 08:35:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512Ab3IHGfi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 02:35:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:42937 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750987Ab3IHGfh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 02:35:37 -0400
Received: (qmail 5354 invoked by uid 102); 8 Sep 2013 06:35:37 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 08 Sep 2013 01:35:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Sep 2013 02:35:34 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8DeJnwJ2hxbKs+ks3Rp6h+uedFA+qt8JTTwyen8sF7XMw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234193>

On Sun, Sep 08, 2013 at 01:28:47PM +0700, Nguyen Thai Ngoc Duy wrote:

> > From a cursory read, this seems fine. If it were done in complete
> > isolation, I'd say it was a slight regression, just because we are doing
> > more I/O for the unpack case, and it is not really saving us any code
> > (it is not like we can throw away unpack-objects, as I think we would
> > want to keep it as a last resort for getting data out of malformed or
> > otherwise non-indexable packs).
> 
> I can see unpack-objects is more tolerable on corrupt/incomplete
> packs. If index-pack finds something wrong, it aborts the whole
> process. I think we can make index-pack stop at the first bad object,
> adjust nr_objects, and try to recover as much as possible out of the
> good part. Any other reasons to keep unpack-objects (because I still
> want to kill it)?

No, I don't think there is another reason. The command name may hang
around for historical reasons, but we can always make it an alias for
"index-pack --unpack-limit=0" or whatever.

I do not think index-pack even needs to be particularly clever about
trying to recover. It is mainly that we may do some extra sanity checks
when writing the index (e.g., the recent discussion on avoiding
duplicates in the index), that do not even come up when simply exploding
the pack in a linear fashion. But I don't think there is any fundamental
reason why index-pack could not learn to be as robust when operating in
unpack mode.

As an aside, you cannot just drop the nr_objects that index-pack's
generated index says it contains. Packfile readers double-check that the
.idx and .pack agree on the number of objects (I tried it as a method
for working around duplicate entries :) ).

-Peff
