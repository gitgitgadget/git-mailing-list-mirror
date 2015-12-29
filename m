From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git stash pop" is doing an unwanted "git add" when there are conflicts.
Date: Tue, 29 Dec 2015 11:04:20 -0800
Message-ID: <xmqq37ulhya3.fsf@gitster.mtv.corp.google.com>
References: <20151221142953.GA12764@acm.fritz.box>
	<1450772258.7937.9.camel@kaarsemaker.net>
	<20151222093032.GA5173@sigill.intra.peff.net>
	<20151224092038.GA2397@acm.fritz.box>
	<20151229075329.GA9254@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Alan Mackenzie <acm@muc.de>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 29 20:04:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDzZO-0002DN-KF
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 20:04:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753826AbbL2TE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 14:04:26 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54594 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753658AbbL2TEX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 14:04:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4069637EE8;
	Tue, 29 Dec 2015 14:04:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WIy6lj9EYNSpR7Tn9RtwBPCRW6Y=; b=TeOfs3
	jwmyQl+es9cip9p6oKxu1YASJNVWEFkpE4VVvMbdrjOG9q3WI+hi8B2smAWR7inz
	VwGD3tZCpIBg0yNxOLSZe2fgoQjx9Jp14Rn2PiiDOBGzqceexQ2OtKMNcWVULqev
	xfWQi7nShKt7943p+fDZXiVbfaSnF5+tZ+SaM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JXVLhGI2ljMzeX0O1OiBWhO4olw+KrVi
	UVFF9arAFjb4/iBgVpQERRVKp0e00yiTRgtc5pEwVAm2HDVl2NO4W8MZKNXh0dAw
	84mW8Xsf37q/+RImQIC6T2+KYzbFG5tQgPwcdovtVesHfdGcMPW6gnU45Pfh2eiC
	+U4eR6o7K/E=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3826237EE7;
	Tue, 29 Dec 2015 14:04:22 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AB22337EE6;
	Tue, 29 Dec 2015 14:04:21 -0500 (EST)
In-Reply-To: <20151229075329.GA9254@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 29 Dec 2015 02:53:30 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F818134C-AE5E-11E5-A5CA-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283144>

Jeff King <peff@peff.net> writes:

> Yeah, I think I agree. But keep in mind that we have to mention the
> conflicts _somewhere_, so we're going to touch the index regardless (and
> the user is going to have to erase the conflicts in the index
> eventually, either with `git add` or `git reset`).

I do not think there is much we can do at this point in time (but
notice that I did say "much", and didn't say "anything").

The way we replay any potentially conflicting change and present the
result to the end user in Git is uniformly to add the cleanly
applied parts to the index while leaving the conflicted ones as
unmerged index entries, but "git stash apply/pop" does not follow
this pattern.  I think this is partly because the command is also
used to "stash away" a work-in-progress changes to the index, and
avoiding to touch the index with the changes in the working tree
would more closely match the behaviour of the command when there is
no conflict.

I notice that I said the same thing long time ago, i.e. in the
initial round of review:

  http://article.gmane.org/gmane.comp.version-control.git/50749

| However, I think it is a bit counterintuitive to update the
| working tree change to the index if the merge did not conflict.
| It might be better to run an equivalent of "git reset", so that
| after "git save restore", the user can say "git diff" (not "git
| diff HEAD") to view the local changes.  Perhaps...

In the above, I suggested to "git reset" when there is no conflict.
I think this line of thinking can be followed even further to
selectively reset the paths that were cleanly merged (which is added
by the call to merge-recursive), leaving _only_ the conflicted paths.

Would that give us a better outcome?  I dunno.

>> Are there any prospects of this getting fixed?
>
> Somebody needs to write a patch. I am not 100% convinced that it
> _should_ be fixed, but I am leaning that way. But I am not planning to
> work on it myself anytime soon. The best way to get more discussion
> going is to post a patch. :)
