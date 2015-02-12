From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/8] reflog_expire(): ignore --updateref for symbolic references
Date: Thu, 12 Feb 2015 12:16:01 -0800
Message-ID: <xmqqtwyqrim6.fsf@gitster.dls.corp.google.com>
References: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>
	<1423473164-6011-7-git-send-email-mhagger@alum.mit.edu>
	<CAGZ79kZvM4FeHQ074kh7qhsz8cHgGaHxOruP7CM2DgPJErkA-w@mail.gmail.com>
	<54DCD015.2080002@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Feb 12 21:16:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YM0BG-0002lK-V4
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 21:16:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbbBLUQG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 15:16:06 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56034 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750810AbbBLUQF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 15:16:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EC1BA37EF4;
	Thu, 12 Feb 2015 15:16:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jIQTODaZLwAt4bJ1hqhCFRLuURs=; b=jaZHFg
	tAYSp4jRfsD5hwmUz93TmeYB+nH1zU9usk3tMqRQdXfY5+kTCPSTEtrf/VElewyG
	Wtx+qEe+UR75AJRBmf5GtJHMpqYsTay1ZeCcQdHwOlEuD5qSxh/aWahCw8eZj04D
	EXVN0mNibauNeZm6tEFAy9Sb67JDD0RXOHdxE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=glv6tu9YaFSO5sOmVKuwfCmqzE5aSp5H
	HlGbU8YZ2zdDILN/dLenIcxokfXKfrkvEcYpB7TqassiK3J8lGSiS+UXUk021rpp
	G3RDGs9OAgMqkxXTcjkEZbC0LXeiQLRFZJPHc7AyACqih8v/U0UTuP+3wR7qviWk
	6/Q+6iVXiB0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DC49937EF3;
	Thu, 12 Feb 2015 15:16:03 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3A5DC37EF0;
	Thu, 12 Feb 2015 15:16:03 -0500 (EST)
In-Reply-To: <54DCD015.2080002@alum.mit.edu> (Michael Haggerty's message of
	"Thu, 12 Feb 2015 17:08:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F7D61454-B2F3-11E4-AC86-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263760>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> This is a pretty exotic usage. I can't think of any real-life use case
> for using "--updateref" together with a symbolic reference. In our
> entire code base, "--updateref" is only used a single time, in
> "git-stash.sh", and that is always for "refs/stash", which is never a
> symbolic reference.

I have been wondering what the valid situation where --updateref is
a right thing to do on _any_ ref, be it a real one or a symbolic,
unless you are trying to manually fix a corrupted repository that
lack random objects left and right.  We may expire old reflog
entries and make stale objects disappear, but even when we purge all
reflog entries by expiring anything that is older than a nanosecond
ago, I do not think of a situation where we see some reflog entry
surface as the "latest" entry that points at an object that is _not_
at the tip of the actual ref.

Except for the stash, of course, as you pointed out.  We could drop
the tip (i.e. the latest) while keeping the other ones.

> "git-stash" itself is implemented in a very stylized
> way ("stylized" being a polite way of saying "bizarre"), and I doubt
> that there are many more users of this option in the wild, let alone
> "--updateref" together with a symbolic reference.
>
> So, honestly, I don't think it is worth the effort of deciding between 3
> vs. 4.

I agree with that assessment.  We might even want to start thinking
about a good strategy to remove the --updateref option command,
which in turn would need to restructure how a stash is represented.
