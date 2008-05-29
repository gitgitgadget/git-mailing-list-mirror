From: Junio C Hamano <gitster@pobox.com>
Subject: Re: whomto.pl -- finding out whom to send patches to
Date: Thu, 29 May 2008 16:33:22 -0700
Message-ID: <7vr6bkofct.fsf@gitster.siamese.dyndns.org>
References: <20080529210018.GA5508@damson.getinternet.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org,
	Jan Engelhardt <jengelh@computergmbh.de>,
	Sverre Rabbelier <alturin@gmail.com>,
	Joe Perches <joe@perches.com>, git@vger.kernel.org
To: Vegard Nossum <vegard.nossum@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 30 01:34:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1rdi-0003q7-GO
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 01:34:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754282AbYE2Xdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 19:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752735AbYE2Xdm
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 19:33:42 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35612 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341AbYE2Xdl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 19:33:41 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BA7485FC7;
	Thu, 29 May 2008 19:33:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C93695FC3; Thu, 29 May 2008 19:33:29 -0400 (EDT)
In-Reply-To: <20080529210018.GA5508@damson.getinternet.no> (Vegard Nossum's
 message of "Thu, 29 May 2008 23:00:18 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A9980516-2DD7-11DD-BF84-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83254>

Vegard Nossum <vegard.nossum@gmail.com> writes:

> I've written this perl script that takes a patch as input and prints the
> authors/committers of the affected lines, using git-blame as the back end.
>
> (The purpose of this is of course to find out whom to send patches to.)
>
> There are some caveats:
>
> - If I've understood correctly, git-blame incremental output doesn't split
>   commits when a newer one is found, so we currently possibly take into
>   account more than just the last patch to touch a line. This might not be
>   a disadvantage, however...

"git blame" does not give irrelevant commits in its output, with or
without --incremental.  Perhaps you were thinking about the "oops, earlier
one was wrong, here are the corrections" behaviour of "git log
--early-output", which is an unrelated mechanism in a different command.

But I have to wonder why you used --incremental and not --porcelain
format, the latter of which is more compact and is designed for parsing by
tools.

I also have to wonder why you did not use -M, -C, and/or -w, if you used
blame to find the true origin of lines that are involved.

Unless the patch is truly about a narrow region of a handful files
(e.g. micro-optimizing the implementation of a single function without
changing its external interface at all, or fixing an off-by-one error in a
group of functions that do similar things), I suspect that it would make
more sense to use "git shortlog --no-merges -- paths" to get the list of
people who are involved in the general area, even though they may not have
been involved in particular _lines_ that the patch touches.  For example,
if a patch changes the lines in a function's implementation, you would
want input not only from the people who improved the implementation of the
function over the years, but more from the people who care about the
calling sites of that function the patch is touching.
