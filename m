From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Changes in function read_pipe
Date: Mon, 16 Jul 2007 16:50:58 -0700
Message-ID: <7vfy3nc3h9.fsf@assigned-by-dhcp.cox.net>
References: <469B9939.5050800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 01:51:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAaLN-0000X0-Pl
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 01:51:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763505AbXGPXvF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 19:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756784AbXGPXvE
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 19:51:04 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:63255 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763181AbXGPXu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 19:50:59 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070716235058.KUAZ1358.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Mon, 16 Jul 2007 19:50:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id QPqy1X00A1kojtg0000000; Mon, 16 Jul 2007 19:50:59 -0400
In-Reply-To: <469B9939.5050800@gmail.com> (Carlos Rica's message of "Mon, 16
	Jul 2007 18:13:45 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52733>

Carlos Rica <jasampler@gmail.com> writes:

> Some people talked recently about renaming the function read_pipe
> (sha1_file.c) to the better name read_fd.
> Here I discuss other possible changes to the current version:
>
> 1. It now requires to allocate memory for the buffer before calling it,
> you cannot pass it a pointer set to NULL or not initializated at all.

It should be a trivial and easy fix to add "initial allocation"
at the beginning of the function.  While I suspect that the
optimal initial allocation would be different for different
callers, probably we would not care that much.

> 2. The function doesn't terminate the data with NUL, and if you
> need that, you must to realloc before adding the '\0', because
> the function only returns the size of the data, not the buffer size.

Among the existing callers, index_fd() does not need NUL
termination, but we are almost always allocating more than
needed when the final size is unknown, so giving an extra NUL
(of course not including that in the final result size) would
not hurt.  Other callers are 'stripspace' and 'mktag', and I
would imagine 'tag' and 'commit' when they are reading the
message from the standard input would benefit from the implicit
NUL termination.  I'd say go for it.

> 3. When function fails in reading (xread returns < 0), buffer is not
> freed.

I do not think this is a problem.  The current callers seem to
do something like this:

	if (read_pipe(fd, ...)) {
        	free(buf);
                return error(...);
	}

but not freeing, and reporting how many you read so far, would
allow readers to work on results partially read (not to be
confused with the EAGAIN which is already handled with xread()).
