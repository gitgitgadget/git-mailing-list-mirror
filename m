From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] extend meaning of "--root" option to index
	comparisons
Date: Fri, 19 Sep 2008 13:39:48 -0400
Message-ID: <20080919173947.GA24541@sigill.intra.peff.net>
References: <3665a1a00809151301p7d8e6387g3cacfb879b45da2f@mail.gmail.com> <48CECA42.1050209@drmicha.warpmail.net> <bd6139dc0809151411p49f5adeaq4beff452574ca980@mail.gmail.com> <20080915223442.GD20677@sigill.intra.peff.net> <bd6139dc0809152319m31a79877h5dc1b701a8210802@mail.gmail.com> <20080916062105.GA12708@coredump.intra.peff.net> <20080918092152.GA18732@coredump.intra.peff.net> <3665a1a00809180931t191b5a24wd58554cdb761535@mail.gmail.com> <20080919142537.GA1287@coredump.intra.peff.net> <3665a1a00809190954q2473e164u5d80d3653d238a27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: sverre@rabbelier.nl, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Anatol Pomozov <anatol.pomozov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 19 19:41:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgjzH-0007yz-J9
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 19:41:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755319AbYISRj4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 13:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755310AbYISRj4
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 13:39:56 -0400
Received: from peff.net ([208.65.91.99]:2097 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753510AbYISRjz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 13:39:55 -0400
Received: (qmail 18494 invoked by uid 111); 19 Sep 2008 17:39:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 19 Sep 2008 13:39:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Sep 2008 13:39:48 -0400
Content-Disposition: inline
In-Reply-To: <3665a1a00809190954q2473e164u5d80d3653d238a27@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96303>

On Fri, Sep 19, 2008 at 09:54:15AM -0700, Anatol Pomozov wrote:

> I dont see how does log.showroot or core.showroot affect 'git log'.
> man git-log says nothing, git-config only mentions that initial commit
> is "a big creation event".

Try this:

  mkdir repo && cd repo && git init
  echo content >file && git add file && git commit -m initial
  git show ;# you see initial as creation event
  git config log.showroot false
  git show ;# you see commit log, but no diff
  git show --root ;# same as log.showroot=true

where of course the same holds for log, as show uses the same display
logic.

> But for me as for person that still actively works with Subversion it
> was quite surprising that I have error messages right after I created
> a fresh empty repo. I always thought that "Empty repo" -> "No history"
> -> "No log output"

I agree it is a bit nicer not to get an error in that situation. It is
really a result of the way git thinks of history. It is not "no history"
but rather "some history may or may not exist, but you have no valid
pointer to any history".

However, I wonder if it might be possible to special-case the "branch
yet to be born" case. That is, if HEAD points to a ref which does not
exist, can we treat that specially. I suspect it may turn out to be a
lot of work tracking down all of the spots in the code that would need
to be special-cased, which may make it not worthwhile.

> > Maybe it really is better to just force the caller to check the initial
> > commit condition. It's more work for them, but the semantics are simple
> > and unambiguous.
> 
> What is the best way to check that repo has valid HEAD? Check that
> file .git/HEAD exists?

No, HEAD will exist even in a just-created repo. But you can check
whether HEAD points to a valid commit:

  git rev-parse --verify HEAD

-Peff
