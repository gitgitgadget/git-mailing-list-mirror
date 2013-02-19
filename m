From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] check-ignore.c, dir.c: fix segfault with '.'
 argument from repo root
Date: Tue, 19 Feb 2013 11:59:38 -0800
Message-ID: <7vzjz03wid.fsf@alter.siamese.dyndns.org>
References: <CAOkDyE9VVuFn6B=Fe4XHxGCEW0MFgndx1X0+9hO36Soxb37YQw@mail.gmail.com>
 <1361301696-11307-1-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>,
	Zoltan Klinger <zoltan.klinger@gmail.com>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Tue Feb 19 21:00:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7tME-0007uL-3j
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 21:00:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933880Ab3BST7m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 14:59:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54813 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932606Ab3BST7l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 14:59:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D92FACCD;
	Tue, 19 Feb 2013 14:59:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jMWp/N2Rloyf4yu7XPPmw+n4aig=; b=Z+oh/q
	l6qmBwDThfasPLXP7ArIvRa2k9KEf1/Ee4x5HMU0a4+3fIdao6Ssyo6oO2oDVdXD
	V+OMEixtDO2wTNdvAXVIg3CpgS87UrKiiR2jKSr+N5bgT6vkPjrGWFdsX3DQrdy3
	qIEO0cHOKLEoFY0ziPmF2QSz9nTtudnrp1qYs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=adB0iDEUSZ7R4Mj9ozB6npVzAEL9qpd3
	uE0/DviTMwzrbqu/KjjhK0HtEt3UlKKYvKWbEO1OIOopzBgl+8d1jTdU4XrTOH3T
	allYjmeTVnlEWQ9tCJNza8ZTAfX/E5lZE3yafrJpOK8mSHvEMw9NNfDMzQeqgCUM
	1gd8RsTyGpY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0FB37ACCC;
	Tue, 19 Feb 2013 14:59:41 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5F9FCACC5; Tue, 19 Feb 2013
 14:59:40 -0500 (EST)
In-Reply-To: <1361301696-11307-1-git-send-email-git@adamspiers.org> (Adam
 Spiers's message of "Tue, 19 Feb 2013 19:21:36 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E557F4F0-7ACE-11E2-AF3E-21622E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216655>

Adam Spiers <git@adamspiers.org> writes:

> Fix a corner case where check-ignore would segfault when run with the
> '.' argument from the top level of a repository, due to prefix_path()
> converting '.' into the empty string.

The description does not match what I understand is happening from
the original report, though.  The above is more like this, no?

    When check-ignore is run with the '.' argument from the top level of
    a repository, it fed an empty string to hash_name() in name-hash.c
    and caused a segfault, as the function kept reading forever past the
    end of the string.

A point to note is that it is not cleaer why it is a corner case to
ask about a pathspec ".".  It is a valid question "Is the whole tree
ignored by default?", isn't it?

> It doesn't make much sense to
> call check-ignore from the top level with '.' as a parameter, since
> the top-level directory would never typically be ignored,

And this sounds like a really bad excuse.  If it were "it does not
make *any* sense ... because the top level is *never* ignored", then
the patch is a perfectly fine optimization that happens to work
around the problem, but the use of "much" and "typically" is a sure
sign that the design of the fix is iffy.  It also shows that the
patch is not a fix, but is sweeping the problem under the rug, if
there were a valid use case to set the top level to be ignored.

I wonder what would happen if we removed that "&& path[0]" check
from the caller, not add the "assume the top is never ignored"
workaround, and do something like this to the location that causes
segv, so that it can give an answer when asked to hash an empty
string?

Does the callchain that goes down to this function have other places
that assume they will never see an empty string, like this function
does, which I _think_ is the real issue?

 name-hash.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/name-hash.c b/name-hash.c
index d8d25c2..942c459 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -24,11 +24,11 @@ static unsigned int hash_name(const char *name, int namelen)
 {
 	unsigned int hash = 0x123;
 
-	do {
+	while (namelen--) {
 		unsigned char c = *name++;
 		c = icase_hash(c);
 		hash = hash*101 + c;
-	} while (--namelen);
+	}
 	return hash;
 }
 
