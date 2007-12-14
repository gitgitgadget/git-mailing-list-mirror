From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Fix config lockfile handling.
Date: Fri, 14 Dec 2007 13:18:30 -0800
Message-ID: <7vwsrhotzt.fsf@gitster.siamese.dyndns.org>
References: <1197660157-24109-1-git-send-email-krh@redhat.com>
	<1197660157-24109-2-git-send-email-krh@redhat.com>
	<Pine.LNX.4.64.0712141928240.27959@racer.site>
	<7vmysdqbui.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0712142015240.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Dec 14 22:19:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3HwD-0002Oa-B1
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 22:19:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756303AbXLNVSx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 16:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754587AbXLNVSw
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 16:18:52 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60688 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754044AbXLNVSv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 16:18:51 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 578358D90;
	Fri, 14 Dec 2007 16:18:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 397B18D86;
	Fri, 14 Dec 2007 16:18:40 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0712142015240.27959@racer.site> (Johannes
	Schindelin's message of "Fri, 14 Dec 2007 20:15:54 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68349>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > AFAICT this cannot work.  At least not reliably.  An atexit() handler 
>> > will access all (even closed) lockfiles.
>> 
>> Correct.  It cannot be on the stack.
>
> Note that this behaviour will be another obstacle to libification.

By your definition of "obstacle", there is no work at all in
libification if the system is obstacle free.

Libification is all about removing run-once-and-exit and atexit() is
just a part of it.

I think we can do this step-by-step by first introducing a new function
"get_lockfile()" that takes a list of active lockfiles (perhaps that
would be a part of "client context" thing in the library) and gives back
a lockfile structure allocated on heap, registers it to the list of
lockfiles that need to be eventually cleaned up, and another function
"rollback_lockfiles()" that take the list of lockfiles in the "client
context" and rolls them all back.  Once there is such a "client contex",
in the current unlibified "main" routines can then declare a global
client context, obtain and use lockfiles for that context, and directly
call rollback_lockfiles() from the atexit() handler.

But that is all post 1.5.4.
