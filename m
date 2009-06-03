From: Jeff King <peff@peff.net>
Subject: Re: Am able to delete a file with no trace in the log
Date: Wed, 3 Jun 2009 19:06:06 -0400
Message-ID: <20090603230606.GA5462@coredump.intra.peff.net>
References: <alpine.LFD.2.01.0906021439030.4880@localhost.localdomain> <7vfxeidqoz.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0906022000040.4880@localhost.localdomain> <7vtz2x6mor.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0906031431100.4880@localhost.localdomain> <7v8wk96knh.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0906031504080.4880@localhost.localdomain> <7vmy8p54fr.fsf@alter.siamese.dyndns.org> <20090603224413.GA2902@coredump.intra.peff.net> <alpine.LFD.2.01.0906031547480.4880@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Graham Perks <gperks@ausperks.net>,
	Git List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jun 04 01:06:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBzXN-00057u-0d
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 01:06:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753846AbZFCXGN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 19:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753608AbZFCXGM
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 19:06:12 -0400
Received: from peff.net ([208.65.91.99]:53116 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753031AbZFCXGM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 19:06:12 -0400
Received: (qmail 27626 invoked by uid 107); 3 Jun 2009 23:06:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 03 Jun 2009 19:06:20 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Jun 2009 19:06:06 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.01.0906031547480.4880@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120662>

On Wed, Jun 03, 2009 at 03:56:01PM -0700, Linus Torvalds wrote:

> > Is there a way to say "show me everything that touched x, _including_
> > merges"?
> 
> Well, that's the "--simplify-merges" part. 
> 
> It's just that our diff generation isn't very smart. We do show the 
> commit, we just don't show a meaningful diff in that case.

No, --simplify-merges doesn't show the merge, unless I am doing
something very wrong. Try (and this is a simplified version of the
original example):

  mkdir repo && cd repo && git init &&
  echo content >base && git add base && git commit -m base &&
  echo context >a.txt && git add a.txt && git commit -m 'master 1' &&
  git checkout -b other HEAD^ &&
  echo content >b.txt && git add b.txt && git commit -m 'other 1' &&
  echo conflict >a.txt && git add a.txt && git commit -m 'other 2' &&
  git checkout master &&
  git merge other ;# conflicts

  rm b.txt && git add b.txt &&
  echo resolve >a.txt && git add a.txt &&
  git commit -m merged

Now try running git log on that. I can see the merge diff if I use "-m",
which is obviously too verbose, but at least works. But if I give
"b.txt" as a path limiter, I can't get the merge commit to display at
all. Doing "git log -m --simplify-merges --stat -- b.txt" yields only
the commit "other 1" in which b.txt was added.

-Peff
