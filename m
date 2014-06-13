From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/1] receive-pack: optionally deny case clone refs
Date: Fri, 13 Jun 2014 14:25:53 -0700
Message-ID: <xmqqfvj81oym.fsf@gitster.dls.corp.google.com>
References: <1402525838-31975-1-git-send-email-dturner@twitter.com>
	<xmqqa99h6hbh.fsf@gitster.dls.corp.google.com>
	<CAL=YDW=xn0OG5vu=9fnP0nycKV0F9bDJLrkYiwmL9P9q79LJSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Turner <dturner@twopensource.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 23:26:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvYzC-0001f0-Lq
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 23:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754095AbaFMV0C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 17:26:02 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63269 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754091AbaFMV0A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 17:26:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D052E20C45;
	Fri, 13 Jun 2014 17:25:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5nPK9vESL0tXWefcW5iibposm74=; b=R9QQq6
	sHmoaumNsLu7baFT4UFVRIzvS9q6YrA3t+rvotkycHOWY8OTCrq5V8HCBYWYcRUX
	FsVRZxxOpzfr4D2x/XvsqzN7fK4WxT0XpQOPAQ5ie0JlAY6s0g/GV7KsBzQGW+5n
	tqanYJtlT67wkAGQjhDgwz9LydX3yWO7mO3UA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iVWP1w7hZgrfkKFDz+SgmjzWNQIO/se0
	oZifpAlSK7vmrY+VFrifNRr/qp1/dozB5ebwAedvRmZ0aBn4BS5ma2Vy82Vs2MF9
	Hx9gbtea1WeXwrUewU1nVOnjwlSUwn1/+mCsEKtjwWJCTzCGzaiL8Awyd8I+bC7o
	+Tg4U7QZQuA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C330E20C44;
	Fri, 13 Jun 2014 17:25:59 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8F27F20C3E;
	Fri, 13 Jun 2014 17:25:55 -0400 (EDT)
In-Reply-To: <CAL=YDW=xn0OG5vu=9fnP0nycKV0F9bDJLrkYiwmL9P9q79LJSw@mail.gmail.com>
	(Ronnie Sahlberg's message of "Fri, 13 Jun 2014 11:20:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4DDCB33A-F341-11E3-8D0F-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251639>

Ronnie Sahlberg <sahlberg@google.com> writes:

> It gets even more hairy :
> If the server has A/a and a/b and you clone it it becomes A/a and A/b
> locally. Then you push back to the server and you end up with three
> refs on the server:  A/a A/b and a/b.

That is part of the transition in deployment.  David who wants to
forbid A/a and a/b mixed in his project will surely correct the
situation at the server end so "somebody fetches A/a and a/b and
ends up with A/a and A/b" will not happen.  They will fetch A/a and
A/b.

If a user is with an older Git and he has his own a/c, fetching A/a
and A/b from a corrected central repository will still give the user
a/a and a/b, but then pushing it back will be forbidden.  The user's
repository needs to be fixed and installation of Git needs to be
updated to the version with an equivalent of David's "optionally
deny" feature implemented for the fetching side, so that the user
notices the local a/c is bad and not allowed within the context of
his project, deletes it and recreates it as A/c before he can fetch
A/a and A/b from the central repository.

I agree that the transition may be painful, but as long as the
desired semantics is "If you have A/a, you are not allowed to have
a/a or a/b", it cannot be avoided---in that sense, I view it as a
lower priority issue.

Having said that, it may indicate that the desired semantics above
may not be the optimal one.  Perhaps the flag might want to be "on
this platform, we cannot do case sensitive refs, so pretend as if
all refs are lowercase" instead.  I suspect that such a flag may
allow smoother transition than what has been proposed.

Underlying refs "A/a" and "a/b" can stay as they are in David's
central repository, but ref enumeration with the flag enabled will
return a/a and a/b, and these are the names that will be fetched by
the users.  If the user had an existing A/c, then fetching these
will still create A/a and A/b locally, but pushing them back will,
under that flag enabled, be turned into updates to a/a, a/b, and a/c
on the central server side with updated Git.

I dunno.
