From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] config: add include directive
Date: Thu, 26 Jan 2012 12:58:25 -0800
Message-ID: <7vipjy2nbi.fsf@alter.siamese.dyndns.org>
References: <20120126073547.GA28689@sigill.intra.peff.net>
 <20120126073752.GA30474@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 26 21:58:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqWOv-0006kC-42
	for gcvg-git-2@lo.gmane.org; Thu, 26 Jan 2012 21:58:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752566Ab2AZU62 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jan 2012 15:58:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63454 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751971Ab2AZU62 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2012 15:58:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 764BA6433;
	Thu, 26 Jan 2012 15:58:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1oXpQylTVURsp7XF45NPkVfvG4g=; b=a+LKE+
	8on1j3veehHjQ0fdnqLVc+5R0zg8JctkCS1PTRTJNKMd2SfeU7iDqS1rZ+bvhxN3
	gUBkryJDtkEe+kG2kUvJdJi9EI9LpQlfvfyehUAWJWrFx2S2RcKzY9KhYOoE8hzU
	hVFpv1hOtdpzFjHAJTkt5j9QlCBBiZ75BarE4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dJGDK7t9LhUf3sTEd5ojnOR0MuYHULGl
	pYU2bLzv/1cNQWU8isanEjVDPfcieJ2tEyuB/0qNSRCNtcgFo+4pw8ZxuIu2l2zf
	4dnUKBWlGkG8mqt6HRx3PgF//JYaqOwc4zaVUXxXzAyl+0BQQSa6PsVbB8L5de6K
	MINELztKh2Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6DB4D6432;
	Thu, 26 Jan 2012 15:58:27 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F158B6431; Thu, 26 Jan 2012
 15:58:26 -0500 (EST)
In-Reply-To: <20120126073752.GA30474@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 26 Jan 2012 02:37:52 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7E3FBAEC-4860-11E1-9A7F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189164>

Jeff King <peff@peff.net> writes:

> Include directives are turned on for regular git config
> parsing (i.e., when you call git_config()), as well as for
> lookups via the "git config" program. They are not turned on
> in other cases, including:
>
>   1. Parsing of other config-like files, like .gitmodules.
>      There isn't a real need, and I'd rather be conservative
>      and avoid unnecessary incompatibility or confusion.

This is a good design decision, I think, but I am not sure where this "we
do not let gitmodules to honor inclusion" is implemented in this patch. I
would have expected a patch to "git-submodule.sh" that adds --no-includes
where it invokes "git config"?

> +Includes
> +~~~~~~~~
> +
> +You can include one config file from another by setting the special
> +`include.path` variable to the name of the file to be included. The
> +included file is expanded immediately, as if its contents had been
> +found at the location of the include directive.

I cannot offer better wording, but the first reaction I had to this was
"Eh, if I include a file A that includes another file B, to which config
file the '[include] path = B' directive found in file A relative to?"

Logically it should be relative to A, and I think your implementation
makes it so, but the above "as if its contents had been found at..."
sounds as if it should be the same as writing '[include] path = B' in the
original config file that included A.

By the way, I was a bit surprised that you did not have to add the source
stacking to git_config_from_file().

It was added in 924aaf3 (config.c: Make git_config() work correctly when
called recursively, 2011-06-16) to address the situation where
git_config() ends up calling git_config() recursively. My gut feeling is
that logically that issue shouldn't be limited to configuration that is
coming from file, which in turn makes me suspect that the source stacking
may be better in one level higher than git_config_from_file() so that the
ones coming from parameters could also be treated as a different kind of
source to read configuration from.

But in practice, including from the command line (i.e. -c include.path=...)
is somewhat crazy and we probably would not want to support it, so...
