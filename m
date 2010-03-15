From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] stash: dont save during a conflicted merge
Date: Mon, 15 Mar 2010 15:14:25 -0700
Message-ID: <7vhbohdygu.fsf@alter.siamese.dyndns.org>
References: <1268451633-30046-1-git-send-email-cxreg@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dave Olszewski <cxreg@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 15 23:14:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrIYa-0005IP-Kp
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 23:14:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936960Ab0COWOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 18:14:35 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59742 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936904Ab0COWOe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 18:14:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A258BA28EC;
	Mon, 15 Mar 2010 18:14:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hUszPdjz9KPY10DbWaNk3soILNY=; b=qUFU+8
	gyO/o/oybz8yXror7sLInqCpPTaCUbWrg8UksrQ0dD7Qb4MFY5tT/a2eyZa43e26
	OFNDACQqKWecliUTW/gyIz1zY5Gd5aim1YbdVl6VuwYGkA9ttFDqAxS2hSONiHoD
	CD5yXNtex3ZqKLLX8ztz1SKTzknzcLOMgyYOo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xJ+iDUvDK/uBPjPMIrQ4sUDvZjmYcQWA
	suJ5uT47PssIG5tg4RIg48iSoKRwfycYCMMAqRnOMNywvMSy7RmCidQ0BAeK4tdR
	rRXoxasNLUA38p4joKBLwtZTit7bOom9SvJEc6ZOEPu/0GcYkZCPX44P38QqFaf8
	ESfMQbtFaKs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A69EA28E9;
	Mon, 15 Mar 2010 18:14:29 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D1C6DA28E6; Mon, 15 Mar
 2010 18:14:26 -0400 (EDT)
In-Reply-To: <1268451633-30046-1-git-send-email-cxreg@pobox.com> (Dave
 Olszewski's message of "Fri\, 12 Mar 2010 19\:40\:33 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1FF7E512-3080-11DF-96EA-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142264>

Dave Olszewski <cxreg@pobox.com> writes:

> Similar to commit c8c562a, if a user is resolving conflicts, they may
> think it wise to stash their current work tree and git pull to see if
> there are additional changes on the remote.
>
> The stash will fail to save if the index contains unmerged entries, but
> if the conflicts are resolved, the stash will succeed, and both
> MERGE_HEAD and MERGE_MSG will be removed.  This is probably a mistake,
> and we should warn the user and refuse to stash.

Warning is probably Ok, but refusing with die() might be too much.

When trying a topic with more than one integration branches (think
"master", "next, "pu"), and the merge is a bit too hairy that I am not
very confident with the resolution, I've deliberately used stash to record
a tentative conflict resolution to avoid contaminating my rerere database:

    $ git merge topic
    ... heavy conflicts, manually "resolved" to a dubious result ...
    $ git rerere clear
    $ git stash save "tentative merge of topic"
    $ git stash apply
    ... test test test ...
    $ git reset --hard
    $ git checkout another-integration-branch
    $ git stash apply
    ... test test test ...
    ... repeat the above for other integration branches ...

This is using the stash as a glorified form of

    $ git diff HEAD >./+save-tentative-merge

and then applying it to other integration branches to test out

    $ git reset --hard
    $ git checkout another-integration-branch
    $ git apply ./+save-tentative-merge

but it actually is better than diff/apply because stash application uses a
real three-way merge.

So I am not entirely happy with this feature-removal.
