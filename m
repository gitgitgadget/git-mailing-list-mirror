From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 5/6] refs.c: remove unlock_ref and commit_ref from write_ref_sha1
Date: Fri, 23 Jan 2015 15:57:43 -0800
Message-ID: <xmqq61bxoxs8.fsf@gitster.dls.corp.google.com>
References: <54C0E76D.5070104@alum.mit.edu>
	<1422043442-30676-1-git-send-email-sbeller@google.com>
	<1422043442-30676-6-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: mhagger@alum.mit.edu, peff@peff.net, git@vger.kernel.org,
	loic@dachary.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Jan 24 00:57:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEo6q-0002mI-40
	for gcvg-git-2@plane.gmane.org; Sat, 24 Jan 2015 00:57:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbbAWX5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 18:57:48 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62449 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750820AbbAWX5q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 18:57:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B708632063;
	Fri, 23 Jan 2015 18:57:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cAyDX6wSATpE9lFFvDuA7yn/1S0=; b=nfJbVo
	T042aZi7uJCCodwpLpPl9jiN8s5n0ngboSHRXa34il4lprXCOLBJCnMXT9UaAJeW
	cSR1kpv5zaNr2BAXOzt/tKrfTFQertcD1Qza/c71HwhoumtvXsLv7Bk47T8RGA+X
	P/rJefv3vELmxdgycYhqX+gP+zIAcEEJ22wb0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uzIvqnQgqWxNQ7jpyRJ35vqY5YOUxoVg
	aqBHga0uv0R5vKKT+kuUwNDphZCKNKPqCwEC1JYDGL0gAuhZ9Mg/xxf2cP5sAxOs
	o0h4MN4CdWdCXrwu229d7esdReb5wWP5x6W0w6ip/lcBdketKqLjzziXgENHHK8P
	UeKEVs9XQVc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AD9BC32062;
	Fri, 23 Jan 2015 18:57:45 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2A48332061;
	Fri, 23 Jan 2015 18:57:45 -0500 (EST)
In-Reply-To: <1422043442-30676-6-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 23 Jan 2015 12:04:01 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A0212C28-A35B-11E4-A916-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262976>

Stefan Beller <sbeller@google.com> writes:

> -static int commit_ref(struct ref_lock *lock)
> +static int commit_ref(struct ref_lock *lock, const unsigned char *sha1)
>  {
> +	if (!lock->force_write && !hashcmp(lock->old_sha1, sha1))
> +		return 0;
>  	if (commit_lock_file(lock->lk))
>  		return -1;
>  	return 0;
> @@ -2879,10 +2882,13 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
>  	}
>  	lock->force_write = 1;
>  	hashcpy(lock->old_sha1, orig_sha1);
> -	if (write_ref_sha1(lock, orig_sha1, logmsg)) {
> +	if (write_ref_sha1(lock, orig_sha1, logmsg)
> +	    || commit_ref(lock, orig_sha1)) {
> +		unlock_ref(lock);

This is not a new problem, but the two lines in pre-context of this
patch look strange.  When the code is renaming into some ref, the
ref either would have no original SHA-1 (i.e. we are renaming to a
non-existing name) or have unrelated SHA-1 (i.e. we are overwriting
an existing one).  For some (unknown to me) reason, however, the
code pretends that lock->old_sha1 has the new SHA-1 already before
we start to do the write or commit.

And because both write and commit tries to pretend to be no-op when
the caller tries to update a ref with the same SHA-1, but in this
codepath it does want the write to happen, it needs to set the
force_write bit set, which look like an unnecessary workaround.

Regardless of what this particular caller does, I am not sure if the
early-return codepath in commit_ref() is correct.  From the callers'
point of view, it sometimes unlocks the ref (i.e. when a different
SHA-1 is written or force_write is set) and sometimes keeps the ref
locked (i.e. when early-return is taken).  Shouldn't these two cases
behave identically?  Or am I wrong to assume that the early return
using "hashcmp(lock->old_sha1, sha1)" is a mere optimization?
