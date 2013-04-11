From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] transport-helper: update remote helper namespace
Date: Thu, 11 Apr 2013 00:33:46 -0400
Message-ID: <20130411043346.GE14551@sigill.intra.peff.net>
References: <1365638832-9000-1-git-send-email-felipe.contreras@gmail.com>
 <1365638832-9000-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 11 06:34:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ9Cw-0001uf-H3
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 06:33:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753083Ab3DKEdy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 00:33:54 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39681 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753074Ab3DKEdx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 00:33:53 -0400
Received: (qmail 11521 invoked by uid 107); 11 Apr 2013 04:35:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 11 Apr 2013 00:35:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Apr 2013 00:33:46 -0400
Content-Disposition: inline
In-Reply-To: <1365638832-9000-3-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220816>

On Wed, Apr 10, 2013 at 07:07:12PM -0500, Felipe Contreras wrote:

> When pushing, the remote namespace is updated correctly
> (e.g. refs/origin/master), but not the remote helper's
> (e.g. refs/testgit/origin/master).
> 
> Let's update it correctly.

I would have thought it was the helper's responsibility to update these.
Obviously remote-testgit can handle this fine, but will any other
helpers be using these refs as a marker to know the last point they
imported, and get confused if we update the refs behind their back?

For example, during the import, a helper might know that it has imported
up to X on a foreign vcs, and that resulted in commit Y in git, which it
stored in refs/$helper/heads/master during the last import. When we
fetch from it again, it picks up from X to the tip of the foreign vcs,
and then imports that history on top of commit Y.

But if we push some commits to the helper, moving Y up to Z, then it
would build the new commit (which contains the foreign-vcs's equivalent of
Y..Z) on top of Z, not Y.

I do not offhand know of any helpers that are implemented this way,
though. vcs-svn does not seem to use the refspec feature at all, and I
assume that your hg/bzr helpers do not have this problem. So perhaps it
is not worth worrying about.

-Peff
