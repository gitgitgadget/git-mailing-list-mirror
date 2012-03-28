From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git: continue alias lookup on EACCES errors
Date: Wed, 28 Mar 2012 11:31:10 -0700
Message-ID: <7v1uocwpap.fsf@alter.siamese.dyndns.org>
References: <20120327175933.GA1716@sigill.intra.peff.net>
 <20120327180503.GB4659@sigill.intra.peff.net>
 <7v4nt9j1m3.fsf@alter.siamese.dyndns.org>
 <20120328043058.GD30251@sigill.intra.peff.net>
 <7vaa30wrjx.fsf@alter.siamese.dyndns.org>
 <20120328174841.GA27876@sigill.intra.peff.net>
 <20120328180404.GA9052@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	James Pickens <jepicken@gmail.com>,
	Git ML <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 20:31:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCxeQ-0002CL-KL
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 20:31:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932682Ab2C1SbN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 14:31:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46708 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932629Ab2C1SbM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 14:31:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 348786AA2;
	Wed, 28 Mar 2012 14:31:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iG9lEQshZ14snd9Vk66GHCp3v6s=; b=DxQcsN
	JvmNVCu2OibnIomtLaIHj59CUbXktdWt0cCIUYE56a8v+FmDwYPXs9Jwc59dXb3z
	YC1xYNkm84mx30kCPVW7VeV2Gi67TAbmkmPkY8sx6oDDQCrAEifU/e9jULB9kD/U
	YJcnmCrc7pE2LevdP0YDTaO7XWisJLgxYFaGE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kDo1t0hd50/dDWMiOOCJKk95Rus3Lpx8
	nQaYzaJDC/NbbET07vekzeFT/f7y+zE+waAE08Ow2/yQ81RM1bkeqNwXavDx5A4U
	7ChdOgBTcKI4BxEoJNCKGDOX7dA2lsaHqvcjH36mylWjabvXi+BF8S53wdKQ0r5E
	rHqCBm5FY8o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C3AB6AA1;
	Wed, 28 Mar 2012 14:31:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B7D2B6AA0; Wed, 28 Mar 2012
 14:31:11 -0400 (EDT)
In-Reply-To: <20120328180404.GA9052@burratino> (Jonathan Nieder's message of
 "Wed, 28 Mar 2012 13:04:04 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 31A67A84-7904-11E1-9A0C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194157>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jeff King wrote:
>> On Wed, Mar 28, 2012 at 10:42:26AM -0700, Junio C Hamano wrote:
>
>>> I am leaning to think that it would be the least surprising if we treat as
>>> if /bin/ls does not even exist if /bin is not searchable.  If /bin/ls is
>>> unreadable or unexecutable but /bin is searchable, then we _know_ it
>>> exists, and we follow the usual exec*p() rule to ignore it
> [...]
>> That sounds sensible to me. I think it involves writing our own
>> execvp, though, right?
>
> If I understood Junio correctly, then checking for ENOENT and EACCES
> should be enough.
>
> Example: when I try
>
>  :; mkdir $HOME/cannotread
>  :; chmod -x $HOME/cannotread
>  :; echo nonsense >$HOME/bin/cat
>  :; chmod -x $HOME/bin/cat
>  :; PATH=$HOME/cannotread:$HOME/bin/cat:/usr/local/bin:/usr/bin:/bin
>  :; cat /etc/fstab
>
> the shell uses /bin/cat without complaint.

Yeah, but I think that the case Peff is worried about is:

        $ >~/bin/nosuch
        $ nosuch
        nosuch: Permission denied
