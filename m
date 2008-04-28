From: Junio C Hamano <gitster@pobox.com>
Subject: Re: entry terminator/separator behavior in show_log()
Date: Mon, 28 Apr 2008 09:10:59 -0700
Message-ID: <7vtzhmc63w.fsf@gitster.siamese.dyndns.org>
References: <20080428045504.GA24981@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Simpkins <adam@adamsimpkins.net>
X-From: git-owner@vger.kernel.org Mon Apr 28 18:14:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqVxe-00035p-6N
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 18:12:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936170AbYD1QLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 12:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936486AbYD1QLR
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 12:11:17 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49115 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936477AbYD1QLO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 12:11:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1077D5B55;
	Mon, 28 Apr 2008 12:11:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 027035B51; Mon, 28 Apr 2008 12:11:06 -0400 (EDT)
In-Reply-To: <20080428045504.GA24981@adamsimpkins.net> (Adam Simpkins's
 message of "Sun, 27 Apr 2008 21:55:05 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80550>

Adam Simpkins <adam@adamsimpkins.net> writes:

> Variables affecting the behavior
> --------------------------------
>
> - The sep argument to show_log()
>
>   As far as I can tell, this is always "".  show_log() is sometimes
>   invoked with a sep argument of diffopt->msg_sep.  However,
>   "git grep -w msg_sep" shows that msg_sep is never set to anything but
>   the empty string.
>
>   Perhaps we could just remove this argument, to reduce complexity and
>   confusion?

Yes.  39bc9a6 (Add msg_sep to diff_options, 2006-06-25) and f005df3
(diff-tree: Use ---\n as a message separator, 2006-06-27) introduced the
variable and used it as the mechanism to add "---\n" at the end of the
message, which was a mistake, because it treated "---\n" as a part of the
message even though it is not --- it is a separator between the message
and the diff part if and only if the diff exists.

Later, 3969cf7 (Fix some more diff options changes., 2006-06-27) corrected
this and made generation of --- as part of the log-tree, where "the diff
for the commit" is generated.  The variable is not used anymore and we can
safely remove it.

> - Whether or not the log entry ends in a terminating newline
>
>   The log entry for CMIT_FMT_ONELINE never ends in a newline.
>   The log entry for CMIT_FMT_USERFORMAT only ends in a newline if the
>   user explicitly places a newline at the end of the format.
>
>   For all other formats, the entry always ends in a terminating newline.

Hmm, interesting.  This is true even when the original commit log message
ends with an incomplete line.

> - Whether or not the log message buffer is empty
>
>   If use_terminator is set and the message buffer returned by
>   pretty_print_commit() is empty, no newline is printed between entries.
>
>   This can happen, for example, if CMIT_FMT_USERFORMAT is used with an
>   empty format string.  Even though pretty_print_commit() returns an
>   empty buffer, the log entry itself does not necessarily have to be
>   empty.  For example, the log size will be printed if if the --log-size
>   argument is used.

This could just be a bug.  I do not think of a good reason to treat an
empty entry any differently from a single line entry that happens to have
zero characters on it.

> (2) For CMIT_FMT_ONELINE and CMIT_FMT_USERFORMAT:
>     (2.2)
>       If use_terminator is not set (--pretty=format):
>
>       diffopt->line_termination is printed before each log entry but the
>       first.  This results in diffopt->line_termination in between each
>       entry, and not after the final entry.

IOW, "use separators between entries."

> - Case 2.1.2 seems reasonable, but not really necessary.  It might be
>   nicer to simply always print a terminating newline even if the message
>   buffer is empty.  This would appear as an extra blank line after each
>   entry.
>
>   The --pretty=tformat option is quite new, so I doubt that many people
>   would complain if we changed this behavior.

Concurred.

> - Case 2.2.1 makes perfect sense.  There are probably lots of scripts
>   out there relying on this behavior.

I would agree with the second sentence, but not necessarily with the
first.  For script consumption, terminator is easier to deal with than
separator if the script is streaming; separator is easier if the script
gobbles up everything and then uses split(/$separator/, $everything).
They both have their uses.

> - I don't really like the behavior for any of the cases under 2.2.2.
>
>   I especially don't like the fact that the output does not end in a
>   terminating newline for case 2.2.2.1.

This is exactly why I did tformat so that we do not have to have a complex
special case (Jeff and I exchanged a few weatherbaloon patches on the list
trying out heuristics) to avoid breaking existing scripts that use format.
