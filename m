From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/4] upload-archive: use start_command instead of fork
Date: Mon, 1 Aug 2011 11:46:03 -0600
Message-ID: <20110801174603.GB10302@sigill.intra.peff.net>
References: <1311012516-4836-1-git-send-email-kusmabite@gmail.com>
 <1311012516-4836-5-git-send-email-kusmabite@gmail.com>
 <7vmxga7zb9.fsf@alter.siamese.dyndns.org>
 <CABPQNSYtpRpNQVW=QvyfFhmWge5-C+k85bs2EJeK8k0jdfHzrw@mail.gmail.com>
 <20110728160845.GA14337@sigill.intra.peff.net>
 <20110728164758.GA15931@sigill.intra.peff.net>
 <20110728170222.GB15931@sigill.intra.peff.net>
 <CABPQNSaqyD+rhWPRbtVdnkweuXSycBahKEsasGZkEg3mi4SaxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	j6t@kdbg.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 01 19:46:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnwZC-0001k5-K4
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 19:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753891Ab1HARqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 13:46:10 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51259
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753598Ab1HARqI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 13:46:08 -0400
Received: (qmail 20284 invoked by uid 107); 1 Aug 2011 17:46:39 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 01 Aug 2011 13:46:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Aug 2011 11:46:03 -0600
Content-Disposition: inline
In-Reply-To: <CABPQNSaqyD+rhWPRbtVdnkweuXSycBahKEsasGZkEg3mi4SaxQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178362>

On Mon, Aug 01, 2011 at 04:45:03PM +0200, Erik Faye-Lund wrote:

> > And that patch would look something like the one below.
> 
> This is the most straight forward way of doing this, thanks. I'll post
> a new version with this squashed in soon.
> 
> What's the proper way of attributing you for the work?

If you're squashing, just make a note in the text, or add a Helped-by
header at the end.

> > You can also now
> > drop the "remote" parameter to write_archive entirely, but I didn't do
> > so here.
> 
> I'm not entirely sure how you propose we do this... do you mean by
> hoisting the relevant logic from write_archive up to cmd_archive or
> something?

Sorry, I wrote that comment, then totally changed how my patch was
implemented and failed to update the comment. :)

The arguments to git-archive actually get parsed in two places:

  1. cmd_archive passes them to decide on meta stuff like remote vs
     local

  2. write_archive has a parse_archive_args function to actually parse
     the arguments that both upload-archive and archive share

My patch puts the new argument in (1). We could put it in (2) and do
away with passing the flag all the way down the call stack. But it seems
conceptually cleaner to me to have it in (1) (and the diff is much
shorter, too).

> $ make t5000-tar-tree
> *** t5000-tar-tree.sh ***
> ok 1 - populate workdir
> <snip>
> ok 53 - infer tgz from .tar.gz filename
> not ok - 54 extract tgz file
> #
> #               $GUNZIP -c <j.tgz >j.tar &&
> #               test_cmp b.tar j.tar
> #
> not ok - 55 remote tar.gz is allowed by default
> #
> #               git archive --remote=. --format=tar.gz HEAD >remote.tar.gz &&
> #               test_cmp j.tgz remote.tar.gz
> #
> ok 56 - remote tar.gz can be disabled
> # failed 2 among 56 test(s)
> 1..56
> make: *** [t5000-tar-tree.sh] Error 1
> 
> It seems "git archive --format=tgz HEAD" is broken on Windows:
> $ git archive --format=tgz HEAD > j.tgz
> $ gunzip -c j.tgz > j.tar && echo ok
> 
> gzip: j.tgz: invalid compressed data--format violated
> 
> But if I perform the compression manually, the archive is fine:
> $ git archive --format=tar HEAD | gzip -cn > j.tgz
> $ gunzip -c j.tgz > j.tar && echo ok
> ok

Weird. What does j.tgz end up looking like? Is it empty, or does it have
bogus data in it? Does gzip actually get invoked at all? Try running
with GIT_TRACE=1. I don't suppose you guys have something like strace,
which might be helpful.

> So, the big question is, are all tar-filters broken on Windows? It
> seems not; the tests for the foo-filter works fine... any clues? Could
> it somehow be newline-related, perhaps?

I'm not sure that newlines would make a difference. We use straight
write() everywhere in the archive code, which should be binary safe.

-Peff
