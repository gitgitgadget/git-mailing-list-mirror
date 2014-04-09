From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Change update_refs to run a single commit loop once all work is finished.
Date: Wed, 09 Apr 2014 11:06:01 -0700
Message-ID: <xmqqmwfu1ipi.fsf@gitster.dls.corp.google.com>
References: <1396999284-4691-1-git-send-email-sahlberg@google.com>
	<1396999284-4691-4-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Brad King <brad.king@kitware.com>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 09 20:06:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXwtA-0007uW-5a
	for gcvg-git-2@plane.gmane.org; Wed, 09 Apr 2014 20:06:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934240AbaDISGN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2014 14:06:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57883 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932908AbaDISGG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2014 14:06:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 380D679301;
	Wed,  9 Apr 2014 14:06:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DOowhHv42qXC8w+yWa/jNbN7VUw=; b=q53Re/
	IgC4vWrxGqfBvUkTjQ/5MU/82AYE4/ThttDPkvQH7dvgPhxLNd7IIDFbnPxpcnkf
	lGbhW9csPUVw+zChGDDzkQDIIR2/hidUOSreAjudfLRMIDEBS3qsOB2bL7lKcGkx
	Yitv2BKfsB2cvnVyEtNsKL0/zfl4X8gqMyZmw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H58Dv1KNvl8RO4/PMOM/j4XVs88kF/kp
	xPTpEPx5bgS12QpaZGnWE6AjEc1EA9zcZ1g8/kucreuWBNfM1SswSmCIfe7a6V03
	gksH4UnucymmwNXbw3Iqg+rPmzmNDTDj9Ouem+urBg/GsZsWl+Cs72tNMPIHqmzJ
	eiBTqc/YbEw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20ED079300;
	Wed,  9 Apr 2014 14:06:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5EFBA792FF;
	Wed,  9 Apr 2014 14:06:03 -0400 (EDT)
In-Reply-To: <1396999284-4691-4-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Tue, 8 Apr 2014 16:21:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9D1ABFB8-C011-11E3-BA6D-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245984>

Hopefully Michael would respond with more in-depth reviews as he has
been touching this area heavily recently, but a few comments.

> Subject: Re: [PATCH 3/3] Change update_refs to run a single commit loop once all work is fi

The project convention is to prefix with the "<area>", colon, SP, a
sentence starting with lowercase, without the final full stop, e.g.

  Subject: [PATCH 3/3] refs.c: make update_refs() update and delete in a single loop

or something like that.

Ronnie Sahlberg <sahlberg@google.com> writes:
>  
>  	/* Perform updates first so live commits remain referenced */

This comment, and the matching comment on the deletion loop below
you removed, are curious, aren't they?

These blame down to 98aee92d (refs: add update_refs for multiple
simultaneous updates, 2013-09-04) where it says:

    Though the refs themselves cannot be modified together in a
    single atomic transaction, this function does enable some useful
    semantics.  For example, a caller may create a new branch
    starting from the head of another branch and rewind the original
    branch at the same time.  This transfers ownership of commits
    between branches without risk of losing commits added to the
    original branch by a concurrent process, or risk of a concurrent
    process creating the new branch first.

My reading of the above is that the user can do an equivalent of
"moving" an existing ref A to a new ref B (and want to see A
disappear in the end), and do not want that to be turned into this
sequence of events:

    $ git update-ref --stdin                $ git gc
    delete A
			                    starts without seeing neither A nor B
    create B
					    finishes, the object was not referenced
					    and excluded from the pack

And the approach 98aee92d took to avoid the above sequence was to
create/update before delete.

It is possible that the particular approach to protect such an
object at the tip of old A is not such a good one and is not
necessary [*1*], but it needs to be justified in the log message.
Also the stale in-code comments need to be updated (or removed).

Thanks.


[Footnote]

*1* For example, you can argue that the user can use two "git
update-ref" back to back to first delete and then create, or the
user is doing "git add" of many paths without yet creating commits
or writing out the final index file, hence having many young loose
objects that are not referenced from anything, and we designed these
use cases to be safe enough by teaching gc not to prune young loose
objects, and that same grace period in gc may make the above "delete
then create" safe enough.
