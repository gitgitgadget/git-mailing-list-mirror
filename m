From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] git-archive ignores remote .gitattributes
Date: Sun, 30 Mar 2008 20:07:25 -0700
Message-ID: <7vbq4vsiaa.fsf@gitster.siamese.dyndns.org>
References: <47EB0FAE.5000102@rea-group.com>
 <20080327033341.GB5417@coredump.intra.peff.net>
 <47EB213F.1020503@rea-group.com>
 <20080327042925.GA6426@coredump.intra.peff.net>
 <47EB271F.1050307@rea-group.com>
 <20080327045342.GC6426@coredump.intra.peff.net>
 <47EC7DD1.3060102@rea-group.com>
 <alpine.LSU.1.00.0803281321260.18259@racer.site>
 <20080331024755.GA690@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Toby Corkindale <toby.corkindale@rea-group.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 31 05:08:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgANi-0003Q4-BW
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 05:08:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753198AbYCaDHk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2008 23:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753182AbYCaDHk
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 23:07:40 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56517 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753175AbYCaDHj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2008 23:07:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 46C221603;
	Sun, 30 Mar 2008 23:07:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 421D91601; Sun, 30 Mar 2008 23:07:30 -0400 (EDT)
In-Reply-To: <20080331024755.GA690@coredump.intra.peff.net> (Jeff King's
 message of "Sun, 30 Mar 2008 22:47:55 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78547>

Jeff King <peff@peff.net> writes:

> I thought there was some discussion of that a while ago (or possibly of
> looking up .gitignore in the same way).

Perhaps we would want two distinct modes in dir.c (gitignore stack) and
attr.c (gitattributes stack).  The current code implements the normal mode
that uses the files from the work tree (so that you can modify .gitigore
and expect it to take effect immediately) and fall back to .index (as the
general principle, low-level part of git pretends missing files are
unmodified files when they can).  The new mode, which would be appropriate
for commands such as "archive", would be triggered by first declaring that
the program is going to work on a single tree object, and will cause the
gitignore and gitattributes to be read from that tree (and only that
tree).

Even a longer term clean-up would be (and this is probably a good GSoC
sized project):

 - Unify gitignore and gitattributes stacks;

 - Maintain two or more gitignore/gitattributes stacks in effect at the
   same time.  Things like "git diff-tree $tree1 $tree2", "git diff-index
   --cached $tree", "git diff-index $tree", and "git archive $tree" should
   take attr/ignore from their respective places.
