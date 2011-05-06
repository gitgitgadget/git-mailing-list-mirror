From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] rerere: Expose an API corresponding to 'clear'
 functionality
Date: Fri, 06 May 2011 09:51:13 -0700
Message-ID: <7vr58b22ny.fsf@alter.siamese.dyndns.org>
References: <20110413203843.GC30630@elie>
 <1304663813-27724-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 06 18:51:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIOFZ-0002qm-A7
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 18:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756662Ab1EFQv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 12:51:28 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43673 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756636Ab1EFQv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 12:51:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7A3DC5DA0;
	Fri,  6 May 2011 12:53:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Lme/huGXP7512HWHjHk5sB2sp2s=; b=Yo/bQc
	Xw6fpaQ1JYXEpWpf1uXKJW0/jwZYNA8lSmpEUrPEHiFw2DLN6XfWt+OccxephFO9
	k/2Z8RbkpIi0rL7jcTG8HLa2+M7HAIWkG+GzMYGh9n0rbhtevhhN113QFeSYt/j7
	RBMRXz8yUVVl+WY7G8kKpJnbIUUJYQBt5k7fQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TCNhYUe3V5p8dPZPKLEwWDZ0S0gp6j7q
	glkDnyjE2kRFs32DCh68tYEkcx0dNzf4uhPe1GHMchoxBMIVB8Z5msFhvhc8SIY4
	ipCwZmCKKW056nEWsZIbuLtolWisGCoiwb5/T22Xq6tfFwrbI2PAzp39Ue9zp0hw
	S2CprNN0Gu0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 339675D9F;
	Fri,  6 May 2011 12:53:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DAC6C5D9E; Fri,  6 May 2011
 12:53:18 -0400 (EDT)
In-Reply-To: <1304663813-27724-1-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Fri, 6 May 2011 12:06:53 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B3072CE-7801-11E0-A8E5-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172989>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Libify the "rerere clear" into a simple function called rerere_clear
> that takes no arguments, and returns the exit status.  Also export
> unlink_rr_item as unlink_rerere_item so rerere_clear and the
> un-libified "git rerere gc" can both use it.
>
> Helped-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  What changed since v2: Jonathan's review.

Are you sure this is the version you wanted to send?

You now return -1 from rerere_clear() when setup_rerere() says that the
feature is not enabled, and this is propagated back to cmd_rerere(),
causing the whole command to report a failure in its exit status, which
seems to me a grave regression.  Your previous round got this part right,
but it is broken in this round.

Also I seem to recall that Jonathan suggested that you do not have to
expose unlink_rr_item() as an external symbol if you moved the garbage
collection part from builtin/rerere.c to rerere.c but I do not see such a
change in this patch.  I think the gc interface is a lot more reasonable
API to expose to external callers ("git gc" may want to make an internal
call to rerere_gc() moved to rerere.c, instead of spawning "git rerere gc"
as an external command) than unlink_rerere_item() that is only useful for
callers that are deep inside rerere specific codepath.

What is going on?
