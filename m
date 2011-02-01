From: Jeff King <peff@peff.net>
Subject: Re: [1.8.0] Remote tag namespace
Date: Tue, 1 Feb 2011 13:14:29 -0500
Message-ID: <20110201181428.GA6579@sigill.intra.peff.net>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 19:14:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkKkQ-0003P3-3E
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 19:14:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755715Ab1BASOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 13:14:32 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:45573 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755515Ab1BASOb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 13:14:31 -0500
Received: (qmail 21076 invoked by uid 111); 1 Feb 2011 18:14:30 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 01 Feb 2011 18:14:30 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Feb 2011 13:14:29 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165837>

On Tue, Feb 01, 2011 at 05:44:50PM +0700, Nguyen Thai Ngoc Duy wrote:

> OK I'm not familiar with tag code, but I can try.
> 
> Proposal:
> 
> Reserve refs/remote-tags namespace to store tags from remotes. Its
> structure is the same as in refs/remotes. When pulling tags, put them
> in refs/remote-tags/<remote> instead of refs/tags.
> Tag dereference code will be taught about refs/remote-tags with
> similar deref order as in remote branches.

There are similar questions around remote notes refs. Should there also
be a refs/remote-notes? And there was some discussion recently about
fetching remote replace refs.

Should we perhaps be massaging refs/remotes into a structure to handle
all of these things? Like:

  refs/remotes/origin/HEAD (-> refs/remotes/origin/heads/master)
  refs/remotes/origin/heads/master
  refs/remotes/origin/tags/v1.7.4
  refs/remotes/origin/notes/commit
  refs/remotes/origin/replace/f67e92af477a2255b64a1ece33d9d126e763fe9b

i.e., make refs/remotes/* an actual mirror of selected parts of the
remote's refs/ hierarchy. And then figure out sane rules for merging
those namespaces into the ref lookup procedure. For heads and tags,
probably some tweaking of the lookup rules in dwim_ref; for
replacements, probably you would want to manually say "I am interested
in this replace" and copy or symref-link it into your refs/ hierarchy.
And probably something similar with notes.

Obviously I haven't thought it all the way through, but it just seems a
shame not to deal with other similar issues when looking at tags.

-Peff
