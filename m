From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] safecrlf: Add flag to convert_to_git() to disable safecrlf check
Date: Mon, 14 Jan 2008 15:58:42 -0800
Message-ID: <7vk5mchsct.fsf@gitster.siamese.dyndns.org>
References: <004D2FB5-2CEA-4DB1-AF8D-D5ADEB0F0508@zib.de>
	<12003528401309-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: dpotapov@gmail.com, gitster@pobox.com,
	torvalds@linux-foundation.org, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Jan 15 00:59:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEZDM-0002GE-OA
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 00:59:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752238AbYANX7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2008 18:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752092AbYANX7H
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 18:59:07 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57674 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314AbYANX7G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2008 18:59:06 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 564466D70;
	Mon, 14 Jan 2008 18:59:03 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7EB336D6B;
	Mon, 14 Jan 2008 18:58:55 -0500 (EST)
In-Reply-To: <12003528401309-git-send-email-prohaska@zib.de> (Steffen
	Prohaska's message of "Tue, 15 Jan 2008 00:20:40 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70492>

Steffen Prohaska <prohaska@zib.de> writes:

> We want to verify if an autocrlf conversion is reversible only if
> the converted data is actually written to the repository.  Only
> in this case the file would be modified during the next checkout.
> But convert_to_git() is used for some other purposes.
> This commit adds a flag to convert_to_git() that controls if the
> safecrlf check is enabled...

At first this felt dirty to me as convert_to_git() is not
limited to crlf, but about external vs canonical representation.
The variable name being "checksafe" however makes it much more
palatable.  It is clear that it is talking about irreversible
conversion.

When running diff with a work tree file and the index (or a
named tree), we read the work tree file and run convert_to_git()
on it before comparing it with what we have in the object store
(either index or a named tree).  When running apply without
touching the index, we also use convert_to_git() on the work
tree file.  The patch file is supposed to record the data in
canonical format, I think.

Of course, "git add" on the path will warn or fail with your
patch, but we may somehow want to be warned about the breakage
before "git add" on that path triggers it.  Perhaps we can have
a separate "check-work-tree" command that iterates over locally
modified work tree files and runs convert_to_git() with checking
enabled.
