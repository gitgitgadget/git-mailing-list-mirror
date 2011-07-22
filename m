From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [REGRESSION, BISECTED] `git checkout <branch>` started to be
 memory hog
Date: Fri, 22 Jul 2011 14:31:22 -0700
Message-ID: <7vk4baxas5.fsf@alter.siamese.dyndns.org>
References: <20110722130518.GA9873@tugrik.mns.mnsspb.ru>
 <20110722170001.GB20700@sigill.intra.peff.net>
 <7vipquz0d0.fsf@alter.siamese.dyndns.org>
 <20110722173601.GA9422@sigill.intra.peff.net>
 <7vaac6ysd2.fsf@alter.siamese.dyndns.org>
 <20110722203614.GA13232@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Kirill Smelkov <kirr@mns.spb.ru>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 22 23:31:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkNJm-00074S-8m
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jul 2011 23:31:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283Ab1GVVb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jul 2011 17:31:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35782 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932200Ab1GVVbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2011 17:31:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A402C4D46;
	Fri, 22 Jul 2011 17:31:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R4IEqx/IXK6Z4CYL7UmLQO5aiOM=; b=NRzGGH
	jrGNnysJ5eV/1+ONfY+YIJx4rcZ6MvVNlFhE7e5L56EKiC80HNbDhJ3rhOJAebXP
	7ww0bTQIPAPhpTZa+hMj5sh1fT1AE6QKA/Fih2PwJ2AXxzBEjZJt0Bvp+hlFYX6f
	h0jIqFyL4uToLCEP5ZIgQ2AVhDhBD2g8M41eE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q9/ebjAUzn8PlZuebk2dUx0Ju3euYJS1
	Ct+ZnSYcL0SHkCta027G7xUyOBXeyt57kDll8SMba25hk3Qwm8iB21NoauuY6OuF
	7kUXLoAiI1FlnNd/DG6G2ha7EGhiKpcrWX1xmhXm54pugq3plPuC5/av1BPz3quL
	FVBlNl3pZKs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9AD254D45;
	Fri, 22 Jul 2011 17:31:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 28B524D44; Fri, 22 Jul 2011
 17:31:24 -0400 (EDT)
In-Reply-To: <20110722203614.GA13232@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 22 Jul 2011 14:36:14 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F3143226-B4A9-11E0-8142-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177669>

Jeff King <peff@peff.net> writes:

> How about:
>
> -- >8 --
> Subject: [PATCH] streaming: free git_istream upon closing
>
> Kirill Smelkov noticed that post-1.7.6 "git checkout"
> started leaking tons of memory. The streaming_write_entry
> function properly calls close_istream(), but that function
> did not actually free() the allocated git_istream struct.
>
> The git_istream struct is totally opaque to calling code,
> and must be heap-allocated by open_istream. Therefore it's
> not appropriate for callers to have to free it.
>
> This patch makes close_istream() into "close and de-allocate
> all associated resources". We could add a new "free_istream"
> call, but there's not much point in letting callers inspect
> the istream after close. And this patch's semantics make us
> match fopen/fclose, which is well-known and understood.
>
> Signed-off-by: Jeff King <peff@peff.net>

Much nicer ;-)  Thanks.
