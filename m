From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/14] lockfile: introduce flag for locks outside .git
Date: Wed, 03 Dec 2014 15:13:13 -0800
Message-ID: <xmqqvblsuy2e.fsf@gitster.dls.corp.google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
	<20141117233525.GC4336@google.com>
	<CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
	<20141118004841.GE4336@google.com>
	<CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
	<20141203050217.GJ6527@google.com> <20141203051911.GP6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 00:13:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwJ6w-0002o0-Py
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 00:13:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752526AbaLCXN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 18:13:26 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54465 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752341AbaLCXNY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 18:13:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1387524F90;
	Wed,  3 Dec 2014 18:13:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ArlTFIKaKSV9HMCQIl4Ql4r2xSI=; b=jHFbQT
	2+Qj6w2sVafTTe0O6VXAUULDTmVCfXZguEDEK6oarWXaSEgWx7nrsj3XMpKvskU5
	4g3WJ6yk1U3GTIRtwyq4oICQth+LS60e5lHIMEpHEeOp2EQvNYHrd/nlQnklnhDY
	PSKyGpS0RcRZav3Ph6aeELJScie56+8F9NQgs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vmxwg4X7jFFMlk1VwhUhPpgh4f3WUnBS
	lvNUc4VsK4Gge0roQUrb1rABmPJvleCY9BPrP1U4C1UC6n2IIOfSz6mwFuaGXwOw
	6+sMM6pDPZ8QXIE4MS8NSaXKu62eGOX60AHDIOEVMLNgY/hwOvRgOnDV5bKLui7h
	X3fC1CEomJ4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 09A5024F8F;
	Wed,  3 Dec 2014 18:13:23 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C9F8524F81;
	Wed,  3 Dec 2014 18:13:14 -0500 (EST)
In-Reply-To: <20141203051911.GP6527@google.com> (Jonathan Nieder's message of
	"Tue, 2 Dec 2014 21:19:12 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F569A350-7B41-11E4-895A-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260707>

Jonathan Nieder <jrnieder@gmail.com> writes:

> diff --git a/refs.c b/refs.c
> index 917f8fc..39e43cf 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2326,7 +2326,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>  			 */
>  			goto retry;
>  		else
> -			unable_to_lock_die(ref_file, errno);
> +			unable_to_lock_die(ref_file, lflags, errno);
>  	}

This has unfortunate interaction with 06839515 (lock_ref_sha1_basic:
do not die on locking errors, 2014-11-19).  The fact that the helper
unable-to-lock-message() is now hidden inside lockfile.c does not
help, either.
