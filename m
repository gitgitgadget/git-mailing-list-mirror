From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9501: Skip testing load if we can't detect it
Date: Sat, 06 Feb 2010 10:31:38 -0800
Message-ID: <7vwryq1aid.fsf@alter.siamese.dyndns.org>
References: <1265432440-52146-1-git-send-email-brian@gernhardtsoftware.com>
 <m3eikya9tn.fsf@localhost.localdomain>
 <0CD6B283-3181-4FAB-A6B2-13AFF9E5071C@gernhardtsoftware.com>
 <201002061505.13886.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	Git List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 19:31:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdpRj-0004vZ-3n
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 19:31:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755922Ab0BFSbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2010 13:31:49 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54466 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755773Ab0BFSbs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 13:31:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CEB79970B1;
	Sat,  6 Feb 2010 13:31:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iE13D7ITz9UoeQJJeq+1sAQn8Jc=; b=x1ynG+
	X6RH1w/7SffyCrODV1Qetxz/98CGXVDqq86k7e0uHWWYqUOBo76/T14yOABOcGXv
	0cLtkbGh9aCnTXElgkAcMAOn8XzfKbXJ7V87a9I6AgiX5o4RHjtHezJiHuXrACo7
	4kTL6ojV9A6QkchmVaoOoVBQ4TEx43ZO1sp94=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IcPYXnPkibAfME8Z5v8glMerErhPG5t1
	OdqobrOUKQ0GwJ2v80NV0bTeu0oWFjne5ugsYEaak+hwrT9IuTBSwKkOAQutUU8T
	A7ZK6uqA4TvU88gkW4AbiNxCBWbP4rbpchb0iVG1FKV6SOYDoSSlWpns/ybx8pmG
	rsbDQ91vea0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BC6B970AD;
	Sat,  6 Feb 2010 13:31:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AE4E7970AC; Sat,  6 Feb
 2010 13:31:39 -0500 (EST)
In-Reply-To: <201002061505.13886.jnareb@gmail.com> (Jakub Narebski's message
 of "Sat\, 6 Feb 2010 15\:05\:13 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DFFD6724-134D-11DF-BBF3-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139183>

Jakub Narebski <jnareb@gmail.com> writes:

> or the test should use 
>
>   $maxload = -1;
>
> to artificially force 'load too high' situation.

One related thing that bugs me somewhat is that there is no corresponding
test to make sure that "too loaded" does not trigger when it shouldn't.
But it is harder to arrange (there is no safe $maxload value you can
hardcode in the test and guarantee the system will not loaded that high),
so you need to teach the get_loadavg() to lie under test only for the sake
of running the test, which is backwards---so I'd say that is not worth it.

Here is my attempt to reword the commit log message from Brian (the "-1"
one, squashed into a revert of the one from yesterday, the latter of which
I already pushed out).  I just added the first paragraph to better justify
the reason why we are testing the codepath that would never be exercised
in real life on platforms that lack /proc/loadavg.

    Subject: t9501: Re-fix max load test

    Revert the previous attempt to skip this test on platforms where we
    currently cannot determine the system load.  We want to make sure that
    the max-load-limit codepath produces results cleanly, when gitweb is
    updated and becomes capable of reading the load average by some other
    method.

    The code to check for load returns 0 if it doesn't know how to find
    load.  It also checks to see if the current load is higher than the
    max load.  So to force the script to quit early by setting the maxload
    variable negative which should work for systems where we can detect
    load (which should be a positive number) and systems where we can't
    (where detected load is 0)

    Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
