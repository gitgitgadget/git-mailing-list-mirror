From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 2/2] branch: name detached HEAD analogous to status
Date: Fri, 06 Mar 2015 12:23:55 -0800
Message-ID: <xmqqtwxxyiw4.fsf@gitster.dls.corp.google.com>
References: <54EB4579.3000103@xiplink.com>
	<0ece5e04a3fb38bdc1201036d65ed98199758ba5.1425653932.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Mar 06 21:24:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTymy-0008LK-EQ
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 21:24:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754846AbbCFUX7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 15:23:59 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50517 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751254AbbCFUX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 15:23:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B4F53D381;
	Fri,  6 Mar 2015 15:23:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s4Jz3JrWoW+1phgov/7uun9iHlk=; b=L6oAPI
	/yxTCFAcntqKZlRVW2yja9JSs13wcRepVMTMUYWrOj1KbJhmX+BpJaaoz+KH+n4+
	DI0WOO+pGHjduHDwmZQQn+v7QRPOWQo+gGSFM67hwaFl2O3JhqpVfnDCujpUMA3B
	rfMzTclt+/bJazLNzEEHJTRVQY5+pGqoJKQpE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gxVYFey+e2KPshdJWykOZDlBCHcVd8c1
	GjLRRXAjq9Vi4/09zDWxoEKhbNOMnZa47IdZ8sqHzp9l6nvFb73TsUQEg+8vZ0cK
	KvORgjn6ziU3UFFFVCOfSSZjLPRc7a0gClVQCkydyAcneLdoniT7WxA5oBHGl85L
	mBgNRPDBM54=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 63CE23D380;
	Fri,  6 Mar 2015 15:23:57 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D35A53D37F;
	Fri,  6 Mar 2015 15:23:56 -0500 (EST)
In-Reply-To: <0ece5e04a3fb38bdc1201036d65ed98199758ba5.1425653932.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Fri, 6 Mar 2015 16:04:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B73642AA-C43E-11E4-AF85-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264957>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> "git status" carefully names a detached HEAD "at" resp. "from" a rev or
> ref depending on whether the detached HEAD has moved since. "git branch"
> always uses "from", which can be confusing, because a status-aware user
> would interpret this as moved detached HEAD.
>
> Make "git branch" use the same logic and wording.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>
> Notes:
>     v2 uses the info from refactored wt-status.
>     
>     In addition, it tries to make sure that branch and status use the same
>     strings:
>     
>     HEAD detached at %s
>     * (HEAD detached at %s)
>     
>     (status first line, branch second line)
>     
>     Unfortunately, status strings are broken into pieces, so this can
>     be achieved by comments only.

It feels somewhat strange to have fields called detached-at and
detached-from in wt_status_state.

With this patch,

    * branch is either a string "HEAD" or the name of the branch we
      are on.

    * detached_from is the name of the branch HEAD detached from,
      or NULL if HEAD is on a branch.

    * detached_sha1[] is the object name of the commit we last
      moved to with "checkout --detach".

    * detached_at is a boolean that says the tip of detached_from
      and detached_sha1[] is the same.

There aren't that many users of these fields, so if we were to
rename them and clarify what they mean in order to make the code
more readable, we may be able to do so without too much churn.

Random conflicting/incoherent thoughts include:

 - perhaps branch can be NULL when detached?

 - perhaps branch can always point at the branch or the current
   detached-from?
 
 - perhaps detached_from can be renamed to make it more clear that
   it is the name of a branch (detached_sha1[] is fine, because it
   is clear what it is by having "sha1" in its name)?

 - perhaps detached_from/detached_at can be made into a single
   string that is set up by wt-status to hold either "HEAD detached
   at %s" or "HEAD detached from %s" to be used by its callers?

but I cannot yet reach a coherent whole to be called a suggestion
for a better organization X-<.

Will replace what was queued with this version.

Thanks.  
