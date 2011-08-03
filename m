From: Jeff King <peff@peff.net>
Subject: Re: git clone does not checkout active branch
Date: Wed, 3 Aug 2011 14:04:38 -0600
Message-ID: <20110803200438.GC23848@sigill.intra.peff.net>
References: <loom.20110803T185528-8@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Udo <u.offermann@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 22:04:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QohgN-0006gu-CR
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 22:04:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754757Ab1HCUEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 16:04:42 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36571
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752831Ab1HCUEl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 16:04:41 -0400
Received: (qmail 10023 invoked by uid 107); 3 Aug 2011 20:05:14 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 03 Aug 2011 16:05:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Aug 2011 14:04:38 -0600
Content-Disposition: inline
In-Reply-To: <loom.20110803T185528-8@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178617>

On Wed, Aug 03, 2011 at 04:56:43PM +0000, Udo wrote:

> I have a remote bare repository with two branches 'master' and 'testing', where
> HEAD refers to 'testing'. When cloning this repository git checks out 'master',
> if 'master' and 'testing' are on the same revision (i.e. HEAD == testing ==
> master). Only if 'testing' is one (or more) commit(s) behind or ahead, git clone
> checks out the 'testing' branch on the local side. I tried this with git 1.7.5
> on Mac OS X (10.6.8).

Yes, this is a known issue.

The git protocol just sends the list of refs and the objects they point
to. So the local clone is forced to guess which ref HEAD is pointing to.
E.g., with something like:

  28f599b... HEAD
  1234abc... refs/heads/master
  28f599b... refs/heads/testing

it can see that HEAD is probably "testing". But if it sees:

  28f599b... HEAD
  28f599b... refs/heads/master
  28f599b... refs/heads/testing

then it has to pick one arbitrarily. Our current heuristic is to prefer
"master" over others, and otherwise pick first alphabetically. So it's
at least deterministic, but as you noticed, it's not always right.

The real solution to this would be to extend the git protocol to convey
symbolic ref information (and then wait for both client and server to be
upgraded). Some patches have been floated in the past, but nothing came
of it[1]. Maybe it's time to resurrect them.

As a workaround, you can use "git clone -b testing ..." if you know
ahead of time that "testing" is what you want.

-Peff

[1] See:

    http://thread.gmane.org/gmane.comp.version-control.git/102039

and also:

    http://article.gmane.org/gmane.comp.version-control.git/113567
