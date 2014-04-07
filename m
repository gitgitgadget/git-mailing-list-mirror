From: Junio C Hamano <gitster@pobox.com>
Subject: Re: notes.rewriteRef doesn't apply to rebases that skip the commit
Date: Mon, 07 Apr 2014 14:33:06 -0700
Message-ID: <xmqqzjjwlt9p.fsf@gitster.dls.corp.google.com>
References: <99F95780-059D-4F62-A851-C43729BB9893@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: gitList list <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Mon Apr 07 23:33:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXHAR-0001Ys-SZ
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 23:33:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755261AbaDGVdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 17:33:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46306 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753119AbaDGVdR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2014 17:33:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B73F7BFD0;
	Mon,  7 Apr 2014 17:33:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ktea2Ot3OKKnPxDrUhopTImlbqM=; b=o5HMBf
	XE5PRrDQ44V32aTSo4NzNfCOP7CotkozS9L+f3svP/N5A+lgA1TQ9cl3NJ/jTLFX
	+XnlBMAt3v3hDQUwQ+zNuE+5BQdIKJHuiqaXs7rBl42iWmBMftOlcPmRnDIRMRo3
	hEWJrZaDW40hsOB6oi/YzAe87Hf78Kj+Bwykw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kTCdB1KOxty3UDyn4x/SsoDTstLdhrxe
	FhH4ctxjvHoCCtsmzDLllQCEuvRGUvBEsTWhzAC8jJdosv1ov1gNaO/UpVmLRVhJ
	FabK+odSn20WKugmde+UT6xpHyeJGjFZX946AxDAQhNXyxG/KPGHLSw4HqTJRTHB
	Bn3ZHdUjsHA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8820F7BFCF;
	Mon,  7 Apr 2014 17:33:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 383467BFCC;
	Mon,  7 Apr 2014 17:33:08 -0400 (EDT)
In-Reply-To: <99F95780-059D-4F62-A851-C43729BB9893@sb.org> (Kevin Ballard's
	message of "Mon, 7 Apr 2014 13:26:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 360F6B00-BE9C-11E3-A37C-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245905>

Kevin Ballard <kevin@sb.org> writes:

> I’ve started using notes recently, and I have notes.rewriteRef set so that
> when I rebase, my notes will be kept. Unfortunately, it turns out that if a
> rebase deletes my local commit because it already exists in upstream, it
> doesn’t copy the note to the upstream commit. It seems perfectly reasonable to
> me to expect the note to be copied to the upstream commit, as it represents
> the same change.

That would cut both ways, depending on the use case.  I suspect that
those who use notes as remainder of what are still to be sent out
would appreciate the current behaviour.

> One complication I can see is when my local commit is deleted not because it
> exists upstream, but because it ends up being an empty commit due to the
> changes existing across multiple upstream commits. In this case I see no
> alternative but to have the note disappear. But I think that's acceptable.

Oh, no question about that.

> Another potential issues is if the commit exists upstream, but the surrounding
> context has changed enough that it contains a different patch-id. In this
> case, I would want Git to take the extra effort to correlate the upstream
> commit with my local one (it has the same message, modulo any Signed-Off-By
> lines, the same authorship info, and all the - and + lines in the diff are
> identical).

That would be an orthogonal improvement, I would think.  Such a
smarter "patch-id may mistake it, but it is a moral equivalent"
detection would not only be useful for copying notes, but also for
skipping the commit from getting replayed in the first place, no?

> On a semi-related note, I don't see why Git should be warning about
> notes.displayRef evaluating to a reference that doesn't exist. It doesn't
> exist because I haven't created any notes for that ref in this repository yet.
> But that doesn't mean I won't be creating them eventually, and when I do I
> want them to be displayed.

That also cuts both ways. I think a warning is primarily to let
those who mistyped the refname take notice.
