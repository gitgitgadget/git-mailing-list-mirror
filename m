From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/1] Add support for an optional .nextmsg file to
 git-commit-script
Date: Tue, 14 Jun 2005 07:44:43 -0700
Message-ID: <7v64wh576s.fsf@assigned-by-dhcp.cox.net>
References: <20050614114243.12267.qmail@blackcubes.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 14 16:44:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DiCe9-00049c-KN
	for gcvg-git@gmane.org; Tue, 14 Jun 2005 16:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbVFNOr7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Jun 2005 10:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbVFNOqB
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jun 2005 10:46:01 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:26001 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261244AbVFNOow (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2005 10:44:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050614144445.ORIK7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 14 Jun 2005 10:44:45 -0400
To: Jon Seymour <jon.seymour@gmail.com>
In-Reply-To: <20050614114243.12267.qmail@blackcubes.dyndns.org> (Jon
 Seymour's message of "Tue, 14 Jun 2005 21:42:43 +1000")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JS" == Jon Seymour <jon.seymour@gmail.com> writes:

JS> This change allows a commit message to be prepared prior to git-commit-script being
JS> invoked. During git commit the user is then given an opportunity to edit the
JS> existing message, if any, and must confirm the commit by deleting a sentinel
JS> line from the top of the edit buffer.

JS>  #!/bin/sh
JS> +SENTINEL="*** delete this line to confirm the commit ***"
JS> ..
JS> +egrep -v "^#|$SENTINEL" < .editmsg | git-stripspace > .cmitmsg

A handful comments.

(1) Although it happens to work in this case, I do not like
    scripts that use grep without quoting metacharacters in a
    string.  You have two egreps that phrases the above slightly
    differently.  Make up your mind ;-) and pick one.

(2) What happens if I later want to make a commit with this commit
    log?

    [PATCH] Reword the sentinel line.

    Instead of saying "*** delete this line to confirm the commit ***",
    just say "# If you want to abort the commit, make this file empty.".

(3) The original implementation knows that the commit is to be
    aborted when resulting .cmitmsg is empty.  You may want to
    tell the user in the comment in the commit template about
    it, instead of using the sentinel line.

(4) Instead of teaching git-commit-script about the .nextmsg
    file, it may be cleaner to split it into two parts:

    - one that prepares the .cmitmsg file for editing;

    - the other that invokes the editor on prepared a .cmitmsg
      file, checks if the message file is edited and asks for
      confirmation to abort if the file is unchanged, and does the
      actual commit.

   The new git-commit-script would prepare its .cmitmsg the way it
   does now and only call the latter half.  Your re-commit script
   can do the first half differently from what git-commit-script
   does, and call the same latter half.

P.S. I see you are using "git format-patch"; I'd suggest you
hand edit " 1/1" out of [PATCH 1/1] subject line for a patch
like this that is not part of a series.  I did not special case
1/1 to do it myself because I often have a handful independent
patches and end up removing 1/7 2/7 ... etc. anyway.


