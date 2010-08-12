From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/10] Add string-specific memory pool
Date: Thu, 12 Aug 2010 10:22:41 -0700
Message-ID: <7vmxsru4ny.fsf@alter.siamese.dyndns.org>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <20100716101352.GA14374@burratino> <20100809215719.GA4203@burratino>
 <20100809223442.GA4429@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 19:23:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjbUc-00014Z-0a
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 19:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755166Ab0HLRW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 13:22:56 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59067 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752977Ab0HLRWz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 13:22:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FCF5CDA28;
	Thu, 12 Aug 2010 13:22:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=vcvvwgOiL2HAa67+kkuV6v4GDlQ=; b=gJazMlP2+KmB/NWPQGxotl2
	VDwm8Hg3ItzP/cO4Y/JZyEHYJjKUgW7/67C6e99pimJwnJoGLMRP0CGPDQ5YVmkl
	+Ye2+tvKzIQS94m7wCAsaUp0yJSzRad5G+WvUaULn/tMC23x5g+b6hiPh8YWcIqt
	M1ZUA3QV1aMv/lXjITok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=fEO7VmY+TVGbyKsVH62Ozv7IPct76+gJ5S9yXMp0DkolnzZPh
	86uLkUXBacPh3ZLmVbojagtMPNxjNa69nbKZv1y/byFAu4YnRtqFg8FwfWQHaMBt
	930ICZBqyHqUYIJb9TXY/g0v0u1dV5GE/KaSPjp1oNIL+gB0q2moiJwPJo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4124DCDA25;
	Thu, 12 Aug 2010 13:22:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4A4F9CDA21; Thu, 12 Aug
 2010 13:22:43 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3AFB6876-A636-11DF-B404-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153389>

Jonathan Nieder <jrnieder@gmail.com> writes:

> diff --git a/Makefile b/Makefile
> index e7c33ec..24103c9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -415,6 +415,7 @@ TEST_PROGRAMS_NEED_X += test-path-utils
>  TEST_PROGRAMS_NEED_X += test-run-command
>  TEST_PROGRAMS_NEED_X += test-sha1
>  TEST_PROGRAMS_NEED_X += test-sigchain
> +TEST_PROGRAMS_NEED_X += test-string-pool
>  TEST_PROGRAMS_NEED_X += test-treap
>  TEST_PROGRAMS_NEED_X += test-index-version

Does your Makefile do the right thing to vcs-svn/*.[oa] upon "make clean"?

> diff --git a/vcs-svn/string_pool.c b/vcs-svn/string_pool.c
> new file mode 100644
> index 0000000..550f0e5
> --- /dev/null
> +++ b/vcs-svn/string_pool.c
> @@ -0,0 +1,102 @@
> ...
> +uint32_t pool_intern(const char *key)
> +{
> +	/* Canonicalize key */
> +	struct node *match = NULL;
> +	uint32_t key_len;
> +	if (key == NULL)
> +		return ~0;
> +	key_len = strlen(key) + 1;
> +	struct node *node = node_pointer(node_alloc(1));

Please fix decl-after-stmt here.
