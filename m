From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add option -b/--branch to clone for select a new HEAD
Date: Wed, 26 Aug 2009 12:10:59 -0400
Message-ID: <20090826161059.GC32741@coredump.intra.peff.net>
References: <20090826121600.GA29098@atjola.homenet>
 <1251298007-18693-1-git-send-email-catap@catap.ru>
 <20090826155029.GA5750@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Kirill A. Korinskiy" <catap@catap.ru>, git@vger.kernel.org
To: =?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 26 18:11:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgL5a-0002p2-Bt
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 18:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbZHZQLA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Aug 2009 12:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbZHZQLA
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 12:11:00 -0400
Received: from peff.net ([208.65.91.99]:37016 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750935AbZHZQK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 12:10:59 -0400
Received: (qmail 23511 invoked by uid 107); 26 Aug 2009 16:11:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 26 Aug 2009 12:11:09 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Aug 2009 12:10:59 -0400
Content-Disposition: inline
In-Reply-To: <20090826155029.GA5750@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127105>

On Wed, Aug 26, 2009 at 05:50:29PM +0200, Bj=C3=B6rn Steinbrink wrote:

> Using guess_remote_head() seems pretty wrong. With -b given, you don'=
t
> want to guess anymore, you _know_ which one you want. Unfortunately, =
I
> don't see a straight-forward way to handle that (but I'm totally
> clueless about the code, so don't let me scare you ;-)).

Thanks for pointing this out, Bj=C3=B6rn (I really should have noticed =
it on
first review, but I guess many eyes, shallow bugs, etc. :) ).

This code is a little bit confusing, so let me explain:

  - we look up the remote HEAD, getting its commit sha1. If the protoco=
l
    supports it, we also get its symref information.

  - we then pass the result to guess_remote_head. _If_ we have symref
    information, then we can quit immediately, as the symref contains
    what we want. If it doesn't, then we proceed with trying to match u=
p
    the commit sha1 with one of the other refs.

So if you want to create a "remote_head" object via "-b" which acts as
if it was the remote HEAD, you would need to actually create a new ref
object and set the "symref" field appropriately.

But I don't think there is any need to do that here. We simply want to
avoid calling guess_remote_head at all, since we know there is nothing
to guess at. We do still need to know whether remote_head is non-NULL
later, though.

So I think the code should probably look like this (totally untested):

  remote_head =3D find_ref_by_name(refs, "HEAD");
  if (option_branch) {
          strbuf_addf(&branch_head, "%s%s", src_ref_prefix, option_bran=
ch);
          head_points_at =3D find_ref_by_name(refs, branch_head.buf);
          if (!head_points_at)
                  warning("remote branch not found, etc");
  }
  if (!head_points_at)
    head_points_at =3D guess_remote_head(remote_head, mapped_refs, 0);

and then initialize head_points_at to NULL instead of remote_head.

-Peff
