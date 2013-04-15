From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] clone: introduce clone.submoduleGitDir to relocate
 $GITDIR
Date: Mon, 15 Apr 2013 03:14:11 -0700
Message-ID: <7v61zo14p8.fsf@alter.siamese.dyndns.org>
References: <1365881007-25731-1-git-send-email-artagnon@gmail.com>
 <7vy5ck4m6b.fsf@alter.siamese.dyndns.org>
 <7v61zo4igg.fsf@alter.siamese.dyndns.org>
 <CALkWK0m-X7K=WXFiiMkqZBBTBB9KC6myeN+s_xYLXfadGJCdZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 12:14:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URgQf-0001ym-F9
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 12:14:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299Ab3DOKOZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 06:14:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37938 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751124Ab3DOKOY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 06:14:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 54DA91309C;
	Mon, 15 Apr 2013 10:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Kk1pOwkEeIEFrh2p95oIHkoJ/es=; b=i2aFfF
	hS+DR77nLe6nly9P0RmBA+geuyZGYRSQXBlF+XEJov5egN+QdqsHpP9mKNr5JhhN
	qLKr+0+ZtRbVzrEwrJkRTiZ97GeA3KE4bCAR8djdaHPDXQ4RoZ1hNq34zZXf/I3D
	sEpltkrnbvFxkdayBYSmuW1srXjqhLzRwCEfk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Mew5izBH5iF+iSGVQEKLdvwRs5JpVLIE
	iBgyoE8xZVCKR8Iy36bdOgFKklRMNtovKZ0sk1aPNebIqUisGBqqUOBBycU63dkp
	55NqSkz5yrNtLi25TwU4F//cYOhRDUkTX7M3rBNQjOMu4F0sLVU6IqxGIIr3Ifl3
	GIKlER/F/Vg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 48E5113099;
	Mon, 15 Apr 2013 10:14:18 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C173213096; Mon, 15 Apr
 2013 10:14:17 +0000 (UTC)
In-Reply-To: <CALkWK0m-X7K=WXFiiMkqZBBTBB9KC6myeN+s_xYLXfadGJCdZQ@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Mon, 15 Apr 2013 13:38:32 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3B5B07C8-A5B5-11E2-9567-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221220>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> I specifically did not go down this route, because I think it is
> gross.  Where does moving a GITDIR fit into what git add's normal job
> (index manipulation) is?  Tools should do one specific thing, and do
> it well: not a mixed bag of unrelated things.

I see you are trying to repeat the UNIX mantra, but I do not think
it is working.

When we discuss "git add", the "one unit of work" is at much higher
level than that of "git update-index".  "git add dir/" has to do a
lot more than "git add file", and "git add symlink" has to do quite
a different thing from "git add file", but to the end user, all of
them are about doing everything necessary to add what the user named
to the index. "git add submodule/" that does whatever necessary to
add the submodule to the index is still doing one thing well inside
the same framework, and that may include moving the $GIT_DIR and
turning it into a gitfile.

Not that I am saying I prefer "add --url=xxx". Quite the opposite.
I very much prefer the "clone and then add, but clone drops the
repository at the right place from the beginning" approach than "add
that knows about URL only for submodules", which is an ugly kludge.

If the user creates here/.git without gitlink with whatever means,
it is "git add here"'s job, if it wants to make it a submodule and
if it wants to make it possible to later check out another branch
that does not have the submodule, to stash away the repository and
turn it into gitfile, if it is part of what is needed to add a
submodule.

Of course, we could start from teaching "submodule add" to do so,
and then internally redirect "git add subm" to "git submodule add",
but that is a minor implementation detail that does not affect the
end user experience.
