From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/8] longest_ancestor_length(): use string_list_split()
Date: Thu, 27 Sep 2012 15:48:06 -0700
Message-ID: <7vr4pnnkux.fsf@alter.siamese.dyndns.org>
References: <1348688090-13648-1-git-send-email-mhagger@alum.mit.edu>
 <1348688090-13648-4-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Sep 28 00:48:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THMsV-0007eU-UZ
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 00:48:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755944Ab2I0WsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 18:48:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39151 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755000Ab2I0WsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 18:48:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4F258AB5;
	Thu, 27 Sep 2012 18:48:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pXUQpB3HEVmjHoCQJjpxiTFs9A8=; b=v9ruU9
	mUasgTeM3GKZyq4ldjRQ3/KNSg6M5vIcJBGHqmZNHh657cviQ4DcZu7fo8a9QXok
	+lAYut+Usj6ix9DhhZ+Pr81HYvIw/KipGsWA/hIrDdVNhmYAZR9wJedWQj56+XgS
	YvnlA7d8yiqAGblhl8Otpk4btbzh0IqXTLOB0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YKaBKeH/NSyKViZmAsUEEEbAAzCq+hJI
	j75tslvCJJl8yqzdMhCOP9pqvW5Y5KR4yrUnssFvCqKUO7p6I53IPEV4crU0jON9
	2+BA6JVuAycXODFvWRGEgTY6bh0CHAee8OCTf/wkQ6nOwYTB68jX//kabOjFb1j4
	J9/RHfTNeKw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D24FF8AB4;
	Thu, 27 Sep 2012 18:48:08 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 425468AB3; Thu, 27 Sep 2012
 18:48:08 -0400 (EDT)
In-Reply-To: <1348688090-13648-4-git-send-email-mhagger@alum.mit.edu>
 (Michael Haggerty's message of "Wed, 26 Sep 2012 21:34:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 68344082-08F5-11E2-B042-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206526>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> -	for (colon = ceil = prefix_list; *colon; ceil = colon+1) {
> -		for (colon = ceil; *colon && *colon != PATH_SEP; colon++);
> -		len = colon - ceil;
> +	string_list_split(&prefixes, prefix_list, PATH_SEP, -1);
> +
> +	for (i = 0; i < prefixes.nr; i++) {
> +		const char *ceil = prefixes.items[i].string;
> +		int len = strlen(ceil);
> +

Much nicer than the yucky original ;-)

>  		if (len == 0 || len > PATH_MAX || !is_absolute_path(ceil))
>  			continue;
> -		strlcpy(buf, ceil, len+1);
> +		memcpy(buf, ceil, len+1);
>  		if (normalize_path_copy(buf, buf) < 0)
>  			continue;

Why do you need this memcpy in the first place?  Isn't ceil already
a NUL terminated string unlike the original code that points into a
part of the prefix_list string?  IOW, why not

	normalize_path_copy(buf, ceil);

or something?

Can normalize_path_copy() overflow buf[PATH_MAX+1] here (before or
after this patch)?
