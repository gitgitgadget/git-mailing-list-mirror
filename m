From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] match_refs: search ref list tail internally
Date: Thu, 28 May 2009 00:06:32 -0700
Message-ID: <7vtz35hfk7.fsf@alter.siamese.dyndns.org>
References: <76718490905260727v7261391uab169167978e4522@mail.gmail.com>
	<1243455224-3463-1-git-send-email-drizzd@aon.at>
	<1243455224-3463-2-git-send-email-drizzd@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@googlemail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Tay Ray Chuan <rctay89@gmail.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Thu May 28 09:06:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9ZhP-0007rP-4p
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 09:06:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbZE1HGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 03:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbZE1HGc
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 03:06:32 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:33918 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951AbZE1HGc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 03:06:32 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090528070631.JUBU25927.fed1rmmtao106.cox.net@fed1rmimpo03.cox.net>;
          Thu, 28 May 2009 03:06:31 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id wv6Z1b0024aMwMQ04v6Z0Y; Thu, 28 May 2009 03:06:33 -0400
X-Authority-Analysis: v=1.0 c=1 a=X0za5sGunokA:10 a=lRXe1y6VuJAA:10
 a=-kq21c6ceYbpZsfJ63YA:9 a=kB2A1Dhsj6fsZIHWIHgA:7
 a=y8mzYV5kdlNf_TP0I6KjaeHTb7UA:4
X-CM-Score: 0.00
In-Reply-To: <1243455224-3463-2-git-send-email-drizzd@aon.at> (Clemens Buchacher's message of "Wed\, 27 May 2009 22\:13\:44 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120158>

Clemens Buchacher <drizzd@aon.at> writes:

> Avoid code duplication by moving list tail search to match_refs().
>
> This does not change the semantics, not even for http-push. The NULL
> test for remote_tail was redundant.

The existing program (and the result after the patch) open-codes too much
inside the huge main() function, and it is extremely painful to follow
what is going on.

But it is not that "the NULL test was redundant" that I'd be worried
about.  In that unreadable main() function:

 - get_dav_remote_heads() is called, which asks the other end what the
   remote refs are; the result is queued in the linked list whose head is
   remote_refs and tail is remote_tail;

 - the resulting remote_tail is given to match_refs() to further grow the
   linked list.  The function will queue new "struct ref" instances
   (e.g. by making a call to match_explicit_refs()) at the end of the
   list.

   The caller used to pass "here is the end of the list" variable to it,
   but now you compute (perhaps redundantly) the end of the ref list by
   tangling from dst to its tail, yourself, and match_refs() links new
   elements at the tail of the list correctly.

   But what happens to the calling program's remote_tail variable after
   match_refs() returns?  The code used to guarantee that it always point
   at the real end of the list, but that guarantee is now gone.

It so happens that http-push.c never looked at remote_tail to do further
processing on the list after match_refs() returned, and that is why your
patch does not break http-push.c.  Any third-party patch to http-push.c
that relied on the old guarantee will textually merge cleanly but will
subtly break with this change.

Other parts of this patch removes the local "remote_tail" variables, and
it is very clear that they do not have this problem; any third-parth patch
will break if they used remote_tail after match_refs() returned, so this
change is a safe one for them.

I wonder what interaction this change will have with the http-push
clean-up Ray Chuan has been working on...
