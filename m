From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix threaded grep for machines with only one cpu
Date: Tue, 16 Feb 2010 17:26:06 -0800
Message-ID: <7vvddwodox.fsf@alter.siamese.dyndns.org>
References: <20100215225001.GA944@book.hvoigt.net>
 <7vwryet2cw.fsf@alter.siamese.dyndns.org>
 <7vocjpnc5v.fsf@alter.siamese.dyndns.org>
 <7vljetlx8r.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1002160914140.20986@pacific.mpi-cbg.de>
 <7viq9wzq8g.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1002170200370.20986@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Fredrik Kuivinen <frekui@gmail.com>, git@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 17 02:26:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhYgR-0002Ah-7J
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 02:26:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933876Ab0BQB0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 20:26:25 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48020 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933864Ab0BQB0X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 20:26:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 716459AE17;
	Tue, 16 Feb 2010 20:26:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NsVNT5pywbXlL5+9Hp20LHgu1Ko=; b=HKfXPW
	92zD/TbIMA8l/PYrAqvxNpKPJsrEXyg6QXDQ7W4m983KAAasQBaA37vc3HlHrlf8
	Hvc02LEo26qYNPWxLRGA7LJL1p52p82p52VL6bnDMtUjZCXm/Rf8XU2OsFyqHkIk
	tRE7aZmSVW1BY6pNMFKmAU6LPwk1/te9eBsSg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JAAsCb/L38ei9vHM4o/r7wVOAdIPN+v1
	hsQ5tUa3Wk1LSVR2QhxMLfjcZyymU9bE2azzCm5849DSW1DgkS5mhqC4yzYtctuS
	eenifhptD2mQwxB8E+WO8jR2BouN6gGA4a09u/zx0qLIwPUf+1Ryq8uVqeL2MAUD
	Mb/MExAdHk8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B4A89AE14;
	Tue, 16 Feb 2010 20:26:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DDD8E9AE06; Tue, 16 Feb
 2010 20:26:08 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1002170200370.20986@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Wed\, 17 Feb 2010 02\:01\:03 +0100
 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 70B1DD3C-1B63-11DF-8376-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140197>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> The program can decide at runtime not to use threading even if the support
>> is compiled in.  In such a case, mutexes are not necessary and left
>> uninitialized.  But the code incorrectly tried to take and release the
>> read_sha1_mutex unconditionally.
>> 
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> Acked-by: Fredrik Kuivinen <frekui@gmail.com>
>> ---
>
> Yes, this one looks much, much nicer.

The structure may be much nicer, but one remaining thing is that I do not
think foo_locked() is a good name; IIRC, kernel folks use _locked() suffix
when the caller is expected to already hold the lock.  So a typical naming
convention goes like this:

	foo()
        {
        	lock();
                foo_locked();
                unlock();
        }

but what the patch did was the other way around:

	read_sha1_file_locked()
        {
        	lock();
                read_sha1_file();
                unlock();
	}

which is probably against the convention many readers of our codebase are
already familiar with.

We need a better name to unconfuse people, I think.
