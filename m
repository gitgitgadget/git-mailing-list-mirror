From: Jeff King <peff@peff.net>
Subject: Re: many files, simple history
Date: Fri, 14 May 2010 00:05:59 -0400
Message-ID: <20100514040559.GB6075@coredump.intra.peff.net>
References: <AANLkTinHZbJ4obpa1FpT8boFWjNYpgU184HUTvki_A0G@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ali Tofigh <alix.tofigh@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 14 06:06:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCmAT-0008R6-7Y
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 06:06:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798Ab0ENEG0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 00:06:26 -0400
Received: from peff.net ([208.65.91.99]:54642 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750716Ab0ENEGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 00:06:25 -0400
Received: (qmail 27112 invoked by uid 107); 14 May 2010 04:06:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 14 May 2010 00:06:02 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 14 May 2010 00:05:59 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinHZbJ4obpa1FpT8boFWjNYpgU184HUTvki_A0G@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147042>

On Thu, May 13, 2010 at 10:57:22PM -0400, Ali Tofigh wrote:

> short version: will git handle large number of files efficiently if
> the history is simple and linear, i.e., without merges?

Short answer: large number of files, yes, large files, not really. The
shape of history is largely irrelevant.

Longer answer:

Git separates the conceptual structure of history (the digraph of
commits, and the pointers of commits to trees to blobs) from the actual
storage of objects representing that history. Problems with large files
are usually storage issues. Copying them around in packfiles is
expensive, storing an extra copy in the repo is expensive, trying deltas
and diffs is expensive. None of those things has to do with the shape of
your history. So I would expect git to handle such a load with a linear
history about as well as a complex history with merges.

For large numbers of files, git generally does a good job, especially if
those files are distributed throughout a directory hierarchy. But keep
in mind that the git repo will store another copy of every file. They
will be delta-compressed between versions, and zlib compressed overall,
but you may potentially be doubling the amount of disk space required if
you have a lot of uncompressible binary files.

For large files, git expects to be able to pull each file into memory.
Sometimes two versions if you are doing a diff. And it will copy those
files around when repacking (which you will want to do for the sake of
the smaller files). So files on the order of a few megabytes are not a
problem. If you have files in the hundreds of megabytes or gigabytes,
expect some operations to be slow (like repacking).

Really, I would start by just "git add"-ing your whole filesystem, doing
a "git repack -ad", and seeing how long it takes, and what the resulting
size is.

-Peff
