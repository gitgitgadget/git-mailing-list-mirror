From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] remote: introduce and fill branch->pushremote
Date: Mon, 13 Jan 2014 12:15:08 -0800
Message-ID: <xmqqtxd763lf.fsf@gitster.dls.corp.google.com>
References: <1389546666-17438-1-git-send-email-artagnon@gmail.com>
	<1389546666-17438-4-git-send-email-artagnon@gmail.com>
	<20140113083421.GA18531@sigill.intra.peff.net>
	<CALkWK0ncSLza3Q0PSZ0oTZqB2YxjgGSqA7QYxk2+rN_77BKZMA@mail.gmail.com>
	<20140113185946.GA30279@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 13 21:15:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2nuv-0004KF-Pa
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jan 2014 21:15:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182AbaAMUPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jan 2014 15:15:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59514 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752078AbaAMUPU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jan 2014 15:15:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 49B946334B;
	Mon, 13 Jan 2014 15:15:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ynqh15M2+C3C0uHp5ll/S8C4O+w=; b=fAuR0r
	SYCEc3Elx712KjWWjLXkkQIPoHNRWOiXkMOCgyE2UcYYdc/yJBXv4K+8WI5Q7RXW
	kcr8phJGmhs8O/vU5wCU6yoPq9KEYU0HSt0sP+VkBii1I5dMeasAifBAorScgJ3k
	o4lSKlR8jhbR5fm4ke3IWFOiiv9zMeKkIGUrA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yjOdIkfx334z5FkVsnxqYW/+NIjSlw9u
	f+r34biWv/7D1R2ct52fPDms0T7Y+nOthhNYHDHS8J1fMboCaSt5+/yMUZyZA4s9
	hPt81XmI9DMy9rANVc2jtUuBjKaXWgA2kU2kfP4yQnh1gNlsswjP/oyq1THHpAdb
	WGNJf0NACo0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B958C63348;
	Mon, 13 Jan 2014 15:15:18 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B5C6C63343;
	Mon, 13 Jan 2014 15:15:13 -0500 (EST)
In-Reply-To: <20140113185946.GA30279@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 13 Jan 2014 13:59:47 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6926A17E-7C8F-11E3-B803-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240371>

Jeff King <peff@peff.net> writes:

> It does not matter for actually pushing, because to do a non-default
> push, you must always specify a remote. But "@{publish}" will ask the
> question "even if I am on 'side' now, what would happen if I were to
> default-push on 'master'?".

In a similar wording to yours, it can be said that B@{upstream} is
"what would happen if I were to default-pull on 'B'?".

A related tangent is what should B@{publish} should yield when there
is no triangular configuration variables like remote.pushdefault,
branch.B.pushremote and a possible future extension branch.B.push
are defined.  The definition you gave, i.e. "if I were to
default-push", gives a good guideline, I think.

I.e. "git push origin master" does tell us to push out 'master', but
it does not explicitly say what ref to update.  It may be set to
update their remotes/satellite/master when we are emulating a fetch
in reverse by pushing, via e.g.

	[remote "origin"]
        	push = refs/heads/master:refs/remotes/satellite/master

and it would be intuitive if we make "master@{publish}" resolve to
"refs/remotes/satellite/master" in such a case.

One thing that makes things a bit fuzzy is what should happen if
you have more than one push destinations.  For example:

	[remote "home"]
        	pushurl = ...
                push = refs/heads/master:refs/remotes/satellite/master

	[remote "github"]
        	pushurl = ...
                mirror

	[remote]
        	pushdefault = ???

"git push home" updates their 'refs/remotes/satellite/master' with
my 'master' with the above, while "git push github" will update
their 'refs/heads/master' with 'master'.

We can say master@{publish} is 'remotes/satellite/master' if
remote.pushdefault (or 'branch.master.pushremote") is set to 'home',
it is 'master' if it is 'github', and if "git push" while sitting on
'master' does not push it anywhere then master@{publish} is an
error.  There may be a better definition of what "if I were to
default-push" really means, but I don't think of any offhand.
