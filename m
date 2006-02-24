From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] diff-delta: produce optimal pack data
Date: Fri, 24 Feb 2006 00:49:13 -0800
Message-ID: <7v4q2pf8fq.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602212043260.5606@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 24 09:49:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCYdb-0007b9-7j
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 09:49:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWBXItQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 03:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWBXItQ
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 03:49:16 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:7083 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932140AbWBXItP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2006 03:49:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060224084603.KZKV17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 24 Feb 2006 03:46:03 -0500
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0602212043260.5606@localhost.localdomain> (Nicolas
	Pitre's message of "Tue, 21 Feb 2006 20:45:36 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16689>

Nicolas Pitre <nico@cam.org> writes:

> Indexing based on adler32 has a match precision based on the block size 
> (currently 16).  Lowering the block size would produce smaller deltas 
> but the indexing memory and computing cost increases significantly.

Indeed.

I had this patch in my personal tree for a while.  I was
wondring why sometimes progress indication during "Deltifying"
stage stops for literally several seconds, or more.

In Linux 2.6 repository, these object pairs take forever to
delta.

        blob 9af06ba723df75fed49f7ccae5b6c9c34bc5115f -> 
        blob dfc9cd58dc065d17030d875d3fea6e7862ede143
        size (491102 -> 496045)
        58 seconds

        blob 4917ec509720a42846d513addc11cbd25e0e3c4f -> 
        blob dfc9cd58dc065d17030d875d3fea6e7862ede143
        size (495831 -> 496045)
        64 seconds

Admittedly, these are *BAD* input samples (a binary firmware
blob with many similar looking ", 0x" sequences).  I can see
that trying to reuse source materials really hard would take
significant computation.

However, this is simply unacceptable.

The new algoritm takes 58 seconds to produce 136000 bytes of
delta, while the old takes 0.25 seconds to produce 248899 (I am
using the test-delta program in git.git distribution).  The
compression ratio is significantly better, but this is unusable
even for offline archival use (remember, pack delta selection
needs to do window=10 such deltification trials to come up with
the best delta, so you are spending 10 minutes to save 100k from
one oddball blob), let alone on-the-fly pack generation for
network transfer.

Maybe we would want two implementation next to each other, and
internally see if it is taking too much cycles compared to the
input size then switch to cheaper version?
