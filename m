From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach "git add" and friends to be paranoid
Date: Thu, 18 Feb 2010 12:17:25 -0800
Message-ID: <7v635ub8oa.fsf@alter.siamese.dyndns.org>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>
 <20100214011812.GA2175@dpotapov.dyndns.org>
 <7vljer1gyg.fsf_-_@alter.siamese.dyndns.org>
 <201002181114.19984.trast@student.ethz.ch>
 <7vtytee7ff.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1002181456230.1946@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Feb 18 21:18:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiCoo-00058C-JU
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 21:17:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758724Ab0BRURq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 15:17:46 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43296 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758697Ab0BRURo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 15:17:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B202F9B76B;
	Thu, 18 Feb 2010 15:17:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vSc/zFTw8qzM5icbZ8MeG8CvdvY=; b=wzxdQe
	tEbgE9WIPHJfAVmJY6aXYe5Ee1rsECaTRzzTlheaDQNLMymUQR1SEW0uVED12nDh
	nK1REQuyVHEyRLp7EeFj6Fipdb80dm4/XjwaizWPBM1v2E4NdjrIXBwo83Wy5b/a
	qAUDYlOVWLMF98/7EZ4r6vo7gz9hiCnHhp5mY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SMvhzZKVV+IBSFrNJh68MfA/wsrl7B7c
	QmWsnjf/oj0k+lvbdHUq1NNpUp+zonSrQ0eg0VUaZqUolV69M8ptPkE8UNda6Tpo
	TupiCCcnu2c5OqsCfDNu9I6ectsCuP9nbhYcR0vdY+1yOlwLHFg769CqB//dkPrc
	J0fyqUuYQpI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ECBFC9B767;
	Thu, 18 Feb 2010 15:17:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 21FCC9B766; Thu, 18 Feb
 2010 15:17:27 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1002181456230.1946@xanadu.home> (Nicolas
 Pitre's message of "Thu\, 18 Feb 2010 14\:58\:06 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A73B654A-1CCA-11DF-BA1E-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140372>

Nicolas Pitre <nico@fluxnic.net> writes:

>> Honesty is very good.  An alternative implementation that does not hurt
>> performance as much as the "paranoia" would, and checks "the input well
>> enough" would be very welcome.
>
> Can't we rely on the mtime of the source file?  Sample it before 
> starting hashing it, then make sure it didn't change when done.

I suspect that opening to mmap(2), hashing once to compute the object
name, and deflating it to write it out, will all happen within the same
second, unless you are talking about a really huge file, or you started at
very near a second boundary.

I am perfectly Ok that it will have false negatives that way, but if the
probability of it catching problems is too low because git is too fast
relative to the file timestamp granularity, then it doesn't sound very
useful in practice, unless of course you are on better filesystems.

It won't have false positives and that is a very good thing, though.
