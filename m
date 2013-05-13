From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 04/10] remote: Reject remote names containing '/'
Date: Sun, 12 May 2013 21:54:22 -0700
Message-ID: <7vtxm7scn5.fsf@alter.siamese.dyndns.org>
References: <1368289280-30337-1-git-send-email-johan@herland.net>
	<1368289280-30337-5-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon May 13 06:54:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbkmM-0003O1-9e
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 06:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223Ab3EMEy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 00:54:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33991 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750763Ab3EMEyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 00:54:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE01E19779;
	Mon, 13 May 2013 04:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=NlEkp3WNF2Y3YRa/NCbn6CWpy+Q=; b=WAySwmq3eE7efZgVeSH/
	VYddFPgZcoRadw+ATB9RbFxIXFHJPAe3Y0rpKA/dQpSLCGvXTE/kh5Vq1XSxDjS9
	sIxjbkENgFvIloWVDOxBXg9cWDZX5eBuOwW6BXkP1ti791xkxmmjYqVCAaTjTutP
	NsIoowTQJc89TWO/ZanBBpA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=BrK1R1uRv3m5OC5sUZuu2UWmwPWIDkvF2I/i0dthmV1riF
	Ob6g6m4q7jy7le3GJmRtN9keBMNQPc6On6AbUJzGLD2YAJoSt4YYK2IMN6utmf/D
	HejKO5hW6GVIKo14MDIYYAGOb/CWXiMV9mCq7ag6rtjaNDKkAfn6F21kn/62s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E268E19778;
	Mon, 13 May 2013 04:54:24 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4B2DB19775;
	Mon, 13 May 2013 04:54:24 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2EB68AD0-BB89-11E2-887B-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224082>

Johan Herland <johan@herland.net> writes:

> Although we definitely support and encourage use of multi-level branch
> names, we have never conciously tried to give support for multi-level
> remote names. Currently, they are allowed, but there is no evidence that
> they are commonly used.
>
> Now, they do provide a source of problems when trying to expand the
> "$nick/$name" shorthand notation (where $nick matches a remote name)
> into a full refname. Consider the shorthand "foo/bar/baz": Does this
> parse as $nick = foo, $name = bar/baz, or $nick = foo/bar, $name = baz?
>
> Since we need to be unambiguous about these things, we hereby declare
> that a remote name shall never contain a '/' character, and that the
> only correct way to parse "foo/bar/baz" is $nick = foo, $name = bar/baz.

I know I am guilty of hinting to go in this direction in the earlier
discussion, but I have to wonder how much more refactoring is needed
to see if there is only one unique possibility among many.

For a string with N slashes, you have only N possible ways to split
it into $nick and $name, and if you see a ref "bar/baz" copied from
remote "foo" but no ref "baz" copied from remote "foo/bar" (or you
may not even have a remote "foo/bar" in the first place), the user
is already very unambiguous. The declaration is merely being lazy.

I am not saying we must implement such a back-track to disambiguate
the user input better.  I am wondering how much more effort on top
of this series is needed if we want to get there (provided that the
disambiguation is a good thing to do in the first place).
