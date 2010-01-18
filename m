From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep --no-index: allow use of "git grep" outside a git
 repository
Date: Sun, 17 Jan 2010 19:35:23 -0800
Message-ID: <7v8wbwultw.fsf@alter.siamese.dyndns.org>
References: <201001131713.05505.agruen@suse.de>
 <7vfx69k0bu.fsf@alter.siamese.dyndns.org>
 <20100115223259.6117@nanako3.lavabit.com>
 <7vska71br0.fsf@alter.siamese.dyndns.org>
 <7vzl4fum3r.fsf_-_@alter.siamese.dyndns.org>
 <20100115210854.GA21540@coredump.intra.peff.net>
 <7vwrzin9jt.fsf@alter.siamese.dyndns.org>
 <20100116011512.GA27082@coredump.intra.peff.net>
 <7vpr5ait1m.fsf@alter.siamese.dyndns.org>
 <20100118015140.GB6831@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nanako Shiraishi <nanako3@lavabit.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 18 04:35:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWiOu-00031S-Rg
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 04:35:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755317Ab0ARDfd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 22:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752452Ab0ARDfc
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 22:35:32 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36427 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116Ab0ARDfc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 22:35:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 93F0D91216;
	Sun, 17 Jan 2010 22:35:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=o616YYKzNJAJiY/8wXpeiNd6Qp0=; b=jPziDLvu6Or2Ujvi0C2pAc6
	pp3KuGWJkK29HRbTO/OjCXYXM13MZA50/5Kxvf+nzyu+DjwzOg6c5AwayoI6HO2v
	w+Kvr9dRLlzBu82f/92hsmbxzEtFlAIpJCybiZS+wnmO5M+/AShovV6WXtVdeUg2
	kyrbkhQj6MCQlY9DCt+w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=tE/cJU8vYD7jf/Sh//fQNNhRpd6qmTYl42GiNmMvzh/8IYZUU
	V1eHYT8eVrFZcdhrMI6YmeQ8x1awnWtMthe5Hp2XCR6396/jrPRQ4vlOq6xKklWi
	pE1IUmE96hLiWYC6bhCKw4HvIf5kL6Fvkt0U6MpKM7fMGYMCtle0C4LsxE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F03B91215;
	Sun, 17 Jan 2010 22:35:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7660691214; Sun, 17 Jan
 2010 22:35:24 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8595A26C-03E2-11DF-8634-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137365>

Jeff King <peff@peff.net> writes:

> Agreed. That is the most common log grep pattern for me (author + grep),
> and I always want all-match. I see from later in the thread, though,
> that implementing it is not as straightforward as we might hope.

I haven't looked at the codepath for quite some time but I have a feeling
that it probably won't be too bad.

It just won't be as simple as flipping the all_match bit with a one-liner.

Before calling compile_grep_patterns() in revision.c::setup_revisions(),
we probably would want to massage revs->grep_filter to result in the
desired grep expression parse tree, i.e. from

    GREP_PATTERN_HEAD("^author .*davvid")
    GREP_PATTERN_HEAD("^committer .*gitster")
    GREP_PATTERN_BODY("difftool")
    GREP_PATTERN_BODY("mergetool")

to

    GREP_PATTERN_HEAD("^author .*davvid")
    GREP_PATTERN_HEAD("^committer .*gitster")
    GREP_NODE_OR(
        GREP_PATTERN_BODY("difftool")
        GREP_PATTERN_BODY("mergetool")
    )           
