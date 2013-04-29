From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: improve recipients_cmd()
Date: Sun, 28 Apr 2013 22:24:41 -0700
Message-ID: <7vd2tdoqna.fsf@alter.siamese.dyndns.org>
References: <1367101561-14671-1-git-send-email-felipe.contreras@gmail.com>
	<7vbo8yqxas.fsf@alter.siamese.dyndns.org>
	<CAMP44s0x8fK-6vbY20eKA9QjWqhiOCvx+KFOgKOZ8q58bwk8Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Joe Perches <joe@perches.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 07:24:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWga0-0000rM-FQ
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 07:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179Ab3D2FYo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 01:24:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45442 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751429Ab3D2FYo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 01:24:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 29E2F14F32;
	Mon, 29 Apr 2013 05:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KWZjeSlm/j25Hdj07PkaWpIaT58=; b=AUpIXO
	VfJKN3XuhTlrW0Li/6vNmjAxd49zvT5dCBkh33S4ucWuAm35zj2gp776vsLGFzU2
	XtuoWOwhGT+pAc73SIxTyMPEk88aDzqCc8LMB7uqFKAJShQlOIJ/ft985iH5wkwc
	HnwDyjuWVQC/bVOLeCDKROWlNre+Rvsv9OUgk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AZBrvIoRcJ2VVRrgGcfbdeu4X0VWff7Z
	Y+9jm+zIvDRQdnaTX+S3usfTWx8mXVXEeT2Jn4opPD+IODLaQYOY4+x/7yWIQFiD
	+PSw+CybwydPfQ+sbvPrAbgnt5n5Cffopy4t+sxpDn81kn7aKv/eAOxORMU0vmvQ
	xkPeXZY8jXU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E95214F31;
	Mon, 29 Apr 2013 05:24:43 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9924014F30;
	Mon, 29 Apr 2013 05:24:42 +0000 (UTC)
In-Reply-To: <CAMP44s0x8fK-6vbY20eKA9QjWqhiOCvx+KFOgKOZ8q58bwk8Tw@mail.gmail.com>
	(Felipe Contreras's message of "Mon, 29 Apr 2013 00:14:52 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 18BB8B7E-B08D-11E2-8192-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222771>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>>         open $fh, "-|", qw(sh -c), $cmd, @args
>
> That doesn't seem to work for me.

My fault.  It needs to form a command line like this:

	sh -c 'cccmd --frotz --nitfol "$@"' - a r g s

[jc: goes and tries
	$ sh -c 'echo X Y "$@"' - a r g s
	X Y a r g s
]

so if we want to get rid of \Q\E, it would be:

	open $fh, '-|', qw(sh -c), "$cmd " . '"$@"', '-', @args
