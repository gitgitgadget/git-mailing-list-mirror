From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] attr: don't confuse prefixes with leading directories
Date: Tue, 10 Jan 2012 11:25:19 -0800
Message-ID: <7vhb039x7k.fsf@alter.siamese.dyndns.org>
References: <20120110070300.GA17086@sigill.intra.peff.net>
 <4F0BFE6E.6080904@alum.mit.edu>
 <20120110171100.GA18962@sigill.intra.peff.net>
 <20120110180820.GA15273@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Henrik =?utf-8?Q?Grubbstr=C3=B6m?= <grubba@grubba.org>,
	git-dev@github.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 10 20:25:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkhK9-00005c-KY
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 20:25:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932862Ab2AJTZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 14:25:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47661 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932175Ab2AJTZV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 14:25:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06E1F77AD;
	Tue, 10 Jan 2012 14:25:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AvvjI5sm3tDSoMd3isDaKjhQroc=; b=dDiKtt
	RB4P1XnZqh9eTie0RraCCPvLxy/pDaQYz4ckGoJGO0/f+BCAxmN7VXDTsvKxhCu2
	SfxAmH7+E+8wopvONPRNU73sNP1MrJVhqmZ45Ob1rVppT1gWVkI5hWLuv0jZpuY9
	val8+Iea/h7zQU5T2IwUpED7aJ1F8C8+8/1y8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HH9Wmq0/K5ux5dXTxZjRYPRjrN2IEler
	aMHieIaYjNsRyOJoQIVSf45w356zh3pFXFAhnQZDNAn2agP88MigcQTvxXzLvBGk
	nBwmJ3CmOpmw6i6jLn86UiV5n0oJW+dI3AoxNH2rFFMk76W828QTgRZBql6Zl2l5
	y6s+CtK0yfQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F016F77AC;
	Tue, 10 Jan 2012 14:25:20 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 85D0377AB; Tue, 10 Jan 2012
 14:25:20 -0500 (EST)
In-Reply-To: <20120110180820.GA15273@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 10 Jan 2012 13:08:21 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D5DCD5CA-3BC0-11E1-A571-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188282>

Jeff King <peff@peff.net> writes:

> diff --git a/attr.c b/attr.c
> index 76b079f..fa975da 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -582,7 +582,8 @@ static void prepare_attr_stack(const char *path)
>  
>  		elem = attr_stack;
>  		if (namelen <= dirlen &&
> -		    !strncmp(elem->origin, path, namelen))
> +		    !strncmp(elem->origin, path, namelen) &&
> +		    (!namelen || path[namelen] == '/'))
>  			break;

Thanks for the fix; I was looking at path_matches() and wondering about
the same thing.
