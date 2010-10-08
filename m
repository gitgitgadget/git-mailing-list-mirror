From: Jeff King <peff@peff.net>
Subject: Re: Efficiently detecting paths that differ from each other only
 in case
Date: Fri, 8 Oct 2010 15:51:20 -0400
Message-ID: <20101008195120.GA10810@sigill.intra.peff.net>
References: <AANLkTimGAbosbD0pprROu_g-UW38faotYA2dTxj9scsP@mail.gmail.com>
 <20101008135034.GC5163@sigill.intra.peff.net>
 <AANLkTik6pSJFUkY9sooSH7iANaKLhxdN+ouKRXJn1B9G@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Dun Peal <dunpealer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 08 21:51:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4IyX-0001iu-0I
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 21:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932734Ab0JHTvS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Oct 2010 15:51:18 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:46915 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932336Ab0JHTvR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 15:51:17 -0400
Received: (qmail 30156 invoked by uid 111); 8 Oct 2010 19:51:15 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 08 Oct 2010 19:51:15 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Oct 2010 15:51:20 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTik6pSJFUkY9sooSH7iANaKLhxdN+ouKRXJn1B9G@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158529>

On Fri, Oct 08, 2010 at 02:44:05PM -0500, Dun Peal wrote:

> On Fri, Oct 8, 2010 at 8:50 AM, Jeff King <peff@peff.net> wrote:
> > You can do:
> >
> > =C2=A0git ls-files | tr A-Z a-z | sort | uniq -d
>=20
> Thanks, but the main issue is that this is a very large repository
> with tens of thousands of paths (files and directories).
>=20
> git ls-files thus takes a long time, almost a second. Since this is a
> commit-heavy repo, I'd rather avoid that overhead.

I don't think you will find a solution that is faster. ls-files is just
reading the list of files from git's index file. I'm not seeing anythin=
g
near that long to do an ls-files on my machine:

  $ cd linux-2.6
  $ git ls-files | wc -l
  34296
  $ time git ls-files >/dev/null
  real    0m0.034s
  user    0m0.028s
  sys     0m0.012s

One thing to consider, though, is if this is a hook running on the
server, you probably don't want to look at the index. You probably want
to look for duplicates in one tree entry (fed to the hook). So you woul=
d
be using git ls-tree, which probably is a bit slower.

-Peff
