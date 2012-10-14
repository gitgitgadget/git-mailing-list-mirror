From: "George Spelvin" <linux@horizon.com>
Subject: Re: git reflog delete HEAD@{1} HEAD@{2} caught me by surprise...
Date: 14 Oct 2012 03:02:18 -0400
Message-ID: <20121014070218.16887.qmail@science.horizon.com>
References: <7vlif91wv6.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org
To: gitster@pobox.com, linux@horizon.com
X-From: git-owner@vger.kernel.org Sun Oct 14 09:02:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNIDW-0004Km-RY
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 09:02:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756Ab2JNHCU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 03:02:20 -0400
Received: from science.horizon.com ([71.41.210.146]:23524 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751589Ab2JNHCT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 03:02:19 -0400
Received: (qmail 16888 invoked by uid 1000); 14 Oct 2012 03:02:18 -0400
In-Reply-To: <7vlif91wv6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207644>

> I would actually call that behaviour a bug.

Well, yes, that was my inclination, too.  But writing documentation was
easier than writing a code patch.  :-)

Even when it is fixed, a comment about when it was fixed and what the
buggy version did should live in the BUGS section for a while, to warn
people writing portable scripts.

> Perhaps it should grab
> all the command line arguments first, group them per the ref the
> reflog entries are based on, and expire _all_ reflog entries from
> the same reflog in one go?

Two other options are to sort them in decreasing entry order (which you
could do either per-reflog, or simply globally), or to remember previous
deletions so you can adjust the numbers of later ones.

One tricky point is whether it's possible for a reflog to have two names,
via a symlink or something.  That definitely complicates collision
detection.

> Until that happens, it may make sense to error it out when more than
> one entries are given from the command line, at least for the same
> ref.

Detecting this seems like half the implementation work of fixing it,
so I'm not sure it's worth bothering.


Looking at the code (builtin/reflog.c), I notice that expire_reflog()
takes a lock on the ref, but the previous count_reflog_ent code doesn't,
so things aren't necessarily race-proof.  I haven't figured out if the
race is a problem (i.e. does expire_reflog do something nasty if the
struct cmd_reflog_expire_cb holds stale data?), but I noticed...
