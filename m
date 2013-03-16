From: Jeff King <peff@peff.net>
Subject: [PATCH 0/3] fix unparsed object access in upload-pack
Date: Sat, 16 Mar 2013 06:24:28 -0400
Message-ID: <20130316102428.GA29358@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 16 11:25:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGoIO-0002lM-IX
	for gcvg-git-2@plane.gmane.org; Sat, 16 Mar 2013 11:25:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755602Ab3CPKYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Mar 2013 06:24:33 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53464 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755587Ab3CPKYc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Mar 2013 06:24:32 -0400
Received: (qmail 830 invoked by uid 107); 16 Mar 2013 10:26:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 16 Mar 2013 06:26:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 16 Mar 2013 06:24:28 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218294>

This series fixes the issue I mentioned recently with upload-pack, where
we might feed unparsed objects to the revision parser. The bug is in
435c833 (the tip of the jk/peel-ref topic), which is in v1.8.1 and up.

The fix should go to maint.  The bug breaks shallow clones from
repositories with packed refs, though the effects range from working OK
to sending too many objects to calling die() in the revision traversal
machinery. Given the size of the breakage (I had several bug reports
within a few hours of deploying v1.8.1.5 on github.com), and the fact
that the bug was introduced only in v1.8.1, it may make sense to roll a
v1.8.1.6 in addition to putting it on the 1.8.2 maint track.

  [1/3]: upload-pack: drop lookup-before-parse optimization

    This is just a cleanup, and is not necessary for the fix.

  [2/3]: upload-pack: make sure "want" objects are parsed

    This is the fix itself, which can stand alone from the other two
    patches, both semantically and textually.

  [3/3]: upload-pack: load non-tip "want" objects from disk

    While investigating the bug, I found some weirdness around the
    stateless-rpc check_non_tip code. As far as I can tell, that code
    never actually gets triggered. It's not too surprising that we
    wouldn't have noticed, because it is about falling back due to a
    race condition. But please sanity check my explanation and patch.

-Peff
