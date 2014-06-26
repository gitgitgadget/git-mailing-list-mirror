From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] replace: add a --raw mode for --edit
Date: Thu, 26 Jun 2014 11:55:30 -0400
Message-ID: <20140626155530.GB10402@sigill.intra.peff.net>
References: <20140624094217.GA14216@sigill.intra.peff.net>
 <20140624094631.GD14514@sigill.intra.peff.net>
 <xmqqsims62m1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 17:55:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0C1Q-00020s-L1
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 17:55:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755517AbaFZPzd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2014 11:55:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:51581 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752149AbaFZPzc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2014 11:55:32 -0400
Received: (qmail 20077 invoked by uid 102); 26 Jun 2014 15:55:32 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 Jun 2014 10:55:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jun 2014 11:55:30 -0400
Content-Disposition: inline
In-Reply-To: <xmqqsims62m1.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252502>

On Wed, Jun 25, 2014 at 03:33:42PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > One of the purposes of "git replace --edit" is to help a
> > user repair objects which are malformed or corrupted.
> > Usually we pretty-print trees with "ls-tree", which is much
> > easier to work with than the raw binary data.  However, some
> > forms of corruption break the tree-walker, in which case our
> > pretty-printing fails, rendering "--edit" useless for the
> > user.
> >
> > This patch introduces a "--raw" option, which lets you edit
> > the binary data in these instances.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> 
> Hmmmmm, this feels almost like inviting accidents to make it easy
> and limiting the attempt to only one shot at the "transformation"
> step.
> 
> Will queue, but we can do the same with "cat-file $type >temp", do
> some transformation on "temp", doubly make sure what is in "temp" is
> sensible and then finally "hash-object -w -t $type temp".  And it
> makes me feel uneasy that the new feature seems to make it harder to
> do the "doubly make sure" part.

I do not think it is any worse than "--edit" is by itself. True, editing
the binary contents is hard, but we do check that the format is sane
when we read it back in (using the same checks that hash-object does). I
think it would be nice to take that a step further and actually let
hash-object (and "replace --edit") do the more rigorous fsck checks on
created objects.

I do still think even with those automated sanity checks that it makes
sense to double-check the replacement manually. But I think that is one
of the features of replace objects: you are not doing anything
permanent, and can view the object in place. So not only can you examine
the object by "git show $new_sha1", you can see it in place as "git log
-p", etc. And easily back it out with "git replace -d" (or fix it up
again with "git replace --edit") if need be.

-Peff
