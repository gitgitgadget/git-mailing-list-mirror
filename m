From: Jeff King <peff@peff.net>
Subject: Re: git reset for index restoration?
Date: Thu, 22 May 2014 14:39:30 -0400
Message-ID: <20140522183930.GB1167@sigill.intra.peff.net>
References: <1400775763.1933.5.camel@stross>
 <CABPp-BHtYnput7SiAbnqUjpDibTi5o_2MAXfSj17fCdKSC7Hjg@mail.gmail.com>
 <1400782642.18134.8.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Elijah Newren <newren@gmail.com>,
	git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu May 22 20:39:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnXtv-00025f-TE
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 20:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbaEVSjc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 14:39:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:57563 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751729AbaEVSjb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 14:39:31 -0400
Received: (qmail 15089 invoked by uid 102); 22 May 2014 18:39:31 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 May 2014 13:39:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 May 2014 14:39:30 -0400
Content-Disposition: inline
In-Reply-To: <1400782642.18134.8.camel@stross>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249931>

On Thu, May 22, 2014 at 02:17:22PM -0400, David Turner wrote:

> In fact, git status does not write the index (at least in this context).
> And what is slow is not (only) checking over the working tree, but
> reading the packs.  There should be no need to read files from the ODB
> at all, since the index knows those objects' SHA1s, and it can check
> those against the working tree's SHA1s.  Interestingly, if strace is to
> be believed, git status doesn't even do check the working trees SHA1s
> after a git reset; maybe reset already sets the stat bits?

Keep in mind that "status" is running _two_ diffs. One between HEAD and
the index, and one between the index and the working tree.

Your timings might be more interesting just run "git diff-index --cached
HEAD", which is the index->HEAD half of that, ignoring the working tree
state entirely.

Naively, running that diff will involve walking the trees and the index
in parallel, which means opening a bunch of tree objects. The cache-tree
index extension, however, records tree sha1s, which means we can avoid
recursing into parts of the comparison.

Comparing the two:

  $ rm .git/index
  $ git reset
  $ time git diff-index --cached HEAD
  real    0m0.044s
  user    0m0.040s
  sys     0m0.000s

  $ git reset --hard
  $ time git diff-index --cached HEAD
  real    0m0.012s
  user    0m0.008s
  sys     0m0.000s

does show some improvement. Perhaps "git reset" is not writing out the
cache-tree extension?

-Peff
