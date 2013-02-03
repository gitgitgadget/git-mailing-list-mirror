From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] combine-diff: suppress a clang warning
Date: Sun, 03 Feb 2013 11:58:15 -0800
Message-ID: <7vwqup890o.fsf@alter.siamese.dyndns.org>
References: <cover.1359901732.git.john@keeping.me.uk>
 <6995fd5e4d9cb3320ab80c983f1b25ae8a399284.1359901732.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Feb 03 20:58:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U25i7-0001J1-Lx
	for gcvg-git-2@plane.gmane.org; Sun, 03 Feb 2013 20:58:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753502Ab3BCT6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2013 14:58:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35282 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753453Ab3BCT6U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 14:58:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A6C8C803;
	Sun,  3 Feb 2013 14:58:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9dF1sp4333N4XhL0kcpxjv77hg0=; b=pDcDgp
	mef6YCYorEqa/sQyknVMRP3DT+Ifc5A4/4nH3hTIX53VzGojUbx0uGzGZ/Jhnr46
	s8h9YNPGkftGMdJYStfpXiZZ54MLBLBzNwKiztvaKqTi48xAxHQhywMll1oug5Wo
	C++C9FKU7qneWfNZNem1M3eOo88/cZ1+Wkotk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mhdFo3N5lRqDIN5pXk2zW6GRvrW0Pjsi
	l+GYqTQOqGf31owVw0WynvPdQ/MITbVaVWYgde2gTilL1EfRTp5ZKjPPxsIQ40UY
	Hikptv0vk+9tomPWylCoIMBATuwLUqmeXW8B0NnovC5H4cGfQOKc/V8BIc106HN9
	UCPuqn0QneQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1EBB5C802;
	Sun,  3 Feb 2013 14:58:20 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4EA24C7FF; Sun,  3 Feb 2013
 14:58:18 -0500 (EST)
In-Reply-To: <6995fd5e4d9cb3320ab80c983f1b25ae8a399284.1359901732.git.john@keeping.me.uk>
 (John Keeping's message of "Sun, 3 Feb 2013 14:37:10 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0E679EB2-6E3C-11E2-B542-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215328>

John Keeping <john@keeping.me.uk> writes:

> When compiling combine-diff.c, clang 3.2 says:
>
>     combine-diff.c:1006:19: warning: adding 'int' to a string does not
> 	    append to the string [-Wstring-plus-int]
> 		prefix = COLONS + offset;
> 			 ~~~~~~~^~~~~~~~
>     combine-diff.c:1006:19: note: use array indexing to silence this warning
> 		prefix = COLONS + offset;
> 				^
> 			 &      [       ]
>
> Suppress this by making the suggested change.
>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---

This was not lost in the noise.

I thought that this wasn't a serious patch, but your attempt to
demonstrate to others why patches trying to squelch clang warnings
are not necessarily a good thing to do.

Who is that compiler trying to help with such a warning message?
After all, we are writing in C, and clang is supposed to be a C
compiler.  And adding integer to a pointer to (const) char is a
straight-forward way to look at the trailing part of a given string.

> -		prefix = COLONS + offset;
> +		prefix = &COLONS[offset];

In other words, both are perfectly valid C.  Why should we make it
less readable to avoid a stupid compiler warning?
