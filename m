From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Hiding some refs in ls-remote
Date: Sat, 19 Jan 2013 11:16:00 -0800
Message-ID: <7v38xxnfv3.fsf@alter.siamese.dyndns.org>
References: <1358555826-11883-1-git-send-email-gitster@pobox.com>
 <CACsJy8C4qx0P621imj5B+HdoJkow0_jaGLVDRvdCDw3YRnK98g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org, mfick@codeaurora.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 19 20:16:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Twdu0-0004MZ-Sb
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jan 2013 20:16:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752238Ab3ASTQH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2013 14:16:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35223 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751554Ab3ASTQF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2013 14:16:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CC28B4E0;
	Sat, 19 Jan 2013 14:16:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=lhD3OnhcfYAh/oXAlo1KcwMLgdc=; b=l9hElHjfRXyzDzlyidRk
	P/N9tSqklE/bImxVB7jy76DvqBY5V5WiNfMgnPyMaLkp3iEr3/QRCQaL49RNeE14
	ekvJqicjNX6hnD/OVLnR47aILJoPt92SeIQlz1EdLOrxMGZ6HTGy+lXL+g7SUFyv
	+HTSJ9hRFZ2hGXaBTv1vDgo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=ekZLtEplEHHTDWf8C84u9jd35UlaFl7n0pcpqhV0PZ0z+W
	7oIVztHo0O468GedD0LmuMueH3C1n+QfWMsHmttUFZtcBtjkjWb6oCzErfPm2pBC
	80uIJhRAlxrV9/c4IbQuiKFYfOe3WZYo7LAs5XVbEIDMZDbRfEYt/qZQIIpE0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00383B4DF;
	Sat, 19 Jan 2013 14:16:04 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8DE5BB4D4; Sat, 19 Jan 2013
 14:16:02 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AA435762-626C-11E2-9C9A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213984>

Duy Nguyen <pclouds@gmail.com> writes:

> Should the client side learn how to list hidden refs too? I'm thinking
> of an extreme case where upload-pack advertises nothing (or maybe just
> refs/heads/master) and it's up to the client to ask for the ref
> selection it's interested in. upload-pack may need more updates to do
> that, I think.

What you are talking about is a different goal.

Look at this as a mechanism for the repository owner to control the
clutter in what is shown to the intended audience of what s/he
publishes in the repository.  Network bandwidth reduction of
advertisement is a side effect of clutter reduction, and not
necessarily the primary goal.

It lets me as the repository owner to say "do not list them to make
these discoverable"; letting the client side learn defeats the whole
point of this mechanism.

For example, if you mirror-clone from either of my repositories from
GitHub:

    git clone --mirror git://github.com/git/git/
    git clone --mirror git://github.com/gitster/git/

you will see stuff that does not belong to the project; objects that
are only reachable from refs/pull/* are not something I approved to
be placed in my repository; I as the project owner do not want to
give these objects to a cloner as if they are part of my project.

The server side can hide refs/pull/ and refs/pull-request-tags/ so
that clones (and ls-remote) will not see clutter, and nobody gets
hurt.

These refs are there only to support GitHub "pull requests"; the
advertisement of them to ls-remote and appearance of them in mirror
clones are undesirable side effects of how GitHub happened to
implement the feature.  GitHub has its way to notify of these pull
requests, and it makes these pull requests discoverable out of band
without involving Git.

Ability to say "git fetch origin $SHA1" (or "git fetch origin
pull/1") is the only thing lacking, in order to get rid of these
clutter.  The patches do the "get rid of clutter" part by letting
you hide these refs from ls-remote and clone; allowing "fetch by tip
SHA1" needs to come latter.

Another example.  If you run ls-remote against the above two
repositories, you will notice that the latter has tons more
branches.  The former are to publish only the primary integration
branches, while the latter are to show individual topics.

I wish I didn't have to do this if I could.

We have periodical "What's cooking" postings that let interested
parties learn topics out-of-band.  If I can hide refs/heads/??/*
from normal users' clones while actually keeping individual topics
there at the same place, I do not have to push into two places.
