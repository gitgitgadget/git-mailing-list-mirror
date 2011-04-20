From: Jeff King <peff@peff.net>
Subject: Re: Git notes list/show <revision-range>
Date: Wed, 20 Apr 2011 03:35:17 -0400
Message-ID: <20110420073517.GB1971@sigill.intra.peff.net>
References: <4DAC80CF.8020704@lyx.org>
 <20110418182724.GB11250@sigill.intra.peff.net>
 <4DAD371F.9040003@drmicha.warpmail.net>
 <20110419203211.GA12071@sigill.intra.peff.net>
 <4DAE8867.8010704@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vincent van Ravesteijn <vfr@lyx.org>,
	Git Mailing List <git@vger.kernel.org>, bebarino@gmail.com,
	johan@herland.net
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Apr 20 09:35:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCRwb-0004RF-Ab
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 09:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753854Ab1DTHfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2011 03:35:20 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53485
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753160Ab1DTHfT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2011 03:35:19 -0400
Received: (qmail 16999 invoked by uid 107); 20 Apr 2011 07:36:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Apr 2011 03:36:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Apr 2011 03:35:17 -0400
Content-Disposition: inline
In-Reply-To: <4DAE8867.8010704@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171847>

On Wed, Apr 20, 2011 at 09:16:55AM +0200, Michael J Gruber wrote:

> > So you could write:
> > 
> >   # long form, just as you can do with "git log"
> >   git notes log notes/commits -- ":(note):`git rev-parse HEAD`"
> 
> I don't think "notes log" should take a notes ref argument like that. It
> already has "--ref" for that purpose, so I would suggest
> 
> git notes [--ref <notesref>] log [<rev>]

Hmm. You are probably right. I was modeling it after "log", but it is a
notes subcommand. I was thinking you could also do something like:

  git notes log commits some-other-notes $sha1

or even

  # see what any notes ref has to say about this commit
  git notes log --all $sha1

but it is probably a better idea to keep the interface more consistent
with the other notes subcommands.

> git notes [--ref <notesref>] log [<rev>]
>
> with <rev> being mapped to :(notes):<rev> automatically, <rev>
> defaulting to HEAD. That is much more in line with the other notes
> subcommands. (We may or may note check for ":(notes):" being there already.)

I think it should be more like:

  git notes [--ref <notesref] log [<rev options>] [<rev> ...]

That is:

  1. There may be arbitrary rev options. Because you might want "log
     -p", or "log --format".

  2. We may want to allow multiple revs (e.g., if you have a patch
     series with 5 commits, you may want to see the history of any notes
     that refer to any of those commits).

I think (1) means we may need to feed the result to the revision
options-parser.

> > I think it would need a little refactoring of setup_revisions() to be
> > more flexible, but most of the hard work is already done by the usual
> > revision traversal mechanism.
> 
> ? I haven't checked in detail, but I think all we need is:
> 
> - Make "git notes --ref <notesref> log <rev>" call "git log
> <resolvednotesref> -- :(notes):<rev>" (and pass on log options).

I was worried about how to get the log options. If you see:

  git notes log --foo bar

is "bar" a revision, or an argument to --foo? I think right now the
answer is always "revision", but that is only because the revision
options do not currently use parse-options, which would allow
"--format=foo" to be written as "--format foo". So I'd rather not rely
on that.

> - Make the pathspec ":(notes):<rev>" resolve <rev> to <sha1> and match
> with all possible breakdowns of <sha1> which we accept for a notes tree.

I was assuming that :(notes): would only accept a sha1. But it probably
makes sense for it to handle resolution itself.

-Peff
