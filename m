From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-apply{,mbox,patch} should default to --unidiff-zero
Date: Thu, 05 Jul 2007 22:41:51 -0700
Message-ID: <7vd4z6gkbk.fsf@assigned-by-dhcp.cox.net>
References: <20070705232210.GR3492@stusta.de>
	<Pine.LNX.4.64.0707060217460.9789@racer.site>
	<20070706014222.GK3492@stusta.de>
	<Pine.LNX.4.64.0707060243110.4093@racer.site>
	<20070706022629.GL3492@stusta.de>
	<Pine.LNX.4.64.0707060413190.4093@racer.site>
	<alpine.LFD.0.98.0707052108070.9434@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Adrian Bunk <bunk@stusta.de>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jul 06 07:42:05 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6gZx-000147-BU
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 07:42:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222AbXGFFly (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 01:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752621AbXGFFly
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 01:41:54 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:51857 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752222AbXGFFlx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 01:41:53 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070706054152.OENO1204.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Fri, 6 Jul 2007 01:41:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id L5hs1X0011kojtg0000000; Fri, 06 Jul 2007 01:41:52 -0400
In-Reply-To: <alpine.LFD.0.98.0707052108070.9434@woody.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 5 Jul 2007 21:12:17 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51723>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Well, we could make the rule be that we require --unidiff-zero only if 
> there really is _no_ old data to verify in a hunk. No deleted lines, and 
> no context around it.

There are two things --unidiff-zero affects, because git-apply
needs to disable otherwise reasonable sanity checks it does for
safety:

 - When we see a patch that has only one hunk, and its change
   consists of only deletion, we can verify and complain if the
   header does not say it delete the file.  Not so if the patch
   was created without "diff -u0".  The same applies for "only
   addition" vs.  "creation of the file".

 - When there is no leading context in the hunk, it usually has
   to match only at the beginning of the file (same for
   "following context" vs "at the end of the file"), and we do
   perform this sanity check.  However, "diff -u0" patch needs
   to bypass it, as not having any context is the norm.

Because "diff -u0" is unusual, these sanity checks are disabled
only when the user explicitly says --unidiff-zero when applying.

> Adrian has a point in that if there are lines to be deleted, that in 
> itself is context, and then the strict behaviour of "git-apply" is 
> arguably unnecessaily strict.

Not really.  That is true, unless you have two identical
instances of the group of lines being deleted, in which case you
cannot safely tell which instance is to be removed.

> That said, I do absolutely _hate_ how GNU patch will basically apply 
> random line noise without complaints. So git-apply is designed to be much 
> stricter on _so_ many levels. The thing that I personally always really 
> detested about GNU patch was how it would apply part of a patch, then fail 
> half-way, and leave the partial patch applied!
>
> git-apply is about a million times better than standard "patch", exactly 
> because it tries to make sure that what it does makes sense, and you 
> actually need to use explicit flags to make it do things that may be hard 
> to undo or slightly questionable.

No question about it.
