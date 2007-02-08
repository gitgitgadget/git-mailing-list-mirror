From: Junio C Hamano <junkio@cox.net>
Subject: Re: Fix "git log -z" behaviour
Date: Thu, 08 Feb 2007 14:34:05 -0800
Message-ID: <7v7iusz3c2.fsf@assigned-by-dhcp.cox.net>
References: <68948ca0702070841m76817d9el7ce2ec69835c50e@mail.gmail.com>
	<Pine.LNX.4.64.0702070856190.8424@woody.linux-foundation.org>
	<Pine.LNX.4.64.0702070919320.8424@woody.linux-foundation.org>
	<Pine.LNX.4.64.0702071139090.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Don Zickus <dzickus@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Feb 08 23:34:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFHqH-0007BV-DJ
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 23:34:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423502AbXBHWeI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 17:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423501AbXBHWeI
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 17:34:08 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:34117 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423500AbXBHWeH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 17:34:07 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070208223407.FJKF1349.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Thu, 8 Feb 2007 17:34:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id MAa51W00c1kojtg0000000; Thu, 08 Feb 2007 17:34:06 -0500
In-Reply-To: <Pine.LNX.4.64.0702071139090.8424@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 7 Feb 2007 11:49:56 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39113>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> For the normal case where the termination character is '\n', this 
> obviously doesn't change anything at all, since we just switched two 
> identical characters around. So it's very safe - it doesn't change any 
> normal usage, but it definitely fixes "git log -z".

Gaah.

I have already applied this but I think this has fallout for
existing users of "-z --raw".  Nothing in-tree uses "git log" as
the upstream of a pipe as far as I know because in-tree stuff
tend to stick to plumbing when it comes to scripting, but I
think your patch would affect the plumbing level as well.

Scripts that read from "-z --raw" have been expecting to get a
record whose first 7 bytes are "commit " to be a log, which is
followed by an arbitrary number of records whose first byte is
":" (and then it needs variable number of records to complete
one diff record).  This patch removes the separator NUL between
the log message and the first diff record.
