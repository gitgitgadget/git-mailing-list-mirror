From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Detecting pushes originating from shallow clones?
Date: Mon, 30 Nov 2015 14:52:18 -0800
Message-ID: <xmqqr3j76qxp.fsf@gitster.mtv.corp.google.com>
References: <147913FA-1158-40BE-8365-B90E3CBD79C7@heroku.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Owen Jacobson <ojacobson@heroku.com>
X-From: git-owner@vger.kernel.org Mon Nov 30 23:52:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3XJ3-0003We-Pb
	for gcvg-git-2@plane.gmane.org; Mon, 30 Nov 2015 23:52:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754884AbbK3WwV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Nov 2015 17:52:21 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51850 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754047AbbK3WwV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Nov 2015 17:52:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 59E26309FD;
	Mon, 30 Nov 2015 17:52:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=r8Z8mkfMuNZ5
	XLRTqFN8EE98wlA=; b=RLxoc2RdWjMvbZfmVfFw5tq22jA3mIlDbvQXZu5M/gRJ
	N3WP0bG0Uk8irwJUZksdijnkXzEieXaI9d7Q3P+WfVl+3wO40zJLnQCHi6KhTAhY
	rGn6f8DzU3HhpTqnviNWyi6Hjdpnx57iMjghJjK8rz/TkEYiAst8IN2lr5EfYh4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=YW445l
	OU0v3y6M8nI2Yo0nfObCtwRP4oVAi4SZWW9Pz6WKDHYnwsu/vKQLC6nyDGQhOnxG
	U5LvW6Aw+Egrdb8a8Aif8s0upNSRt3aHSI/l0Y6yMOePGJkQnwC4GIyeqRlT9Kq7
	ev7oNwsrnmKCMoSDkeUfNiynbeI4ytuYrks7A=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 521E9309FB;
	Mon, 30 Nov 2015 17:52:20 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C8403309F7;
	Mon, 30 Nov 2015 17:52:19 -0500 (EST)
In-Reply-To: <147913FA-1158-40BE-8365-B90E3CBD79C7@heroku.com> (Owen
	Jacobson's message of "Mon, 30 Nov 2015 17:27:31 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 02E84AA0-97B5-11E5-A52B-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281823>

Owen Jacobson <ojacobson@heroku.com> writes:

> Hi folks,
>
> Here at Heroku, we ingest code from users by supplying them with a
> Git server they can `git push` into. Occasionally, users will
> attempt to push to us from a shallow clone, which causes numerous
> problems for us and, often, for our users (incomplete
> repositories, gaps in history, failed builds, and a host of other
> problems). We=E2=80=99ve been investigating what we can do to give th=
ese
> users clearer advice on how to fix the problem.
>
> Within the constraints that
>
> * we cannot control which version of Git our users have installed, an=
d
> * we run Git v1.9.1, obtained from the Ubuntu 14.04 LTS .deb reposito=
ries
>
> what can we do in an update/pre-receive hook to detect that an
> incoming push originates from a shallow repository and reject it?

Hmm, I would have suggested to set receive.fsckObjects which has
been around since early 2008 (it is in v1.5.6, so it would likely be
in v1.9.1 as well).

But even without that configuration set, "push" shouldn't leave the
receiving repository in an inconsistent state (e.g. incomplete
repository, gaps in history) in the first place.

Does anybody recall us having such a bug in the distant past in
1.9.1 and fixing it?  I do not offhand recall but I wouldn't be
surprised.

> Right now, the best strategy we have is to observe whether
>
>     git rev-list OLD NEW
>
> fails, and if it does fail, whether the stderr output includes the
> phrase "revision walk setup failed=E2=80=9D. This feels like a fairly
> weak fix ...

Actually, that (with "--objects" option) is essentially the test the
receiving end does internally to detect the "gaps in history" when
receive.fsckObjects configuration is set.
