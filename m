From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] Teach Git about the patience diff algorithm
Date: Fri, 2 Jan 2009 15:52:08 -0500
Message-ID: <20090102205208.GA9273@coredump.intra.peff.net>
References: <alpine.LFD.2.00.0901011134210.5086@localhost.localdomain> <20090101204652.GA26128@chistera.yi.org> <alpine.LFD.2.00.0901011747010.5086@localhost.localdomain> <20090102105537.GA14691@localhost> <20090102105856.GB14691@localhost> <alpine.LFD.2.00.0901020833000.5086@localhost.localdomain> <alpine.DEB.1.00.0901021918100.30769@pacific.mpi-cbg.de> <alpine.LFD.2.00.0901021050450.5086@localhost.localdomain> <20090102193904.GB9129@coredump.intra.peff.net> <20090102195053.GA10876@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Clemens Buchacher <drizzd@aon.at>,
	Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>,
	Pierre Habouzit <madcoder@debian.org>, davidel@xmailserver.org,
	Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 02 21:54:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIr1T-00028g-CS
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 21:53:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbZABUwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 15:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758458AbZABUwN
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 15:52:13 -0500
Received: from peff.net ([208.65.91.99]:1997 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758272AbZABUwM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 15:52:12 -0500
Received: (qmail 19484 invoked by uid 111); 2 Jan 2009 20:52:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 02 Jan 2009 15:52:09 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Jan 2009 15:52:08 -0500
Content-Disposition: inline
In-Reply-To: <20090102195053.GA10876@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104414>

On Fri, Jan 02, 2009 at 02:50:53PM -0500, Jeff King wrote:

> For example, f83b9ba209's commit message indicates that it moves the
> "--format-patch" paragraph. Which is what "git diff" shows. Patience
> diff shows it as moving other text _around_ that paragraph.

Here's another interesting one: d592b315. The commit removes dashes
from git commands in test scripts. Git says:

        echo "tag-one-line" >expect &&
-       git-tag -l | grep "^tag-one-line" >actual &&
+       git tag -l | grep "^tag-one-line" >actual &&
        test_cmp expect actual &&
-       git-tag -n0 -l | grep "^tag-one-line" >actual &&
+       git tag -n0 -l | grep "^tag-one-line" >actual &&
        test_cmp expect actual &&
-       git-tag -n0 -l tag-one-line >actual &&
+       git tag -n0 -l tag-one-line >actual &&
        test_cmp expect actual &&

whereas patience says:

        echo "tag-one-line" >expect &&
-       git-tag -l | grep "^tag-one-line" >actual &&
-       test_cmp expect actual &&
-       git-tag -n0 -l | grep "^tag-one-line" >actual &&
-       test_cmp expect actual &&
-       git-tag -n0 -l tag-one-line >actual &&
+       git tag -l | grep "^tag-one-line" >actual &&
+       test_cmp expect actual &&
+       git tag -n0 -l | grep "^tag-one-line" >actual &&
+       test_cmp expect actual &&
+       git tag -n0 -l tag-one-line >actual &&
        test_cmp expect actual &&

which is exactly what patience is advertised to do: it's treating the
non-unique lines as uninteresting markers. But in this case they _are_
interesting, and I think the git output is more readable. And this is a
case where your "weight lines by length instead of uniqueness"
suggestion would perform better, I think.

-Peff
