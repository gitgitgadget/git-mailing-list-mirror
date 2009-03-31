From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bsd group semantics
Date: Tue, 31 Mar 2009 08:55:00 -0700
Message-ID: <7vvdpp6623.fsf@gitster.siamese.dyndns.org>
References: <20090331112637.GA1910@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 31 17:56:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LogKV-0004k4-0O
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 17:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760324AbZCaPzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 11:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761181AbZCaPzK
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 11:55:10 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58421 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760324AbZCaPzI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 11:55:08 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3D0A1BBC2;
	Tue, 31 Mar 2009 11:55:06 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 87ECFBBC1; Tue,
 31 Mar 2009 11:55:02 -0400 (EDT)
In-Reply-To: <20090331112637.GA1910@coredump.intra.peff.net> (Jeff King's
 message of "Tue, 31 Mar 2009 07:26:38 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4DDBF02C-1E0C-11DE-8FFA-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115271>

Jeff King <peff@peff.net> writes:

> The recently added test t1301.17 is failing for me on FreeBSD; the
> created directories don't have the GID bit set.
>
> I traced this back to the fact that FORCE_DIR_SET_GID is a no-op on
> FreeBSD due to the DIR_HAS_BSD_GROUP_SEMANTICS flag being set. I am not
> sure I understand the original reasoning for this flag at all; GID seems
> to work just fine on my FreeBSD 6.1 test system.

IIRC, DIR_HAS_BSD_GROUP_SEMANTICS means you do not have to ask explicitly
with g+s to the filesystem to use the "subdirectory is owned by the same
group as its parent" semantics.  On SysV you have to ask; on BSD you do
not have to (and do not need FORCE_DIR_SET_GID).

> The original thread is here:
>
>   http://article.gmane.org/gmane.comp.version-control.git/75999

That one was not about "you do not have to ask", but "you are not allowed
to ask because the request will fail".  Perhaps between FBSD4 and FBSD6
things changed, and you can now make g+s request (which I presume is still
a no-op other than setting the bit on)?

Ideally the test should be checking if the subdirectory is owned by the
same group as the toplevel, but that is rather hard to correctly arrange,
as it depends on the set of groups the user who runs the test belongs to,
how the git work tree is set up (if it is owned by his primary group or a
secondary), etc.

For now, I'd suggest teaching the test not to care about g+s bit.
