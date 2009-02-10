From: Jeff King <peff@peff.net>
Subject: Re: RFC: Flat directory for notes, or fan-out?  Both!
Date: Tue, 10 Feb 2009 07:18:33 -0500
Message-ID: <20090210121833.GC15491@coredump.intra.peff.net>
References: <alpine.DEB.1.00.0902092200170.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, spearce@spearce.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 10 13:20:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWrar-0006Pj-Uk
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 13:20:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754526AbZBJMSi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 07:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754271AbZBJMSh
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 07:18:37 -0500
Received: from peff.net ([208.65.91.99]:38535 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754154AbZBJMSg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 07:18:36 -0500
Received: (qmail 13208 invoked by uid 107); 10 Feb 2009 12:18:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 10 Feb 2009 07:18:51 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Feb 2009 07:18:33 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0902092200170.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109221>

On Mon, Feb 09, 2009 at 10:12:06PM +0100, Johannes Schindelin wrote:

> Shawn triggered some well needed thinking on my part about the notes 
> implementation.  At the moment, we have flat directory structure, and read 
> all of them in one go (when needed).
> 
> I think we should support that, because it is relatively easy to generate 
> that kind of trees for small-scale applications.

Hmm. Do we really care about how easy it is to generate? Are we
expecting people to not use the command interface and instead check out
a notes tree and start putting stuff into $commit/foo?

And if we are encouraging the dual possibilities, how do we handle the
case of merging two trees with equivalent but differently-formatted
content?

Imagine I have three users, A, B, and C, all collaborating on a project
with notes. A and B use the "git notes" interface which generates a
fan-out directory structure. C uses his own script that directly writes
to the notes tree without fan-out.

Now let's imagine A, B, and C all write a note for commit X, and A pulls
from the other two. When he pulls from B, there is a file-level
conflict, and he decides that his note is better and resolves in his
favor. But when he pulls from C, there is _no_ conflict, and now there
are two notes for the same commit in his notes tree. You can give the
multiple notes some sane semantics (one trumps the other, or they are a
list, or whatever), but there is still an inconsistency: B's notes and
C's notes behave differently. So now A has to start caring about how
other people generate their notes.

The only two solutions I can think of are:

  - when A pulls notes, he does a specialized merge that normalizes the
    note trees

  - particular notes trees are specified as being in "fan out" or "not
    fan out" mode. But there is no place to specify that to enforce it.

-Peff
