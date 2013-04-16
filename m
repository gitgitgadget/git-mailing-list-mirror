From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Resend PATCH] t3903 (stash): add failing test for ref of form
 ^{/message}
Date: Tue, 16 Apr 2013 11:41:28 -0700
Message-ID: <7vmwsyl3mv.fsf@alter.siamese.dyndns.org>
References: <1366135765-18437-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 20:41:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USAoy-0000mZ-3g
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 20:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753817Ab3DPSlb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 14:41:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47288 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753283Ab3DPSlb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 14:41:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5ED8B17B86;
	Tue, 16 Apr 2013 18:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=umLR+EcnwNwC0by6qVXEwUfqAZ0=; b=kzy1zH
	Kdm0qIW3bISUQunfWPKmnY5mUwPFlPX0por0hKOwRp7t1J3/eUbleXL2QcixOYoC
	x7OqrVj2J5/7kkzbY7TYBw9DxPZLp9KH06jMU2BNFoZLOa7om3Q5BeaPY/YRucG7
	AGOo0uNhTVPXal9N+tZ2303IVkTCSBGl8ins8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OqE+cM8XB58MjM/eeXAhOviBpCTIjWFr
	PcZ4ec0hV9XJl37vHWx5m6rnPUnWmXfFckcdUtcZEwJjV3VSklMdpWhc1zSL0gqJ
	mgGj+mRnP02W7bHYLpNkdcd6gdlkfivkjdfLQZdbMYyI3or1gJcFxhx/Dfwyuxqi
	DGbQb8Qt0OE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52FA317B84;
	Tue, 16 Apr 2013 18:41:30 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A2D9817B83; Tue, 16 Apr
 2013 18:41:29 +0000 (UTC)
In-Reply-To: <1366135765-18437-1-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Tue, 16 Apr 2013 23:39:25 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4093F02C-A6C5-11E2-BA17-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221449>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> While a 'git stash show stash^{/quuxery}' works just fine, a 'git
> stash pop stash^{/quuxery}' complains with: 'stash^{/quuxery} is not a
> stash reference'.  This confusing behavior arises from the differences
> in logic that 'show' and 'pop' internally employ to validate the
> specified ref.  Document this bug by adding a failing testcase for it.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  So sorry about misspelling Junio's address in my previous email.
>  Please respond to this one instead.
>
>  So if you look at git-stash.sh:377, you'll notice that it's doing a
>  the shell substitution "${REV%@*}" to figure out whether the stash
>  ref is a valid ref.  This hacky myopic design has to be done away
>  with immediately, and we should really compare the SHA-1 hex of the
>  specified ref with those in the stash reflog.
>
>  The only reason I haven't written a fix yet is because I'm not sure
>  why you need this convoluted IS_STASH_LIKE and IS_STASH_REF logic in
>  the first place.  Can someone enlighten me as to what is going on?

I think they were an attempt to catch command line argument errors
early to be helpful to the end users.

See ef763129d105 (detached-stash: introduce parse_flags_and_revs
function, 2010-08-21).  As the advertised and originally intended
use for stash was to name them with "stash@{number}", chomping at
the first at-sign to make sure it names refs/stash does not sound
too bad a check.

I do not think anybody considered the approach to look at the commit
object name and making sure it appears in the reflog that implements
the stash. It sounds like a more robust check if done right.
