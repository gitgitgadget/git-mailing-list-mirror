From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How does Git's maintenance policy handle topics that don't start
 from "master?"
Date: Tue, 29 May 2012 14:29:23 -0700
Message-ID: <7vbol63ccs.fsf@alter.siamese.dyndns.org>
References: <m21um2682e.fsf@Spindle.sehlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Steven E. Harris" <seh@panix.com>
X-From: git-owner@vger.kernel.org Tue May 29 23:29:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZTyt-0008JV-9z
	for gcvg-git-2@plane.gmane.org; Tue, 29 May 2012 23:29:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755923Ab2E2V31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 May 2012 17:29:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52918 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755875Ab2E2V30 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2012 17:29:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC2828991;
	Tue, 29 May 2012 17:29:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vxA+gU68Zkj0NNR2UiagXkML464=; b=kcZ5Vm
	S931G4SNy+uf75rYAjcuqBF/bGejNCx2LPlenuf8vF56MsFarw2R5Shk7W2rqQJD
	XQZZ36m55QcZ3/9Wd9d6BXnvDGxMPNva8cfAFzo/JphJXWVEu6O7spGjeifMhdiG
	Fv3y7EM4ReI3WIfCNa6BY5LRqzVKZtGwoQavQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fa8yoXq1k7g+VEAnSf3uPGsPgUAO7DF0
	VAw0C9riyhfWNEI5LUXwoafJQVKc1Pen+UBSQm/KkOAI2gAB4TftvoKx2tivVUc0
	QqCYZ9FaRCSzFXl3mvcIfOA7qp8XJsjRO5qJUNRGZrgM1vS7s8xfPKrzUdzs3g4T
	NDVDL/swPBU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D091C8990;
	Tue, 29 May 2012 17:29:25 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 64DDD898E; Tue, 29 May 2012
 17:29:25 -0400 (EDT)
In-Reply-To: <m21um2682e.fsf@Spindle.sehlabs.com> (Steven E. Harris's message
 of "Tue, 29 May 2012 16:33:45 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5D2DBBFC-A9D5-11E1-828A-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198765>

"Steven E. Harris" <seh@panix.com> writes:

> What about the case where an author started his work from the "next"
> branch instead? He may have submitted an earlier batch of work that's
> still cooking in "next," and now he needs to build something else that
> can take advantage of that earlier work.

It often is clear that the follow-on topic depends on an earlier
topic branch (mostly because the contributor is aware of it and
state it in the message).  An obvious thing to do in such a case is
to create a new branch to queue that topic starting at the tip of
the earlier topic.  Note that this is never from the tip of "next",
as it is very unlikely that such a follow-on topic depends on
everything that is not in "master" yet.

Sometimes a new work depends on multiple topics that are still
cooking, and *all* of these topics that the new work depends on are
in good shape.  In such a case, I create a new branch by merging
these prerequisite topics and then queue new work there.  Obviously
the new work is taken hostage to *all* of its dependent topics, and
cannot graduate until all of the base topics graduate.

Sometimes a new work depends on one topic that is still cooking in
"next", *and* also needs updates made by other topics that are
already in "master".  You can guess what should happen---take the
tip of that topic that is still cooking in "next", merge the commit
on "master" that adds other necessary bits, and then that becomes
the base of the new topic.  The "commit that adds other necessary
bits" could be the tip of "master" (easiest for me, but it makes the
new topic unmergeable to "maint" later) or the tip of an old topic
that was merged to "master" (more work for me, but it is worth if
both the other old topic and the topic that is cooking in "next" are
meant to be merged to "maint" later, and the new work is also meant
to eventually be merged to "maint").

In a rare cases where a new work depends on millions of uncooked
topics, we simply reject the follow-on series and tell the submitter
to wait until the dust settles, but in practice it does not happen
very often.

In other words, the "policy" is not a mechanical recipe to be
followed by brainless monkeys; the integrator needs to follow the
common sense of keeping the resulting topic branch mergeable to as
many relevant contexts as necessary.

And the contributor can help in this process, as well.
