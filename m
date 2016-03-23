From: Jeff King <peff@peff.net>
Subject: Re: "git tag --contains <id>" is too chatty, if <id> is invalid
Date: Wed, 23 Mar 2016 18:41:13 -0400
Message-ID: <20160323224113.GB12531@sigill.intra.peff.net>
References: <CAJj6+1Fcp+Fjx9N6Mon1A5uP-_npnPL1Acu5-cR_bHVfs3EMWA@mail.gmail.com>
 <20160319175705.GA6989@sigill.intra.peff.net>
 <CAJj6+1HaVnRcmDHOTDdx=o8a+aXvSi8+LykWzrfx7knE-_3ocg@mail.gmail.com>
 <20160319181228.GA9115@sigill.intra.peff.net>
 <CAJj6+1H6L=LxnDRzuC6OzXgVvzXsngGJ5X=E5Fi6Fg7JXkEJaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Chirayu Desai <chirayudesai1@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 23:41:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1airSr-000341-Bs
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 23:41:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754131AbcCWWlQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 18:41:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:37039 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752806AbcCWWlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 18:41:16 -0400
Received: (qmail 6401 invoked by uid 102); 23 Mar 2016 22:41:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 23 Mar 2016 18:41:15 -0400
Received: (qmail 4487 invoked by uid 107); 23 Mar 2016 22:41:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 23 Mar 2016 18:41:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Mar 2016 18:41:13 -0400
Content-Disposition: inline
In-Reply-To: <CAJj6+1H6L=LxnDRzuC6OzXgVvzXsngGJ5X=E5Fi6Fg7JXkEJaQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289688>

On Sun, Mar 20, 2016 at 12:19:46PM +0530, Chirayu Desai wrote:

> I went for 3, and have sent a patch for that here - [PATCH/GSoC]
> parse-options: Add a new nousage opt
> However, it currently has one bug
> Running 'git tag --contains qq' twice will first show an error, then
> print qq, meaning that the first command creates the tag qq.
> Running 'git tag -l --contains qq' works fine.
> My first question is if 'git tag --contains' (without '-l') supposed to work?
> If not, then I would fix that bug, otherwise fix the bug my code
> introduced, and add tests for it.

Yes, "--contains" should imply "-l", and we should complain if there is
an attempt to create a tag.

This seems to work with the tip of "master":

  $ git tag --contains v2.8.0-rc3
  v2.8.0-rc3
  v2.8.0-rc4

  $ git tag --contains qq
  error: malformed object name qq
  [...and then the usage...]

  $ git tag --contains HEAD qq
  fatal: --contains option is only allowed with -l.

  $ git rev-parse --verify qq
  fatal: Needed a single revision

but with your patch:

  $ git tag --contains qq
  error: malformed object name qq

  $ git rev-parse --verify qq
  e9cacb7f8231dd6616671f9bcdd0945043483064

So presumably we're not aborting the program when the options fail to
parse, and it continues to process the "qq" as a tag to be created.

-Peff
