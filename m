From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] log: pass rev_info to git_log_config()
Date: Thu, 04 Oct 2012 00:05:29 -0700
Message-ID: <7v1uhe3efa.fsf@alter.siamese.dyndns.org>
References: <7v626r48cv.fsf@alter.siamese.dyndns.org>
 <1349314419-8397-1-git-send-email-gitster@pobox.com>
 <1349314419-8397-6-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 00:31:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtTg-0001w8-Ju
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:01:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197Ab2JDHFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 03:05:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47747 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755563Ab2JDHFg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 03:05:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D0FD6BF9;
	Thu,  4 Oct 2012 03:05:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nMmHZTwtI6VaidZMs8yBSgRE7Kk=; b=FMPJTX
	fCGI4IXQUEhe/lBRurxoNwiC7Q8dFc0SWGWoxutZf7iUxPpu9///aiDghqO7orAZ
	ilEXsMNruPcIEMBPRpXQzj3ihNQ7S9f8bDGq3sGY6fd+iovBxoOWwmuCfIg7e0MF
	fJgoxpBYMp91Q+TUf5ciHU4OCq8ti36gCR9Wc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Sa1PPydnAiRl88yDj7syKfNy2+xN+o7S
	wwyeLNMn1LdxkvMxsMSo/O6s84g3ObAvQKOcJiKkzYu5w4iKvZvMukEw+VktfEtN
	AHxGLResY6tLf3GEvFriD41FitfJKPdiGcL/E6NO32AmApAdrvBlierrTOJ5dDwK
	932PlfHvlYk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 364DE6BF8;
	Thu,  4 Oct 2012 03:05:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B967A6BF7; Thu,  4 Oct 2012
 03:05:33 -0400 (EDT)
In-Reply-To: <1349314419-8397-6-git-send-email-gitster@pobox.com> (Junio C.
 Hamano's message of "Wed, 3 Oct 2012 18:33:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E3FA910C-0DF1-11E2-A15B-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207007>

Junio C Hamano <gitster@pobox.com> writes:

> Call init_revisions() first to prepare the revision traversal
> parameters and pass it to git_log_config(), so that necessary bits
> in the traversal parameters can be tweaked before we call the
> command line parsing infrastructure setup_revisions() from
> the cmd_log_init_finish() function.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * This is made separate from the next one that touches the contents
>    of "rev" to make sure the existing code does not depend on the
>    current initialization order.  I do not think it does but better
>    be careful to keep the history easier to bisect, than be sorry
>    when an issue does appear.

And I was right X-<.  This does break the assumption the recent
diff.context series makes.

What happens is that

    - init_revisions() initializes revs->grep_filter; that is why this
      patch wanted to call it first, so that it can futz with it
      from git_config().

    - however, init_revisions() also calls diff_setup(), and the
      diff machinery initializes revs->diffopt->context from
      diff_context_default.  Compiled in default of this value is 3,
      but the diff.context series wants to update this variable with
      the configuration before this call happens.

So we would need to do something like:

    - call git_log_config() first to let diff_context_default
      updated from the configuration as before.  find the values of
      grep.* defaults at the same time, but stash it away in a
      separate "struct grep_opt" (yuck);

    - call init_revisions() and let it initialize revs->grep_filter
      and revs->diffopt as before;

    - copy the grep.* defaults we learned during git_log_config() to
      revs->grep_filter.

which is a bit yucky, but survivable.

I'll fix these two patches up later.
