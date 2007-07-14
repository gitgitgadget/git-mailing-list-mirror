From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add --show-size to git log to print message size
Date: Sat, 14 Jul 2007 12:03:52 -0700
Message-ID: <7vodiehko7.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550707140952hb60735bi95a4f03636c4aa99@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 14 21:03:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9muL-0006cL-KB
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 21:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759855AbXGNTDz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 15:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759376AbXGNTDz
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 15:03:55 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:37486 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759758AbXGNTDy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 15:03:54 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070714190354.KATO1358.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sat, 14 Jul 2007 15:03:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id PX3t1X00A1kojtg0000000; Sat, 14 Jul 2007 15:03:53 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52497>

"Marco Costalba" <mcostalba@gmail.com> writes:

> Print message size just before the corresponding message
> to speedup the parsing by scripts/porcelains tools.

> diff --git a/log-tree.c b/log-tree.c
> index 8624d5a..2fb7761 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -295,6 +295,9 @@ void show_log(struct rev_info *opt,
> 	if (opt->add_signoff)
>  		len = append_signoff(&msgbuf, &msgbuf_len, len,
> 				     opt->add_signoff);
> + 	if (opt->show_size)
> +		printf("size %i\n", len);
> +
>  	printf("%s%s%s", msgbuf, extra, sep);
>  	free(msgbuf);
> }

"size" is a bit vague here.  What if we later want to extend
things so that you can ask for the entire log entry size
including the patch output part (I am not saying that would be
an easy change --- I am more worried about the stability of the
external interface).  So is --show-"size".  "message-size" would
have been a bit easier to swallow, but I sense the problem runs
deeper.

The current code spits out a log message after formatting it in
its entirety in core, so we happen to have its size upfront.
Having to say the size upfront means we close the door for
alternative implementations that stream the log formatting
processing.

This is not a problem for log messages per-se, as we
traditionally even did not show a commit log over 16kB (these
days we are supposed to be unbounded, although I do not know if
anybody actually tested that).  But if we ever want to extend
this concept to cover the patch part, so that the reader can
split the "git log" output stream into individual commits with
the same "efficiency improvements" you are seeing from this
patch, that becomes a real problem, I would think.

Naturally, this reminds me of having to say Content-Length
upfront vs chunked transfer.  Essentially you are treating the
output stream from "git log" into the pipe as a sequence of
messages (and without "-p", your "size" is exactly what a
"Content-Length" header is).  The fact that this analogy works
only when the command is run without "-p" (but "--show-size"
does not check that) bothers me.  What would we do when we want
to help the readers that reads from "-p" output?

I have a more basic question. If you are reading from non "-p"
output, where do you exactly have the wasted cycles in your
reader's processing?  One immediately obvious thing is that you
would not have to repeatedly realloc your buffer to keep one
message worth of data in core, but somehow I cannot imagine that
that is the source of a huge performance boost.

One use case that this would give a huge improvement I can think
of is if you read the stream, and show only every tenth commit.
You can discard other 9 out of 10 without even looking at their
contents, and being able to read known amount of bytes and
immediately discard would certainly be much more efficient than
having to scan for NUL, only to discard.  But that does not
sound as a plausible real-life scenario.
