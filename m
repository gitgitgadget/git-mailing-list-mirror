From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: linux-next: manual merge of the security-testing tree with the tree
Date: Thu, 30 Jun 2011 09:20:35 -0700
Message-ID: <BANLkTi=usrsF60Popfu55v3_dXe7Yo0GrA@mail.gmail.com>
References: <20110630142910.2fea4257.sfr@canb.auug.org.au> <20110630072559.GA4048@pengutronix.de>
 <20110630193023.6056d48e.sfr@canb.auug.org.au> <20110630121710.GJ11559@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	James Morris <jmorris@namei.org>, linux-next@vger.kernel.org,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: linux-kernel-owner@vger.kernel.org Thu Jun 30 18:21:28 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1QcJzb-0006bN-Gy
	for glk-linux-kernel-3@lo.gmane.org; Thu, 30 Jun 2011 18:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169Ab1F3QVT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 30 Jun 2011 12:21:19 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48770 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750928Ab1F3QVS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2011 12:21:18 -0400
Received: from mail-wy0-f174.google.com (mail-wy0-f174.google.com [74.125.82.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p5UGKuga031281
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL);
	Thu, 30 Jun 2011 09:20:58 -0700
Received: by wyg8 with SMTP id 8so1664722wyg.19
        for <multiple recipients>; Thu, 30 Jun 2011 09:20:56 -0700 (PDT)
Received: by 10.216.145.234 with SMTP id p84mr1872140wej.24.1309450856106;
 Thu, 30 Jun 2011 09:20:56 -0700 (PDT)
Received: by 10.216.66.132 with HTTP; Thu, 30 Jun 2011 09:20:35 -0700 (PDT)
In-Reply-To: <20110630121710.GJ11559@pengutronix.de>
X-Spam-Status: No, hits=-103.03 required=5 tests=AWL,BAYES_00,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176490>

2011/6/30 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
>
> A flag would be nice that does what I did: redo the merge and compare
> bcd05ca10420^{tree} with the result?

The problem with that is that it's *way* too expensive an operation to
do for the normal "git log" kind of operations.

Also, truly re-doing the merge actually requires workspace access
and/or require new objects to be created, so it would be inappropriate
anyway: git log/show absolutely has to be a read-only operation,
anything else would be totally insane.

So there's no way - both for performance and 'fundamental' reasons -
to make the normal logging code truly re-do the merge and then compare
the end result of the merge with the end result that is in the tree.

That said, what the current "git show/log" does is to just compare the
end points with the merge result, which means that if the end result
matches either of the end-points, nothing will be shown. That works
for the common cases, but it absolutely doesn't work if somebody does
something crazy, and just picks one end-point over another without
doing a proper merge (ie "-s ours" or just a mis-merge). But the
reason it's done that way is that it's possible to do without re-doing
the merge.

It would be lovely if "git show" (and log operations) had some option
to do a "expensive merge check" and did actually figure out the common
ancestor and at least took that into account.

It would be doable to do it at least better than we do now - the
common ancestor is not cheap to compute, but it's much cheaper than a
full merge, and would at least allow us to flag dangerous merges. Of
course, it gets fun when there are multiple common ancestors and
renames. It's entirely possible that it's never going to be practical
to do anything but "re-do the merge and compare result".

                      Linus
