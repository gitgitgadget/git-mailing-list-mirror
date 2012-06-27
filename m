From: Jeff King <peff@peff.net>
Subject: Re: Bug: problem with file named with dash character
Date: Wed, 27 Jun 2012 18:41:29 -0400
Message-ID: <20120627224129.GA27566@sigill.intra.peff.net>
References: <80a7ce17-3ee7-4f09-b984-b6685e163b87@office.digitalus.nl>
 <7vk3ys8v96.fsf@alter.siamese.dyndns.org>
 <20120627195205.GA11700@sigill.intra.peff.net>
 <7vfw9g8pqn.fsf@alter.siamese.dyndns.org>
 <7vbok48pfu.fsf@alter.siamese.dyndns.org>
 <7v4npw8pdo.fsf@alter.siamese.dyndns.org>
 <7vzk7o7am5.fsf@alter.siamese.dyndns.org>
 <7vvcic7a6t.fsf@alter.siamese.dyndns.org>
 <20120627210039.GA2292@sigill.intra.peff.net>
 <7v7gus7625.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Lyubomirov <daniel@digitalus.bg>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 28 00:41:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sk0vZ-00061y-I9
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jun 2012 00:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756839Ab2F0Wld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 18:41:33 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:47348
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755655Ab2F0Wld (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 18:41:33 -0400
Received: (qmail 5520 invoked by uid 107); 27 Jun 2012 22:41:36 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Jun 2012 18:41:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Jun 2012 18:41:29 -0400
Content-Disposition: inline
In-Reply-To: <7v7gus7625.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200769>

On Wed, Jun 27, 2012 at 03:17:54PM -0700, Junio C Hamano wrote:

> > I think that's bad. I wonder if it should have "*" attributes applied to
> > it or not. While I can see it being convenient in some cases, I think it
> > makes the rules confusingly complex.
> 
> It is likely that the crlf conversion on Dos systems wants to be
> applied regardless.

Yeah, that's specifically the case I was thinking of. I would say "well,
we don't need to care about path at all, they can just use
core.autocrlf", but I think autocrlf is discouraged these days in favor
of using attributes.

> This is unrelated to the "standard input confusion" issue, but there
> are two more things coming either from the way the no-index code is
> done or from the way it is bolted onto git.
> 
> With the current code, this:
> 
> 	mkdir foo bar
>         echo hello >foo/1
>         echo bye >bar/2
>         git diff --no-index foo bar
> 
> shows differences between a/foo/1 and b/bar/1, as the no-index code
> records foo/1 and bar/1 as the paths in the filespec for them.
> 
> But if you are comparing two directory hierarchies, it is a lot more
> likely that you would want to see corresponding files in these two
> directories.  In other words, the patch is better shown as
> differences between a/1 and b/1 (the code makes the core compare
> foo/1 and bar/2 after all).  This of course requires no-index to
> differentiate the logical pathname (i.e. "this is the path inside
> collection a/ (or b/)") and the physical location from which the
> contents are read.  Such a differentiation would allow us to also do
> renames and rename classifications much more sanely.  We had to add
> DIFF_PAIR_RENAME() and filepair->renamed_pair only to support this
> codepath because of this misdesign.  We could have just run strcmp()
> between the logical pathname of one/two members of the filepair to
> see if the pair was renamed if it was done that way.

Yeah, that makes sense. Really you want to split the idea of
diff_filespec into a logical unit of "the thing I am diffing" and a
source struct of "here is where I get the data from". And the latter
could be a union of blob information, filesystem path, and stdin flag,
all contained inside the filespec.

> And the way diff-no-index.c::queue_diff() walks two directories to
> grab paths from them in parallel and incrementally means that the
> filesystem walking code cannot be reused for something like this:
> 
> 	git diff master:Documentation /var/tmp/docs
> 
> to compare a hierarchy represented with a tree object with another
> hierarchy stored in the filesystem outside git's control.  A natural
> way to do so would be to grab a set of paths from /var/tmp/docs and
> have that set compared against the other set that comes from the tree,
> and the "grab a set of paths from /var/tmp/docs" machinery can be
> used twice to implement the current
> 
> 	git diff --no-index /var/tmp/foo /var/tmp/bar
> 
> which would have been a lot cleaner implementation.

Agreed. I have occasionally wanted to do something like the tree
comparison you mentioned above, and I think I resorted to actually
making a git tree out of it.

All of that is nice, and if you feel like working on it, great. But I
admit I don't care too much about the --no-index code path. The key
thing to me is fixing the "-" path in the regular code path without
regressing the no-index stdin code-path too badly. And I think your
patches already do that, so it might be a good stopping point.

-Peff
