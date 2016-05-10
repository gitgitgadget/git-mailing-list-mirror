From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Windows: only add a no-op pthread_sigmask() when needed
Date: Tue, 10 May 2016 10:57:08 -0700
Message-ID: <xmqqvb2lpzij.fsf@gitster.mtv.corp.google.com>
References: <26c2fb5560246fc7f980da24a239edc333864527.1462885167.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 10 19:57:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0BuG-0008Ak-BP
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 19:57:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730AbcEJR5N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 13:57:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58366 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751318AbcEJR5M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 13:57:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3EE1D1815D;
	Tue, 10 May 2016 13:57:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+hUi3A0j1Zl/x/jRk3aZjMUYRkM=; b=Msb5h8
	OcCpO0qkdP5GARCoHB7upNtf5vtaExAEqWeY1X85zdDbZRMKbKDykUCMYscWOzM/
	2bbqj3YB6gjpsK/bPxeicDYNo1P8/8QlsdusRBYbudzjusHh6fHYQUQysrvxhE6u
	HfzuEFO4AIbLVlzfpsj74bJVY31Rmnf5dPp88=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Pv/ncJvEZU09Te+XFYVmOaNYD0mvOX05
	cb2Yo2V0QXbbyqhNzLgn0MneDSgOqZLPfrqgnpHFfaEdVrmFYClcxDcNPUPueX1h
	3tC9YbwkIAIdj9GMuZJhBSEMq6iulnVbPwDvTfJNKCJ1fzRPayfNFqBzY1yJ2QV4
	5Qvxe0EOd2I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3634F1815C;
	Tue, 10 May 2016 13:57:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AA9A218159;
	Tue, 10 May 2016 13:57:10 -0400 (EDT)
In-Reply-To: <26c2fb5560246fc7f980da24a239edc333864527.1462885167.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Tue, 10 May 2016 15:00:35 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9E5E618E-16D8-11E6-80FB-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294166>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> In f924b52 (Windows: add pthread_sigmask() that does nothing,
> 2016-05-01), we introduced a no-op for Windows. However, this breaks
> building Git in Git for Windows' SDK because pthread_sigmask() is
> already a no-op there, #define'd in the pthread_signal.h header in
> /mingw64/x86_64-w64-mingw32/include/.
>
> Let's guard the definition of pthread_sigmask() in #ifndef...#endif to
> make the code compile both with modern MinGW-w64 as well as with the
> previously common MinGW headers.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>
> 	This patch is obviously based on 'next' (because 'master' does not
> 	have the referenced commit yet).

One thing that makes me wonder is what would happen when
/mingw64/x86_64-w64-mingw32/include/pthread_signal.h changes its
mind and uses "static inline" instead of "#define".  How much
control does Git-for-Windows folks have over that header file?

Also, could you explain "However" part a bit?  Obviously in _some_
environment other than "Git for Windows' SDK", the previous patch
helped you compile.  And you need to #ifdef it out, because "Git for
Windows' SDK" already has its own support.  What is that other
environment that lacks the support (hence we need our own "static
inline") and is there a way to tell "Git for Windows' SDK" from that
other environment?

What I am trying to get at is:

 (1) If the answer is "we have total control", then I am perfectly
     fine with using "#ifdef pthread_sigmask" here.

 (2) If not, i.e. "they can change the implementation to 'static
     inline' themselves", then I do not think it is prudent to use
     "#ifndef pthread_sigmask" as the conditional here--using a
     symbol that lets you check for that "other" environment and
     doing "#ifdef THAT_OTHER_ONE_THAT_LACKS_SIGMASK" would be
     safer.

Also is https://lists.gnu.org/archive/html/bug-gnulib/2015-04/msg00068.html
relevant?  Does /mingw64/x86_64-w64-mingw32/include/ implement "macro only
without function"?

> Published-As: https://github.com/dscho/git/releases/tag/mingw-sigmask-v1
>  compat/win32/pthread.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
> index d336451..8df702c 100644
> --- a/compat/win32/pthread.h
> +++ b/compat/win32/pthread.h
> @@ -104,9 +104,11 @@ static inline void *pthread_getspecific(pthread_key_t key)
>  	return TlsGetValue(key);
>  }
>  
> +#ifndef pthread_sigmask
>  static inline int pthread_sigmask(int how, const sigset_t *set, sigset_t *oset)
>  {
>  	return 0;
>  }
> +#endif
>  
>  #endif /* PTHREAD_H */
