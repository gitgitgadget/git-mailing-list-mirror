From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] lookup_commit_reference_gently: do not read
 non-{tag,commit}
Date: Thu, 30 May 2013 17:22:23 -0400
Message-ID: <20130530212223.GA2135@sigill.intra.peff.net>
References: <2d926e4dbd218b2305f50652c00a5c1d87e81208.1369943791.git.trast@inf.ethz.ch>
 <5cc40825d5b4fb3382e4c054c49adf5e6b6fe110.1369943791.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <kernel-hacker@bennee.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu May 30 23:22:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiAIq-0000Ll-8o
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 23:22:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757769Ab3E3VW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 17:22:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:52015 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757675Ab3E3VW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 17:22:26 -0400
Received: (qmail 29993 invoked by uid 102); 30 May 2013 21:23:07 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 30 May 2013 16:23:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 May 2013 17:22:23 -0400
Content-Disposition: inline
In-Reply-To: <5cc40825d5b4fb3382e4c054c49adf5e6b6fe110.1369943791.git.trast@inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226037>

On Thu, May 30, 2013 at 10:00:23PM +0200, Thomas Rast wrote:

> lookup_commit_reference_gently unconditionally parses the object given
> to it.  This slows down git-describe a lot if you have a repository
> with large tagged blobs in it: parse_object() will read the entire
> blob and verify that its sha1 matches, only to then throw it away.
> 
> Speed it up by checking the type with sha1_object_info() prior to
> unpacking.

This would speed up the case where we do not end up looking at the
object at all, but it will slow down the (presumably common) case where
we will in fact find a commit and end up parsing the object anyway.

Have you measured the impact of this on normal operations? During a
traversal, we spend a measurable amount of time looking up commits in
packfiles, and this would presumably double it.

This is not the first time I have seen this tradeoff in git.  It would
be nice if our object access was structured to do incremental
examination of the objects (i.e., store the packfile index lookup or
partial unpack of a loose object header, and then use that to complete
the next step of actually getting the contents).

-Peff
