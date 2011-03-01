From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 0/3] Fix unnecessary (mtime) updates of files during
 merge
Date: Tue, 1 Mar 2011 14:31:42 -0500
Message-ID: <20110301193142.GA10082@sigill.intra.peff.net>
References: <1298941732-19763-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com,
	Stephen Rothwell <sfr@canb.auug.org.au>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 20:31:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuVIK-0005XR-PK
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 20:31:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756244Ab1CATbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 14:31:35 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:50181 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752551Ab1CATbf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 14:31:35 -0500
Received: (qmail 9398 invoked by uid 111); 1 Mar 2011 19:31:32 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 01 Mar 2011 19:31:32 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Mar 2011 14:31:42 -0500
Content-Disposition: inline
In-Reply-To: <1298941732-19763-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168240>

On Mon, Feb 28, 2011 at 06:08:49PM -0700, Elijah Newren wrote:

> This patch series fixes a bug reported by Stephen Rothwell -- that
> during merges git would unnecessarily update modification times of
> files.

Thanks for the fix. Sorry I didn't have a chance to look at your interim
patch, but it seems you resolved the issue.

> There are two testcases included in this patch series.  The first is a
> simple case to test the originally reported bug; this testcase is
> fixed in this series (as is Stephen's original linux-next testcase).
> The second testcase suffers from the exact same problem, but arises
> from a different situation and is not fixed in this series.  That
> testcase is slightly harder to solve because:
> 
>   * unpack_trees + threeway_merge throws away the original index entry
>     with stat information when it notices the directory/file conflict
> 
>   * make_room_for_directories_of_df_conflicts() must remove such files
>     from the working copy or the corresponding directory and files
>     below it will be unable to be written to the working copy (which
>     can cause spurious conflicts, or make resolving conflicts very
>     hard for users who don't know how to access the many files missing
>     from their working copy).
> 
> We could fix this second testcase by recording stat information for
> files removed by make_room_for_directories_of_df_conflicts(), and
> then, if those files are reinstated at the end of conflict resolution
> (i.e. the directory of the D/F conflict went away during the merge),
> then call utime() to reset the modification times on those files back
> to what they originally were.

As you mention, this second testcase is not a regression at all, and
while it would be great if we could avoid touching those files at all, I
don't think anybody will be too upset at files being rewritten that were
actually involved in the conflict.

I think the fix you have for the first testcase is reasonable. It feels
a little like a band-aid, as we are throwing away stat information early
on and then pulling it again from the filesyste at the end. But from
your description, the real fix to that would probably involve some
changes to the way unpack_trees works, and that's probably complex
enough that the band-aid is a good fix for now.

-Peff
