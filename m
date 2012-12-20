From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add core.pathspecGlob config option
Date: Wed, 19 Dec 2012 19:51:16 -0800
Message-ID: <7vehil7557.fsf@alter.siamese.dyndns.org>
References: <20121219203449.GA10001@sigill.intra.peff.net>
 <CACsJy8BB3=3ZHD5Ua9M-0+98JVigHBBuo07gBSgEwanvB0zBSA@mail.gmail.com>
 <20121220031327.GB9917@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 20 04:53:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlXCb-0005rs-IX
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 04:53:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752307Ab2LTDvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 22:51:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51141 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751397Ab2LTDvU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 22:51:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36D38A36B;
	Wed, 19 Dec 2012 22:51:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sggx7mYDbpgabgLRweeTFeZumaU=; b=deyRSc
	BrPkJ6ZiJ+nt87OLNrjfiDA63/hf0+x5+yCLoALb3iOfQhLrYHdE9OJnmdv8Lp5S
	IPDzJlPMPtiDxohsy9yNsc1fXAssg79dIweD0JF6VGz8UWq6YsIvA4GFsTs98gwp
	ADvcdZ3LQCG8FQmrGvzcWRQMPRv2Mc9kxIOig=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EyXvlHV087wBZJ08bjP9XlI1s1fqiFTB
	lln49n+jbPyHtVW1yicX0mw8KLnYjOfY8q03U2kVmUO5dAoRJxOmJgsl3H1AVe/K
	HXmmI+KWg8Jsn7T+Kd+BsGboH5GNznJ9AH7MBo8yO0hjmHq6FHJZ9ht/p0Q8DULv
	gRKryvQwbts=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21FFAA36A;
	Wed, 19 Dec 2012 22:51:19 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 79444A369; Wed, 19 Dec 2012
 22:51:18 -0500 (EST)
In-Reply-To: <20121220031327.GB9917@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 19 Dec 2012 22:13:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 82B56A54-4A58-11E2-8DCE-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211874>

Jeff King <peff@peff.net> writes:

> On Thu, Dec 20, 2012 at 08:28:57AM +0700, Nguyen Thai Ngoc Duy wrote:
>
>> > So I think this is a nice, simple approach for sites that want it, and
>> > noglob magic can come later (and will not be any harder to implement as
>> > a result of this patch).
>> 
>> Any chance to make use of nd/pathspec-wildcard? It changes the same
>> code path in match_one. If you base on top of nd/pathspec-wildcard,
>> all you have to do is assign nowildcard_len to len (i.e. no wildcard
>> part).
>
> I'd rather keep it separate for now. One, just because they really are
> independent topics, and two, because I am actually back-porting it for
> GitHub (we are fairly conservative about upgrading our backend git
> versions, as most of the interesting stuff happens on the client side; I
> cherry-pick critical patches with no regard to the release cycle).
>
> And the resolution is pretty trivial, too. It looks like this:
>
> diff --cc dir.c
> index 5c0e5f6,03ff36b..81cb439
> --- a/dir.c
> +++ b/dir.c
> @@@ -1456,14 -1433,10 +1460,18 @@@ int init_pathspec(struct pathspec *path
>   
>   		item->match = path;
>   		item->len = strlen(path);
> - 		item->nowildcard_len = simple_length(path);
>  -		item->use_wildcard = !limit_pathspec_to_literal() &&
>  -				     !no_wildcard(path);
>  -		if (item->use_wildcard)
>  -			pathspec->has_wildcard = 1;
>  +		item->flags = 0;
> - 		if (item->nowildcard_len < item->len) {
> - 			pathspec->has_wildcard = 1;
> - 			if (path[item->nowildcard_len] == '*' &&
> - 			    no_wildcard(path + item->nowildcard_len + 1))
> - 				item->flags |= PATHSPEC_ONESTAR;
> ++		if (limit_pathspec_to_literal())
> ++			item->nowildcard_len = item->len;
> ++		else {
> ++			item->nowildcard_len = simple_length(path);
> ++			if (item->nowildcard_len < item->len) {
> ++				pathspec->has_wildcard = 1;
> ++				if (path[item->nowildcard_len] == '*' &&
> ++				    no_wildcard(path + item->nowildcard_len + 1))
> ++					item->flags |= PATHSPEC_ONESTAR;
> ++			}
>  +		}
>   	}
>   
>   	qsort(pathspec->items, pathspec->nr,

Hmph.  I thought that returning the length without any "stop at glob
special" trick from simple_length() would be a simpler resolution.

That is what is queued at the tip of 'pu', anyway.
