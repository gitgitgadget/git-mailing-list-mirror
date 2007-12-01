From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] xdiff-interface.c (buffer_is_binary): Remove buffer size limitation
Date: Sat, 01 Dec 2007 11:46:52 -0800
Message-ID: <7vlk8e42qb.fsf@gitster.siamese.dyndns.org>
References: <20071201160113.GA20849@nomad.office.altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Dmitry V. Levin" <ldv@altlinux.org>
X-From: git-owner@vger.kernel.org Sat Dec 01 20:47:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyYJD-0008FT-T4
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 20:47:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbXLATrC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2007 14:47:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbXLATrB
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 14:47:01 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:38077 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063AbXLATrA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2007 14:47:00 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 25A742F2;
	Sat,  1 Dec 2007 14:47:19 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id A85E29BC8D;
	Sat,  1 Dec 2007 14:47:16 -0500 (EST)
In-Reply-To: <20071201160113.GA20849@nomad.office.altlinux.org> (Dmitry
	V. Levin's message of "Sat, 1 Dec 2007 19:01:13 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66735>

"Dmitry V. Levin" <ldv@altlinux.org> writes:

> When checking buffer for NUL byte, do not limit size of buffer we check.
> Otherwise we break git-rebase: git-format-patch may generate output which
> git-mailinfo cannot handle properly.

I think this is tackling a valid problem but it is a wrong solution.
The change penalizes text changes which is the majority, just in case
there is an unusual change that has an embedded NUL far into the file
(iow, exception).

Perhaps mailinfo can be updated to handle embedded NUL.

Another alternative (I've been trying to find time to do so for quite a
while now but dealing with list traffic always takes priority on my time
allotment) is to update rebase not to rely on "format-patch piped to
am", and I think that is more correct solution in the longer term.

In the meantime, a workaround would be to use "rebase -i".  It uses
cherry-pick machinery instead of "format-patch piped to am", and
hopefully would handle NULs better.  It probably is slower than non
interactive one exactly because it uses cherry-pick, and that is the
reason I am first working on updating cherry-pick before actually making
the non-interactive rebase to use it.
