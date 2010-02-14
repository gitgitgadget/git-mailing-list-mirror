From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] don't use mmap() to hash files
Date: Sat, 13 Feb 2010 19:14:01 -0800
Message-ID: <7v8wawy0ee.fsf@alter.siamese.dyndns.org>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>
 <20100213121238.GA2559@progeny.tock> <20100213133951.GA14352@Knoppix>
 <201002131539.54142.trast@student.ethz.ch> <20100213162924.GA14623@Knoppix>
 <37fcd2781002131409r4166e496h9d12d961a2330914@mail.gmail.com>
 <20100213223733.GP24809@gibbs.hungrycats.org>
 <20100214011812.GA2175@dpotapov.dyndns.org>
 <7vtytk61im.fsf@alter.siamese.dyndns.org>
 <20100214021847.GA9704@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 14 04:14:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgUwN-0002Ss-3q
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 04:14:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758280Ab0BNDOT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 22:14:19 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45050 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753436Ab0BNDOS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 22:14:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B06DE99833;
	Sat, 13 Feb 2010 22:14:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Sb0IVfY05A72v6M778VcMwpRKvg=; b=Lu15zD
	uol9xqZd/cHieRsnjp4GMX5GPrqvx6gm6tJujQmLaXxciEkzWaa9wv8E8AM65N4s
	/dpztJ8GEBV93Z4jY0wzTgXhg2g5OXXZQ2YU8aXLoADEsUVZ3NcJS0KWIecCD8b7
	pr5TeG42iPey9cheLJxAIpmC8I5RQa/K949FY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZmZ8oazN5CyTa5wnlNDS3invinYfhD0w
	e+bj468klzY1NANQNrWAYMWfqt0TOLwvBqVQgyyUQ4s1ICArVESl/7Q6BAwO18r0
	f0svzrtJYdTcnSC8N6MyWa8XAl3MZiukTbN0pxos4ALo8WDU/WEWD2DCA9E5Ez0w
	IahHsM6Ovf4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A57F99831;
	Sat, 13 Feb 2010 22:14:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3BA6E99830; Sat, 13 Feb
 2010 22:14:03 -0500 (EST)
In-Reply-To: <20100214021847.GA9704@dpotapov.dyndns.org> (Dmitry Potapov's
 message of "Sun\, 14 Feb 2010 05\:18\:47 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 04F8B2F8-1917-11DF-A4EE-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139886>

Dmitry Potapov <dpotapov@gmail.com> writes:

> My initial reaction was to write that the whole problem is due to abuse
> Git for the purposes that it was not intended. But then I decided to do
> some testing to see what impact it has. And, because I do not see any
> negative impact (in fact, slightly improve speed), and I decided to ask
> other people (who are interested in this patch) to do more testing.

Yes, I know, and I greatly appreciate it.

Later, we might want to split the codepath again to:

 (0) see if it is huge or small if we are not reading from pipe;

 (1) if we do not know the size or if it is moderately tiny, keep doing
     what your code does;

 (2) if we know we are reading something huge with known size, then have a
     loop to read-a-bit-compress-and-write-it-out-while-hashing, and
     finally rename the loose resulting object to the final name.  Or we
     may even want to do that into a new pack on its own.

but obviously all of that can come after this initial round ;-)
