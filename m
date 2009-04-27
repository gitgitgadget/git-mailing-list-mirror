From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] daemon.c: fix segfault on OS X
Date: Sun, 26 Apr 2009 19:28:48 -0700
Message-ID: <7vy6tmbzj3.fsf@gitster.siamese.dyndns.org>
References: <49F4BD9F.6070709@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jon Loeliger <jdl@freescale.com>
To: Benjamin Kramer <benny.kra@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 10:10:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyGde-0000SX-VJ
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 04:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753240AbZD0C3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2009 22:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752932AbZD0C3A
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 22:29:00 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37884 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752306AbZD0C3A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2009 22:29:00 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B282512D2D;
	Sun, 26 Apr 2009 22:28:58 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id F1D8612D2B; Sun,
 26 Apr 2009 22:28:54 -0400 (EDT)
In-Reply-To: <49F4BD9F.6070709@googlemail.com> (Benjamin Kramer's message of
 "Sun, 26 Apr 2009 22:01:35 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 29B9AC76-32D3-11DE-A8D1-D766E3C8547C-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117602>

Benjamin Kramer <benny.kra@googlemail.com> writes:

> On OS X (and maybe other unices) getaddrinfo(3) returns NULL
> in the ai_canonname field if it is called with an IP address.
>
> steps to reproduce:
> $ git daemon --export-all
> $ git clone git://127.0.0.1/frotz
> => git daemon's fork (silently) segfaults.
>
> Remove the pointless loop while at it.

Hmm.  This codepath comes from dd467629, both the loop and the use of
getaddrinfo.

I have a mild suspicion that the loop originally was meant to notice that
an element in the addrinfo linked list is unusable and skip it to find a
usable one in the list or something like that, but as it stands it
processes the first entry (or fails to process and segfaults for you ;-)
and breaks out, which indeed is pointless.

But the part your patch touches is about supporting virtual hosting via
pattern interpolation, and the daemon will still segfault even with your
patch when somebody uses %CH expansion, because canon_hostname is left as
NULL, won't it?  I suspect in such a case it might be safer to use a copy
of the ip_address or something.
