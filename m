From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/6] vcs-svn: prefer constcmp to prefixcmp
Date: Fri, 01 Jun 2012 09:27:34 -0700
Message-ID: <7vfwaf3sll.fsf@alter.siamese.dyndns.org>
References: <1338475290-22644-1-git-send-email-davidbarr@google.com>
 <1338475290-22644-4-git-send-email-davidbarr@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Fri Jun 01 18:27:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaUhR-0000Kp-C1
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 18:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965456Ab2FAQ1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jun 2012 12:27:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40852 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965413Ab2FAQ1g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 12:27:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E97A8EEF;
	Fri,  1 Jun 2012 12:27:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1fNDZBucAP77IPIbRRmGVw/0XgY=; b=FlwBg0
	vUAEb/IEkx4lCfWYTVF+ZwLFKHZmnDx1kDjPX+Ziihj3vbqNF432OC7XAGPXtVTf
	bxtH7b5N/WMCJpuGneDX/4QdGQTPnkR1HoDjt7KNZVelu+bKqJJTbOzeP2PP0BJB
	mMvYwI0cuB0sCNbCX0D0Un9v2FloIN7gSbhAE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XKbjEIi45wmPXKDC6pu102awZdMAwRCC
	BJOVb4ilDDSSIRaLgvcIobzCvi4FFxQThsshJb12xqvb7mo283wQBZGyAsb+HiD4
	6EbvXGxov/9uWwMS8A9LzWQCIs5ieSdwnV0p9cHMBsx0eWj95K71udDWtHMV3tb6
	WY5DbKiVWk8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 05F148EED;
	Fri,  1 Jun 2012 12:27:36 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5F4CE8EEB; Fri,  1 Jun 2012
 12:27:35 -0400 (EDT)
In-Reply-To: <1338475290-22644-4-git-send-email-davidbarr@google.com> (David
 Barr's message of "Fri, 1 Jun 2012 00:41:27 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B200E608-AC06-11E1-8BBA-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198999>

David Barr <davidbarr@google.com> writes:

> Comparisons in svndump.c are always guarded by length.
> As a bonus, elimate dependency on prefixcmp for upstream.
>
> Signed-off-by: David Barr <davidbarr@google.com>

It feels suboptimal, from cross-project maintenance point of view,
that "do not use prefixcmp() in the source in this directory" has to
be an unwritten rule.  Is there something we can do better to avoid
having to apply a patch like this in the future?

>  vcs-svn/svndump.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
> index 0899790..8d0ae9c 100644
> --- a/vcs-svn/svndump.c
> +++ b/vcs-svn/svndump.c
> @@ -361,7 +361,7 @@ void svndump_read(const char *url)
>  			reset_rev_ctx(atoi(val));
>  			break;
>  		case sizeof("Node-path"):
> -			if (prefixcmp(t, "Node-"))
> +			if (constcmp(t, "Node-"))
>  				continue;
>  			if (!constcmp(t + strlen("Node-"), "path")) {
>  				if (active_ctx == NODE_CTX)
