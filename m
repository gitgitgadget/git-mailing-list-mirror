From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 01/10] wildmatch: fix "**" special case
Date: Wed, 23 Jan 2013 20:49:36 -0800
Message-ID: <7vwqv3dw2n.fsf@alter.siamese.dyndns.org>
References: <1357008251-10014-1-git-send-email-pclouds@gmail.com>
 <1357008251-10014-2-git-send-email-pclouds@gmail.com>
 <7vr4lcnbn5.fsf@alter.siamese.dyndns.org>
 <7v1udcn84w.fsf@alter.siamese.dyndns.org>
 <CACsJy8DiVy7tcG_t2JENKoPSFWV24Tneh4q=upPPJML4VESMag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 05:50:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyElG-0002ol-GU
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 05:50:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753181Ab3AXEtl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 23:49:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60605 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752933Ab3AXEtj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 23:49:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CB90BB90;
	Wed, 23 Jan 2013 23:49:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=owhniTacZL1KA1bUTTpVeQUEeeQ=; b=Mus//l
	1jhHCo15UP1QQVMkq57jkBiQhSMIeFQz8jjlpwJ2mx64ydHrJtwBdLsJ9P39qEzU
	0p24qYhHGi2YXc/8cqfwAfo0oGi5wJFM9qDQwKbk3lsyjo9e/HnPwT2X03CArPfJ
	XxglUZlQJ/78u0eA2lI204YKbULhHb9Byb7SA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ar2u/x5g7Pqdb/OAFsNrhkilAcRWpIEA
	mjb3hs3fYWVTE4AozyhumDRyHPIQGmcn+RqLheWMfWtgegxnYI/OKPLItNZlI1hQ
	G4eO9kJnGgz9hn0Ia4umGjS4QfHB6nFi40tn6A8Ion9Sh3yqIav3qdq4Ze3BMcw0
	MUgc/NublD8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 017E0BB8F;
	Wed, 23 Jan 2013 23:49:39 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 577C5BB85; Wed, 23 Jan 2013
 23:49:38 -0500 (EST)
In-Reply-To: <CACsJy8DiVy7tcG_t2JENKoPSFWV24Tneh4q=upPPJML4VESMag@mail.gmail.com> (Duy
 Nguyen's message of "Wed, 23 Jan 2013 08:04:50 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 753F363A-65E1-11E2-8584-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214390>

Duy Nguyen <pclouds@gmail.com> writes:

> If we do that, we need to do the same in tree_entry_interesting(). In
> other words, pathspec learns the new glob syntax. It's fine for an
> experimental flag like USE_WILDMATCH. But after fnmatch is replaced by
> wildmatch unconditionally (thus USE_WILDMATCH becomes obsolete), then
> what? Should people who expects new syntax with USE_WILDMATCH continue
> to have new syntax? How does a user know which syntax may be used in
> his friend's "git" binary?

Good point.

> On a related subject, I've been meaning to write a mail about the
> other use of patterns in git (e.g. in git-branch, git-tag,
> git-apply...) but never got around to. Some use without FNM_PATHNAME,
> some do and the document does not go into details about the
> differences. We might want to unify the syntax there too. It'll
> probably break backward compatibility so we can do the same when we
> switch pathspec syntax.

Right now, I think for-each-ref is the only one with FNM_PATHNAME.
With the experimental USE_WILDMATCH, "for-each-ref refs/**/master"
will give us what is naturally expected.  With a working wildmatch,
I think it probably makes sense to globally enable FNM_PATHNAME;
it would probably be nice if we could do so at Git 2.0 version bump
boundary, but I suspect we are not ready yet (as you pointed out,
there are still codepaths that need to be adjusted).

> The only problem I see is, without the version string, there's no way
> to know if "**" is supported. Old git versions will happily take "**"
> and interpret as "*". When you advise someone to use "**" you might
> need to add "check if you have this version of git". This problem does
> not exist with pathspec magic like :(glob)

OK, so what do we want to do when we do the real "USE_WILDMATCH"
that is not the current experimental curiosity?  Use ":(wild)" or
something?
