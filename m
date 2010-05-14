From: Jeff King <peff@peff.net>
Subject: Re: Re: git log -M -- filename is not working?
Date: Fri, 14 May 2010 00:55:22 -0400
Message-ID: <20100514045522.GE6075@coredump.intra.peff.net>
References: <19428.24021.324557.517627@winooski.ccs.neu.edu>
 <20100508044434.GC14998@coredump.intra.peff.net>
 <19428.62170.654092.308682@winooski.ccs.neu.edu>
 <20100508053025.GG14998@coredump.intra.peff.net>
 <7v39y3c5p1.fsf@alter.siamese.dyndns.org>
 <19429.3589.823244.270582@winooski.ccs.neu.edu>
 <20100512113855.GB23847@coredump.intra.peff.net>
 <19434.39095.448649.313537@winooski.ccs.neu.edu>
 <20100512124948.GA11761@coredump.intra.peff.net>
 <19434.48308.815673.263230@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Eugene Sajine <euguess@gmail.com>,
	Bo Yang <struggleyb.nku@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Fri May 14 06:55:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCmvr-00082m-H9
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 06:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752239Ab0ENEz0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 00:55:26 -0400
Received: from peff.net ([208.65.91.99]:45767 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751522Ab0ENEzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 00:55:25 -0400
Received: (qmail 28562 invoked by uid 107); 14 May 2010 04:55:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 14 May 2010 00:55:25 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 14 May 2010 00:55:22 -0400
Content-Disposition: inline
In-Reply-To: <19434.48308.815673.263230@winooski.ccs.neu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147047>

On Wed, May 12, 2010 at 10:35:32AM -0400, Eli Barzilay wrote:

> But with `-p' it was doing something confusing: I used two files that
> were recently renamed, and the result was the correct log history, but
> the first patch that was shown (the rename) showed the two files as
> added.  (That's even when I added `-C' and `-M'.)  This happens even
> with a single path.  OTOH, using `--follow' with `-p' and a single
> path without your patch produces the expected result where the first
> patch is a rename (even without `-C'/`-M').

Ah, yeah, I see. The problem is that my code is doing something like:

  1. Do a sha1-only diff with our current path list.

  2. If there were any created files, they might be renames.
     Put aside the old diff results. Do a new diff, looking for renames.

  3. If there are renames, add them to our path list.

  4. Restore the old diff results.

  5. Proceed with other desired diff options (rename detection, showing
     patches, etc).

But the during step (5), remember that we are still working with the old
diff results, which will not include the expanded path. Thus we won't
consider the new path as a rename source, and will fail to find the
rename.

The naive right way would be to re-do step (1) with the expanded path.
But there is an optimization, since we can use the diff results from (2)
directly, including avoiding re-doing the rename detection.

The only "downside" is that it means --follow actually impacts the diff
generation by implying --find-copies-harder. And I put downside in
quotes because it is probably not a big deal. We have already spent the
CPU time to find the answer, so it is silly not to show it. I can't
imagine why somebody would want --follow, but would _not_ want rename
detection in the resulting diff.

Bo's version of the patch does that optimization. When I clean up the
patch (probably sometime next week), I'll take those changes.

-Peff
