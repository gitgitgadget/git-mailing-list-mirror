From: Jeff King <peff@peff.net>
Subject: Re: [BUG] git-svn parses --pretty=medium log output, fails when
 log.decorate is true
Date: Tue, 5 Oct 2010 12:58:31 -0400
Message-ID: <20101005165830.GA13413@sigill.intra.peff.net>
References: <1286273926.2364.6.camel@wpalmer.simply-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Wong <normalperson@yhbt.net>, git <git@vger.kernel.org>
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 18:58:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3AqM-0003ge-GV
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 18:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753157Ab0JEQ6O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 12:58:14 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:33438 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752627Ab0JEQ6N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 12:58:13 -0400
Received: (qmail 596 invoked by uid 111); 5 Oct 2010 16:58:12 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 05 Oct 2010 16:58:12 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Oct 2010 12:58:31 -0400
Content-Disposition: inline
In-Reply-To: <1286273926.2364.6.camel@wpalmer.simply-domain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158216>

On Tue, Oct 05, 2010 at 11:18:46AM +0100, Will Palmer wrote:

> I started receiving this error during "git svn dcommit" today:
> 
> Use of uninitialized value $hash in string eq
> at /home/wpalmer/libexec/git-core/git-svn line 1534.
> 
> Examining that section reveals that git-svn is running 
> "git log --no-color --first-parent --pretty=medium"
> 
> and parsing the output in order to find commit hashes and git-svn-id:
> lines. This breaks when log.decorate is true.
> 
> This could be patched-up by adding "--no-decorate" to the options
> git-svn passes, but that seems to me like it would just be adding to the
> pile, as "--pretty=medium" is a moving target. I assume the correct
> solution is to specify the format exactly as it is expected.

The problem isn't necessarily --pretty=medium, but that we are using
"git log" instead of "git rev-list" (though because "git log" does have
some features that rev-list does not have, we do turn off most
configurable features for "git log --pretty=raw").

So I think the simplest thing is just the patch below (which has only
been lightly tested by me):

-- >8 --
Subject: [PATCH] git-svn: use rev-list instead of log

We are parsing the output, so we don't want user
configuration like color or decorations to appear in the
output. The simplest way to accomplish this is to use the
rev-list plumbing instead of the log porcelain.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index d292224..03d93d8 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1514,7 +1514,7 @@ sub cmt_sha2rev_batch {
 
 sub working_head_info {
 	my ($head, $refs) = @_;
-	my @args = ('log', '--no-color', '--first-parent', '--pretty=medium');
+	my @args = ('rev-list', '--first-parent', '--pretty=medium');
 	my ($fh, $ctx) = command_output_pipe(@args, $head);
 	my $hash;
 	my %max;
-- 
1.7.3.1.158.g8f5ae
