From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] tag: make list exclude !<pattern>
Date: Fri, 10 Feb 2012 23:50:06 -0800
Message-ID: <7vy5s9n70x.fsf@alter.siamese.dyndns.org>
References: <20120210185516.GA4903@tgrennan-laptop>
 <1328926618-17167-1-git-send-email-tmgrennan@gmail.com>
 <7vaa4qnk4u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pclouds@gmail.com, git@vger.kernel.org, krh@redhat.com,
	jasampler@gmail.com
To: Tom Grennan <tmgrennan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 11 08:50:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rw7ir-0002fI-5j
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 08:50:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753517Ab2BKHuL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Feb 2012 02:50:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57424 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753142Ab2BKHuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 02:50:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ACD053F4F;
	Sat, 11 Feb 2012 02:50:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kV79MNT1lkWiusm0QYL7zm0U/Pk=; b=SspKh3
	2fZpam84Fg8I6VMDwgRXubJwCQkfickXAGHjvhzDO3POb55ZGfKZxnCfra75xEei
	n0pTSUwC4tEf1aqJBMHWjie+dSJ1SUTRWzPNifXfjGFI/MLMB5Cfqz//JlD40olE
	GF8FgXUAsM8LdKTR1FCg5Zoigrh7J18P6rUgI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TG+DEcBqb4jADBznwroW2evjpLr7YYT5
	rDlYGRYu6It+F4QXQUoZKvCdcUdIqdYE+Dyn6fx44nIThp4KAlRF/2IbOY/9yi5i
	19qc0UKvsDuow9VcL+AZqfj7FZIr+vd5jAja7F4FUzUGIlodOM72r5vNLR4B9g9O
	SFjvlO7RHRI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A0FD23F4E;
	Sat, 11 Feb 2012 02:50:08 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F14133F4C; Sat, 11 Feb 2012
 02:50:07 -0500 (EST)
In-Reply-To: <7vaa4qnk4u.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 10 Feb 2012 19:06:57 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 04757E96-5485-11E1-855D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190497>

Junio C Hamano <gitster@pobox.com> writes:

>    ... Same
>    for 1c, which I highly suspect will introduce regression without
>    looking at the code (for-each-ref is prefix-match only), ...

This part needs correction.  for-each-ref matches the command line
arguments differently from branch --list and tag --list in two important
ways.

 (1) It allows (not "only" which was a mistake in my earlier message)
     prefix matching, e.g. "for-each-ref refs/heads/", in addition to
     fnmatch(); and

 (2) The fnmatch() call is made with FNM_PATHMAME, which "branch --list"
     and "tag --list" does not use.

Strictly speaking, therefore, if you make all three commands to use the
same matching logic, there is no way to avoid regression.  If you choose
to use fnmatch() without FNM_PATHNAME, then for-each-ref suddenly starts
matching wildcards across name hierarchy boundary '/' for a pattern that
does not match today, e.g. "git for-each-ref 'refs/heads/*'" was a good
way to grab only the integration branches while excluding individual topic
branches such as refs/heads/tg/tag-points-at, but this technique can no
longer be used for such a purpose, which is an unpleasant regression.

I personally think that it was an annoying UI mistake that we let branch
and tag call fnmatch without FNM_PATHNAME, but we cannot fix it lightly,
either.  People who use hierchical branch names (e.g. maint-1.0/$topic,
maint-2.0/$topic, and feature-2.0/$topic) may already be used to list all
the topics on the maintenance tracks with "branch --list 'maint*'", and we
need to keep "branch --list" and "tag --list" working as they expect.

One possible way forward (now I am talking about a longer term solution)
would be to introduce

	refname_match_pattern(const char *refname,
        		      const char **pattern,
                              unsigned flags);

where flags can tell the implementation if FNM_PATHNAME should be used,
and if prefix matching should be attempted, so that the three commands
share the single same matching function while still retaining their
current behaviour in the initial round.  Inside the implementation, we
would use good old fnmatch(), with or without FNM_PATHNAME, depending on
the flags the caller passes.

In a future versions, we may want to have "branch/tag --list" also ask for
FNM_PATHNAME (this *is* a backward incompatible change, so it needs to be
performed across major version boundary, with backward compatibility
configurations, deprecation warnings and whole nine yards). Under the new
match function, today's "branch --list 'maint*'" needs to be spelled as
"branch --list 'maint*/*'" or something.  The prefix matching is probably
safer to enable by default without causing big regression hassle if we
limit the prefix match to only patterns that end with an explicit slash,
as users already *know* today's "branch --list tg/" would not match
anything (because the pattern does not even match a brahch 'tg', so it is
unlikely they are using it and expecting only 'tg' to match), which means
that is an unlikely input we can safely give new meaning to match anything
under tg/ hierarchy.
