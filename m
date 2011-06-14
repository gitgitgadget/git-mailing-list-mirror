From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge: Preserve ORIG_HEAD if already up-to-date with
 remote.
Date: Tue, 14 Jun 2011 16:14:28 -0700
Message-ID: <7vy614j99n.fsf@alter.siamese.dyndns.org>
References: <1307950525-8011-1-git-send-email-kunal.gangakhedkar@gmail.com>
 <1307950525-8011-2-git-send-email-kunal.gangakhedkar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kunal Gangakhedkar <kunal.gangakhedkar@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 01:14:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWcom-0001MD-GO
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 01:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089Ab1FNXOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2011 19:14:32 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40584 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751686Ab1FNXOb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 19:14:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8E36752EE;
	Tue, 14 Jun 2011 19:16:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/+pbBHSQYguTKi4hymdBJj59b78=; b=oAKnYZ
	Wj3dN0BTdk20knoKNLGXvM3TixJO2RuodJe3F9n7xcegL2bSRmNu49/uh8svjrks
	5YlFQIf1Pc0p4ykIXSJb8M5FJscKkO/i5xPYQp/sqVtLEeEAsLEaP0fIg3y8iEVe
	cCc+/DXmZzQ/iLR1/fgA2f3JjjgbsWNo1JHMk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gPj7LyKSjMWWvx3UW+VCS3kvHFbXaLHT
	+We9lDxn9z0MIKKrQzDj0mCzrNF9LhxkSqCVs03CanSroFhGyqAyiIhsiUpID4Jm
	JZwkPGwvhhsXLZCeYUAUos0mNjDhBHPshbMSuFTqJpRcqJ+LgioFJk9OXKGcd+kB
	l3fcq757EG4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 85F4652ED;
	Tue, 14 Jun 2011 19:16:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B30A652EC; Tue, 14 Jun 2011
 19:16:40 -0400 (EDT)
In-Reply-To: <1307950525-8011-2-git-send-email-kunal.gangakhedkar@gmail.com>
 (Kunal Gangakhedkar's message of "Mon, 13 Jun 2011 13:05:25 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5C58EA7E-96DC-11E0-A381-2C88C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175802>

Kunal Gangakhedkar <kunal.gangakhedkar@gmail.com> writes:

> Do not update ORIG_HEAD ref to current HEAD if the repo is already
> in-sync with the remote.
>
> Otherwise, it becomes difficult to keep track of last set of changes.
>
> With this patch, it's possible to do a diffstat/log for last set of
> changes even after a pull/merge that returns 'Already up-to-date'.

I am not sure what you mean.  If you are behind remote A and remote B is
behind remote A, i.e.

	You -- (fast forwards) --> B -- (fast forwards) --> A

then you should be able to expect these:

	: point zero
	$ git pull A
        $ git diff/log ORIG_HEAD.. ;# shows how your tree and history
        			    # are updated wrt point zero above
	: point one
	$ git pull B
        $ git diff/log ORIG_HEAD.. ;# shows how your tree and history
        			    # are updated wrt point one above

If your patch is to stop recording ORIG_HEAD for the second "git pull"
above, I fail to see how that could be a good change.

If you want to drive "pull" from a script (e.g. cron) and want to have
precise control of what happens depending on how HEAD is updated, your
script has enough freedom and flexibility to do so before running "pull",
I think.  E.g.

	. $(git --exec-path)/git-sh-setup

	CURRENT=$(git rev-parse HEAD^0) || die "Eh? No Head?"
        git pull || die "pull fails"
        UPDATED=$(git rev-parse HEAD^0)
        if test "$CURRENT" = "$UPDATED"
        then
		exit 0; # nothing happened
	fi
	git shortlog --no-merges $CURRENT..$UPDATED
        git diff --stat --summary $CURRENT..$UPDATED
