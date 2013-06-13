From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] am: handle stray $dotest directory case
Date: Thu, 13 Jun 2013 11:40:16 -0700
Message-ID: <7vmwqtua5r.fsf@alter.siamese.dyndns.org>
References: <1371133031-28049-1-git-send-email-artagnon@gmail.com>
	<7v61xivsxh.fsf@alter.siamese.dyndns.org>
	<CALkWK0mUnNTfJQuGQAoMtnsOXvXU+z+W6D_MMuio1sq4vkucjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 13 20:40:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnCRf-0001Hq-6i
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 20:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759018Ab3FMSkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 14:40:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63961 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758890Ab3FMSkT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 14:40:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F01A25C61;
	Thu, 13 Jun 2013 18:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PL+fVFMHUspKwkCFYwn5h9GnYag=; b=nZkuOl
	WxJNYJ6N7gjUPl0zU7FpR9sRnIjYPvzYCDJ2A9fvlL6rkl9x6Gst3G1ZxVLaM2mx
	9CFQsUJlXAwCI5PoZG98FXEwPGxru6V3Cl9j63fVFt/s7xacNv6031SBdaLVV6f7
	+qaorOPNan4Tkh6SKcKYhOzNxC/g6fmw6EKdY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vGfQFtBKNRKF4YhRobOX9VqPdspxZNzX
	IotLqDpC/xj61v7thKQ7FwVTLmp3E8JcppjpVZJhBHxh1MtQieC1khYxJIMCEo2O
	qkRKfAbtfbarKXAQ9QoDOKQagL3H96wJEwWBuxxo+zbcl37yfDT+kLA3RA1ZPmqj
	C8FwG06hIDg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6394A25C5E;
	Thu, 13 Jun 2013 18:40:18 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BB11525C5C;
	Thu, 13 Jun 2013 18:40:17 +0000 (UTC)
In-Reply-To: <CALkWK0mUnNTfJQuGQAoMtnsOXvXU+z+W6D_MMuio1sq4vkucjA@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Thu, 13 Jun 2013 23:03:56 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B1AE8E28-D458-11E2-B799-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227771>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> Perhaps _that_ guarding condition is what needs
>> to be fixed, by reverting it back to just "does $dotest exist?"
>>
>> Adding a single case workaround smells like a band-aid to me.
>
> Like I pointed out earlier, the original codepath is not equipped to
> handle this case.  A "normal" git am --abort runs:
>
>   git read-tree --reset -u HEAD ORIG_HEAD
>   git reset ORIG_HEAD

Hmph, when did ORIG_HEAD set, and what commit does it point at?

As "git am" reading from stdin, waiting, hasn't moved HEAD yet at
all, I think two things need to happen to fix that:

 (1) at around the call to check_patch_format and split_patches,
     clear ORIG_HEAD (this may have to be done only !$rebasing,
     though).

 (2) safe_to_abort() should make sure ORIG_HEAD exists; otherwise it
     is unsafe.

But that is entirely an independent issue (I am going to agree with
you in the end).

> blowing away the top commit in the scenario you outlined.
>
> This happens because that codepath incorrectly believes that an am is
> "in progress".  What this means is that it believes that some of the
> am code actually got executed in the previous run, setting ORIG_HEAD
> etc.  In your scenario
>
>   % git am
>   ^C
>
> nothing is executed, and a stray directory is left behind.

That is a correct observation.  But it needed a bit of thinking to
reach your conclusion that special casing this and handling --abort
in a new different codepath is the right solution.

> If anything, I think the check for $dotest/{next,last} has made the
> code more robust by correctly verifying that some code did get
> executed, and that an am is indeed in progress.  The bug you have
> outlined is equivalent to:
>
>   % mkdir .git/rebase-apply
>   % git am --abort

Yes.  Or a previous "git am" run lost "$dotest/last" by a bug and
then the user asked to "am --abort".  Either case, the best you can
do is probably to blow away .git/rebase-apply directory.

How would "am --skip", "am --resolved", or "am anothermbox" behave
in this "we already have $dotest because the user started one
session but killed it" case, which used to be covered by -d $dotest
alone but now flows to the other side of the if/else/fi codepath?
Do they need a similar treatment, or would they naturally error out
as they should?
