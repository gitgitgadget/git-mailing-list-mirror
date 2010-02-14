From: Junio C Hamano <gitster@pobox.com>
Subject: Re: mmap with MAP_PRIVATE is useless
Date: Sat, 13 Feb 2010 17:53:48 -0800
Message-ID: <7vy6iw4m6r.fsf@alter.siamese.dyndns.org>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org>
 <20100212002741.GB9883@progeny.tock> <4B775384.50009@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	569505-forwarded@bugs.debian.org,
	Zygo Blaxell <zblaxell@gibbs.hungrycats.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Sun Feb 14 02:54:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgTgb-0000wL-Me
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 02:54:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132Ab0BNByI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 20:54:08 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60001 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758151Ab0BNByE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 20:54:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BC50699032;
	Sat, 13 Feb 2010 20:54:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uQbsaOPu/CBrjRC5Gm4mutB0ZjA=; b=pbGg9u
	tG4zZadRowmyZS04Z2mNECq1lromXTzDqRByTgXptpHMBeTEaA2N4qP8F701z72z
	QmLoo8c4WPddBKsPv2tYoyZm9hXkfYnHlSpcZBQBA7ojzuxPmYyYga1mYg+AiUD8
	07Xych76ZRBUAL8NKxLEWj7mA873NJAaSyMWw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dbo9HuV+iJ5D5iu7ePifiWF8uxEj9S7H
	slSvetbVe3UJhQFu9rQ6lHMSqHVg8ErKIe5nDQFEPmk1nhQ8Su5jDYW7fGa28SU1
	nBZBS7N3iLoP1sCMcDBrUlbhIh3uU3IVLQ6fnqxFrUFESR0evwPh9eUX5qiG3S1I
	bB+VgFFg39s=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 688C09902F;
	Sat, 13 Feb 2010 20:53:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7C7CF9902C; Sat, 13 Feb
 2010 20:53:50 -0500 (EST)
In-Reply-To: <4B775384.50009@gnu.org> (Paolo Bonzini's message of "Sun\, 14
 Feb 2010 02\:36\:04 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CFAD28C8-190B-11DF-A0DA-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139880>

Paolo Bonzini <bonzini@gnu.org> writes:

> This means that MAP_PRIVATE is utterly useless.

I do not think we ever used MAP_PRIVATE in order to protect outselves from
uncontrolled changes made by the outside world in the first place.  Back
when most of these mmap calls were written by Linus and myself, we weren't
interested in using MAP_PRIVATE, or any other trick for that matter, to
deal with the case where the user tells git to go index a file, and then
mucks with the file before git finishes and gives back control.

We do use mmap in read-write mode when reading from the index file, and we
use MAP_PRIVATE to protect the outside world from our writing into the
mapped memory.  As far as I know that is the only mmap for which
MAP_PRIVATE matters in the core git codebase.

Our calls to mmap() almost all have MAP_PRIVATE, even for read-only mmap,
but that is more or less from inertia, aka "an existing call to mmap is
with these options, I'll add another call imitating that".
