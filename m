From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] Check order when reading index
Date: Tue, 26 Aug 2014 08:20:09 -0400
Message-ID: <20140826122008.GC29180@peff.net>
References: <xmqq38cpsmli.fsf@gitster.dls.corp.google.com>
 <1408903047-8302-1-git-send-email-jsorianopastor@gmail.com>
 <xmqqvbpgmqmh.fsf@gitster.dls.corp.google.com>
 <20140825194430.GI30953@peff.net>
 <CAPc5daW-ZckFfhyueNLnPaBeriAmCUVJjFc1cw0O5iRi8F+Kng@mail.gmail.com>
 <CAPuZ2NHafXQthtuq-RnTvpjVfNPaXHEy8SejuhPEnG+MwCK=sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jaime Soriano Pastor <jsorianopastor@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 14:20:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMFjW-0007FM-4F
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 14:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755065AbaHZMUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 08:20:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:59149 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754695AbaHZMUK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 08:20:10 -0400
Received: (qmail 15748 invoked by uid 102); 26 Aug 2014 12:20:10 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Aug 2014 07:20:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Aug 2014 08:20:09 -0400
Content-Disposition: inline
In-Reply-To: <CAPuZ2NHafXQthtuq-RnTvpjVfNPaXHEy8SejuhPEnG+MwCK=sg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255894>

On Tue, Aug 26, 2014 at 02:08:35PM +0200, Jaime Soriano Pastor wrote:

> > That is how we natively (read: not with the funky "virtual" stuff
> > merge-recursive does) express a merge with multiple merge bases.
> > You also should be able to read this in the way how "git merge" invokes
> > merge strategies (one or more bases, double-dash and then current
> > HEAD and the other branches). I think there are some tests in 3way
> > merge tests that checks what should happen when our HEAD matches
> > one of the stage #1 while their branch matches a different one of the
> > stage #1, too.
> 
> I'm a bit lost with this, conceptually it doesn't seem to be any
> problem with having multiple merge bases, but I don't manage to
> reproduce it.
> With "natively" do you mean some internal state that is never written
> into the index? If this were the case then there wouldn't be any
> problem with the restriction when reading the index file.

FWIW, that was my question on reading Junio's response, too.

> I have also tried to reproduce it by directly calling
> git-merge-recursive and the most I have got is what it seemed to be
> like a conflict in the stage #1:
> 
> $ git ls-files -s
> 100644 1036ba5101378f06aa10c5fa249b67e14f83166b 1 conflict
> 100644 2638c45f8e7bc5b56f70e92390153572811782c3 2 conflict
> 100644 178481050188cf00d7d9cd5a11e43ab8fab9294f 3 conflict
> 
> $ git cat-file blob 1036ba5101378f06aa10c5fa249b67e14f83166b
> <<<<<<< Temporary merge branch 1
> G
> =======
> E
> F
> >>>>>>> Temporary merge branch 2

Yes, I think merge-recursive resolves the earlier merges and then feeds
the result into the main merge. And that's how you end up with the
"temporary merge branch" name instead of something useful.

It might work to have a recursive merge that causes a conflict on path
X, and then we further need to resolve that conflict. I'm not sure if we
try to represent that in the index somehow, or if merge-recursive just
bails in this case (I didn't try it).

-Peff
