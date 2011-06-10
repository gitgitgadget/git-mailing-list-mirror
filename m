From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 06/19] git_remote_helpers: push all refs during a
 non-local export
Date: Thu, 9 Jun 2011 21:40:22 -0400
Message-ID: <20110610014022.GB12256@sigill.intra.peff.net>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
 <1307558930-16074-7-git-send-email-srabbelier@gmail.com>
 <20110608194205.GI27715@elie>
 <20110608221908.GB15530@sigill.intra.peff.net>
 <20110609080912.GB4885@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 03:40:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUqi8-0005Mj-Fx
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 03:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756527Ab1FJBk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 21:40:27 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58106
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753992Ab1FJBk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 21:40:27 -0400
Received: (qmail 22786 invoked by uid 107); 10 Jun 2011 01:40:33 -0000
Received: from 70-36-146-246.dsl.dynamic.sonic.net (HELO sigill.intra.peff.net) (70.36.146.246)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 09 Jun 2011 21:40:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Jun 2011 21:40:22 -0400
Content-Disposition: inline
In-Reply-To: <20110609080912.GB4885@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175593>

On Thu, Jun 09, 2011 at 03:09:12AM -0500, Jonathan Nieder wrote:

> If we imagine that the remote helper author wants to write as little
> code as possible (which seems reasonable), then probably their
> "export" command will simply feed its input to a vcs-fast-import
> program.  git fast-export doesn't know how to do ref mapping and
> neither would vcs-fast-import.  So one is led to wonder which stage in
> the pipeline can make the adaptations to make "git push hgrepo
> HEAD:refs/heads/bar" work.

Yeah, when writing the original series, I really had the thought that
the remote helper would be sitting in the middle and could do the
mapping. But really, not necessarily; the data is more likely to go
straight to an importer. And the mapping code may be ugly, which means
we want git itself to do the heavy lifting, not individual helpers.

> To be friendly to remote helper authors, it would be nice to take
> care of the ref mapping somewhere on the transport-helper side, unless
> fast-import learns a new mode that does not label its result with
> refs.  In the latter case, the "export" command could look like[*]
> 
> 	export :1 refs/heads/foo
> 	export :2 refs/heads/bar
> 	export :3 +refs/heads/force
> 
> with :1, :2, and :3 being marks in the fast-import stream.

I think we already have something like that with:

  reset refs/heads/foo
  from :1

in the import stream. And then that matches the concept that the helper
is really just pushing all of the work to that VCS's fast-import stream.
And _if_ we can convince fast-export to write a stream of commits that
are not on any particular ref, then we could just dump the ref-mapping
at the end of the export stream.

There's nowhere to talk about "forced" pushing there, though. We could
add in a "force" flag on that reset command. But it's not even
necessarily a concept that will map to other version control systems. I
wonder if it is simply something that we might have to live without
when moving commits between systems.

-Peff
