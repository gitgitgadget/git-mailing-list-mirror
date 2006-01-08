From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 6/7] Add an optional limit to git-formatpatch
Date: Sun, 08 Jan 2006 01:30:11 -0800
Message-ID: <7vpsn312zg.fsf@assigned-by-dhcp.cox.net>
References: <20060108004059.GN1113@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 08 10:30:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvWsU-0005MK-Do
	for gcvg-git@gmane.org; Sun, 08 Jan 2006 10:30:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610AbWAHJaO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jan 2006 04:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752611AbWAHJaO
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jan 2006 04:30:14 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:57497 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1752610AbWAHJaN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2006 04:30:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060108092907.LKEU6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 8 Jan 2006 04:29:07 -0500
To: Yann Dirson <ydirson@altern.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14311>

Yann Dirson <ydirson@altern.org> writes:

> We may not want to format all patches since the merge base.

I am unsure about this one for a few reasons.

 - If you have:

           topic~3--topic~2--topic~1--topic
          /      
	MB--*--*--*--upstream

   and you do "not want to format all patches since the merge
   base", instead of "format-patch --limit=topic~2 master topic",
   you could just say "format-patch topic~2 topic", so this
   feature seems unnecessary.  Maybe I am not reading you right.

 - Even if the idea of having limit makes sense, only one limit
   can be specified, but you can have multiple (upstream,mine)
   pairs.  Your --limit applies the single limit to all of them.
   I am not sure if that makes sense either.

   I'd expect the limit value to be per (upstream,mine) pair,
   making "# Now we have what we want in $@" for-loop to iterate
   over (upstream,mine,limit) 3-tuples.

   Internally an (upsteam,mine) pair is canonicalized to be a
   single string "upstream..mine", so extending the canonical
   syntax somehow, say, "upstream..mine..limit" where empty
   "limit" means "use the merge base", might make sense.  I
   dunno.

 - One thing that comes to mind is to deal with this structure:

         topic~5--topic~4--topic~3--topic~2--topic~1--topic
       /                  /
      Z--*--*--*--*--*--MB--*--*--*--upstream

   and you do want to include commits older than topic~3 because
   they have not been picked up by the upstream.  In such a
   scenario, specifying commit Z as the "limit" may make sense.
   It is not "limit", but is what ASCII drawing in git-cherry
   calls "fork-point".  Is that what you are doing (the commit
   log suggests otherwise and you want to get less than what
   merge base gives you)?
