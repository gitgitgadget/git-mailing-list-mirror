From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-core: conflictstyle=diff3 doesn't actually use diff3 
 compatible format
Date: Sat, 06 Mar 2010 11:03:17 -0800
Message-ID: <7vvdd9gtmy.fsf@alter.siamese.dyndns.org>
References: <20100305215253.364.63583.reportbug@localhost>
 <20100305221950.GB5083@progeny.tock>
 <7vpr3itn89.fsf@alter.siamese.dyndns.org>
 <36ca99e91003060457s6417f800uc7a3e126ee6b7d6f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Stefan Monnier <monnier@iro.umontreal.ca>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Mar 06 22:28:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No16y-0004YU-Q5
	for gcvg-git-2@lo.gmane.org; Sat, 06 Mar 2010 22:00:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754308Ab0CFTD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Mar 2010 14:03:29 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47889 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754290Ab0CFTD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 14:03:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B00A49F1DE;
	Sat,  6 Mar 2010 14:03:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=En9boqIl2ClJ1L2qQOBYMaHZpNk=; b=ApQb0+oHi5oqWFMYdT7Xg4T
	UffiYR+A85ejGmtQtgX/r2WTXioY4/9KhXSSv2gAwyYmjx3d5eioH7y1/uoJ0CmC
	RoUQYOvSEsILcUF5p2m1LcAmFWKpVvvhKN/YOuhMMSUuEWN2jGjNxR/UqkYnlzQc
	V687udcGfEeGnuovMFgI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=oN/VoRueM8mHF4/vnDQ628kuhJMB4pii1KX5xPghEGpP2nkfn
	ntvJTHQseB3/yFQL0Og+WyOPiC0qpkpEJLum4om+MrHjrBEK1BolHL89+aLfPJwl
	YJ6AcNBP1A+gN2Ewp7R7tP/CVCS5/0n7/6rcW/tQivb0ntqyQbz01Pa3Pg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 61ABE9F1D8;
	Sat,  6 Mar 2010 14:03:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 913BF9F1D6; Sat,  6 Mar
 2010 14:03:18 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EFEC65FC-2952-11DF-87F6-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> rerere needs an isspace() after the specified marker length. So I
> assume it could live with extra cruft after the | marker and a space.

is_cmarker() is called with want_sp = 0 for '=======' and '|||||||', so
the current code accepts both "||||||| rubbish\n" and "|||||||\n".

Also, rerere sanitizes a diff3 style conflict into a merge style conflict
before writing a preimage to rr-cache for later comparison [*1*], so it
probably is Ok even if we changed it in a way that it no longer reads the
current output without " rubbish" after the marker.  It appears that it is
already prepared to take either form, so we are probably safe here.

But I didn't check subcommands other than rerere that may read and act on
the conflict markers.

> BTW: Am I right, that rerere would need to handle my new conflict style too?

If we were to change the output, git needs to be prepared to see both the
output before and after the change and behave sensibly; it is not limited
to rerere.

For the reverse combined diff format, rerere probably needs to be taught
how to convert it as merge style conflict before computing the conflict
identifier and write it out in the preimage file, I think.

[Footnote]

*1* See 387c9d4 (rerere: understand "diff3 -m" style conflicts with the
original, 2008-08-29).
