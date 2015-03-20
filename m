From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why is "git fetch --prune" so much slower than "git remote prune"?
Date: Fri, 20 Mar 2015 00:04:42 -0700
Message-ID: <xmqq7fucgned.fsf@gitster.dls.corp.google.com>
References: <CACBZZX5n5tTCSa-_A5gQzbzboF_v8a3_oVUjdjyFtKHHe8h-NA@mail.gmail.com>
	<20150306225917.GA1589@peff.net> <550AE1E4.7020407@alum.mit.edu>
	<xmqqpp84iye2.fsf@gitster.dls.corp.google.com>
	<550BA76C.80501@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jay Soffian <jaysoffian@gmail.com>,
	=?utf-8?Q?Bj=C3=B6rn?= Gustavsson <bgustavsson@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Mar 20 08:04:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYqzD-0002al-3w
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 08:04:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbbCTHEr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 03:04:47 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59520 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750935AbbCTHEq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 03:04:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 76F0C3BD60;
	Fri, 20 Mar 2015 03:04:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q6MAAXXeP7qOwAUjnYkQZbpeZSs=; b=rameli
	5dfplvZSX+hWIWxGJHxNcoPKESUOZqDW/ppR8iUFdHVmUQ9Xey/mJpIn+zWiMm8l
	xXfLGhH3iPE9oyTtkBQil+yOjpP5bD9l13/wI17VQHPqwptNWjtAj2+0QqEtc9q3
	fmeE39VplikUdoQYgwbxA4NSu+qy29YXPTZbg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LIX+mgJ5pLvMjHd1tpsOtnz8TM77L4cD
	dS91x/wXWay4iGPnCw2tIkNnJVQwEBuP5VsT9Vv6jvzkhKp5lFyWOaJrTx1tFN6l
	+HpLtJdIwn3rsHVh5cALjQOFK/9eoFWptIj15zzu8S2xzGIpfeS9Fsj95IKpKFkt
	pCp5kTK2fjY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E4423BD5F;
	Fri, 20 Mar 2015 03:04:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C66DB3BD5D;
	Fri, 20 Mar 2015 03:04:44 -0400 (EDT)
In-Reply-To: <550BA76C.80501@alum.mit.edu> (Michael Haggerty's message of
	"Fri, 20 Mar 2015 05:51:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6363FF32-CECF-11E4-8451-FAE19E42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265865>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> The lock conflict scenario is the only one that really worries me.

Actually, I'd feel worried if this were on the receive-pack side, as
it is entirely valid that two or more people make uncoordinated push
into a single meeting point, but much less for something like
"fetch".  I do not see a valid reason why somebody cannot avoid
fetching into the same repository in a racy way.

> But I don't think it is *so* hard to keep the current "best-effort"
> behavior.

I agree that transaction is a wrong way to look at this.  I view "We
know packed refs is a lot more efficient if written once" as in the
same category as "We know we will register many new objects with
this operation, so instead of creating them into separate loose
object files, declare that the object store is 'plugged' and send
them into a single new packfile" (aka "bulk checkin").  Both are
uninterested in all-or-none execution, but merely want to declare a
boundary between a group of operations to help Git optimize them.

> I am working on a function delete_refs() for the reference API
> that deletes a bunch of references on a "best effort" basis, reporting
> per-reference errors for any deletions that fail.

I think it would make sense, but I suspect you would want to make it
clear that the function is best-effort-bulk somewhere in its name
(e.g. delete-refs-if-able or something) and make it not to
automatically fail the surrounding transaction if any.  That way
an application could do things like this:

    transaction-begin;
      create-ref;
      update-ref;
      ...
      delete-refs-if-able;
      if trying to be as atomic as possible
      then
	if previous delete-refs-if-able found undeletable refs
        then
          transaction-abort;
	fi
      fi
    transaction-commit;

Of course, supplying delete-refs that is not best-effort separately
would make it even easier to code the above (the last if/then/fi will
become unnecessary).
