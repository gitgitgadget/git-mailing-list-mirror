From: Jeff King <peff@peff.net>
Subject: [RFC] use typechange as rename source
Date: Wed, 21 Nov 2007 12:12:36 -0500
Message-ID: <20071121171235.GA32233@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 21 18:13:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iut8z-0002g1-W5
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 18:13:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751672AbXKURMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 12:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752686AbXKURMj
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 12:12:39 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3918 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751634AbXKURMi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 12:12:38 -0500
Received: (qmail 16130 invoked by uid 111); 21 Nov 2007 17:12:37 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 21 Nov 2007 12:12:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Nov 2007 12:12:36 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65684>

Today in one of my repositories I did something like this:

  $ mv foo bar
  $ ln -s bar foo
  $ git add .

and I expected git-status to claim:

  typechange: foo
  renamed:    foo -> bar

but it didn't find the rename (without -C) because the path 'foo' still
exists. So there is a disconnect in what git and I think of as "exists".
Should typechanges make a file eligible as a rename src?

A quickie patch to implement this is:

diff --git a/diffcore-rename.c b/diffcore-rename.c
index f9ebea5..5a34e8a 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -417,6 +417,10 @@ void diffcore_rename(struct diff_options *options)
 				p->one->rename_used++;
 			register_rename_src(p->one, p->score);
 		}
+		else if (DIFF_PAIR_TYPE_CHANGED(p)) {
+			p->one->rename_used++;
+			register_rename_src(p->one, p->score);
+		}
 		else if (detect_rename == DIFF_DETECT_COPY) {
 			/*
 			 * Increment the "rename_used" score by

There are a few add-on questions:

  - should typechanges in both directions be used, or just file ->
    symlink?

  - this actually produces a 'copied' status rather than a 'renamed'
    since the 'foo' entry does still exist. Is this reasonable?

-Peff
