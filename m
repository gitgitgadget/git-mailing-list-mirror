From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fix "git diff --stat" for interesting - but empty - file changes
Date: Wed, 17 Oct 2012 11:28:02 -0700
Message-ID: <7v4nltoswd.fsf@alter.siamese.dyndns.org>
References: <CA+55aFz88GPJcfMSqiyY+u0Cdm48bEyrsTGxHVJbGsYsDg=Q5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Oct 17 20:28:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOYLr-0005nK-FP
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 20:28:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757596Ab2JQS2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 14:28:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56717 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754716Ab2JQS2G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 14:28:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C949C9981;
	Wed, 17 Oct 2012 14:28:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d/0Q4YyrWxfyeyuPCJXDtijIkxA=; b=g+O35F
	6UXslhcFZRxynkAMu4d5hqIJbxVy4C9cfCUsooFCwAtCyjY5QrD+3zWs/G+8psXW
	ha5vuWYFyGS5lxT3lWf/vHEXYCOLwYUF5Hcnnn6ryZBRHDolBTxz5jUv+yFR67Po
	OdffFvLTXaKkLmL8P4dzcm34Efgd/XtC9KC7c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=APdlLPBQb1REoOWHeNTdxse2K2DnZpZ0
	TO8gXrNy6QbW5qs+jWEJXvMXSMgkGS5rLDk8AQX55zW4+W9I4RI3asPSc6W+Xa/r
	D0k9exobPHZ0Z4qDc7ckW0wVyNLW24M+HPCa04cARVuZVrrLIfhuYfnEVli576NC
	wQTfDjUW2oI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B54CB9980;
	Wed, 17 Oct 2012 14:28:05 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0125A997E; Wed, 17 Oct 2012
 14:28:03 -0400 (EDT)
In-Reply-To: <CA+55aFz88GPJcfMSqiyY+u0Cdm48bEyrsTGxHVJbGsYsDg=Q5w@mail.gmail.com> (Linus
 Torvalds's message of "Wed, 17 Oct 2012 10:00:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 63990A92-1888-11E2-9473-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207933>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So if you did
>
>    chmod +x Makefile
>    git diff --stat
>
> before, it would show empty (" 0 files changed"), with this it shows
>
>  Makefile | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>
> which I think is a more correct diffstat (and then with "--summary" it
> shows *what* the metadata change to Makefile was - this is completely
> consistent with our handling of renamed files).
>
> Side note: the old behavior was *really* odd. With no changes at all,
> "git diff --stat" output was empty. With just a chmod, it said "0
> files changed". No way is our legacy behavior sane.
>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>
> This was triggered by kernel developers not noticing that they had
> added zero-sized files, because those additions never showed up in the
> diffstat.
> ...
> Comments?

I think listing a file whose content remain unchanged with 0 as the
number of lines affected makes sense, and it will mesh well with
Duy's

  http://thread.gmane.org/gmane.comp.version-control.git/207749

I first wondered if we would get a division-by-zero while scaling
the graph, but we do not scale smaller numbers up to fill the
columns, so we should be safe.

These days, we omit 0 insertions and 0 deletions, so I am not sure
what you should get for this case, though:

>  Makefile | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)

Should we just say "1 file changed"?
