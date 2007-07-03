From: Jeff King <peff@peff.net>
Subject: Re: git-rm isn't the inverse action of git-add
Date: Tue, 3 Jul 2007 00:59:48 -0400
Message-ID: <20070703045948.GE4007@coredump.intra.peff.net>
References: <46893F61.5060401@jaeger.mine.nu> <20070702194237.GN7730@nan92-1-81-57-214-146.fbx.proxad.net> <46895EA4.5040803@jaeger.mine.nu> <20070702204051.GP7730@nan92-1-81-57-214-146.fbx.proxad.net> <46896C3B.1050406@jaeger.mine.nu> <20070703041241.GA4007@coredump.intra.peff.net> <7vhcomt7oa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Jaeger <christian@jaeger.mine.nu>,
	Yann Dirson <ydirson@altern.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 06:59:57 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5aUX-0003Ng-2A
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 06:59:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245AbXGCE7v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 00:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752149AbXGCE7v
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 00:59:51 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2424 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752133AbXGCE7u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 00:59:50 -0400
Received: (qmail 26450 invoked from network); 3 Jul 2007 05:00:11 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 3 Jul 2007 05:00:11 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jul 2007 00:59:48 -0400
Content-Disposition: inline
In-Reply-To: <7vhcomt7oa.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51456>

On Mon, Jul 02, 2007 at 09:47:33PM -0700, Junio C Hamano wrote:

> These were explicitly done per request from git-rm users (myself
> not one of them) who wanted to:
> 
> 	rm the-file
>         git rm the-file

Ah, makes sense (if such a thing can be said about CVS behavior).

> > H I W | ok? | why?
> > ---------------------------------------------------
> > N A N |  ?  | currently ok, but 'A' recoverable only through fsck
> > N A A |  ?  | currently not ok, but 'A' still available in W
> > A A B |  ?  | currently not ok, but 'A' still available in H
> > A B N |  ?  | currently ok, but 'B' recoverable only through fsck
> > A B B |  ?  | currently not ok, but 'B' still available in W
> 
> I personally do not think we would need any safety check for
> "git rm --cached", as it does not touch the working tree.  If

It depends on how we want to define "lost" data. In many cases, we are
protecting against losing content that will still be available until the
next git-prune. Should our safety valve protect against that case, or
should it not? We are totally inconsistent.

The main one for --cached, of course, is when that content exists _only_
in the index, but no longer in the working tree (!A A N or !A A B).  You
really should be using regular git-rm (in the first case, since you are
saying "I don't want this file anymore") or git-add (throw out the old
data, use my new version).

OTOH, clearly git-add can "lose" data in this way as well, since a
"modify, git-add, modify, git-add" will "lose" any reference to the
index state after the first add. So maybe that is not worth worrying
about at all (in which case our safety valve is too strict in many
places).

We could also issue a warning when "losing" reference to data that is in
the object db, which would include the sha1; in that case, an immediate
"oops" could be rectified with git-show.

> one cares about the differences among three states, one would
> not issue "rm --cached" anyway.  The only reason "rm --cached"
> is used is because one _knows_ that any blob should not exist at
> that path in the index.

How about:

  git-add foo
  echo changes >>foo
  # oops, I don't want to commit foo just yet
  git-rm --cached foo

but in that case, maybe the user doesn't actually _care_ about that
intermediate state of 'foo'.

-Peff
