From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bash completion: use read -r everywhere
Date: Wed, 21 Dec 2011 11:23:07 -0800
Message-ID: <7v1urxhgpw.fsf@alter.siamese.dyndns.org>
References: <4502a0248bb843018335e9b5cdf70736c096ebe3.1324482693.git.trast@student.ethz.ch> <7vipl9hht4.fsf@alter.siamese.dyndns.org> <87wr9pkahw.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Kevin Ballard <kevin@sb.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Dec 21 20:23:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdRkx-0002VI-M6
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 20:23:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753626Ab1LUTXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Dec 2011 14:23:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43662 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752866Ab1LUTXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2011 14:23:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 294216212;
	Wed, 21 Dec 2011 14:23:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Vxee65yRb/kLqKeYpqR0Wpu98NU=; b=G+829+
	4HKA5dArFcGLXrRvSw0bBZJijOK6K6XdGNOR/JXRx/wraFTtBAG2hiXDLFuBJsmI
	iZwUBUFIJayCmAsZ3njAnEfoDxpOVUC0iluiSPlhlWjp8siZXqpIgQw4cF5sSlHt
	ZM3G/jQjXp+9mXmG4uSUFzGDHjc798bJHVlwc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tQ20/+kCUH5kFEKvqKWxxC6HzKIXTMSL
	g0pS5qv5OHhiEKamko0UyMMAnZkQvl92wUGnfNwt2p6JarMdJ6cd878rvd/jFFMp
	W4Bu66mrJAlTs0RZ5sFeAWx3lwxSIf9obzYLWL4nMTNLL91MNpBJpXIYHYXxjtK6
	awbBUEToKIM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21D946211;
	Wed, 21 Dec 2011 14:23:09 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9D3AB620F; Wed, 21 Dec 2011
 14:23:08 -0500 (EST)
In-Reply-To: <87wr9pkahw.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Wed, 21 Dec 2011 20:09:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 36FAA818-2C09-11E1-A0BC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187584>

Thomas Rast <trast@student.ethz.ch> writes:

> Perhaps we can then just fold it into the first paragraph after the
> POSIX quote, like

Well, that is what I tried say so we are on the same page ;-).

>   We use the 'read' command without -r, so that it treats '\' as an
>   escape character, in several places.  This breaks the loop reading
>   refnames from git-for-each-ref in __git_refs() if there are refnames
>   such as "foo'bar", in which case for-each-ref helpfully quotes them as
>   in
>
> Or some such.  Do you want me to resend?

Nah, The above as-is is perfectly fine.

By the way, this is not a problem with the patch, but the for-each-ref
loop is a poor example. Its --shell option is meant to produce a scriptlet
that can be evaled without the buggy processing loop you are fixing, i.e.

	script=$(git for-each-ref --shell --format='
		ref=%(refname:short)
                ref=${ref#*/}
                if [[ "$ref" == "$cur"* ]]
                then
                	...
	' refs/remotes/) &&
        eval "$script"

is how it was designed to be used avoiding shell loops.

>> Does this regress for zsh users in some ways, by the way?
>
> I'm not one of them, but...

Thanks, that was all I wanted to know before deciding if I should apply
this directly to 'master' or cook in 'next' to give real zsh users a
chance to object or tweak it.
