From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git produces Unidiff - Does it really?
Date: Sun, 24 May 2009 20:27:10 -0700
Message-ID: <7v4ov9zwtt.fsf@alter.siamese.dyndns.org>
References: <alpine.LSU.2.00.0905250105410.22963@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jan Engelhardt <jengelh@medozas.de>
X-From: git-owner@vger.kernel.org Mon May 25 05:28:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8Qrn-00051M-Th
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 05:28:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772AbZEYD1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 23:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751580AbZEYD1K
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 23:27:10 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:35000 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849AbZEYD1J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 23:27:09 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090525032711.WHJM25927.fed1rmmtao106.cox.net@fed1rmimpo03.cox.net>;
          Sun, 24 May 2009 23:27:11 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id vfTA1b00E4aMwMQ04fTAMe; Sun, 24 May 2009 23:27:10 -0400
X-Authority-Analysis: v=1.0 c=1 a=dvCLD_nRVvgA:10 a=LCMQ-0ShYWwA:10
 a=uZvujYp8AAAA:8 a=0dMwXjx9bwxo7ISuhGwA:9 a=R4r7oCh7h67yHrL97kUA:7
 a=uCjODzMeL32LZkCiQZsR-dTVw7EA:4 a=bAv3psboLzYA:10
X-CM-Score: 0.00
In-Reply-To: <alpine.LSU.2.00.0905250105410.22963@fbirervta.pbzchgretzou.qr> (Jan Engelhardt's message of "Mon\, 25 May 2009 01\:15\:43 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119884>

Jan Engelhardt <jengelh@medozas.de> writes:

> Any insights?

We have "index ..." and other metainformation (most noticeable when
renames and mode changes are involved) before any hunk begins.  POSIX
unified context format of course would not know about them either.

In the context of git, file modification time often does not have a
defined meaning.  If you are comparing two arbitrary tree objects (or two
arbitrary blob objects), there is no concept of "timestamp of the preimage
and the postimage".  If you are comparing two commits, you _could_ show
the timestamps of the commits, but that is misleading and useless
information.  The paths being shown may not have been changed by the newer
commit being compared, but by some other commit in-between the two commits
(and even that is not guaranteed --- the two commits may not have any
ancestry relationship, and/or the clock of the committer who made one of
these commits may have had skews).

The enhancements and ommissions were chosen not to confuse tools that
people use to process patches.  The metainformation headers are safely
ignored by "patch", for example (of course "patch" does not know about
renames yet, but that can be fixed later).  Even though "patch" _can_
optionally set the timestamp of the affected files, nobody sane would do
so in the context of source code control (it will screw up "make").

The answer to your question depends on how anal you would want to be, but
no, we fundamentally cannot produce "unidiff -- _really_" in the "POSIX
unified context format" without losing useful information (renames and
modes) nor without adding information that is meaningless (timestamps).

But on the other hand, you can say what we produce is in unified context
format to the same extent that RCS and CVS produces unified when given -u
option (i.e. "rcsdiff -u", "cvs diff -u").

For example, "rcsdiff -u" shows something like:

    diff -u -r1.1 -r1.2
    --- Make        1995/01/08 20:50:24     1.1
    +++ Make        2001/10/04 07:14:29     1.2
    @@ -1,7 +1,11 @@
     #!/bin/sh
    -...

It has cruft after the timestamp, and the timestamp itself is not even in
the format POSIX expects to see (see

 http://www.opengroup.org/onlinepubs/9699919799/utilities/diff.html#tag_20_34_10_07

if you really care).

Is it in violation of POSIX unified context format?  Of course yes.  Is it
then not in unified context format at all?

For all practical purposes, if you (either you human or your tool) know
how to read unified context format, you can process what we (or RCS)
produce.

I used RCS as an example because it has been maintained by the same person
who maintains "GNU diff" and was one of the main player who pushed
"unified context" format to the updated POSIX.
