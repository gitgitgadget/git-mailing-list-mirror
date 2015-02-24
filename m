From: Jeff King <peff@peff.net>
Subject: Re: assistance with git error
Date: Tue, 24 Feb 2015 16:56:58 -0500
Message-ID: <20150224215658.GA23488@peff.net>
References: <loom.20150224T213812-434@post.gmane.org>
 <20150224211136.GA32217@peff.net>
 <COL127-W1624CE9FAAEECB25DBE954A5160@phx.gbl>
 <20150224214500.GA23245@peff.net>
 <COL127-W7F78AD18199BF6C38EEA0A5160@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Thomas Moretto <tdmoretto@hotmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 22:57:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQNTX-0002uv-14
	for gcvg-git-2@plane.gmane.org; Tue, 24 Feb 2015 22:57:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953AbbBXV5B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2015 16:57:01 -0500
Received: from cloud.peff.net ([50.56.180.127]:52871 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752941AbbBXV5A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2015 16:57:00 -0500
Received: (qmail 8235 invoked by uid 102); 24 Feb 2015 21:57:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Feb 2015 15:57:00 -0600
Received: (qmail 9420 invoked by uid 107); 24 Feb 2015 21:57:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Feb 2015 16:57:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Feb 2015 16:56:58 -0500
Content-Disposition: inline
In-Reply-To: <COL127-W7F78AD18199BF6C38EEA0A5160@phx.gbl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264351>

On Tue, Feb 24, 2015 at 04:49:00PM -0500, Thomas Moretto wrote:

> i also have a question concerning large files.

Sure, but let's take it back on-list. Then other people can help answer,
and later users can benefit from seeing the answers.

> i ran a check and it said there was a schema.sql file that was 1.2G(i followed this guide:  http://stevelorek.com/how-to-shrink-a-git-repository.html)

Running verify-pack like that is slow. If you have a recent version of
git, you can use:

  git rev-list --objects --all |
  git cat-file --batch-check='%(objectsize:disk) %(objectname) %(rest)' |
  sort -rn

to get a sorted list of the largest objects that are reachable. If you
don't see your big object there, try doing:

  git rev-list --objects --reflog

for the first line, to see if it shows up in the reflog.

If the object is only in the reflog, the simplest thing is to expire the
reflog and repack:

  git reflog expire --expire-unreachable=now --all
  git gc --prune=now

If it is reachable, then you'll have to actually rewrite history to get
rid of it. Since you know the sha1 of the object, you can find which
commit introduced it with:

  sha1=...whatever...
  git log --all --no-abbrev --raw | less +/$sha1

That will dump you in less, with the sha1 highlighted (if it comes and
goes through history, you may need to use "/" to find other instances).

-Peff
