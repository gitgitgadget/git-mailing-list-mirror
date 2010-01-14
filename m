From: Jeff King <peff@peff.net>
Subject: Re: touching a file causes it to be listed using git diff-files
Date: Wed, 13 Jan 2010 22:02:04 -0500
Message-ID: <20100114030204.GB1878@coredump.intra.peff.net>
References: <p0624080ec7740ddc4caf@[63.138.152.134]>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Stephen Bannasch <stephen.bannasch@deanbrook.org>
X-From: git-owner@vger.kernel.org Thu Jan 14 04:02:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVFyW-00013K-JD
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 04:02:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751960Ab0ANDCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 22:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500Ab0ANDCP
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 22:02:15 -0500
Received: from peff.net ([208.65.91.99]:54617 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751411Ab0ANDCO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 22:02:14 -0500
Received: (qmail 1925 invoked by uid 107); 14 Jan 2010 03:07:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 13 Jan 2010 22:07:04 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jan 2010 22:02:04 -0500
Content-Disposition: inline
In-Reply-To: <p0624080ec7740ddc4caf@[63.138.152.134]>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136924>

On Wed, Jan 13, 2010 at 06:57:28PM -0500, Stephen Bannasch wrote:

> If I touch a file in the working directory (only changing it's last-modified) attribute it shows up when running git diff-files.
> 
> If I then run git status followed by git diff-files again it doesn't show up either time.
> 
> Is this an error?

No. For performance reasons[1], plumbing commands like diff-files do not
update the index. You must run "git update-index --refresh" manually.

User-facing porcelain commands like "git diff" and "git status" will
refresh the index automatically. So "git status" will, as a side effect,
refresh the index and impact further calls to diff-files.

-Peff

[1] Refreshing the index needs to stat all of the files. If you are
writing a script using plumbing commands, you probably want to do the
possibly-expensive refresh once at the start of your script, and then
issue many diff commands. This makes a lot of sense for "diff-index",
which otherwise does not need to touch the working tree at all. I'm not
sure how much it helps with diff-files, though, which clearly ends up
stat'ing the working tree file anyway.
