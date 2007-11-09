From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git-rebase fails when a commit message contains a diff
Date: Thu, 08 Nov 2007 17:51:59 -0800
Message-ID: <7vhcjwxk1s.fsf@gitster.siamese.dyndns.org>
References: <20071109011214.GA5903@diku.dk>
	<7vlk98xkm3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Fri Nov 09 02:52:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqJ2s-0007Qn-LE
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 02:52:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757730AbXKIBwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 20:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757554AbXKIBwP
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 20:52:15 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:60259 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756118AbXKIBwP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 20:52:15 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 2018F2F0;
	Thu,  8 Nov 2007 20:52:35 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 9472B93B05;
	Thu,  8 Nov 2007 20:52:32 -0500 (EST)
In-Reply-To: <7vlk98xkm3.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 08 Nov 2007 17:39:48 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64113>

Junio C Hamano <gitster@pobox.com> writes:

> That's a known design limitation of applymbox/mailinfo.  Any
> line that looks like a beginning of a patch in e-mail ("^--- ",
> "^---$", "^diff -", and "^Index: ") terminates the commit log.

Ok, so that explains the symptom.  What's the next step?

 * The applymbox/mailinfo pair should continue to split the
   commit log message at the first such line.  There is no point
   breaking established workflow, and people in communities that
   exchange patches via e-mail already know to avoid this issue
   by indenting quoted diff snippet in the log message,
   e.g. 5be507fc.

 * There is no fundamental reason for rebase to use e-mail
   format to express what "format-patch | am -3" pipeline does.
   We do it currently because (1) it was expedient to reuse what
   was already there, and because (2) the original target
   audience of git are e-mail oriented communities, so there was
   not strong incentive to make rebase independent of the
   applymbox/mailinfo limitation (that is, even if you make
   rebase able to handle such a patch, you cannot send out the
   result over e-mail *anyway*).

   This however does not mean we should always use merging
   rebase.  patch based approach "format-patch | am -3" pipeline
   uses is often much faster.  Instead of using "format-patch |
   am -3", we could use more careful patch and message
   generation, like git-rebase--interactive.sh:make_patch()
   does.
