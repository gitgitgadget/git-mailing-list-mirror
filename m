From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/14] http: use hostname in credential description
Date: Fri, 22 Jul 2011 15:01:53 -0700
Message-ID: <7vbowmx9da.fsf@alter.siamese.dyndns.org>
References: <20110718074642.GA11678@sigill.intra.peff.net>
 <20110718075232.GJ12341@sigill.intra.peff.net>
 <7vr55k4mxn.fsf@alter.siamese.dyndns.org>
 <20110722204749.GC11922@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 23 00:02:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkNnH-0003Fx-1y
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jul 2011 00:02:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932606Ab1GVWB5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jul 2011 18:01:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47823 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932420Ab1GVWB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2011 18:01:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FB405301;
	Fri, 22 Jul 2011 18:01:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lue20gdwjRk4aQgNfcTbYkyfbwg=; b=QGWGm1
	rhIxShZ+M1Cjx9k4sxV6fsf/hUvH2eB5vgSzRt9ghQjnlU7HTeLQDRNuaEllETQY
	zZZtVUeyuA7FEYOIwmEuYA1A+nHOAD6xGiwIIcykbKBHnGPM0SThT/HejcHtM1KJ
	b493Rjj8ib2bxI1XS7lKcZyIEa+C7RZ8lqgTA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w6saCNFunm+3m9Kr+9tOZPKbjkCOPhHI
	jZ+FTYMdrBxhIEOWj0OTYt9AIq5HhmFr2CaILehODTYyfptWGGo9u5vl0/IlXFPg
	kWsMpsoosx+uJPYAwVHVJva4N82+t7sSlZHUVYwiDSI/tBvYtl0vAFuWFgeYjU+V
	soBxipIimjY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9842C5300;
	Fri, 22 Jul 2011 18:01:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1A2C452FF; Fri, 22 Jul 2011
 18:01:55 -0400 (EDT)
In-Reply-To: <20110722204749.GC11922@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 22 Jul 2011 14:47:50 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 36677BB0-B4AE-11E0-B96D-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177670>

Jeff King <peff@peff.net> writes:

> It means that you can get convenient credential handling (whether it's
> because you've configured a username, or you're getting it from a
> wallet, or caching, or whatever) with:
>
>   git push https://github.com/peff/git.git &&
>   git push https://github.com/peff/foo.git
>
> which should hopefully just prompt you once (and a configured username
> would have to be configured only once for the host).
>
> And it comes at the cost that there's not a good way to use two
> different identities for the same host.

Yes, both "just prompt you once" and "would have to be configured only
once" cut both ways, and that is mildly disturbing to my taste.

If we annotate the remote in .git/config perhaps like this:

	[remote "foo"]
        	url = https://github.com/peff/foo.git
                auth_context = "foo project at github"
		...
	[remote "bar"]
        	url = https://github.com/peff/bar.git
                auth_context = "bar project at github"

and have "git push foo" pass the auth_context to the credential backend,
which can notice the two projects are in different context and cache two
identities under different contexts, would it be a good workaround for the
issue?  Then, a remote that does not have auth_context configured would
use "https:github.com" that is machine-generated (in http.c in your code),
but that can easily be overridden if/as necessary.

> I tried to optimize for the common case (many repos under one identity)
> than the uncommon (many identities under one host).

As I am not convinced if this statement is true.
