From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP PATCH] Manual rename correction
Date: Tue, 31 Jul 2012 09:32:49 -0700
Message-ID: <7vtxwnki1a.fsf@alter.siamese.dyndns.org>
References: <20120731141536.GA26283@do>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 18:33:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwFNS-0000qC-Ff
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 18:32:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754957Ab2GaQcx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 12:32:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52877 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753711Ab2GaQcw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 12:32:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9142889E8;
	Tue, 31 Jul 2012 12:32:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T0Mu5ScQ/dni9Rlf1K9vpQrsLNE=; b=O5Oaet
	4oJeCrmXYSkBufraas4PiyXtH5ZfBlH0YOzkbgzYjw7ONHNF9j2uL7ibTVOjsIj+
	OBOZhkoNFHzmmlvAHusE4xn1YgzH0xLqf3iR4FLvIdq+g/XV3DtONqlfSn3sKi6p
	NlSU2n5Dn6bRAhessIoPcM6Q5BtYs+MuGh7ZY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xb4W0O6rG4XGXrC6KhDctczmdPFm4uP/
	IxCOhZMy959lJRuFGf7KUgPcvF573nDL1RyD1tRYDCQFn1kW1gV2M6nnD6OzzkIy
	iBB1orDn9Ru3IHDqpNxfHBRtggo7E19TrtwiCAsrZyXhtFqgAB11jxlIlkO7Tgej
	HjrLQz8p+FQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F6FE89E7;
	Tue, 31 Jul 2012 12:32:51 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E437489E6; Tue, 31 Jul 2012
 12:32:50 -0400 (EDT)
In-Reply-To: <20120731141536.GA26283@do> (Nguyen Thai Ngoc Duy's message of
 "Tue, 31 Jul 2012 21:15:36 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5EDDA2EE-DB2D-11E1-A4B2-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202658>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> The above output is done with "git diff --manual-rename=foo A B"
> and "foo" contains (probably not in the best format though)
>
> -- 8< --
> attr.c dir.c
> dir.c attr.c
> -- 8< --
> ...
> Comments?

It is a good direction to go in, I would think, to give users a way
to explicitly tell that "in comparison between these two trees, I
know path B in the postimage corresponds to path A in the preimage".

I however wonder why you did this as a separate function that only
does the explicitly marked ones.  Probably it was easier as a POC to
do it this way, and that is fine.

The real version should do this in the same diffcore_rename()
function, by excluding the paths that the user explicitly told you
about from the the automatic matching logic, and instead matching
them up manually; then you can let the remainder of the paths be
paired by the existing code.

Notice how the non-nullness of rename_dst[i].pair is used as a cue
to skip the similarity computation in the expensive matrix part of
diffcore_rename()?  That comes from find_exact_renames() that is
called earlier in the function.  I would imagine that your logic
would fit _before_ we call find_exact_renames() as a call to a new
helper function (e.g. "record_explicit_renames()" perhaps).
Anything that reduces the cost in the matrix part should come
earlier, as that reduces the number of pairs we would need to try
matching up.

We might want to introduce a way to express the similarity score for
such a filepair that was manually constructed when showing the
result, though.
