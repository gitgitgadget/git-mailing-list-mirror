From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/5] refactor userdiff textconv code
Date: Fri, 24 Oct 2008 18:50:01 -0400
Message-ID: <20081024225001.GA13978@coredump.intra.peff.net>
References: <20081024024631.GA20365@coredump.intra.peff.net> <20081024025330.GC2831@coredump.intra.peff.net> <7v3ail3dfy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 25 00:51:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtVV2-0002Yi-VC
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 00:51:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbYJXWuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 18:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbYJXWuF
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 18:50:05 -0400
Received: from peff.net ([208.65.91.99]:4075 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751529AbYJXWuE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 18:50:04 -0400
Received: (qmail 24983 invoked by uid 111); 24 Oct 2008 22:50:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 24 Oct 2008 18:50:02 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Oct 2008 18:50:01 -0400
Content-Disposition: inline
In-Reply-To: <7v3ail3dfy.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99078>

On Fri, Oct 24, 2008 at 02:12:17PM -0700, Junio C Hamano wrote:

> Either that or drop data_is_textconv and have two sets of <ptr,size> pair
> in filespec, one for real data and another purely for diff text
> generation.

I thought about that. My reasoning against it was two-fold:

 1. We don't want to keep two copies in memory unnecessarily. Of
    course, we could easily free the original, but just store the
    information in a different pointer to make sure they never get
    confused. So that is a non-issue.

 2. I had some vague notion that it is more convenient in the long run
    to do this to the filespec, since we can then transparently pass the
    munged filespec around and pretend like the converted text was the
    original content.

    However, I'm not sure exactly _where_ we would want to do this.
    The obvious places are for patch, for diffstat, or for whitespace
    checking. But all of those places use mmfile, so we can munge them
    in the same way. I haven't looked at using this with blame, but I do
    think "git blame --textconv foo.jpg" would be useful.

    (Actually not true. I did just look for 30 seconds at using this
     with blame, but blame doesn't seem to to use builtin_diff at all).

> That is, you let fill_mmfile() to fill the real data in mf1 and mf2 as
> before, ask one/two if they have textconv, and if so, convert mf1 and mf2
> in place, and let xdl work on it, like...

I think your example would work fine, if there is no other advantage to
having a transparently-munged diff_filespec (as above).

-Peff
