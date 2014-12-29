From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/7] push.c: add an --atomic argument
Date: Mon, 29 Dec 2014 12:33:37 -0800
Message-ID: <xmqq7fxayz4u.fsf@gitster.dls.corp.google.com>
References: <1419017941-7090-1-git-send-email-sbeller@google.com>
	<1419017941-7090-7-git-send-email-sbeller@google.com>
	<549D0B78.402@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, ronniesahlberg@gmail.com,
	jrnieder@gmail.com, sunshine@sunshineco.com, git@vger.kernel.org,
	Ronnie Sahlberg <sahlberg@google.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Dec 29 21:34:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5h16-00030X-86
	for gcvg-git-2@plane.gmane.org; Mon, 29 Dec 2014 21:34:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009AbaL2Udl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2014 15:33:41 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65188 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751589AbaL2Udk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2014 15:33:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D83122AC27;
	Mon, 29 Dec 2014 15:33:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9Jy6KskudsaEfMWmTTnPnMDWwpc=; b=Di8J1K
	BIm29cE4TKLWGL33/pFNF+oF1yxJ9IQW1d2EHCr6GnJnCc9IcLdhb5wjqzC1Fzrr
	NR74n0mLZoQAb42TrnVJ4PQ+gp1aGYOw61vja4jn9/z6m3jsrFH8E4oC9OdOqrJe
	Vjja0pJH+9KQH8pa5FuhFg1iMFIeZugYlPTGo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x/s4QNVukNwC30G/rHZb4BjTYdfXL4VH
	i6Mhh8oUtnwdQxNYZwUUwwsolbaVp+XwAnIyEBmSW7k/XFUp8aWQ6WCrvGaNuJRv
	RrEg5Y34bib+ZMGJS6tsgrMINb3mgdFAwLAWTnJjmd2NSdeAm+JpMjU+fUL9SUit
	kLDUDlCMfzw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CD44A2AC26;
	Mon, 29 Dec 2014 15:33:39 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5165F2AC1E;
	Mon, 29 Dec 2014 15:33:39 -0500 (EST)
In-Reply-To: <549D0B78.402@alum.mit.edu> (Michael Haggerty's message of "Fri,
	26 Dec 2014 08:17:12 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F8C161AC-8F99-11E4-AE4A-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261876>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I'd like to discuss the big picture around this feature. I don't think
> that any of these questions are blockers, with the possible exception of
> the question of whether "--atomic" should fall back to non-atomic if the
> server doesn't support atomic pushes.
>
> 1. Should "--atomic" someday become the default?
>
> You seem to imply that "--atomic" might become the default sometime in
> the future. (I realize that this patch series does not propose to change
> the default but let's talk about it anyway.) In the real world, the most
> common reason for an "--atomic" push to fail would be that somebody else
> has pushed to a branch since our last update, resulting in a non-ff
> error. Would I find out about such an error before or after I have
> transferred my objects to the server?

That question is pretty much rhetorical, as certain rejections you
cannot fundamentally implement without having the data at hand.

> If I only find out at the end of the transfer, then it could be a pretty
> frustrating experience pushing a lot of references to a server over a
> slow connection.

We'd like to have a long overdue protocol update for fetch and push
soonish anyawy (perhaps in the first half of 2015) and part of that
should include unified logic for common ancestor negotiation between
fetch and push [*1*].  We should be able to ease that with an
optimization similar to quickfetch done on the fetch side once that
happens.

> Even *if* "--atomic" becomes the default, we would certainly want to
> support a "--no-atomic" (or "--non-atomic"?) option to get the old
> behavior. It might be a good idea to add that option now, so that
> forward-looking script writers can start explicitly choosing "--atomic"
> vs. "--no-atomic".

Perhaps.  But on the other hand, pushing multiple refs at the same
time is a sign that they are related and need to go together.  The
reason why one but not others fails would be an indication that
there is somebody else pushing into the same repository and the
pusher and the other party are stepping on each other's toes, which
should be resolved primarily by inter-developer communication, not
with "--no-atomic" workaround.

> 2. Is this an option that users will want to specify via the command line?
>
> For scripts that want to insist on "atomic" updates, it is no problem to
> specify "--atomic" on the command line.
>
> But supposing that "--atomic" is a good default for some people, it
> would be awkward for them to have to specify it on every "git push"
> invocation. It therefore might be nice to have a configuration setting
> to choose whether "--atomic" is the default.
>
> Also (see above) it might be useful to set "--atomic" only for
> particular servers (for example, only for those to which you have a fast
> connection). This suggests that the "atomic/non-atomic" configuration
> should be settable on a per-remote basis.

I think you are hinting to have remote.atomicPush = {yes,no} that is
weaker than remote.$nick.atomicPush = {yes,no} or something like
that.  I agree that would be a good direction to go.

> 3. What should happen if the server doesn't support atomic pushes?

If you asked for atomic push explicitly and if the server cannot
support it, push should fail.

If the only reason we are doing atomic is because in some future we
flipped the default (i.e. no remote.*.atomicPush or --atomic option
from the command line), then it might be OK to continue with a
warning.

I however think that the automatic demotion is too much complexity
for such a simple option.  "Please be atomic if you can but I'd take
non-atomic one if you do not want to give me atomic one" that is
responded by "I'd do non-atomic then, as you are perfectly happy
without" is not very useful---such a pusher should just say "I
accept non-atomic", which is what "--no-atomic" is for.


[Footnotes]

*1* Two other big ones are syntax change to have an explicit
    extension packets instead of hiding the capability after NUL,
    and resolving the "who speaks first" issue.
