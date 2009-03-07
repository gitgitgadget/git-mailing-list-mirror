From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http: add_fill_function checks if function has been
 added
Date: Sat, 07 Mar 2009 12:18:02 -0800
Message-ID: <7vy6vhm6it.fsf@gitster.siamese.dyndns.org>
References: <49B266B0.4020304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 21:20:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg30R-0001Ia-EF
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 21:20:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755993AbZCGUSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 15:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755372AbZCGUSJ
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 15:18:09 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41628 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755042AbZCGUSI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 15:18:08 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8FFC64B4F;
	Sat,  7 Mar 2009 15:18:06 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DA9244B4E; Sat, 
 7 Mar 2009 15:18:03 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 11C2E47A-0B55-11DE-8FB7-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112576>

Tay Ray Chuan <rctay89@gmail.com> writes:

> This patch ensures that the same fill function is called once so to
> prevent any possible issues.
>
> Nevertheless, calling a fill function repeatedly in
> ''fill_active_slots'' will not lead to any obvious change in existing
> behavior, though performance might be affected.
>
> ''add_fill_action'' checks if the function to be added has already been
> added. Allocation of memory for the list ''fill_chain*'' is postponed
> until the check passes, unlike previously.

Could you care to explain the following a bit better?

 - what "possible issues" you are addressing;

 - what changes in the behaviour that are not "obvious" we would be
   suffering from, if we apply this patch;

 - in what situation the performance _might_ be affected, in what way and
   to what extent.

If the patch author does not have clear answers to these questions, how
can others decide if it is worth reading the patch to judge if it is worth
applying?

In other words, I'd expect you to explain the issues like this:

    add_fill_function() adds the same fill function twice on the fill_cfg
    list; this causes THIS and THAT breakages when the fill function is
    called twice.

    Ignore add_fill_function() when fill_cfg list already has the function
    registered on it to fix this issue.  Note however that the new code may
    behave very inefficiently under this situation:

    - XYZZY happens, then
    - FROTZ happens, and then
    - NITFOL happens.

    In such a case we end up doing FROTZ repeatedly, and ...; we might
    want to later optimize this, but a correctly working code is more
    important than efficient code that works most of the time but silently
    breaks in some cases.

    We need to iterate over the existing entries in fill_cfg list to find
    duplicates, which may look like an overhead, but the existing function
    already needed to do so to queue the new entry at the end anyway, so
    this is nothing new.
