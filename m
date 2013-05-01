From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/5] t1508 (at-combinations): more tests; document
 failures
Date: Wed, 1 May 2013 17:16:13 -0400
Message-ID: <20130501211613.GA15392@sigill.intra.peff.net>
References: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
 <1367425235-14998-2-git-send-email-artagnon@gmail.com>
 <7va9oe5y6k.fsf@alter.siamese.dyndns.org>
 <CALkWK0nL+UvjsUKh6v4x_MaWJmsU6Uh_gh82iE7UT0UE-ZMt0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 23:16:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXeNy-00013e-6c
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 23:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757056Ab3EAVQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 17:16:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:50966 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756882Ab3EAVQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 17:16:16 -0400
Received: (qmail 7666 invoked by uid 102); 1 May 2013 21:16:32 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 01 May 2013 16:16:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 May 2013 17:16:13 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0nL+UvjsUKh6v4x_MaWJmsU6Uh_gh82iE7UT0UE-ZMt0g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223145>

On Thu, May 02, 2013 at 02:34:01AM +0530, Ramkumar Ramachandra wrote:

> Junio C Hamano wrote:
> > Just making sure.  HEAD@{$n} and @{$n} for non-negative $n mean
> > totally different things.  @{0} and HEAD@{0} are almost always the
> > same, and @{1} and HEAD@{1} may often happen to be the same, but as
> > a blanket statement, I find "Since HEAD is implicit in @{}" very
> > misleading.
> 
> When will they be different?  I'm looking at this from the parser's
> point of view: when the part before @{} is missing, we dwim a "HEAD".

The difference is that HEAD@{} refers to HEAD's reflog, but @{} refers
to the reflog of the branch pointed to by HEAD. For example, try:

  git init repo && cd repo
  git commit --allow-empty -m one &&
  git commit --allow-empty -m two &&
  git checkout HEAD^ &&
  git commit --allow-empty -m three &&
  git checkout master &&
  for i in 0 1 2; do
    echo "HEAD@{$i}: $(git log -1 --oneline HEAD@{$i} 2>&1)"
    echo "    @{$i}: $(git log -1 --oneline     @{$i} 2>&1)"
  done

which produces:

  HEAD@{0}: 1fbb097 two
      @{0}: 1fbb097 two
  HEAD@{1}: 42f3f4d three
      @{1}: 1089d0e one
  HEAD@{2}: 1089d0e one
      @{2}: fatal: Log for '' only has 2 entries.

Unless your reflogs are screwed up, the 0th reflog should always point
to the same commit (since you just moved HEAD there), but beyond that
there is not necessarily any relation. And even for the 0th reflog
entry, the reflog information is not the same. Try this on the repo
above:

  echo "HEAD@{0}: $(git log -g -1 --format='%gd %gs' HEAD@{0})"
  echo "    @{0}: $(git log -g -1 --format='%gd %gs'     @{0})"

which yields:

  HEAD@{0}: HEAD@{0} checkout: moving from ... to master
      @{0}: master@{0} commit: two

-Peff
