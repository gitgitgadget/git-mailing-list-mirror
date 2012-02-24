From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] do not stream large files to pack when filters are
 in use
Date: Fri, 24 Feb 2012 12:03:17 -0800
Message-ID: <7vehtkyp6i.fsf@alter.siamese.dyndns.org>
References: <20120224093924.GA11680@sigill.intra.peff.net>
 <20120224094805.GB11846@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 24 21:03:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S11MX-0000QV-8F
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 21:03:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757972Ab2BXUDX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Feb 2012 15:03:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57788 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757889Ab2BXUDU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 15:03:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD00A6130;
	Fri, 24 Feb 2012 15:03:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=NbcbQPqUFBZXl94lTOpbI9hXXYw=; b=Xtsls6DNOkZyKtToCGDz
	Zc61YCXVr//JLbhdr7Ea/WV+AKeYFMF1jv8ZywFOeN8b4Ht2fMRbmqTopt2ylBN9
	GLI+5ABmIwKkbUgL2ly09pI7XDjOfIOW/I8IL2OLc5x71QPa/KX6VZ14CQwHOCJd
	yOSzZKEWgctIiUXc+qd0KRw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=dxB7QSd/+Q6prreDmzGuWLihySfFvZhkGpsuKzpiB/tZ/y
	UW6tjTjb9VSAC/Nt7yVOO8p14jlBora7U58IBBXIgKOzgEZzGwJafr8BdddT3Dal
	YhQSGXl4fMiCHgy8OQC+e9h76q3KE2WHxBpZ7IpsOa3lqBCmX3qKVMKFBujic=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B42B5612F;
	Fri, 24 Feb 2012 15:03:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 47C806129; Fri, 24 Feb 2012
 15:03:19 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 98B035B8-5F22-11E1-B421-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191456>

Jeff King <peff@peff.net> writes:

> I'm on the fence about the performance regression above. On the one
> hand, if you're telling git to autocrlf your gigantic binary files, you
> should fix your attributes, and expect not to use the streaming
> optimization until you do.

That is a sensible angle to view the issue from, I would think.

> diff --git a/sha1_file.c b/sha1_file.c
> index f9f8d5e..61f597b 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2720,7 +2720,8 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st,
>  
>  	if (!S_ISREG(st->st_mode))
>  		ret = index_pipe(sha1, fd, type, path, flags);
> -	else if (size <= big_file_threshold || type != OBJ_BLOB)
> +	else if (size <= big_file_threshold || type != OBJ_BLOB ||
> +		 convert_to_git(path, NULL, 0, NULL, 0))

Nice.  It would be even nicer to give a readability macro whose name makes
it clear that this is a query (unfortunately we cannot add '?' at the end
of the function name) and not a conversion.  Any name suggestions?

By the way, I tried this with the tip of 'pu' as of last night, and the
result segfaults on me in t1050 (hash-object -w) ;-).
