From: Junio C Hamano <gitster@pobox.com>
Subject: Re: smudge filters during checkout & crash consistency
Date: Wed, 12 Nov 2014 12:51:16 -0800
Message-ID: <xmqqfvdo3zy3.fsf@gitster.dls.corp.google.com>
References: <CAMsgyKbox7e2pv4+_=jG6Ywh3Km2gPsw+Qf6qj-28GWrVg7RZQ@mail.gmail.com>
	<xmqqk33046ha.fsf@gitster.dls.corp.google.com>
	<CAMsgyKagoz7NU7cGuwvq61aiKc6Wq-z+w0_Fep7t9tYy90pB6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Derek Moore <derek.p.moore@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 21:51:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xoest-0007Ng-D5
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 21:51:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753362AbaKLUvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2014 15:51:19 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54272 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753248AbaKLUvT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2014 15:51:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D92AC1DF16;
	Wed, 12 Nov 2014 15:51:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iCCu945SDewLYoJOj6ArnenXTxA=; b=n3nNhw
	jw7JdiV9lRij/ZuGaO30SKquUKeqwMtcu5WLkxBDUYtzwQpz4XMkkqBVL5fND/Yj
	Y4z0DUO+dZ70i3yuu4jVBY/NciC9PffWgg0r96wqlEaaVb4m+w/YcqCYYGAFgUta
	x8zYJleiFiMUAuqlv8EPvqfIX8qTzbF7yEtao=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kdcoIIqPdnte5y3VrjBLppEMdEFnRUn0
	ZKXWyNasVNU+XpuGMLA3RVrHaphQkdLTm1EXuAD8migucWZMyeDMj1PBx3HJwNRo
	8zA173v77abBKvRUSXoTWRA6iTtI9KTH2bT9YvUHL5ta1x44AM8rt1gTFhapKW1w
	QYbH3Vv7f7c=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D0C9D1DF15;
	Wed, 12 Nov 2014 15:51:17 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4A5901DF12;
	Wed, 12 Nov 2014 15:51:17 -0500 (EST)
In-Reply-To: <CAMsgyKagoz7NU7cGuwvq61aiKc6Wq-z+w0_Fep7t9tYy90pB6w@mail.gmail.com>
	(Derek Moore's message of "Wed, 12 Nov 2014 14:30:12 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A5E61204-6AAD-11E4-9219-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derek Moore <derek.p.moore@gmail.com> writes:

>> But if you then switch to B from that state, F will not even be
>> modified (i.e. it will keep the contents you prepared for "branch
>> A's instance of F").
>
> Or: the post-commit hook used in the workaround looks up the prior
> branch via @{-1}, finds all files common between @ & @{-1} that don't
> share a latest commit, deletes those files and replaces them singly
> with the results of git-archive using the latest commits of those
> files relative to @. ("All files common between @ & @{-1}" would need
> to be either all non-locally-modified files or making use of git-stash
> {save,pop} to preserve local modifications.) All this assumes having
> reversible $Format$ strings, so the clean filter can restore the
> proper $Format$ string.
>
> Might be worth doing...

I still do not see what you are trying to record in the checked out
source files with your smudge filter, so I won't comment if it might
be "worth" doing.

Your use of reflog suggests me that whatever you are recording
depends on how you acquired your history in your specific repository
you work in, and your result is not reproducible by other people who
work with you by fetching from a repository that is different from
the repository you work in.  E.g. perhaps you have a repository at
GitHub and push into there, and others fetch from there into their
repository.  What is in their reflog has no relation to what you
have in your reflog.

That's the nature of distrubuted life.  More generally, in a
distributred world with merges, even between two people who agree
that the tip of the 'master' branch of the project is at a certain
commit, there is no single sensible answer to the question "which
commit changed this path last?"  We wouldn't mind anything you may
do to emulate RCS $Id$, but it would be futile.
