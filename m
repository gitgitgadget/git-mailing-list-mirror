From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 02/13] declare overflow during base128 decoding when 1 MSB nonzero, not 7
Date: Thu, 05 Apr 2007 17:29:29 -0700
Message-ID: <7vvegal506.fsf@assigned-by-dhcp.cox.net>
References: <56b7f5510704051524p28eafc18mae3131ef13cdabfa@mail.gmail.com>
	<7vr6qymo3r.fsf@assigned-by-dhcp.cox.net>
	<56b7f5510704051608g4bf9ffb7t9f94b532c7a0ebdf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Dana How" <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 02:29:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZcKc-0004lO-E5
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 02:29:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767456AbXDFA3b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 20:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767452AbXDFA3b
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 20:29:31 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:58850 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767456AbXDFA3a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 20:29:30 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070406002930.OIKS373.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Thu, 5 Apr 2007 20:29:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id jcVV1W00n1kojtg0000000; Thu, 05 Apr 2007 20:29:30 -0400
In-Reply-To: <56b7f5510704051608g4bf9ffb7t9f94b532c7a0ebdf@mail.gmail.com>
	(Dana How's message of "Thu, 5 Apr 2007 16:08:55 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43887>

"Dana How" <danahow@gmail.com> writes:

> Concerning SEEK_SET,
> you are correct: my unistd.h #define's SEEK_SET to 0.

My understanding of the history is back when there was seek()
but not lseek() nor SEEK_X macros, everybody passed bare
integers and it was quite well established that 0 meant what
SEEK_SET means now, so I would be quite surprised if there is
_any_ platform that defines SEEK_SET to anything but zero.

Having said that, I wonder if this kind of thing can be caught
with sparse.  We should be able to express (or perhaps sparse
could have a built-in rule that says) something like "although
the standard says the third parameter to lseek() can be any
integer, you should not use anything but SEEK_X preprocessor
macros; also SEEK_X preprocessor macros, although they are
typically just "#define"s of small integer literals, can never
appear anywhere other than the third parameter as seek() and
lseek()".  I realize that there needs some data-flow analysis to
allow a code like this, though:

	int move_to(int fd, ofs_t offset, int relative)
	{
		int whence = SEEK_SET;

	        if (relative) {
                	whence = SEEK_CUR;
	                offset += relative;
	        }
		return lseek(fd, offset, whence) != (off_t)-1;
	}

> But if someone edits this, the arg order might remain.

Very true, and that is why I said I am going to take the patch.
