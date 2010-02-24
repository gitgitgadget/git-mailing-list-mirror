From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] fallback SSH_ASKPASS when GIT_ASKPASS not set
Date: Wed, 24 Feb 2010 08:24:22 -0800
Message-ID: <7vocje38ll.fsf@alter.siamese.dyndns.org>
References: <1267024554-3288-1-git-send-email-lznuaa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 17:24:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkK2S-0007X3-OM
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 17:24:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757083Ab0BXQYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 11:24:35 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37558 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756863Ab0BXQYe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 11:24:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EB529C9F4;
	Wed, 24 Feb 2010 11:24:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I2+xeGVR8jXixiiHhHp1qswXX38=; b=ABW2KK
	czNAu1QBGhlKVWxFiJwcvT9GZZTZybZ6JGl9Ogg5LWmBq6GfdRpko/p8c8MWfOKf
	OJQAa4mS+RvKf48f9cuZf+Y0MR/JSAnkNQxbIi+OwGkZTrcA9C4wgmbupPdcMp6n
	w1p6eH6hAW4DyMo+Zh394lNMQAWEpwV3CNufw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XWmv4+6eN6o/AKsIB9L67apbweY3mXwg
	0NRCPC4SbaAKjBKq43UthvNH/j9yuviRMGSkd0mDMnO35WP8/R3aQ3kzfztprrrH
	Pe1kNgk+c/99ZMGAxIhqkZHtzA94UsHC+cYDk0dMJEBBzwvUbR7i+MupWcTOcvGl
	ZSEzt5tfnlk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 11FA69C9F0;
	Wed, 24 Feb 2010 11:24:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 55B609C9E6; Wed, 24 Feb
 2010 11:24:24 -0500 (EST)
In-Reply-To: <1267024554-3288-1-git-send-email-lznuaa@gmail.com> (Frank Li's
 message of "Wed\, 24 Feb 2010 23\:15\:54 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 144B0A9C-2161-11DF-A421-E038EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140952>

Frank Li <lznuaa@gmail.com> writes:

> If GIT_ASKPASS is not set and SSH_ASKPASS set, GIT_ASKPASS will
> use SSH_ASKPASS. If GIT_ASKPASS set and SSH_ASKPASS is not set,
> SSH_ASKPASS will use GIT_ASKPASS.

If both are set and to different values, what should happen?

I think the basic idea is sound, but I am not sure if we should fallback
on both ways.  If both GIT_ASKPASS and SSH_ASKPASS are set, the user is
probably telling us to use GIT_ASKPASS when git does something, similar to
how GIT_EDITOR and EDITOR interacts.

So probably the patch to implement the fallback should be more like

	if (SSH_ASKPASS is set but not GIT_ASKPASS)
        	set GIT_ASKPASS from SSH_ASKPASS

and then the password prompter should use GIT_ASKPASS exclusively.

Of course, when we _do_ spawn ssh ourselves internally in connect.c, we
may have to export the value of GIT_ASKPASS as SSH_ASKPASS at the call
site to honor the user's request to use GIT_ASKPASS while in git (that is
part of "use GIT_ASKPASS exclusively").

But it feels wrong if we exported SSH_ASKPASS set from GIT_ASKPASS when
spawning processes in other codepaths, especially if SSH_ASKPASS is set
(or unset) differently from GIT_ASKPASS.

Shawn is CC'ed as git-gui currently honors only SSH_ASKPASS and this patch
changes the behaviour slightly.
