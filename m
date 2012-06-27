From: Jeff King <peff@peff.net>
Subject: Re: Bug: problem with file named with dash character
Date: Wed, 27 Jun 2012 17:00:39 -0400
Message-ID: <20120627210039.GA2292@sigill.intra.peff.net>
References: <52ae7682-3e9a-4b52-bec1-08ba3aadffc0@office.digitalus.nl>
 <80a7ce17-3ee7-4f09-b984-b6685e163b87@office.digitalus.nl>
 <7vk3ys8v96.fsf@alter.siamese.dyndns.org>
 <20120627195205.GA11700@sigill.intra.peff.net>
 <7vfw9g8pqn.fsf@alter.siamese.dyndns.org>
 <7vbok48pfu.fsf@alter.siamese.dyndns.org>
 <7v4npw8pdo.fsf@alter.siamese.dyndns.org>
 <7vzk7o7am5.fsf@alter.siamese.dyndns.org>
 <7vvcic7a6t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Lyubomirov <daniel@digitalus.bg>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 23:00:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjzLz-0001GP-MM
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 23:00:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163Ab2F0VAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 17:00:43 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:47249
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756274Ab2F0VAm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 17:00:42 -0400
Received: (qmail 3389 invoked by uid 107); 27 Jun 2012 21:00:46 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Jun 2012 17:00:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Jun 2012 17:00:39 -0400
Content-Disposition: inline
In-Reply-To: <7vvcic7a6t.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200751>

On Wed, Jun 27, 2012 at 01:48:42PM -0700, Junio C Hamano wrote:

> >>> It is not ready yet, but here are a few patches WIP.
> >>
> >> And this is the second clean-up
> >
> > And this is the third one.
> 
> Some of the other breakages that comes from the "no-index" codepath
> that we may want to consider addressing I have found so far are:

>From a cursory look, these definitely go in the right direction. I like
how the third one was able to rip populate_from_stdin entirely out of
diff.c.

I suspect we could get by without even the nongit_stdin flag you added;
the only place which uses it is diff_fill_sha1_info, but theoretically
we don't even need it there; we could just index_mem the file contents
we get via diff_populate_filespec, and the stdin contents will
already be there.

Right now we call index_path for worktree files, but I don't really see
much point; we have to read the whole data either way, and
populate_filespec should be mmap-ing them for us.

>  - We say on the "diff --git" header uglyness like "a/-", "b/-";
>    likewise in the metainfo;

I'd consider changing the path to "/dev/stdin" for this case. It doesn't
exist on some platforms, of course, but neither does /dev/null, which we
use similarly.

>  - We show on the "index" header "0*" value for these entries, even
>    though we should be able to compute it (after all we do so for
>    files on disk in a non-git directory);

The index_mem I mentioned above would fix that.

>  - We still apply attributes and textconv as if we are dealing with
>    a regular file "-" at the root level.

I think that's bad. I wonder if it should have "*" attributes applied to
it or not. While I can see it being convenient in some cases, I think it
makes the rules confusingly complex.

-Peff
