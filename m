From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Documentation/git-diff: remove -r from --name-status
 example
Date: Sat, 28 Jul 2007 21:27:18 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707282119010.3442@woody.linux-foundation.org>
References: <20070729002427.GA1566@coredump.intra.peff.net>
 <alpine.LFD.0.999.0707281905050.3442@woody.linux-foundation.org>
 <20070729041159.GA5544@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Jon Smirl <jonsmirl@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jul 29 06:28:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IF0OG-0008HG-1d
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 06:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbXG2E2D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 00:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbXG2E2D
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 00:28:03 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:38751 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750708AbXG2E2A (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jul 2007 00:28:00 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6T4RP0J003233
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 28 Jul 2007 21:27:26 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6T4RIfQ007647;
	Sat, 28 Jul 2007 21:27:19 -0700
In-Reply-To: <20070729041159.GA5544@coredump.intra.peff.net>
X-Spam-Status: No, hits=-4.727 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.15__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54079>



On Sun, 29 Jul 2007, Jeff King wrote:
> 
> So if I "git diff" two commits with --raw or --name-status, we don't
> recurse into recurse into subdirectories (because they are actually
> subtrees).

Exactly.

As it pertains to "git diff", none of this actually makes sense, and I 
think it might make sense to make "git diff" automatically set 
"recursive", exactly because "git diff" sometimes operates on trees, and 
sometimes on the index.

> If I "git diff" a commit against the index using --raw or
> --name-status, I we do recurse (since the index is actually flat). But
> if I "git diff" using -p, --stat, or --summary, it _does_ recurse no
> matter what I'm diffing.

When you ask for patches, it has to recurse, because there is no way to 
show a patch for a directory. So yes, anything non-raw will always enable 
recursing.

The fact that "--name-status" is not considered a "patch" is an 
implementation detail, and I would _almost_ suggest that we just make it 
always recurse, and leave thenon-recursing case for _just_ "--raw". But 
that is a separate decision.

> Does anybody else find this behavior confusing? I can understand why
> diff-tree might not recurse by default, but I wonder if porcelain like
> git-diff should try to be a little more consistent and always recurse.

I do agree.

The behaviour is obviously historical, and comes from "git diff" being 
just a shell-script wrapper around the different versions of diffing trees 
and indexes etc.

So it makes sense in that historical setting (and realizing that the 
"HEAD<->index" and "index<->files" cases were really a totally different 
operations), but it makes no sense in the modern world where people don't 
even *know* about "git diff-tree", but just use "git diff" for everything.

So:

> Something like:

Ack. Patch looks fine, makes sense, and is obviously good.

It *is* a change in behaviour, though, so I can understand if Junio 
doesn't think it's appropriate this late in the 1.5.3 series.

> For comparison, whatchanged, show, and format-patch are already always
> recursive. log is not.

Yeah. The other cases already default to patches, so they get the 
recursive from there.

"git log", of course, defaults to no output at all, so the only way to get 
non-recursive behaviour is to ask for "--raw", and then having to specify 
explicitly whether to get recursion or not make sense. Once you want raw 
output, it really _is_ your choice.

Whether we should make "--name-status" default to "-r" is worth 
discussing. I don't have any really strong opinion, although I _suspect_ 
that we should. The non-recursive case is useful, but in a very limited 
sense, and I think we might as well limit it to just the --raw case.

		Linus
