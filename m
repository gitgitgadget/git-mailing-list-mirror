From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] add --summary option to git-push and git-fetch
Date: Thu, 04 Feb 2010 09:55:13 -0800
Message-ID: <7v3a1gdgxq.fsf@alter.siamese.dyndns.org>
References: <20100130020548.GA29343@cthulhu>
 <7vsk9oysds.fsf@alter.siamese.dyndns.org> <20100201005751.GA8322@cthulhu>
 <20100204171619.GA9367@cthulhu> <7vwrysdiaq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Larry D'Anna <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Thu Feb 04 18:55:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nd5vQ-00024A-HQ
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 18:55:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755634Ab0BDRz0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 12:55:26 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53438 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755580Ab0BDRzY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 12:55:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C164978EF;
	Thu,  4 Feb 2010 12:55:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Clvit+fapQggZUUZjFyNECAcvzE=; b=sGx640
	Hkvq5jv+X4xqULzMCmLGv52Y0OJGT0OQy2l9RoCZoORQcU0iJpzuFRctSeVi5uVe
	SjvWOg7HRLn9ZfWwIjDR5Mi5iSCF+aGEkbFs0hfbxmSHVIe53omMT0DOskrHn+3X
	jQnNlCyrPH6x9I9gj6SnngbN8NV50Mwxw71So=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iivr5C8WEQUolvka/f5sIVswJYIbJXBC
	WExZ11N/xh9HBriHMhc89Xx63srHG8MdsHea+noFO4TX2+SMtRIUf95XN0jksMrl
	jGVe2g+luDz5wl8PeL6eaj9Wl0Z4v7sHrmrhmiWgXo2YicvUfsvxeRrQDVS4Pd+v
	IIKyEgvmdm4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F31F978EE;
	Thu,  4 Feb 2010 12:55:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A8F0C978ED; Thu,  4 Feb
 2010 12:55:15 -0500 (EST)
In-Reply-To: <7vwrysdiaq.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu\, 04 Feb 2010 09\:25\:49 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 74B4A632-11B6-11DF-919A-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138990>

Junio C Hamano <gitster@pobox.com> writes:

> I dunno.  If it delegated to a subprocess it would certainly be easier to
> review and get convinced that the change won't affect object flags for
> other parts of the system in bad ways, but there obviously is a
> performance downside.

You fundamentally cannot use the same "summary" logic for push and fetch,
and it is especially true if you are doing it inside the same process, I
think.

When you force a fetch, you will have the complete histories for both old
and new, as you started from old (and I am assuming that you are fsck
clean) and you successfully fetched new.  When you force a push, however,
you may already have the old in your object store, but there is no
guarantee that you have the complete history leading to it (i.e. you may
have got the tip commit left by an earlier fetch done with a commit walker
that you interrupted in the middle).

So at the very least, your "summary_impossible" logic should work a lot
harder than a single lookup-commit-reference-gently; it needs to walk the
ancestry until you hit some ref to prove that you have a complete history
for that commit, without dying.  Otherwise get_revision() loop inside
print_summary_for_push_or_fetch() would say "oops -- I don't have the
parent commit" when it tries to call add_parents_to_list() and die.

Doing the summary traversal inside a subprocess would simplify the
handling of the error for such a case, I guess.

My gut feeling from the beginning has been that a patch that touches
revision.c for this topic would add unacceptable cruft to the already
complex logic in that library for no real gain.  Doing the traversal
inside a subprocess would allay that worry as well ;-)
