From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Bugfix: GIT_EXTERNAL_DIFF with more than one changed
	files
Date: Fri, 13 Feb 2009 13:07:40 -0500
Message-ID: <20090213180740.GA31860@coredump.intra.peff.net>
References: <20090212133614.GA12746@bigbear> <20090212140740.GB3057@coredump.intra.peff.net> <7vskmjl729.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nazri Ramliy <ayiehere@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 19:09:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LY2TP-00031v-KP
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 19:09:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753254AbZBMSHn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 13:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752879AbZBMSHn
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 13:07:43 -0500
Received: from peff.net ([208.65.91.99]:50009 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752841AbZBMSHn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 13:07:43 -0500
Received: (qmail 25298 invoked by uid 107); 13 Feb 2009 18:08:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 13 Feb 2009 13:08:00 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Feb 2009 13:07:40 -0500
Content-Disposition: inline
In-Reply-To: <7vskmjl729.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109768>

On Thu, Feb 12, 2009 at 12:43:42PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So this bug should trigger only in the face of reusing worktree files. I
> > checked your test; it constructs a diff between the worktree and the
> > index, so it correctly finds the problem.
> >
> > Acked-by: Jeff King <peff@peff.net>
> 
> Thanks, both.
> 
> Jeff, according to your analysis, this shouldn't trigger when
> core.autocrlf is set, should it?

Depending on the diff you are doing. If one of the sides is the
worktree, then we should always be using the worktree file. But for
"diff --cached" it depends on the file contents matching the index (in
theory, it would work for arbitrary tree diffs when one side matches the
worktree, but see the comment in reuse_worktree_file -- if nobody has
looked at the cache already, we don't load it just for this).

I tried to construct a simple test that shows this behavior, but I
couldn't. I did:

  mkdir repo && cd repo && git init

  git config core.autocrlf true

  printf 'one\r\n' >file1
  printf 'one\r\n' >file2
  git add .
  git commit -m one

  printf 'two\r\n' >file1
  printf 'two\r\n' >file2
  git add -u

  PAGER=cat GIT_EXTERNAL_DIFF=echo git diff --cached

which should fail without the core.autocrlf setting, but work otherwise.
But it doesn't, and the reason is that the content in the index actually
has the CRLF:

  $ xxd < file1
  0000000: 7477 6f0d 0a                             two..
  $ git cat-file blob :file1 | xxd
  0000000: 7477 6f0d 0a                             two..

which has me confused. Am I using autocrlf wrong? I have been fortunate
enough in the past never to work on filesystems that needed such a
thing.

-Peff
