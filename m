From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] Add init-serve, the remote side of "git init
	--remote=host:path"
Date: Sun, 1 Mar 2009 05:00:39 -0500
Message-ID: <20090301100039.GD4146@coredump.intra.peff.net>
References: <1235865822-14625-1-git-send-email-gitster@pobox.com> <1235865822-14625-2-git-send-email-gitster@pobox.com> <1235865822-14625-3-git-send-email-gitster@pobox.com> <20090301031609.GA30384@coredump.intra.peff.net> <7v63itbxe7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 11:02:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdiV8-0003s4-AW
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 11:02:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756145AbZCAKAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2009 05:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756035AbZCAKAs
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 05:00:48 -0500
Received: from peff.net ([208.65.91.99]:50646 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755620AbZCAKAr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 05:00:47 -0500
Received: (qmail 30414 invoked by uid 107); 1 Mar 2009 10:00:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 01 Mar 2009 05:00:45 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 01 Mar 2009 05:00:39 -0500
Content-Disposition: inline
In-Reply-To: <7v63itbxe7.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111833>

On Sat, Feb 28, 2009 at 09:54:56PM -0800, Junio C Hamano wrote:

> One issue I did not describe in the message was to what extent we would
> want to allow operations other than the creating of a new repository
> itself.
> 
> "Other than the creation" includes things like these:

Hmph. I am not too excited by this list. What is the advantage of doing
them over the git protocol versus some out-of-band method?

It seems to me there are two main cases for dealing with a remote in
this way:

  1. You have shell access and a uid on the remote, but it is
     inconvenient to ssh across, find the repo (which may already be
     known locally by remote.*.url config), and then execute some
     commands.

     In this scenario, there really are no security concerns; you could
     have logged in and done all of this anyway. So it seems like a more
     natural fit would be a _client_ program that figures out what shell
     snippet you want to execute, connects to the remote, and does it.

  2. Your access on the remote is very restricted, you may not have your
     own uid, and hooks may be enforcing arbitrary security policy.

     In this case, even something as simple as chgrp seems like it could
     be a problem, depending on the remote's setup (e.g., because all
     users connect as one uid, but group permissions are somehow
     meaningful to the system; this implies that connecting users should
     not be able to arbitrarily chgrp their repos, even if chgrp itself
     allows it).

     Furthermore, in the case of many providers (e.g., github,
     repo.or.cz), there is already a separate out-of-band interface for
     doing "meta" stuff, like managing user accounts and repos. Isn't it
     more natural for them to integrate these features with their
     existing interfaces?

But let's say that there really is some value in setting up this
channel (because we want a uniform way of doing these things so we can
add more automated tool support from the client side). Then I think it
makes sense to look at what the people in (2) above are doing already.
That is, what sorts of things can you already do (and not do) in
github's or repo.or.cz's interface? On top of that, it probably makes
sense to ask them if they are interested in such a feature, as they
would be primary users. And if they are, what do they want out of it?

-Peff
