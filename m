From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Best Practices with code/build fixes post-merge?
Date: Mon, 16 May 2016 12:42:24 -0700
Message-ID: <xmqqr3d123j3.fsf@gitster.mtv.corp.google.com>
References: <CAHd499D7kgMtUXgBgsUzNLEMuuHRE7j_T1mikL21KJjDE8ey3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 16 21:42:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2OPQ-0002ll-Ur
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 21:42:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754442AbcEPTm3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 15:42:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57059 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753874AbcEPTm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 15:42:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3877F1CA71;
	Mon, 16 May 2016 15:42:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UApfFTj9GGHSX++LBeDcl5s7u98=; b=MqeafV
	3vYfzK8ml1KL5KT2XnBhZeHaFUvqr1r1aNpOAZF8rhqxgMK66UzMwcO6T1pHOllg
	NX0CgIk6frNREgWg/HYZa8vtl9TESPI0FKD3tnBjDgbFvnC9HflILQLNd/Tl73gH
	KocSrIbMv6+Dh3h0KzduovQtEoJNV227T9o8E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RSYDRyUBKzAC1ieACU/tZDQQZ9UgPKaT
	hhMOj/gkdZ1mxQGKn1qKQuG9pBLO11rPW97g7dnxYPhZIYw6GDcda9rWIAtKv6Z/
	4qBMax/jWN0Z8AJrj/seL3fGigS4jSV3/PnN7WmAUK+PWOamwPP+9Y1s6vr+qIIM
	CNj0m1o0LrM=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 308B31CA70;
	Mon, 16 May 2016 15:42:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9216B1CA6E;
	Mon, 16 May 2016 15:42:26 -0400 (EDT)
In-Reply-To: <CAHd499D7kgMtUXgBgsUzNLEMuuHRE7j_T1mikL21KJjDE8ey3A@mail.gmail.com>
	(Robert Dailey's message of "Mon, 16 May 2016 14:19:52 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 516AD5FE-1B9E-11E6-A93E-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294784>

Robert Dailey <rcdailey.lists@gmail.com> writes:

> Sometimes, I merge 2 branches that have deviated quite a bit. A
> worst-case example would be some API change. The topic branch
> (long-lived) may start using the old API. However, once I merge the
> topic back to master, that API no longer exists. As such, every place
> that introduces a usage of the old API will fail to build (but won't
> necessarily cause a conflict during a merge).
> ...
> Is there a best practice here? What do each of you do as a personal
> preference or policy? Thanks in advance.

I think the best practice is to make sure your "some API change" is
done in a way competent people do.  Namely, have a thin wrapper to
emulate the old API so that such a long-lived topic that adds new
caller of old API would still be syntactically and semantically
correct after getting textually merged.

Your developers however are not perfect (nobody is), so the next
best is to arrange that a build fails (which seems to be what you
have), so that you can notice at the merge time.

If the adjustment of an application that uses the old API to use the
new one is simple enough, amending the merge would be my preference,
as a merge commit should be "a single atomic change" as any other
commit.  But at the same time, you do not have to be too worried
about such a "mismerge".  A merge commit is a change that can
introduce a bug as any other commit.  After all, we are dealing with
human endeavours.  So "I did this merge as a single atomic change,
merging the work done in the topic while adjusting the way the topic
did certain things using old API to use new API, to the best of my
ability, but I may have introduced a bug" is perfectly fine.  You do
a commit to ensure it is correct to the best of your ability, and
because everybody knows you are not perfect (nobody is), nobody
expects your commit is always correct.  If you find a bug later, you
just fix up with a follow-up commit.  A merge commit is no special.

My personal preference, if adjustment from old API to new API is
more involved, is to have a new topic branch that is forked from the
trunk and merge the topic with new call sites of old API into it.
I'd fix as much breakage in that merge commit, and then fix things
up as necessary in follow up commits on that new topic branch as
necessary.  After that, merging the result to the trunk.
