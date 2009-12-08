From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC] rebase: add --revisions flag
Date: Tue, 08 Dec 2009 12:22:59 -0800
Message-ID: <7vfx7lcj18.fsf@alter.siamese.dyndns.org>
References: <20091208144740.GA30830@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 21:23:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI6ab-0003QO-A0
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 21:23:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965973AbZLHUXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 15:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965759AbZLHUXC
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 15:23:02 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51976 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965757AbZLHUXB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 15:23:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 647CA86186;
	Tue,  8 Dec 2009 15:23:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Jeyu5d2nzf9ThGOWFPLJnUOi3ow=; b=pKIdVE
	pFqkGXxRYu5upyuVhm3UT/lCKHLJkXuXGNj5wX/5dwSNt1NRsB7gYs/5/eY5y7Kl
	SR3OU1AIFpPYHJ8NhiXzk0ROtQ/ATrahwwtvqXr5dIqdhmX9xDqCk33hvxTORXAD
	iUVipr8pD22+jLFz3gxUvd1Xg+jvSR0KZyD/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g5n6IIhxYpJ4S/c4kp6dwhB8kLdZvG0h
	O2HneasDwICOH4FK3lFpPbhoumMWsE1T9WoxeLKRYem6veT8ymNf4mGZpcrKlx86
	+ChKkjUKrV3XM05LqYXa4O+NVSCYj3eTuFDvGKvdoXDtvs72XafKY5H6ZcwHmzw9
	7qkXkaThJzE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3181486185;
	Tue,  8 Dec 2009 15:23:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8AF3586184; Tue,  8 Dec
 2009 15:23:01 -0500 (EST)
In-Reply-To: <20091208144740.GA30830@redhat.com> (Michael S. Tsirkin's
 message of "Tue\, 8 Dec 2009 16\:47\:42 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7D26B212-E437-11DE-A831-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134908>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> Add --revisions flag to rebase, so that it can be used
> to apply an arbitrary range of commits on top
> of a current branch.

Many people wanted to have "pick many commits onto the current HEAD" and I
think it would be a natural, uncontroversial and welcome addition to allow
"git cherry-pick A..B".  In fact, historically, people who wanted to have
"pick many commits" complained that the "rebase" interface was backwards,
because it works in the _wrong_ direction for _their_ usecase.  Of course,
when you _are_ rebasing a branch on top of some other branch, the way
"rebase" currently works is the _right_ direction.

But I think it is a reasonable thing to _implement_ the feature to
range-pick commits reusing the sequencing logic already in "rebase" and
"rebase -i".  That essentially is what we wanted to do with "git
sequencer" that would be a sequencing logic backend shared among rebase,
cherry-pick, and perhaps am.

So perhaps a good way to move forward is to teach "git cherry-pick A..B"
to be a thin wrapper that invokes a new hidden mode of operation added to
"rebase" that is not advertised to the end user.

I would suggest calling the option to invoke that hidden mode not
"--revisions", but "--reverse" or "--opposite" or something of that
nature, though.  It makes "rebase" work in different direction.
