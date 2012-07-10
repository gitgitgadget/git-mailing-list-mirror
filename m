From: Jeff King <peff@peff.net>
Subject: Re: "git commit --amend --only --" nevertheless commits staged
 changes
Date: Tue, 10 Jul 2012 16:11:25 -0400
Message-ID: <20120710201125.GA23798@sigill.intra.peff.net>
References: <4FFC06C9.5050405@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Marc Strapetz <marc.strapetz@syntevo.com>
X-From: git-owner@vger.kernel.org Tue Jul 10 22:11:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SogmT-00027l-0C
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 22:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752827Ab2GJUL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jul 2012 16:11:28 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:56831
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752757Ab2GJUL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2012 16:11:28 -0400
Received: (qmail 1923 invoked by uid 107); 10 Jul 2012 20:11:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Jul 2012 16:11:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jul 2012 16:11:25 -0400
Content-Disposition: inline
In-Reply-To: <4FFC06C9.5050405@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201274>

On Tue, Jul 10, 2012 at 12:41:13PM +0200, Marc Strapetz wrote:

> When using "git commit --amend --only --message <message> --", I'd
> expect to have just the commit message of my last commit changed,
> according to the man page:
> 
> "--only Make a commit only from the paths specified on the command line,
> disregarding any contents that have been staged so far. [...] If this
> option is specified together with --amend, then no paths need to be
> specified, which can be used to amend the last commit without committing
> changes that have already been staged."
> 
> However, all staged changes are committed as well. So looks like either
> the man page or Git is wrong here!?

I think git has a bug. As far as I can tell, this has never worked as
the documentation advertised. We originally forbid the use of "--only"
without paths as nonsensical. This was loosened by 6a74642 (git-commit
--amend: two fixes., 2006-04-20) to let "--amend --only --", but I don't
think it even worked then.

Using this test:

  git init repo &&
  cd repo &&
  echo "foo one" >foo &&
  echo "bar one" >bar &&
  git add . &&
  git commit -m one &&
  echo "foo two" >foo &&
  echo "bar two" >bar &&
  git add foo &&
  GIT_EDITOR=true git commit --amend -o &&
  git cat-file -p HEAD:foo &&
  git cat-file -p HEAD:bar

I always get:

  foo two
  bar one

i.e., we accidentally amend the commit with the staged contents in the
index. I get the same results for 6a74642 and on. If you switch the
commit to "-o bar", it does work properly (you get the updated "bar",
but the staged "foo" in the index is ignored).

-Peff
