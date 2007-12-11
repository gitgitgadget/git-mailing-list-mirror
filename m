From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH (amend)] diff: Make numstat machine friendly also for renames (and copies)
Date: Mon, 10 Dec 2007 18:50:36 -0800
Message-ID: <7vprxehrlv.fsf@gitster.siamese.dyndns.org>
References: <200712102332.53114.jnareb@gmail.com>
	<200712102355.39084.jnareb@gmail.com>
	<7vejdujazu.fsf@gitster.siamese.dyndns.org>
	<200712110226.35343.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 03:51:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1vDB-0006Vd-EG
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 03:51:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbXLKCur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 21:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbXLKCuq
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 21:50:46 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44015 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202AbXLKCuq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 21:50:46 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 850EC20C0;
	Mon, 10 Dec 2007 21:50:41 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DA9DE20BF;
	Mon, 10 Dec 2007 21:50:38 -0500 (EST)
In-Reply-To: <200712110226.35343.jnareb@gmail.com> (Jakub Narebski's message
	of "Tue, 11 Dec 2007 02:26:33 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67778>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>> Jakub Narebski <jnareb@gmail.com> writes:
>> 
>> > Previous version of this patch (from 7 May 2007) used instead of current
>> > only "to_name" format similar to git-diff-tree raw format for renames:
>> >
>> >   added deleted TAB path for "src" TAB path for "dst" LF

That's perfectly fine (that is without -z).

>> > ... Previous version
>> > of patch used (or was to use actually, because of error in the code)
>> >
>> >   added deleted TAB path for "src" NUL NUL path for "dst" NUL
>> >
>> > when -z option was used.

I think your "previous" one:

	<added> <deleted> <src> NUL		  (no rename)
	<added> <deleted> <src> NUL NUL <dst> NUL (with rename)

would be unambiguously parsable, but it would be cleaner and easier for
the parser if the latter were like this instead:

	<added> <deleted> NUL <src> NUL <dst> NUL (with rename)

The reader can expect to find a NUL terminated src, finds the length is
zero and notices it cannot be src and then reads two paths from that
point.

Without having the status letter, we cannot do "optional two paths"
without breaking existing --numstat -z readers that do not care about
renames and copies, and I agree that existing --numstat -z readers that
pass -M or -C are already broken, so I think a format extension along
the above line (your "previous" and the above clean-up proposal have the
same power of expressiveness, I just think the latter is syntactically
cleaner) would be reasonable.  And at that point we probably would not
need --numstat-enhanced at all ;-)
