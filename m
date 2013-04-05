From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] t3600: test rm of path with changed leading symlinks
Date: Fri, 5 Apr 2013 01:04:24 -0400
Message-ID: <20130405050424.GA30533@sigill.intra.peff.net>
References: <20130404190621.GA7484@sigill.intra.peff.net>
 <7v6202hykh.fsf@alter.siamese.dyndns.org>
 <20130404195554.GA20823@sigill.intra.peff.net>
 <7v1uaqhwb4.fsf@alter.siamese.dyndns.org>
 <20130404210304.GA25811@sigill.intra.peff.net>
 <7vhajlgabi.fsf@alter.siamese.dyndns.org>
 <20130404232903.GA27128@sigill.intra.peff.net>
 <7vd2u9g9bg.fsf@alter.siamese.dyndns.org>
 <20130405000009.GA27775@sigill.intra.peff.net>
 <7vsj35efne.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: jpinheiro <7jpinheiro@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 05 07:05:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNypg-00066m-Nt
	for gcvg-git-2@plane.gmane.org; Fri, 05 Apr 2013 07:05:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752279Ab3DEFEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 01:04:31 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56803 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750738Ab3DEFEb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 01:04:31 -0400
Received: (qmail 10846 invoked by uid 107); 5 Apr 2013 05:06:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 05 Apr 2013 01:06:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Apr 2013 01:04:24 -0400
Content-Disposition: inline
In-Reply-To: <7vsj35efne.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220142>

On Thu, Apr 04, 2013 at 09:59:49PM -0700, Junio C Hamano wrote:

> > That means the worst case is not the accidental loss of content,
> > but rather confusion by the user when a copy of a file another
> > part of the tree is removed.
> 
> A copy of a file that is on the filesystem that may not be related
> to the project at all may be lost, and the user may not notice the
> lossage for quite a while.  A symlink that points at /etc/passwd may
> cause the file to be removed and the user will hopefully notice, but
> if the pointed-at file is something in $HOME/tmp/ that you occasionally
> use, you may not notice the lossage immediately, and when you notice
> the loss, the only assurance you have is that there is a blob that
> records what was lost _somewhere_ in _some_ of your project that had
> a symlink that points at $HOME/tmp/ at some point in the past.

It's actually quite hard to lose those files. We will only remove the
file if it has a matching index entry. So you cannot do:

  ln -s /etc foo
  git rm foo/passwd

because there is no index entry for foo/passwd. You would have to do:

  mkdir foo
  echo content >foo/passwd
  git add foo/passwd
  rm -rf foo
  ln -s /etc foo
  git rm foo/passwd

and then you only lose it if it matches exactly "content". And
recovering it, you know that the original path that held the content was
called "passwd". So yes, technically you could lose a file outside of
the repo and have trouble finding which path it came from later. But in
practice, not really.

Anyway, it is academic at this point. :)

-Peff
