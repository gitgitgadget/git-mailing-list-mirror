From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/2] fix missing NUL termination with pretty=tformat
Date: Wed, 01 Jul 2009 01:27:46 -0700
Message-ID: <7vprcklse5.fsf@alter.siamese.dyndns.org>
References: <20090701070252.GA7987@sigio.peff.net>
	<20090701072632.GB8101@sigio.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 01 10:28:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLvAf-0005xK-3M
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 10:28:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882AbZGAI1s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2009 04:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbZGAI1p
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 04:27:45 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:47547 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856AbZGAI1o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2009 04:27:44 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090701082747.UTTH25927.fed1rmmtao106.cox.net@fed1rmimpo03.cox.net>;
          Wed, 1 Jul 2009 04:27:47 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id AYTn1c0014aMwMQ04YTnGF; Wed, 01 Jul 2009 04:27:47 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=noATkg2JvO8A:10 a=PKzvZo6CAAAA:8
 a=ybZZDoGAAAAA:8 a=CsMVKd5Hpbnn84NyaPYA:9 a=fXfNzvQn9k9oA6zWL7UA:7
 a=tw4mHHM30LrFaPtzctvdmEg5yk4A:4 a=OdWmie4EkE0A:10 a=qIVjreYYsbEA:10
X-CM-Score: 0.00
In-Reply-To: <20090701072632.GB8101@sigio.peff.net> (Jeff King's message of "Wed\, 1 Jul 2009 03\:26\:33 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122574>

Jeff King <peff@peff.net> writes:

> This one is RFC. It is missing tests, but that is because I am not
> completely sure what we want the output to look like. With this change,
> you still get a newline at the end of a single-line user-formatted
> string, like:
>
>   $ git log -z --format:%s
>   three
>   ^@two
>   ^@one
>   ^@

I haven't thought things through, but my knee-jerk reaction is that we
should treat "%s" itself as not having a final LF in itself.  So I would
actually expect the above to produce

    three^@two^@one^@

In other words, --pretty=format:%s and --pretty=format:X-%s-Y should
behave identically.  Strings produced by these format specifications will
not have terminating LF appended (because %s itself does not end with LF,
and in the second example you did not write any LF after your "Y").  For
consistency, I think %b should include the LF at the end on its own, but I
may be wrong on this last point.

"git log" (with or without -z) would begin with the string that comes out
of the log message part (i.e. with or without any custom format via
format/tformat) first.

When run with -p, the output would be followed by a LF (with -z, or
without), followed by the patch text (each line of which is terminated
with a LF, again with or without -z).  Without -p, this part is omitted.

After that, a LF/NUL (depending on the use of -z) would be appended if
there are more records or if we are using the terminator semantics.  Then
we would move on to the next record.

E.g.  When "log -p" shows a commit with a one-liner message, like this:

    commit e8a39af8d471d190a749c390a0cf614cb59ec8ee
    Author: Junio C Hamano <gitster@pobox.com>
    Date:   Wed Jul 1 00:50:48 2009 -0700

        second commit

    diff --git a/one b/one
    index e69de29..d00491f 100644
    --- a/one
    +++ b/one
    @@ -0,0 +1 @@
    +1

    Side note. Conceptually I would say that canned formats (--pretty,
    --pretty=short etc. but not --pretty=oneline) produce a string that
    ends with "second commit\n" in the above example, and the blank line
    between the log and beginning of "diff --git" is coming from the rule
    "log is always followed by a LF (with or without -z)".

"log -p --pretty=format:X-%s-Y" would begin with

    X-second commit-Y
    diff --git a/one b/one
    index e69de29..d00491f 100644

"log --pretty=format:X-%s-Y" would become

    X-second commit-Y
    X-initial commit-Y

and with -z, the latter would look
    
    X-second commit-Y^@X-initial commit-Y

while "log --pretty=tformat:X-%s-Y -z" would be

    X-second commit-Y^@X-initial commit-Y^@

All of the above was written, ignoring the memory of what the current code
actually does, nor checking if it is easy to implement without tweaking
the current code structure too much.  So it may not help your RFC, but I
at least think it is internally consistent.
