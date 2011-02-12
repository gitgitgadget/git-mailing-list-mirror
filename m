From: Jeff King <peff@peff.net>
Subject: [PATCH] git-gui: give more advice when detaching HEAD
Date: Sat, 12 Feb 2011 02:05:38 -0500
Message-ID: <20110212070538.GA2459@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Feb 12 08:05:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Po9YD-0007GH-0F
	for gcvg-git-2@lo.gmane.org; Sat, 12 Feb 2011 08:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499Ab1BLHFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Feb 2011 02:05:34 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:56985 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750950Ab1BLHFd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Feb 2011 02:05:33 -0500
Received: (qmail 31584 invoked by uid 111); 12 Feb 2011 07:05:31 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 12 Feb 2011 07:05:31 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 12 Feb 2011 02:05:38 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166595>

The current advice is a little sparse and dates back to
d41b43e (git-gui: Refactor branch switch to support detached
head, 2007-07-08). In the meantime, command-line git grew
much more detailed advice for this situation, especially in
13be3e3 (Reword "detached HEAD" notification, 2010-01-29).

Let's use that more detailed advice here.

Signed-off-by: Jeff King <peff@peff.net>
---
I recently helped somebody who had detached HEAD via git-gui, made a
bunch of commits, switched to another branch, and then became confused
about where his work went.

After working through what happened with him, I think this is one place
where we could have prevented the problem. And given that we saw the
need for more advice in the CLI, I think this change is a no-brainer.

I also think we could have saved him by doing one or more of:

  1. Give some indication or warning during commit that you're in a
     detached state. The CLI template says "You are not on any branch"
     when editing the commit message, and mentions "detached HEAD" as
     the branch in the post-commit summary. As far as I can tell,
     git-gui says nothing at all.

  2. When leaving the detached state, notice that we have commits not
     contained in any other ref and pop up an "are you sure you want to
     lose these commits" dialog, with an option to create a branch. This
     is something we considered and rejected for the CLI, but I wonder
     if it makes more sense for git-gui.

  3. Make it easier to create a new branch from the checkout dialog.
     Obviously I can go to "Branch->Create" and make a new branch from a
     remote one. But if my mental model is "Checkout", then I pick a
     remote branch, we may want to present the user with the decision
     _then_ about detaching or creating. Something as simple as a "make
     local branch from remote" checkbox would help. Or perhaps the
     "you're going to a detached HEAD" dialog should actually have a
     button to create a local branch right then and there instead. I
     dunno.

All of those things are too far beyond my scope of caring about git-gui
and wanting to write tcl to actually implement myself. But I thought I
would share them as thoughts that came from a real confused-user
interaction. Feel free to ignore.

 lib/checkout_op.tcl |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/lib/checkout_op.tcl b/lib/checkout_op.tcl
index 9e7412c..9c95208 100644
--- a/lib/checkout_op.tcl
+++ b/lib/checkout_op.tcl
@@ -449,9 +449,16 @@ method _after_readtree {} {
 	}
 
 	if {$is_detached} {
-		info_popup [mc "You are no longer on a local branch.
-
-If you wanted to be on a branch, create one now starting from 'This Detached Checkout'."]
+		info_popup [mc \
+"You are no longer on a local branch. You can look
+around, make experimental changes and commit,
+and you can discard any commits you make in this
+state without impacting any branches by
+performing another checkout.
+
+If you want to create a new branch to retain
+commits you create, you may do so (now or later)
+by starting from 'This Detached Checkout'."]
 	}
 
 	# -- Run the post-checkout hook.
-- 
1.7.4
