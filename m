From: Junio C Hamano <junkio@cox.net>
Subject: Re: Horrible re-packing?
Date: Mon, 05 Jun 2006 12:37:41 -0700
Message-ID: <7vy7wb4cmy.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0606050951120.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606051140530.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606051155000.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 05 21:37:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnKtW-00064t-Sq
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 21:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbWFEThn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Jun 2006 15:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWFEThn
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jun 2006 15:37:43 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:7652 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751326AbWFEThn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jun 2006 15:37:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060605193742.CNMJ11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 5 Jun 2006 15:37:42 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606051155000.5498@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 5 Jun 2006 12:03:31 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21330>

Linus Torvalds <torvalds@osdl.org> writes:

> I think the hash function with its comment is self-explanatory:
>
>         /*
>          * This effectively just creates a sortable number from the
>          * last sixteen non-whitespace characters. Last characters
>          * count "most", so things that end in ".c" sort together.
>          */
>         while ((c = *name++) != 0) {
>                 if (isspace(c))
>                         continue;
>                 hash = (hash >> 2) + (c << 24);
>         }
>         return hash;
>
> ie we just create a 32-bit hash, where we "age" previous characters by two 
> bits, so the last characters in a filename count most. So when we then 
> compare the hashes in the sort routine, filenames that end the same way 
> sort the same way.

IIRC, sometimes this function is called with path and name split
and sometimes with full path in name, depending on who calls you
(the latter happens for rev-list --object generated names, and
the former is for objects we extract ourselves from the --thin
base tree, or something like that). I suspect your patch may
break paths whose filename after the last slash is shorter than
16 bytes.
