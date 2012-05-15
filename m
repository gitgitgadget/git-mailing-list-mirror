From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] drop length limitations on gecos-derived names and
 emails
Date: Tue, 15 May 2012 08:03:38 -0700
Message-ID: <7vtxzhfpv9.fsf@alter.siamese.dyndns.org>
References: <20120511231303.GA24611@sigill.intra.peff.net>
 <20120514162824.GA24457@sigill.intra.peff.net>
 <20120514210225.GA9677@sigill.intra.peff.net>
 <20120514211324.GA11578@sigill.intra.peff.net>
 <20120515015437.GA13833@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 15 17:03:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUJHu-0000eh-PQ
	for gcvg-git-2@plane.gmane.org; Tue, 15 May 2012 17:03:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754147Ab2EOPDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 May 2012 11:03:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64757 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753009Ab2EOPDl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2012 11:03:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8629D677A;
	Tue, 15 May 2012 11:03:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=88sF4XBAaE0GMvITn20bVv/xYOM=; b=PsIMgb
	UDpFSf0atrdgmNuTwUudomUi+dg3znLfaTK3S5F9V3omODQHxkDISy6vWBUteJD6
	Zvmq0bRa8pcK/w8CVdIlaBJCtoytlw9f9cQqkC6xyjfYeCWeftq0sh/M3w0rFHoD
	sO6V6aH4kRmEWlmyfqT5f1/IWCZsU7FQQ7WD8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LWLayecbjhbd12BUDS7RPcdHRa17ExC7
	R9o/5Zneab0Cki0tPnU4YGo/a4xq0837yoL+uZ8JrbCxP2DNAxsTZ9NJjtkDNmTu
	yAznc9+/jCypJMhHUlEjvX6n4qa3qI3DEjZddT1uWrShvKQULXRlj6bHXO1LjHXS
	0++Um9b/z3U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D00B6779;
	Tue, 15 May 2012 11:03:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0ED2D6777; Tue, 15 May 2012
 11:03:39 -0400 (EDT)
In-Reply-To: <20120515015437.GA13833@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 14 May 2012 21:54:37 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 27B0D34C-9E9F-11E1-A737-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197835>

Jeff King <peff@peff.net> writes:

> On Mon, May 14, 2012 at 05:13:24PM -0400, Jeff King wrote:
>
> We call setup_ident with our name pointer, which usually comes from
> getenv("GIT_*_NAME"), although could also come from something like "git
> commit -c $commit". We feed that to setup_ident. If name is NULL, then
> setup_ident will use git_default_name (filling it in from gecos or
> config). If it's not NULL, then we use it literally. And then we check
> _that_ result to see if it's empty. If it is, we either die or warn,
> depending on the flags. In the latter case, we fallback to using the
> username as the name.
>
> And that's what confuses me. Depending on what was passed in, we may
> have checked that GIT_COMMITTER_NAME is an empty string, or we may have
> checked that the config or gecos field yielded an empty string. 

Sounds quite sensible to me, though.

> In the
> latter case, it makes sense to fall back to the username.

I agree that we should use something like "Sorry, Mr. McDonald" codepath
when the GECOS field returns an empty string---after all that is what we
do when we are built with NO_GECOS_IN_PWENT.

> But in the
> former case, it doesn't; we should fall back to the config name or the
> gecos name.

If the user said GIT_COMMITTER_NAME is empty with "GIT_COMMITTER_NAME=",
that is different from saying with "unset GIT_COMMITTER_NAME" that the
user does not want the environment to take effect, no?  So I do not think
falling back to configured or gecos in the former case is the right thing
to do, even though that would mean explicitly giving an empty string in
that configuration variable is asking only for an error without any
recourse, which is not useful at all.
