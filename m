From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Nesting a submodule inside of another...
Date: Wed, 13 Jul 2011 15:44:18 -0700
Message-ID: <7v8vs16bst.fsf@alter.siamese.dyndns.org>
References: <CAEBDL5XQDehUyqKoazxy+YVHh_2iAyt9aE-77H1jZg4oujMJgw@mail.gmail.com>
 <4E1C9F21.6070300@web.de>
 <CAEBDL5U0F+QaqhW92i-s82-C9fj2knp6JPNtNvgdJY68kRYwWQ@mail.gmail.com>
 <4E1E0C27.60903@web.de> <7vhb6p6fcl.fsf@alter.siamese.dyndns.org>
 <4E1E1672.7040503@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Szakmeister <john@szakmeister.net>,
	Git mailing list <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Jul 14 00:44:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh8AN-0003HG-8o
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 00:44:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777Ab1GMWoX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 18:44:23 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41978 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935Ab1GMWoV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 18:44:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7C5515479;
	Wed, 13 Jul 2011 18:44:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eZIspRZ9UILPBjKY66dPAAMnXEg=; b=yaYpCv
	kNrcIxsSBxb4CvX3XLy6EPzIALPwyQV+uDRB8RXgIc0WWdz8+c7R6YcLbEfjdqXm
	CuVGlDHkqaHZkBmIwc4QMS9N9E7mt9+HqRTY0ybdCgicCF+Lw4vvdIYtdt+L2tWb
	jnMEBeHMe9GNtg36xnWI9Dxa0RcQD+CjuosNY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aCxzNIacvoGYXOyE2LYnIvz7+rWOu3mk
	52GuxAxq2cnv2s3UhW+3TSpSsAqK6Yjcv/oRKr1Nvxh2YBmt/cvB5T5nl5BoXDcE
	8M3Zs/XAWA3TxoTS6q21GgFNYZ3u/MbdbOsGmIWIwl0aiKKdtQ67QXXAaRRmPBxJ
	+qzqwyXsjSI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 735995478;
	Wed, 13 Jul 2011 18:44:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B96165477; Wed, 13 Jul 2011
 18:44:19 -0400 (EDT)
In-Reply-To: <4E1E1672.7040503@web.de> (Jens Lehmann's message of "Thu, 14
 Jul 2011 00:04:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A56AC742-ADA1-11E0-9A6A-B086C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177091>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> ... (at least when it concerns their work tree, the
> gitfile effort is trying to introduce some superproject awareness).

I don't think so.

The "gitfile effort" just makes it more convenient and potentially safer
for superproject to remove submodule working tree by running an equivalent
of "rm -fr submodule". The submodule shouldn't even care where its .git
metadirectory is by looking at the "gitfile: " line, nor should it assume
that location its .git metadirectory moved out of its working tree has
some fixed relationship with its supermodule's repository.  E.g. the
superproject could choose to store it under $HOME/cache or /var/state as
long as it knows where to point it back to after it runs "rm -rf submodule"
and then it has to re-instantiate the submodule.

IOW, the superproject must be aware of that location, but submodule
shouldn't depend on what convention the superproject chose to use.
After all, there may not even be a superproject when gitfile is in use,
so running "test -f .git" and assuming that it is used as a submodule of
somebody else is already a bogus test.
