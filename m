From: Jeff King <peff@peff.net>
Subject: Re: sporadic git failures on interactive rebase
Date: Wed, 14 Jan 2015 07:35:36 -0500
Message-ID: <20150114123536.GA31530@peff.net>
References: <trinity-5098e61e-b59a-4225-9d4c-8879dc78bb53-1421146472532@3capp-gmx-bs08>
 <20150114121915.GB30383@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Henning Moll <newsScott@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 14 13:35:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBNAl-0003LX-J6
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 13:35:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704AbbANMfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 07:35:39 -0500
Received: from cloud.peff.net ([50.56.180.127]:34302 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752499AbbANMfi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 07:35:38 -0500
Received: (qmail 25014 invoked by uid 102); 14 Jan 2015 12:35:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jan 2015 06:35:38 -0600
Received: (qmail 2619 invoked by uid 107); 14 Jan 2015 12:35:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jan 2015 07:35:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Jan 2015 07:35:36 -0500
Content-Disposition: inline
In-Reply-To: <20150114121915.GB30383@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262381>

On Wed, Jan 14, 2015 at 07:19:15AM -0500, Jeff King wrote:

> Hmm. There are some instances in git where we know we are looking for an
> object of a particular type, and we can disambiguate a short-sha1 based
> on the type. And "git log" is just such a place, whereas a generic "git
> rev-parse" used by the git-rebase script would not be.
> [...]
>      I don't think
>      we _have_ a codepath to do type-dependent shortening, though, which
>      is maybe an indication that this is a red herring.

Yeah, I think this cannot be it. There is a 7-character commit/blob
ambiguity in git. You can find it yourself with:

  git rev-list --objects --all |
  cut -d' ' -f1 |
  sort | uniq -w 7 -D |
  git cat-file --batch-check |
  head -2

which produces:

  01319837c53050109c60e6740dfa9462327161f0 commit 649
  0131983dfbc143ce5dae77e067663bb2e7d5f126 blob 20638

And it behaves as expected. Running "git rev-parse 0131983" complains of
the ambiguity, but "git log 0131983" shows the commit.

What happens if we rebase with it?

  $ git checkout 01319837
  $ git rebase -i HEAD^

will yield a todo file with the 8-character unambiguous abbreviation.

So I guess all is working as intended there. Perhaps you really were
just very unlucky and an earlier step of the rebase created a
conflicting sha1.

-Peff
