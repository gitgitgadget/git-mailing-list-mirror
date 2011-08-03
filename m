From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v15 7/7] bisect: add documentation for --no-checkout
 option.
Date: Wed, 03 Aug 2011 13:59:00 -0700
Message-ID: <7v62meb4a3.fsf@alter.siamese.dyndns.org>
References: <1312383811-7130-1-git-send-email-jon.seymour@gmail.com>
 <1312383811-7130-8-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, gitster@pobox.com,
	j6t@kdbg.org, jnareb@gmail.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 22:59:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoiX0-0003zR-HY
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 22:59:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754681Ab1HCU7F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 16:59:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39390 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754516Ab1HCU7D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 16:59:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 67C2D5B59;
	Wed,  3 Aug 2011 16:59:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vpPdtUrjhLFMcyDVhC/oTqE06eQ=; b=fD7LkC
	8PJBM9OYA3UUwso0b7uqllMqEtrMYxDJxXF6XIrPEsLOHJBIWvYqoEFI07VBmTOA
	BaqwdV98nlXycFV+D2mxzbAQtnrs9+u1k0g9szYYiJ3yFgKUI/ZBb+VwOKvQCK3h
	Ha6jVzYTHfJcSLkv28WQH3ax/En5E4J4aOqAU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wmX/Mrsi7Fr/Ppm5SQCnNZoAIu0cBPcG
	5uSn5A/nxPvFW0/zmZ7xpMObo4pM8cUKwkd+7Q/pgW0EWDgE40Hvfh+fTh92WYz7
	FQp3FRMsTVMbivlUl+AuKUSq+LKgjWOAQKpobekAN0loh2WDQnjjPWoxrTZ+nAQp
	iYzdIAUK9CI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 566BD5B58;
	Wed,  3 Aug 2011 16:59:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A2A445B56; Wed,  3 Aug 2011
 16:59:01 -0400 (EDT)
In-Reply-To: <1312383811-7130-8-git-send-email-jon.seymour@gmail.com> (Jon
 Seymour's message of "Thu, 4 Aug 2011 01:03:31 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6A451B04-BE13-11E0-B489-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178618>

Jon Seymour <jon.seymour@gmail.com> writes:

> +This option is useful in circumstances in which checkout is either not
> +possible (because the repository is damaged) or is otherwise not required.

I do not think "because the repository is damaged" is a particularly good
example to single out here. For one thing, you may not be able to bisect
the history in a damaged repository due to unreadable commits. There are
other valid and more plausible reasons that the users do not want to
update the working tree while bisecting, e.g. they have local changes,
they do not want to rebuild everything after bisection is done, etc.

Also the above description muddies what is prerequisite and what is user's
wish.

 - "is otherwise not required" is the prerequisite: "if and only if the
   test you would perform during bisection does not need a checkout of the
   version being tested, you can use this option";

 - Even if the user wishes to use this option for various reasons (e.g. so
   that the next "make" wouldn't have to rebuild everything unnecessarily;
   or the repository has corrupt blobs and checkout of some versions may
   fail), if the test _needs_ a checkout, it is not an option to use this
   feature.

So I would suggest toning it down perhaps like this:

    This option may be useful when the test you would perform in each step
    does not require a checked out tree.

> +$ git bisect run eval '
> +rc=1;
> +if git rev-list --objects BISECT_HEAD >tmp.$$; then
> +   git pack-objects --stdout >/dev/null < tmp.$$ && rc=0;
> +fi;
> +rm tmp.$$;
> +test $rc -eq 0;'

Hmm, "eval"?

More importantly, aren't these excessive and unnecessary semicolons
unsightly?

	$ git bisect run sh -c '
                git rev-list --objects BISECT_HEAD >tmp.$$ &&
		git pack-objects --stdout >/dev/null <tmp.$$
                rc=$?
                rm -f tmp.$$
                test $rc = 0'

> +In this case, when 'git bisect run' finishes, bisect/bad will refer to a commit that
> +has at least one parent whose reachable graph is fully traversable in the sense
> +required by 'git pack objects'.

Also "everything reachable from BISECT_HEAD" feels unnecessarily
wasteful. By the time you invoke "bisect run", you already know one good
commit, everything reachable from which are known to be good.
