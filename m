From: Jeff King <peff@peff.net>
Subject: Re: Cloning empty repositories, was Re: What is the idea for bare
	repositories?
Date: Sat, 17 Nov 2007 19:25:14 -0500
Message-ID: <20071118002514.GA4458@sigill.intra.peff.net>
References: <18232.35893.243300.179076@lisa.zopyra.com> <Pine.LNX.4.64.0711121727130.4362@racer.site> <vpq7iknqrtp.fsf@bauges.imag.fr> <Pine.LNX.4.64.0711121755460.4362@racer.site> <vpqy7d3pck0.fsf@bauges.imag.fr> <Pine.LNX.4.64.0711121804400.4362@racer.site> <vpqoddzpc88.fsf@bauges.imag.fr> <7v4pfr2kmh.fsf@gitster.siamese.dyndns.org> <87myth58r5.fsf@osv.gnss.ru> <7vfxz8hbcf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergei Organov <osv@javad.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bill Lear <rael@zopyra.com>,
	Jan Wielemaker <wielemak@science.uva.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 18 01:26:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItXzF-0007Ka-2P
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 01:26:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278AbXKRAZV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 19:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbXKRAZU
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 19:25:20 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4256 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751954AbXKRAZS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 19:25:18 -0500
Received: (qmail 6795 invoked by uid 111); 18 Nov 2007 00:25:16 -0000
Received: from ppp-216-106-96-70.storm.ca (HELO sigill.intra.peff.net) (216.106.96.70)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 17 Nov 2007 19:25:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Nov 2007 19:25:14 -0500
Content-Disposition: inline
In-Reply-To: <7vfxz8hbcf.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65325>

Junio, can I get an ACK or NAK on the patch below? There doesn't seem to
be a patch for making cloning empty repos work on the horizon, but can
we at least improve the error message?

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
