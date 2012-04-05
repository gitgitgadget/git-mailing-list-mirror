From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] argv-array: Add argv_array_pop function [v2]
Date: Thu, 05 Apr 2012 13:12:51 -0700
Message-ID: <7vd37m5458.fsf@alter.siamese.dyndns.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1333654745-7898-1-git-send-email-nhorman@tuxdriver.com>
 <1333654745-7898-2-git-send-email-nhorman@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 22:12:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFt3C-0003Wd-NS
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 22:12:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756033Ab2DEUMy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 16:12:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43914 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755499Ab2DEUMx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 16:12:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D5986D27;
	Thu,  5 Apr 2012 16:12:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Jecyk2eY6loojtbFUsb6xObZb8k=; b=HU1Os0
	ndcmav3eQbkUufAsfqmArqsCAQsntaaTZxbxA+xV9jMggoHLsyKAUscRYY2gbEHw
	7JOlvAY+9Ux3tcL6dKRAqsFTcFfLHt7iWtHx/bIrAlYlWYsoO6dDSXIymOKVBRDk
	gFjK0C/ZOPNMFQEPXA2RvBbNAWUIcAuOaI66c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oUZhVmuvMXErm3oWnzNekyEexyfXdYL4
	jgqotISVSxLqYsJlsum9LuXp+vZwD7E7FvAskOF4SrWIpnuNBTLgIx8QaGSVevCv
	nJoljAGmTLeUzTkfFtOYjRSIpNtdSm7e9B9vJJWqsdRb87ZJIaCERi3F/SEJfH2n
	PA6/00ipeO4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 23E1C6D26;
	Thu,  5 Apr 2012 16:12:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7CA886D24; Thu,  5 Apr 2012
 16:12:52 -0400 (EDT)
In-Reply-To: <1333654745-7898-2-git-send-email-nhorman@tuxdriver.com> (Neil
 Horman's message of "Thu, 5 Apr 2012 15:39:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B94A229E-7F5B-11E1-8DBF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194804>

Neil Horman <nhorman@tuxdriver.com> writes:

> As a convienience, it would be nice if we could pop entries off the argv_array
> structs so that if they had multiple uses in a function, we wouldn't have to
> clear them and repopulate common entries.  This patch adds the argv_array_pop
> function to do just that.  Common entries can be added to an argv_array first,
> then useage specific ones can be added on the end and removed later on.
>
> Signed-off-by: Neil Horman <nhorman@tuxdriver.com>


> CC: Jeff King <peff@peff.net>
> CC: Phil Hord <phil.hord@gmail.com>
> CC: Junio C Hamano <gitster@pobox.com>
> ---

Please don't do "Cc:" here; they belong to your e-mail header.

> diff --git a/argv-array.c b/argv-array.c
> index a4e0420..ce24a48 100644
> --- a/argv-array.c
> +++ b/argv-array.c
> @@ -39,6 +39,18 @@ void argv_array_pushf(struct argv_array *array, const char *fmt, ...)
>  	argv_array_push_nodup(array, strbuf_detach(&v, NULL));
>  }
>  
> +int argv_array_pop(struct argv_array *array, unsigned int num)
> +{
> +	if (num > array->argc)
> +		return -1;

If your use case is "After using an argv_array for the first invocation,
truncate it while keeping the common ones that appear early, so that ones
that are specific to the second invocation can be pushed", it strikes me
somewhat odd why you would want to specify "how many to pop".

Wouldn't argv_array_truncate() or argv_array_setlen() make more sense?


> +	for(num--; num>0; num--) {

Gaah.

> +		free((char **)array->argv[num]);
> +		array->argv[num] = NULL;
> +	}
> +	return 0;
> +}
> +
>  void argv_array_clear(struct argv_array *array)
>  {
>  	if (array->argv != empty_argv) {
> diff --git a/argv-array.h b/argv-array.h
> index 74dd2b1..8233243 100644
> --- a/argv-array.h
> +++ b/argv-array.h
> @@ -15,6 +15,7 @@ void argv_array_init(struct argv_array *);
>  void argv_array_push(struct argv_array *, const char *);
>  __attribute__((format (printf,2,3)))
>  void argv_array_pushf(struct argv_array *, const char *fmt, ...);
> +int argv_array_pop(struct argv_array *, unsigned int num);
>  void argv_array_clear(struct argv_array *);
>  
>  #endif /* ARGV_ARRAY_H */
