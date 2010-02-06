From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/9] revert: add --ff option to allow fast forward when
 cherry-picking
Date: Fri, 05 Feb 2010 16:21:12 -0800
Message-ID: <7vzl3nkydj.fsf@alter.siamese.dyndns.org>
References: <20100205231028.3689.12228.chriscool@tuxfamily.org>
 <20100205231112.3689.67634.chriscool@tuxfamily.org>
 <7vpr4jnsm9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Feb 06 01:21:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdYQd-0006FB-N0
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 01:21:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757376Ab0BFAVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 19:21:34 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39159 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757276Ab0BFAVd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 19:21:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D2569701F;
	Fri,  5 Feb 2010 19:21:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VV8vz3dEk1bjBpxs/wtB2u4BUes=; b=Rt/YJF
	ye06FfllGfypT6n8CtzEbv16Y8GIpgeOGghaKvwq6Ykc67WY1ow8iPchFkb575Mv
	Gn25/ZbFHUkzNHUo3qnrMAr/H2jlwEi2tkwveQXvl0hu5HmDFtMy1CehVicZgWnN
	U7xgDQQ3SWfVA+n7/5sUr/eTC0Xhuc58Uq84c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xilB51LuFRlioq9tDXA7gbGndSWappHD
	sc1lnTNuhXUrug7cimS/ErO8cyGmBJQuop+ejvkIUii7n2fiLBSICAcyFMwu2eD5
	/kVd0HBOcVznU3xMZfRhrjxr12zl49WGekX8wK8twCDEBWavYKtpjlRdcvI7DqV0
	6I00nJvJ6ug=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EB2D9701E;
	Fri,  5 Feb 2010 19:21:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4AE389701D; Fri,  5 Feb
 2010 19:21:14 -0500 (EST)
In-Reply-To: <7vpr4jnsm9.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri\, 05 Feb 2010 15\:57\:18 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8EA6730E-12B5-11DF-8ED8-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139130>

Junio C Hamano <gitster@pobox.com> writes:

> Christian Couder <chriscool@tuxfamily.org> writes:
>
>> As "git merge" fast forwards if possible, it seems sensible to
>> have such a feature for "git cherry-pick" too, especially as it
>> could be used in git-rebase--interactive.sh.

One more thing, in the same part of the code:

>> +	if (!(flags & PICK_REVERSE) && ff_ok && commit->parents) {
>> +		unsigned char head_sha1[20];
>> +		if (get_sha1("HEAD", head_sha1))
>> +			die("You do not have a valid HEAD.");
>> +		if (!hashcmp(commit->parents->item->object.sha1, head_sha1)) {
>> +			char *hex = sha1_to_hex(commit->object.sha1);

Is there a need to check commit->parents->next?

Should this code work the same way if the commit being cherry-picked is a
merge?  Should "-m <parent-num>" option affect this codepath in any way?
