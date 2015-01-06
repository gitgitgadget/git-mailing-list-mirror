From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git 2.2.x: Unexpected, overstrict file permissions after "git update-server-info"
Date: Tue, 06 Jan 2015 02:08:16 -0800
Message-ID: <xmqqd26sql0v.fsf@gitster.dls.corp.google.com>
References: <20150105210724.032e9718@x230> <20150106034702.GA11503@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Sokolovsky <paul.sokolovsky@linaro.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 06 11:12:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8R3t-0007HB-G8
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 11:08:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754533AbbAFKIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 05:08:25 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64504 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751698AbbAFKIY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 05:08:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3EC9624AFD;
	Tue,  6 Jan 2015 05:08:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6LdWNEN6mmLEv9GA3fSSOQHaovc=; b=lgYlDk
	cWa/239QfF2k2ZUWGhIhjRS/fZR8LKhw24llRFzbFQmXGEdhI6zEDxYBHQcbeOvc
	yIU3OQNKCYjCxJ8c13Yrd+wy0OqZl8SxgwAYB/1AmAHmLrxgvSsaQrf3P/ihMbFv
	NEGpchkOrDSiOtjaU8PBGfKXTO4xU59ZkDBNE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xxAg+eAZnJ6ixkJlRuhrzRsb84uoO7xJ
	v/EYwi5ydwYw1qqFsnLK71qnKkkErEtlwh7CECDMwO463vkr75jeQo1PQ8f/HjSK
	JckyJydwQ1y8GbZDWxGvXbJo05OTJWYfq58ylccqsleXKZ/TPraouDXiQPLanOm9
	Hsqfy3Nwmhw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3636B24AFB;
	Tue,  6 Jan 2015 05:08:18 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B059524AF9;
	Tue,  6 Jan 2015 05:08:17 -0500 (EST)
In-Reply-To: <20150106034702.GA11503@peff.net> (Jeff King's message of "Mon, 5
	Jan 2015 22:47:02 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EF64DC2C-958B-11E4-AFD4-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262049>

Jeff King <peff@peff.net> writes:

> Yeah, I didn't consider the mode impact of using mkstemp. That is
> definitely a regression that should be fixed. Though of course if you
> really do want 0644, you should set your umask to 0022. :)
> ...
> If you haven't set core.sharedrepository, then adjust_shared_perm is a
> noop. But you shouldn't have to do that. Git should just respect your
> umask in this case.

Thanks for a nicely done patch series, but I am not sure if I agree
with the analysis and its conclusion.

If adjust_shared_perm is a no-op, how do we ensure that other files
that need to be served by a dumb HTTP server are readable by it?  Is
it because we just happen not to use mkstemp() to create them (and
also is it because the pushers do not have umask 007 or stronger to
prevent files from being read by the HTTP server user)?

Is our goal here to give the users this statement?

    For shared repository served by dumb HTTP and written by users
    who are different from the user that runs the HTTP server, you
    need to do nothing special.

If that is the case, shouldn't the rule be something a lot looser
than "we should just respect your umask"?  To satisify the above
goal, shouldn't we somehow make it readable by the HTTP user even
when some pusher has a draconian 0077 umask?  But that, while still
complying to the promise of "nothing special", would imply we would
have to make everything readable everywhere, whish is an unachievable
goal.  We need to somehow be able to say "this repository should be
readable by these people" per-repository basis.

And we have a mechanism exactly designed to do so to defeat
draconian umask individual users have.

It feels to me that the old set-up were "working" by accident, not
by design (I may be mistaken--so correct me if that were the case).
And if that is the case, I do not think it is a good idea to try to
hide the broken configuration under the rug longer.  "As long as
everybody writes world-readable files, you do not have to do
anything" will break when the next person with 0xx7 umask setting
pushes, no?
