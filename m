From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/4] test-dump-cache-tree: invalid trees are not errors
Date: Mon, 07 Jul 2014 12:27:35 -0700
Message-ID: <xmqqa98lc6l4.fsf@gitster.dls.corp.google.com>
References: <1404619619-4774-1-git-send-email-dturner@twitter.com>
	<1404619619-4774-2-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 21:27:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4EZq-0005aY-9n
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jul 2014 21:27:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbaGGT1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2014 15:27:46 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62250 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751338AbaGGT1p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2014 15:27:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0513C26507;
	Mon,  7 Jul 2014 15:27:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8/PFrBDo3Mujj6o4Hlb6uPQrYOE=; b=gyrkmm
	tXMmG5gqFlF+2y+ZDPYTmGmAoJ91vIzZSl6JStuPEbCJjR4P7Z1Kl2/bMsdos3mj
	0x+s9CN1/ZHmz7FvDIMruTUh4y7E5dQy+tPMx5jKGW5aiRCcitmv+7OqUWy06T98
	Wq9XWBvQhTJH98N+hn8zR8y1MwCAnWa433Q6k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mozyXLTJDo2/G6hx9rLA8T08PHEV+6H0
	BALxBG4lJXw1o+QTFI1u+6AVJDguJPuH+IvmKCHn9VSOHXoJRNefk1gNEugJpyWi
	yZJdfAD/MzE13TETqhP6u9+z9k4hCDMHGIoDmBYuWOPk7lm4T+ZqV0ht8GOvU0D4
	u8ZE4T65R9Q=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EBD5326506;
	Mon,  7 Jul 2014 15:27:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CB2A6264FE;
	Mon,  7 Jul 2014 15:27:26 -0400 (EDT)
In-Reply-To: <1404619619-4774-2-git-send-email-dturner@twitter.com> (David
	Turner's message of "Sat, 5 Jul 2014 21:06:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BAA0BCD6-060C-11E4-963F-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252983>

David Turner <dturner@twopensource.com> writes:

> Do not treat known-invalid trees as errors even when their count is
> incorrect.  Because git already knows that these trees are invalid,
> nothing depends on the count field.

s/count/subtree_nr/; they are different.

"nothing depends on" is not quite correct.  The field keeps track of
the number of subdirectories in the directory recorded in the
cache-tree, and it *must* be maintained correctly (we iterate over
the it->down[] array up to that number).

The number of subdirectories the directory actually has, which we
can discover by counting entries in the main part of the index, may
be different from subtree_nr, if we haven't run update_one() on it,
e.g. we may have added a path in a new subdirectory, at which time
we would have invalidated the directory and its it->down[] array does
not know the new subdirectory.

While reading 3/4, I wondered if it makes sense to show the (N
subtrees) for invalidated node, but as a debugging measure it helped
me often while developping the framework, so we may not want to drop
the subtree_nr from the output for invalidated entries.

The change itself looks good.

Thanks.
