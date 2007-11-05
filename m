From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] upload-pack: Use finish_{command,async}() instead of waitpid().
Date: Mon, 05 Nov 2007 12:05:40 -0800
Message-ID: <7v3avkqwyz.fsf@gitster.siamese.dyndns.org>
References: <200711042046.48257.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Mon Nov 05 21:06:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip8Cw-0000q9-1R
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 21:06:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752208AbXKEUFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 15:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752096AbXKEUFq
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 15:05:46 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:39315 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887AbXKEUFp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 15:05:45 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 5DD402F9;
	Mon,  5 Nov 2007 15:06:06 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id ECCA4927A9;
	Mon,  5 Nov 2007 15:06:03 -0500 (EST)
In-Reply-To: <200711042046.48257.johannes.sixt@telecom.at> (Johannes Sixt's
	message of "Sun, 4 Nov 2007 20:46:48 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63545>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> - If pack-objects sees an error, it terminates with failure. Since this
>   breaks the pipe to rev-list, rev-list is killed with SIGPIPE.

I was a bit uneasy about this part.  We do not explicitly tell
rev-list not to ignore SIGPIPE, so it could spin fruitlessly
listing revs and calling write(2).  But the error from that
write should already be handled correctly anyway, so this should
be Ok.

> 	The test case checks for failures in rev-list (a missing
> 	object). Any hints how to trigger a failure in pack-objects
> 	that does not also trigger in rev-list would be welcome.

How about removing a blob from the test repository  to corrupt
it?  rev-list --objects I think would happily list the blob
because it sees its name in its containing tree without checking
its existence.
