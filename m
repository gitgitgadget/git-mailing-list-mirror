From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-merge segfault in 1.6.6 and master
Date: Thu, 21 Jan 2010 10:12:31 -0800
Message-ID: <7viqavs4xc.fsf@alter.siamese.dyndns.org>
References: <hj7abm$5vc$1@ger.gmane.org>
 <7vocko3802.fsf@alter.siamese.dyndns.org>
 <4B577C3F.7040608@brooklynpenguin.com>
 <7vtyugzabq.fsf@alter.siamese.dyndns.org>
 <4B5882BD.3090908@brooklynpenguin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Miklos Vajna <vmiklos@frugalware.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Tim Olsen <tim@brooklynpenguin.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 19:12:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY1WT-0007yK-V2
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 19:12:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754842Ab0AUSMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 13:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754827Ab0AUSMo
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 13:12:44 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51477 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431Ab0AUSMo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 13:12:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B1148911C1;
	Thu, 21 Jan 2010 13:12:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eOECcCZ2Wqvto43tFcDuCMjX/GQ=; b=fQx/G/
	KmNCe2HM3m6o07/lyAwrJQ56BMtBjzYWlziV/Z47H0XWNXJv71Tl0j1MG5/tFLfc
	/UdZvEXNkpZxy4XCxlCWNK/7+rgdxP7l3VGBMm3L2x9ipmarVeQh1y2MTN4TCTrI
	gqNdjACi6g89UQkNuIqT3jXp5qPWElZsvsVsE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Zsu6CGk1ifj4LDqtUyqFXB7DRvshkxv9
	qB/tG/0mByFzb8vIYCBzlO7GrQF9m8Erl8oi3QhZ3zWCBqYVADuQAETLJ0h9nZrW
	VctHXmaiLMBjIYhSIkSIGTchb+yH9IK711l49kH2Y+uxnxKs1MRmkHJJkTeQaN9p
	cdFMN3BUYlI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6683C911BD;
	Thu, 21 Jan 2010 13:12:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6A1A8911B4; Thu, 21 Jan
 2010 13:12:32 -0500 (EST)
In-Reply-To: <4B5882BD.3090908@brooklynpenguin.com> (Tim Olsen's message of
 "Thu\, 21 Jan 2010 11\:37\:17 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8E3268D2-06B8-11DF-8AEB-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137681>

Tim Olsen <tim@brooklynpenguin.com> writes:

>> In the recursive case (i.e. o->call_depth is non-zero), process_renames()
>> and process_entry() are supposed to be forcing the conflicts resolved,
>> recording the contents with conflict markers if necessary, before the
>> control gets to that point, so it clearly is a bug very specific to the
>> recursive merge implementation.
>
> Setting breakpoints on process_renames() and process_entry() shows that
> they are being executed.  Is there anything I can gather from their
> execution that would help you?

When they are called with non-zero o->call_depth, they are supposed to
drop all the index entries that they handle down to stage #0 (even if the
path had contents level conflict).  For example, you see this bit in
process_entry():

	} else if (a_sha && b_sha) {
		/* Case C: Added in both (check for same permissions) and */
		/* case D: Modified in both, but differently. */
		const char *reason = "content";
		...
		mfi = merge_file(o, &one, &a, &b,
				 o->branch1, o->branch2);

		clean_merge = mfi.clean;
		if (!mfi.clean) {
			if (S_ISGITLINK(mfi.mode))
				reason = "submodule";
			output(o, 1, "CONFLICT (%s): Merge conflict in %s",
					reason, path);
		}
		update_file(o, mfi.clean, mfi.sha, mfi.mode, path);
	} ...

and update_file() eventually calls update_file_flags() to make sure that
the content in mfi.sha is at the stage #0 of path when o->call_depth is
non-zero (or mfi.clean is true).  process_renames() and process_entry()
are humongous functions that handle full of different cases, but all
codepaths must follow the rule not to leave non-stage #0 entries in the
index before merge_trees() function calls write_tree_from_memory().

We've fixed a similar bug in c94736a (merge-recursive: don't segfault
while handling rename clashes, 2009-07-30) and I think there were similar
breakages we fixed over time in the same area, but the two functions being
as huge as they are, I suspect you are hitting a codepath that hasn't been
fixed.
