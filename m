From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] check_refname_component: Optimize
Date: Thu, 29 May 2014 19:41:09 -0400
Message-ID: <20140529234109.GA28683@sigill.intra.peff.net>
References: <1401311055-480-1-git-send-email-dturner@twitter.com>
 <1401311055-480-2-git-send-email-dturner@twitter.com>
 <538658C0.8050001@alum.mit.edu>
 <1401320968.18134.98.camel@stross>
 <CACsJy8BcBmuC3KMu+5dhGiOXX=u7WtHWQzQuT=ZPTbSCduJdbw@mail.gmail.com>
 <xmqqfvjsbkz2.fsf@gitster.dls.corp.google.com>
 <CACsJy8BS_YhMB9ZZRx4faj=_YWZQrqm7B9AHkTGye=okja=m-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twitter.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 30 01:41:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wq9wi-0006Xp-Dn
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 01:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753670AbaE2XlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 19:41:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:33773 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753614AbaE2XlL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 19:41:11 -0400
Received: (qmail 29170 invoked by uid 102); 29 May 2014 23:41:11 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 29 May 2014 18:41:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 May 2014 19:41:09 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8BS_YhMB9ZZRx4faj=_YWZQrqm7B9AHkTGye=okja=m-Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250420>

On Fri, May 30, 2014 at 06:24:30AM +0700, Duy Nguyen wrote:

> >> I wonder if we can get away without SSE code by saving stat info of
> >> the packed-refs version that we have verified. When we read pack-refs,
> >> if stat info matches, skip check_refname_component(). Assuming that
> >> pack-refs does not change often, of course.
> >
> > Can you elaborate a bit more?
> 
> The first time we read packed_refs, check_refname_format() is called
> in read_packed_refs()->create_ref_entry() as usual. If we find no
> problem, we store packed_refs stat() info in maybe packed_refs.stat.
> Next time we read packed_refs, if packed_refs.stat is there and
> indicates that packed_refs has not changed, we can make
> create_ref_entry() ignore check_refname_format() completely.

I'm confused. Why would we re-open packed-refs at all if the stat
information hasn't changed?

read_packed_refs is only called from get_packed_ref_cache, and we only
do so if !refs->packed. And refs->packed is only NULL if we haven't read
the file yet, or it is stat-dirty.

If that is working as intended, then we should generally only open and
read packed-refs once per invocation of git.

-Peff
