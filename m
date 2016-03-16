From: Jeff King <peff@peff.net>
Subject: Re: Can't git stash after using git add -N
Date: Wed, 16 Mar 2016 17:05:35 -0400
Message-ID: <20160316210535.GA2200@sigill.intra.peff.net>
References: <20160315230754.GA12058@cloud>
 <xmqq8u1j7193.fsf@gitster.mtv.corp.google.com>
 <20160316020000.GB12130@cloud>
 <xmqqvb4n58ko.fsf@gitster.mtv.corp.google.com>
 <20160316120245.GA15091@cloud>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
X-From: git-owner@vger.kernel.org Wed Mar 16 22:05:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agIdT-0007hu-PX
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 22:05:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754425AbcCPVFj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 17:05:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:32779 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751621AbcCPVFi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 17:05:38 -0400
Received: (qmail 21545 invoked by uid 102); 16 Mar 2016 21:05:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Mar 2016 17:05:37 -0400
Received: (qmail 19958 invoked by uid 107); 16 Mar 2016 21:05:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Mar 2016 17:05:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Mar 2016 17:05:35 -0400
Content-Disposition: inline
In-Reply-To: <20160316120245.GA15091@cloud>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289034>

On Wed, Mar 16, 2016 at 05:02:45AM -0700, Josh Triplett wrote:

> On Tue, Mar 15, 2016 at 09:51:35PM -0700, Junio C Hamano wrote:
> > Josh Triplett <josh@joshtriplett.org> writes:
> > 
> > > As far as I can tell, if I run "git add -N" on a file, and then commit
> > > without adding the file contents, it gets committed as an empty file.
> > 
> > Is that true?  Git once worked like that in earlier days, but I
> > think write-tree (hence commit) would simply ignore intent-to-add
> > entries from its resulting tree.
> 
> Git 2.7.0 does appear to commit an empty file if I commit after git add
> -N.

I don't think this is the case:

  git init
  echo content >file
  git add -N file
  git commit -m "empty?"

  git ls-tree HEAD
  git status

shows that we committed an empty tree. So I see two obvious
possibilities for improvement:

  1. This commit should have failed without --allow-if-empty. We need to
     be more careful about intent-to-add entries when figuring out if
     the commit would be empty or not

  2. I'm not sure if "silently ignore intent-to-add" is the best policy.
     At least a warning ("hey, what did you want to do with these
     entries") seems merited, if not aborting the commit entirely. I
     hesitate on the latter only because perhaps that would mess up
     somebody's legitimate workflow.

-Peff
