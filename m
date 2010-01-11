From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 9/9] rerere forget path: forget recorded resolution
Date: Sun, 10 Jan 2010 17:58:12 -0800
Message-ID: <7v4omte72j.fsf@alter.siamese.dyndns.org>
References: <1262122958-9378-1-git-send-email-gitster@pobox.com>
 <1262122958-9378-10-git-send-email-gitster@pobox.com>
 <201001082255.51499.j6t@kdbg.org> <7vpr5krxoo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Jan 11 02:58:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NU9Y0-00078e-H2
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 02:58:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752615Ab0AKB6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2010 20:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752371Ab0AKB6U
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jan 2010 20:58:20 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37206 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292Ab0AKB6T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2010 20:58:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C0CB8F812;
	Sun, 10 Jan 2010 20:58:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bQDBaoP5czfBFz8UixkkKC1Qb38=; b=sQNAaA
	oaItu2+tHgv1vODJzb5kGyMnHHWEOQ6JhEacJqtTyPZRes5QVfvxZ9zqppRg/1nr
	jCf9C5/oqFLAAD30pm4E4pmrk1Sbny7D7oIEHPhVJP3KwmU0hAWMqnnJhRATNue1
	YxccQRGp5CU4290P7mRDf9ZHQ+aVoI+Erhl6M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TDMtMDSRI17uJk9rlLeyx5HRWUydOutt
	mw3xjOHx/7wDHVzntsJnj8WjRFzYb/w7kCcl/mfAW937AUTHPtzqJHcgW7d3voMx
	hSTwmDBjYS94sSzotHsXFGF+0A+JsmwymP7VFfrvWiSaYZFawf3dXD9W8WAjil/y
	f3iWTzGWhXs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BD6B8F80E;
	Sun, 10 Jan 2010 20:58:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D0FC68F80C; Sun, 10 Jan
 2010 20:58:13 -0500 (EST)
In-Reply-To: <7vpr5krxoo.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri\, 08 Jan 2010 15\:20\:23 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C8A6F4CC-FE54-11DE-8889-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136595>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Sixt <j6t@kdbg.org> writes:
>
>> Your implementation forgets to re-insert the forgotten resolutions into
>> MERGE_RR, therefore, the next 'git rerere' does not record the new
>> resolution.
>>
>> In my implementation of 'rerere forget', I had the following tests.
>
> Please filfre to roll a patch that adds the tests and code that inserts
> necessary MERGE_RR entries, if the feature is pressing; unfortunately I
> don't think I will have much git time during the coming weekend.

I ended up doing this myself.  As we are dropping the postimage and adding
a new MERGE_RR entry, I also think that it is safer to update the preimage
with the conflict we got for this round, so I added that as well.

However, I think there is a room for improvement in preimage handling.

Currently, the rerere database is indexed with the conflict hash and for
each conflict hash you can record a single preimage-postimage pair to
replay.  But you can have conflicts with the same conflict hash, but with
slightly different contexts outside the conflicted region, and the right
resolution can be different depending on the outside context.

In the traditional implementation, I punted this issue by noticing
conflicts in the three-way merge between pre, post and this images.  If
preimage is too different from the conflicted contents we got during this
merge, then the previous resolution should not apply.

But I think the right solution would be to have more than one preimage and
postimage pairs (preimage.0 vs postimage.0,... etc.) and try to use each
of them in handle_path() until it finds one that can be used to cleanly
merge with the conflict we got in thisimage during this round.
