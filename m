From: Jeff King <peff@peff.net>
Subject: Re: GIT Performance question
Date: Sat, 17 Apr 2010 06:37:49 -0400
Message-ID: <20100417103748.GC23110@coredump.intra.peff.net>
References: <1271498149921-4917066.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: santos2010 <santos.claudia2009@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Apr 17 12:38:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O35Q6-0000iS-9b
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 12:38:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756175Ab0DQKiV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 06:38:21 -0400
Received: from peff.net ([208.65.91.99]:60589 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756136Ab0DQKiU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 06:38:20 -0400
Received: (qmail 16993 invoked by uid 107); 17 Apr 2010 10:38:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 17 Apr 2010 06:38:24 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Apr 2010 06:37:49 -0400
Content-Disposition: inline
In-Reply-To: <1271498149921-4917066.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145130>

On Sat, Apr 17, 2010 at 01:55:49AM -0800, santos2010 wrote:

> Our company is evaluating SCM solutions, one of our most important
> requirements is performance as we develop over 3 differents sites across the
> world.
> I read that GIT doesn't use deltas, it uses snapshots. My question is: how
> could GIT have high performance (most of the users say that) if for
> synchronization (pull/push command) with e.g. a shared repository GIT
> transfers all modified files (and references) instead of the respective
> deltas? 

Short answer: Git does store and transfer deltas. It generally beats any
other system in terms of repo size.

Longer answer:

Git separates the concept of the history graph and the actual storage
mechanism. So conceptually the history is a directed graph of snapshots,
each representing the whole tree. But there are two things that save
space:

  1. Git addresses content by its sha1. So each snapshot may refer to a
     file by the sha1 of its content, meaning we only have to store that
     content once.

  2. Git packs "objects" (where each file's content is in a single
     object) into "packfiles", in which it aggressively deltas objects
     against each other, including objects which do not come from the
     same path in your tree.

Git will store "loose" objects when performing most operations, but will
occasionally pack when the number of objects get too high. You can also
initiate a full pack by running "git gc".

For transferring between repositories, git will figure out which parts
of the history each side has, and will only send the objects that the
other side needs. In addition, it will send them as a packfile using
delta compression, including deltas against objects that are not being
sent but that it knows the other side has.

-Peff
