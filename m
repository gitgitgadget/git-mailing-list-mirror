From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Segfault in the attr stack
Date: Wed, 01 Jun 2016 15:46:16 -0700
Message-ID: <xmqqh9dcwmrr.fsf@gitster.mtv.corp.google.com>
References: <CAGZ79ka_4vZfNhgOyMeFKdossO-S5Q7RVnvEzB8YAJNc1YQ+uQ@mail.gmail.com>
	<CAGZ79kbSKgS42nAShsK3JV78geam3k84=ipWRx7vbRODuHcmcA@mail.gmail.com>
	<CAPc5daXuQAeWvJAciRA_Kzyoxa=atEntGzKhqzjiN+ho6TnQyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 00:46:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8Eu8-0004Ey-Mj
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 00:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbcFAWqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 18:46:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64770 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751326AbcFAWqT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 18:46:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id ADE25205D8;
	Wed,  1 Jun 2016 18:46:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SRn8PhrKZJ4/eK/DjymzmKhDLJ8=; b=nJ1pnD
	XJkaG1s1WFkXrF4kF1p65w9rUtXDfFju3blZvlI8LWw2j27uHifCPeqlqsZ735zS
	ta/6vDCNpXK2r+oTbpIPQS9/3XrjHEbsbpGJX6t3c0MdFTD79Pl917L5UScgtgiX
	uHValEHpXt8O5CuQ0Eqt0/cXAgXtaAn0u8v3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v+7QHPtI4fMyyQ4uc78yyHj3jxYachHz
	jHYlryOKhY/LxtrIzA1Kaiv7cjUPUl3NxXsZUx9fHdLhCvpQ115nAvlr+Wk+S0ke
	BVrxtocWrMuWdgf+nxZCiMS/jueD5gJOQp6Bp9CjCmSSsWpBSyyzsTYvi34vC4rY
	qy8HGo9FHeY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A588A205D7;
	Wed,  1 Jun 2016 18:46:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2BF32205D6;
	Wed,  1 Jun 2016 18:46:18 -0400 (EDT)
In-Reply-To: <CAPc5daXuQAeWvJAciRA_Kzyoxa=atEntGzKhqzjiN+ho6TnQyg@mail.gmail.com>
	(Junio C. Hamano's message of "Wed, 1 Jun 2016 15:17:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A75C095C-284A-11E6-AA9C-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296175>

Junio C Hamano <gitster@pobox.com> writes:

> Gaah, of course.
>
> This is coming from the cache preload codepath, where multiple threads
> try to run ce_path_match().
> It used to be OK because pathspec magic never looked at attributes,
> but now it does, and attribute system is not thread-safe.

The symlink check code has dealt with a similar issue in the past in
the codepath.  threaded_has_symlink_leading_path() is called with
per-thread data structure called "cache", because the leading
symbolic link check uses a cache that is shared across different
invocations of the check.

We need something similar to duplicate the attribute stack per
thread.  git_check_attrs() currently uses the singleton instance of
attr_stack chain, that is rooted at the file scope global
"attr_stack", and no wonder that would be clobbered when multiple
threads try to use it.  The result of attribute collection is also
accumulated in a file scope global, which should probably be moved
to the "struct git_attr_check" introduced in the jc/attr topic.

We need to teach the callchain that includes prepare_attr_stack()
and bootstrap_attr_stack() to take a pointer to the attr_stack root,
give git_check_attr_threaded() that takes such root so that threaded
code can use per-thread attr stack, and for non-threaded
applications use &the_default_attr just like the file scope global
"default_cache" is used in symlinks.c.  Then a threaded attribute
lookup can maintain its own attr_stack when running more than one
instance of lookup.
