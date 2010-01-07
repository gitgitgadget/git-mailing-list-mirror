From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add quiet option to git-ls-files
Date: Thu, 07 Jan 2010 12:19:01 -0800
Message-ID: <7v1vi14qiy.fsf@alter.siamese.dyndns.org>
References: <f3271551001071137u6158fa4fm1bf7a51a83354574@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 21:19:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSypA-0007Wg-QK
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 21:19:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141Ab0AGUTL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 15:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006Ab0AGUTK
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 15:19:10 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51057 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744Ab0AGUTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 15:19:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 673A08E846;
	Thu,  7 Jan 2010 15:19:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X9KmJiXpuBCy3H0mzzV6uTX9pvA=; b=qW9/Ac
	KlT0b4KH9eeELsEr0Fr5kNjOr8NUjYjSX7FspTI/1QPti1BGSlSECfIOiRCUHLNg
	Y71/ytNvaVcdf96K94T6mhNkalz7xUN7rDs56u52MaJqcJN+z3u1YIpA4SUS8OPo
	IpIVi9f+NvA7U1tndoGMUnC+8L8tqfUB4qQbc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u2i94a+MVgiRCJLRQsYuw7Yw8hpaKKxi
	SteVM0t6eFJAbDEruIk8SeG2VbsG6oNb4EkLnfQ8GK1jWqFpA8vcShVB7BC9jz3p
	vNdhDzFeooH1N+3LFCpHVOSCXfHiuSoxM7uGpaBsGrkIRyo11/TBjDl2LfmE75aC
	IfbZd+jSWFw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FA7E8E845;
	Thu,  7 Jan 2010 15:19:06 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 89CA38E843; Thu,  7 Jan
 2010 15:19:03 -0500 (EST)
In-Reply-To: <f3271551001071137u6158fa4fm1bf7a51a83354574@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Fri\, 8 Jan 2010 01\:07\:20 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E7B79CB4-FBC9-11DE-84E1-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136382>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
> index 625723e..0a1f94e 100644
> --- a/Documentation/git-ls-files.txt
> +++ b/Documentation/git-ls-files.txt
> @@ -82,6 +82,12 @@ OPTIONS
>  	Skips files matching pattern.
>  	Note that pattern is a shell wildcard pattern.
>  
> +--q::
> +--quiet::
> +	Only meaningful in --error-unmatch mode. Do not output an
> +	error message if <file> does not appear in the index. Instead
> +	exit with non-zero status silently.

The code doesn't seem to match the claim.

> diff --git a/builtin-ls-files.c b/builtin-ls-files.c
> index c9a03e5..40560da 100644
> --- a/builtin-ls-files.c
> +++ b/builtin-ls-files.c
> @@ -547,10 +548,11 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
>  
>  	if (ps_matched) {
>  		int bad;
> +		if (!quiet) {
> +			bad = report_path_error(ps_matched, pathspec, prefix_offset);
> +			if (bad)
> +				fprintf(stderr, "Did you forget to 'git add'?\n");
> +		}
>  		return bad ? 1 : 0;
>  	}

You might have seen that the code returns 1 during your testing, but that
is not because ps_matched[] was inspected, but because you are checking an
uninitialized garbage on stack in "bad" that happened to be non-zero.
