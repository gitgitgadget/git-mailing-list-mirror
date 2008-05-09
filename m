From: Jeff King <peff@peff.net>
Subject: Re: git filter-branch --subdirectory-filter
Date: Fri, 9 May 2008 04:00:39 -0400
Message-ID: <20080509080039.GA15393@sigill.intra.peff.net>
References: <e5e204700805081801x314b02bek5d53a086b02dac83@mail.gmail.com> <20080509013300.GA7836@sigill.intra.peff.net> <e5e204700805090038k373bbabcyfb10d8c93ec5b3a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: James Sadler <freshtonic@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 10:01:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuNXi-00085R-SR
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 10:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754790AbYEIIAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2008 04:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751916AbYEIIAh
	(ORCPT <rfc822;git-outgoing>); Fri, 9 May 2008 04:00:37 -0400
Received: from peff.net ([208.65.91.99]:2111 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754790AbYEIIAg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2008 04:00:36 -0400
Received: (qmail 32660 invoked by uid 111); 9 May 2008 08:00:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 09 May 2008 04:00:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 May 2008 04:00:39 -0400
Content-Disposition: inline
In-Reply-To: <e5e204700805090038k373bbabcyfb10d8c93ec5b3a7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81606>

On Fri, May 09, 2008 at 05:38:12PM +1000, James Sadler wrote:

> I originally tried --subdirectory-filter by itself to see if it would
> do the job, but it filtered more commits than I thought it should
> (some commits that touched the subdir were missing after filter-branch
> was run).
> 
> I then began to question my understanding of the semantics of
> subdirectory-filter.
> 
> Is it meant to:
> A) Only keep commits where ALL of the changes in the commit only touch
> content under $DIR?
> B) Only keep commits where SOME of the changes in the commit touch
> content under $DIR?
> 
> I suspected that it was behaving as A.

My understanding is that it should behave as B. E.g.:

  git init
  mkdir subdir1 subdir2
  echo content 1 >subdir1/file
  echo content 2 >subdir2/file
  git add .
  git commit -m initial
  echo changes 1 >>subdir1/file
  git commit -a -m 'only one'
  echo more changes 1 >>subdir1/file
  echo more changes 2 >>subdir2/file
  git commit -a -m 'both'
  git filter-branch --subdirectory-filter subdir1
  git log --name-status --pretty=oneline

should show something like:

  b119e21829b6039aa8fe938fb0304a9a7436b84d both
  M       file
  db2ad8e702f36a1df99dd529aa594e756010b191 only one
  M       file
  dacb4c2536e61c18079bcc73ea81fa0fb139c097 initial
  A       file

IOW, all commits touch subdir1/file, which becomes just 'file'.

It could be a bug in git-filter-branch. What version of git are you
using?

-Peff
