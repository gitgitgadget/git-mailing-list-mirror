From: Jeff King <peff@peff.net>
Subject: Re: git reflog delete / manpage confusion
Date: Thu, 1 Jul 2010 06:16:13 -0400
Message-ID: <20100701101613.GA1961@sigill.intra.peff.net>
References: <AANLkTik3bApuScgjXtr-VjhmY4NIuakoX_RZaYLqqpwL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Mahesh Vaidya <forvaidya@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 01 12:16:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUGog-0008FI-9W
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 12:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755160Ab0GAKQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 06:16:17 -0400
Received: from peff.net ([208.65.91.99]:48444 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754554Ab0GAKQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 06:16:16 -0400
Received: (qmail 2457 invoked by uid 107); 1 Jul 2010 10:17:09 -0000
Received: from c-67-172-213-4.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (67.172.213.4)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 01 Jul 2010 06:17:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Jul 2010 06:16:13 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTik3bApuScgjXtr-VjhmY4NIuakoX_RZaYLqqpwL@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150024>

On Thu, Jul 01, 2010 at 03:08:04PM +0530, Mahesh Vaidya wrote:

> git reflog delete HEAD{4} indeed deletes  HEAD{5} or N+1 ; is there a
> bug manpage or my interpretation ?

Hmm. I don't think the deletion is wrong, but rather the walker. Try:

  mkdir repo && cd repo && git init
  for i in 1 2 3 4 5; do
    echo $i >file && git add file && git commit -m file
  done
  git reflog -g --oneline >old
  git reflog delete HEAD@{3}
  git reflog -g --oneline >new
  diff -u old new

I get:

  --- old 2010-07-01 05:54:48.000000000 -0400
  +++ new 2010-07-01 05:54:48.000000000 -0400
  @@ -1,5 +1,4 @@
   01bb1c7 HEAD@{0}: commit: file
   c8020a8 HEAD@{1}: commit: file
   d82df6b HEAD@{2}: commit: file
  -364bcc0 HEAD@{3}: commit: file
  -2993260 HEAD@{4}: commit (initial): file
  +364bcc0 HEAD@{3}: commit (initial): file

So we give the proper reflog message (but note that HEAD@{4} has become
HEAD@{3}, because we always number compactly). But the sha1 still refers
to the deleted entry! We show the initial commit as creating 364bcc0,
when it didn't.

What happens is that there is a gap in the reflog (apologies for the
long lines):

  $ cat .git/logs/HEAD
  0000000000000000000000000000000000000000 299326064426c58bfec68b44b50a37fe7ec4e15e Jeff King <peff@peff.net> 1277978088 -0400    commit (initial): file
  364bcc0479c8b2d3a8a4be0cd67e46c81afafb03 d82df6b185d19134c7330cb93a7eb7c630b0714a Jeff King <peff@peff.net> 1277978088 -0400    commit: file
  d82df6b185d19134c7330cb93a7eb7c630b0714a c8020a8ead949ab725abc0dfe2345b2aeca6c145 Jeff King <peff@peff.net> 1277978088 -0400    commit: file
  c8020a8ead949ab725abc0dfe2345b2aeca6c145 01bb1c78a68703338810a559cdef270e10192fc3 Jeff King <peff@peff.net> 1277978088 -0400    commit: file

If I do "git show HEAD@{3}" I will properly get 2993260, and a warning:

  warning: Log .git/logs/HEAD has gap after Thu, 1 Jul 2010 05:54:48 -0400.

So I think that delete is behaving properly, but the reflog walker in
"git log -g" should be using the second field of HEAD@{3} to determine
the commit sha1, not the first field from HEAD@{2}. In the normal case
they are the same, but with a gap, they will be different (which should
also probably provoke us to print a gap warning as above).

I took a look at how hard this would be to fix. It looks like the wrong
sha1 is actually printed by the regular pretty-printer, which then calls
show_reflog_message() to show the actual entry. Which means we probably
need some special case hackery in show_log() to handle this case.

Shawn, any thoughts?

-Peff
