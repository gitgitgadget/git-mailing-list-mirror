From: Junio C Hamano <gitster@pobox.com>
Subject: Re: rm and mv commands: should I use them?
Date: Sun, 06 Jan 2008 18:05:16 -0800
Message-ID: <7v63y62xwj.fsf@gitster.siamese.dyndns.org>
References: <379EDA94-A67B-483A-BC5F-E961DD52AD0C@gmail.com>
	<alpine.LFD.1.00.0801061108320.2811@woody.linux-foundation.org>
	<20080107015518.GD17748@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jon Hancock <redstarling@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 07 03:06:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBhNF-00060y-Tu
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 03:05:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360AbYAGCFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2008 21:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752556AbYAGCFa
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jan 2008 21:05:30 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60900 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752360AbYAGCFa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2008 21:05:30 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E0972A9C2;
	Sun,  6 Jan 2008 21:05:27 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C118A983;
	Sun,  6 Jan 2008 21:05:23 -0500 (EST)
In-Reply-To: <20080107015518.GD17748@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 6 Jan 2008 20:55:19 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69754>

Jeff King <peff@peff.net> writes:

> I haven't looked to see if this optimization is in place, but "git mv"
> can also avoid having to recompute the sha1 of the file (which in most
> cases doesn't matter, but on a large file with a cold cache, can make
> the operation seem just as snappy as a regular "mv").

Actually, I think I found a bug.

	$ git reset --hard
	$ echo >>Makefile
        $ git diff --numstat
        1	0	Makefile
        $ git mv Makefile makefile
        $ git diff
        $ git diff --cached -M --numstat
        1	0	Makefile => makefile

"git mv" should not have staged the change.  It should have
moved the index entry from Makefile to makefile and moved the
work tree files.

The fix for this would fall out from your "optimization" quite
naturally, but I think that might be a post 1.5.4 item.
