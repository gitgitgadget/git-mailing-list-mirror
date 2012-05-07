From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch/push: allow refs/*:refs/*
Date: Mon, 07 May 2012 09:24:20 -0700
Message-ID: <7vobq06jt7.fsf@alter.siamese.dyndns.org>
References: <7vsjfj7des.fsf@alter.siamese.dyndns.org>
 <7vwr4r8tpm.fsf@alter.siamese.dyndns.org> <4FA4C2CC.7080205@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon May 07 18:24:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRQjn-0002Ch-Q9
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 18:24:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757386Ab2EGQYc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 12:24:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43230 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757263Ab2EGQY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 12:24:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A01EB70E7;
	Mon,  7 May 2012 12:24:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yXTnKwPcE94doT+Mm+FFoNqTiq0=; b=bpOI7F
	yUF3hZPJ/LpCgQi4HyZymahAfJ7f0myEsyY9Lc46ctkFI2x2RhFsnL7+4PKQCXZV
	IqNZTosMPl2ogp8ZVSVNrODLDX7wXR5T8jCF3eB1R515M5SKeqNYWPD7ra7wtbnl
	PvcKAs2JYlm8+7gBf71Kd+G832SdFrtL9RupA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BmQ29k0tCTWuIcMMbubPfSzJiD3uELvl
	xdkatasXf2I89DYtAqPhMQB23C4EQbb66/jA71XDZz97rzA27GhKq+Uw8EfqBsch
	R2DvpUTeTZaXczANBdQwALzNV/yuyZgPprhrm/BdhjmTogfb/Ssz/qkNEvL0mA+Y
	HaJbZNnXXjY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9275C70E6;
	Mon,  7 May 2012 12:24:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 276A270E5; Mon,  7 May 2012
 12:24:23 -0400 (EDT)
In-Reply-To: <4FA4C2CC.7080205@alum.mit.edu> (Michael Haggerty's message of
 "Sat, 05 May 2012 08:03:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1B197150-9861-11E1-BEF0-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197281>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> This combination "!memcmp(ref->name, "refs/", 5) &&
> check_refname_format(ref->name, 0)" is the reason that I suggested
> adding a REFNAME_FULL option [1], in which case it could be written
> "check_refname_format(ref->name, REFNAME_FULL)".

I personally think that check-refname-format should lose its second
parameter and always check for a concrete full refs, so that we can
tighten the current allow-onelevel case a bit further (i.e. ".git/HEAD" is
OK at the root level, but ".git/refs/heads/HEAD" is asking for trouble,
and ".git/config" is downright confusing. The function does not get a good
enough clue by only ONELEVEL).  That would mean REFNAME_FULL will not be
necessary---it should be the only mode of operation, and the callers need
to be adjusted accordingly.

We should also introduce another function check-refspec-half-format to be
used for the checks for left and right halves of refspec ("refs/heads/*"
is OK but "refs/heads*" is not, perhaps).

A single function trying to do both and not doing a good job in either
case is not a pretty picture.
