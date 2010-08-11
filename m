From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] split_cmdline: Allow caller to access error string
Date: Wed, 11 Aug 2010 11:31:45 -0700
Message-ID: <7vhbj1yp9q.fsf@alter.siamese.dyndns.org>
References: <1281158019-25995-1-git-send-email-gdb@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Greg Brockman <gdb@MIT.EDU>
X-From: git-owner@vger.kernel.org Wed Aug 11 20:32:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjG5r-0001jq-Iq
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 20:32:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753620Ab0HKSb4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 14:31:56 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45799 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753414Ab0HKSbz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 14:31:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 09E27CC3B8;
	Wed, 11 Aug 2010 14:31:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=CRGoJSzvjgrd7xcsJVP5hDFWPA0=; b=Whp+IhBf5/QL7ixJzaJsIiy
	x6PXA8tfLJX+o+0SwFjNluI2DSrVTfUqsBM+QTIGIXtzBhEwesCH0zrXo1N2qeWF
	BjYi+RM7lDZrg5zptwCwc6feodL6phyu/ux8z9TckKggrJf4UEAiR+UsWaMEnWsT
	rqIzX2wIV6yb5YLoDRLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=P0ezs3o7tBaAa2wPYYow4aYI5TtkEnXrxwyf7UpkZL4apHQ1t
	fGaISoyxpIGJ7kE1Nihn3Q4+VzJjrB7LU9RAU2QxYJpKWUwVoAk59AV1PCTHMdZi
	CwGHwZC/Fj+ifXwjNxbVZJVn8vn/4txpIAViP9nt2TvAQ7wIpJ5I1THKGc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D3923CC3B4;
	Wed, 11 Aug 2010 14:31:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 07AD6CC3B3; Wed, 11 Aug
 2010 14:31:47 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B6531976-A576-11DF-839C-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153271>

Greg Brockman <gdb@MIT.EDU> writes:

> This allows the caller to add its own error message to that returned
> by split_cmdline.  Thus error output following a failed split_cmdline
> can be of the form
>
> fatal: Bad alias.test string: cmdline ends with \
>
> rather than
>
> error: cmdline ends with \
> fatal: Bad alias.test string
>
> Signed-off-by: Greg Brockman <gdb@mit.edu>
> ---

> diff --git a/alias.c b/alias.c
> index 372b7d8..6f771cb 100644
> --- a/alias.c
> +++ b/alias.c
> @@ -1,7 +1,9 @@
> ...
> +#define SPLIT_CMDLINE_BAD_ENDING 1
> +#define SPLIT_CMDLINE_UNCLOSED_QUOTE 2
> +static const char *split_cmdline_errors = { "cmdline ends with \\", "unclosed quote" };
> ...
> @@ -53,7 +55,7 @@ int split_cmdline(char *cmdline, const char ***argv)
>  				if (!c) {
>  					free(*argv);
>  					*argv = NULL;
> -					return error("cmdline ends with \\");
> +					return -SPLIT_CMDLINE_BAD_ENDING;
>  				}
>  			}
>  			cmdline[dst++] = c;
>...
> @@ -75,3 +77,6 @@ int split_cmdline(char *cmdline, const char ***argv)
>  	return count;
>  }
>  
> +const char *split_cmdline_strerror(int split_cmdline_errno) {
> +	return split_cmdline_errors[-split_cmdline_errno-1];
> +}

Looks like a reasonable way to go.  Thanks.
