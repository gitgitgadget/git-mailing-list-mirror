From: Jeff King <peff@peff.net>
Subject: Re: Cloning empty repositories, was Re: What is the idea for bare
	repositories?
Date: Thu, 15 Nov 2007 01:19:42 -0500
Message-ID: <20071115061941.GC10185@sigill.intra.peff.net>
References: <18232.35893.243300.179076@lisa.zopyra.com> <Pine.LNX.4.64.0711121727130.4362@racer.site> <vpq7iknqrtp.fsf@bauges.imag.fr> <Pine.LNX.4.64.0711121755460.4362@racer.site> <vpqy7d3pck0.fsf@bauges.imag.fr> <Pine.LNX.4.64.0711121804400.4362@racer.site> <vpqoddzpc88.fsf@bauges.imag.fr> <7v4pfr2kmh.fsf@gitster.siamese.dyndns.org> <87myth58r5.fsf@osv.gnss.ru> <7vfxz8hbcf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergei Organov <osv@javad.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bill Lear <rael@zopyra.com>,
	Jan Wielemaker <wielemak@science.uva.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 07:22:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsY7F-0006Dy-2U
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 07:22:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764083AbXKOGTt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 01:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764074AbXKOGTs
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 01:19:48 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2173 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764042AbXKOGTr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 01:19:47 -0500
Received: (qmail 6487 invoked by uid 111); 15 Nov 2007 06:19:45 -0000
Received: from ppp-216-106-96-30.storm.ca (HELO sigill.intra.peff.net) (216.106.96.30)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 15 Nov 2007 01:19:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Nov 2007 01:19:42 -0500
Content-Disposition: inline
In-Reply-To: <7vfxz8hbcf.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65065>

On Wed, Nov 14, 2007 at 11:32:32AM -0800, Junio C Hamano wrote:

> We already spent quite a lot of time on this thread, and at
> least to me I feel that my time would have been better spent if
> instead I were looking at patches on some other topics, or
> working on cleaning up cherry-pick/revert implementation.

Personally, I think cloning empty repositories should be allowed, but
there are many more interesting things to be working on right now.
However, I think the current behavior of not printing anything is quite
bad, so here is a productive email that didn't take too long to write.

-- >8 --
git-clone: print an error message when trying to clone empty repo

Previously, cloning an empty repository looked like this:

$ (mkdir parent && cd parent && git --bare init)
$ git-clone parent child
Initialized empty Git repository in /home/peff/clone/child/.git/
$ cd child
-bash: cd: child: No such file or directory
$ echo 'wtf?' | mail git@vger.kernel.org

Now we at least report that the clone was not successful.

---
diff --git a/git-clone.sh b/git-clone.sh
index 18003ab..e2b7a9c 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -278,7 +278,8 @@ yes)
 				      find objects -type f -print | sed -e 1q)
 			# objects directory should not be empty because
 			# we are cloning!
-			test -f "$repo/$sample_file" || exit
+			test -f "$repo/$sample_file" ||
+				die "fatal: cannot clone empty repository"
 			if ln "$repo/$sample_file" "$GIT_DIR/objects/sample" 2>/dev/null
 			then
 				rm -f "$GIT_DIR/objects/sample"
