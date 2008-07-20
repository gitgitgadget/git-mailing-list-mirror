From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Enable git rev-list to parse --quiet
Date: Sun, 20 Jul 2008 11:31:38 -0700
Message-ID: <7vwsjg76gl.fsf@gitster.siamese.dyndns.org>
References: <20080718040459.13073.76896.stgit@marcab.local.tull.net>
 <7v8wvzeojm.fsf@gitster.siamese.dyndns.org>
 <20080718092001.GD16102@mail.local.tull.net>
 <7vwsjhc7kj.fsf@gitster.siamese.dyndns.org>
 <20080720120437.GC15586@mail.local.tull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nick Andrew <nick@nick-andrew.net>
X-From: git-owner@vger.kernel.org Sun Jul 20 20:32:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKdi9-0002A6-0V
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 20:32:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbYGTSbq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 14:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbYGTSbq
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 14:31:46 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58363 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbYGTSbp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 14:31:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E8B2834654;
	Sun, 20 Jul 2008 14:31:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0BF1B34653; Sun, 20 Jul 2008 14:31:39 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 19CE01AC-568A-11DD-A611-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89210>

Nick Andrew <nick@nick-andrew.net> writes:

> Exiting a process from within a callback function seems to me to violate
> the principle of least surprise.

Huh?  Who is surprised?

I do not know who taught you that "do not exit in a callback" dogma, but I
suspect it was misrepresented when it was taught to you.

A library that calls your function back could be structured this way:

	lib() {
        	perform some set-up that affects external world;
                call your callback function;
                clean-up the effect of previous set-up action;
	}

and exiting from your callback function is not a good idea as it prevents
the library from doing the necessary clean-up in such a case.

But that is true just in a(n extremely) general case.  Your generalization
is not particularly useful, methinks, and use of exit(0) in the patch is
very well justified (rather, I do not think they even need justifying).

 - The callback you are looking at is not a general purpose callback for
   other program's use, but written for a specific use of rev-list;

 - The purpose of that exit(0) is to signal "there is something" as
   quickly as possible, which was what you wanted out of rev-list;

 - Revision traversal is a read-only operation and we know that there is
   no externally visible set-up done in the function you are calling to
   get your callback called, that needs cleaning up later --- this is not
   expected to change, as there are longstanding existing callback
   functions supplied to traverse_commit_list() that die() upon seeing
   errors already.
