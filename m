From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Strange O(N^3) behavior in "git filter-branch"
Date: Fri, 15 Jul 2011 11:51:49 -0700
Message-ID: <7vlivz1inu.fsf@alter.siamese.dyndns.org>
References: <4E1E97C3.3030306@alum.mit.edu> <4E1EB5E9.1070902@alum.mit.edu>
 <4E200611.9010005@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Jul 15 20:51:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhnUT-0007XH-KQ
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 20:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754382Ab1GOSvw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 14:51:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35264 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754296Ab1GOSvv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2011 14:51:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 690433F05;
	Fri, 15 Jul 2011 14:51:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9k5no29M7nEAR5YcG0sHS0326WA=; b=GEOmwl
	SBCeOhP8g6ImS/GEThydaNr2pkssiEp4i1kO9jztrA0i0b952jVRReU1PTy6aJ8G
	RZbrT3WwalekAhybCTbnzfcpzb8LB575XUKhzIWjxFDYIQXab3pGuH0nb0ao2eYu
	cX6ddp9Z3gXR3keURcvJYHRQXOGiy41qv9iNk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xwuUfLcgSjGuCQqtScvCg2l06qIxoe/9
	vyAzIpN3X3DTNy4FxhDQ1c8ZcQYEsBBOLfb90W71t/sGIsEzY5Qm5NQqMKX3c8zx
	XPFPWSWd6sl6GczhSzV4skXhXIZfZlBBLL7bIJfRNlo7vupl5o0qDjGn9Xx+RvTY
	5vn+NGl/W5U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 609053F03;
	Fri, 15 Jul 2011 14:51:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C6A4F3F02; Fri, 15 Jul 2011
 14:51:50 -0400 (EDT)
In-Reply-To: <4E200611.9010005@alum.mit.edu> (Michael Haggerty's message of
 "Fri, 15 Jul 2011 11:19:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 80063298-AF13-11E0-B6CE-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177210>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> 1. Change git-filter-branch (and any other long-running commands?) to do
> an initial check for the presence of replace references (packed or
> loose), and if there are none, set GIT_NO_REPLACE_OBJECTS automatically.
>  This would of course fail if any of the user's scripts try to set up
> replace references.  (Side note: perhaps the git-replace command should
> complain if GIT_NO_REPLACE_OBJECTS is turned on?  It would almost always
> indicate a mistake.)  It also wouldn't help in repositories that *have*
> replace references.

In the short term I think this makes sense, as the whole point of using
filter-branch in a repository that has grafts and replacements is so that
the resulting history won't have to look-aside into grafts and replace
information.

But I think the replace-object codepath should be optimized to realize
there is no funky replacement (which _is_ a rare configuration) going on
much early so that it does not incur that much overhead you observed. IOW,
I tend to agree with your 3. below.

> 2. Add an option to git-filter-branch to have it pack references
> occasionally.

Doesn't the code already do this via "git gc" though?

> 3. Optimize the specific case where there is no refs/replace
> directory--if this directory is missing, then defer populating the loose
> refs cache in the hope that it will never be needed.
