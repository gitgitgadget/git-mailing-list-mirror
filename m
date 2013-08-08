From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] During a shallow fetch, prevent sending over unneeded objects
Date: Wed, 07 Aug 2013 18:01:44 -0700
Message-ID: <7v61vhc7wn.fsf@alter.siamese.dyndns.org>
References: <20130711220127.GK10217@login.drsnuggles.stderr.nl>
	<7vsizkpv21.fsf@alter.siamese.dyndns.org>
	<20130712071157.GL10217@login.drsnuggles.stderr.nl>
	<20130807102716.GA10217@login.drsnuggles.stderr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthijs Kooijman <matthijs@stdin.nl>
X-From: git-owner@vger.kernel.org Thu Aug 08 03:02:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7EcQ-0007Wt-QI
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 03:02:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933603Ab3HHBBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Aug 2013 21:01:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48901 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933575Ab3HHBBr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 21:01:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77CEF28BFE;
	Thu,  8 Aug 2013 01:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=H9aLOxnHtgLe9Yy8Sn45jPUhpjA=; b=gdMCaoCDwlpF2yBqgPMZ
	CwcQ4hK5T9hJvK/TlgBrLjnm+3TmHsDM/G2yd5fPCl6GIyZnucrs/J95KVrsa9RI
	zcxvjV0CpG1988PyvPlcylP+xzj3S6k9KPAI4h9sA+iN2nwqgC7zGe+sOiz/W4u/
	PZVTnOgzk7YTSSQ0iwyHT4c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=J+xEghNUX5+zARd+yhBThZ0mjDpLdh/YRRtzQfJ++yf95S
	ARi9ZyFssPwQlCYNZYbb+9FF6/QgFDzaGtrGCHr7waKlACFS9K0lZccmeyiWJDR9
	4MWkuka6lvb+UfItIPDsR9hOJ8DtIYJ88QElWNVw65Lh4yrJIo7/al2yOn8Lo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6AD5F28BFD;
	Thu,  8 Aug 2013 01:01:46 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9769828BFB;
	Thu,  8 Aug 2013 01:01:45 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 18A03D14-FFC6-11E2-9AE6-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231853>

Matthijs Kooijman <matthijs@stdin.nl> writes:

>> > In your discussion (including the comment), you talk about "shallow
>> > root" (I think that is the same as what we call "shallow boundary"),
>> I think so, yes. I mean to refer to the commits referenced in
>> .git/shallow, that have their parents "hidden".
> Could you confirm that I got the terms right here (or is the shallow
> boundary the first hidden commit?)

As long as you are consistent it is fine. I _think_ boundary refers
to what is recorded in the .git/shallow file, so they are commits
that are missing from our repository, and their immediate children
are available.

> My proposal was to only apply the fix for all have revisions when the
> previous history traversal came across some shallow boundary commits. If
> this happens, then that shallow boundary commit will be a "new" one and
> it will have prevented the history traversal from finding the full list
> of relevant "have" commits. In this case, we should just use all "have"
> commits instead.
>
> Now, looking at the code, I see a few options for detecting this case:
>
>  1 Modify mark_edges_uninteresting to return a boolean (or have an
>    output argument) if any of the commits in the list of commits to find
>    (not the edges) is a shallow boundary.
>  2 Modify mark_edges_uninteresting to have a "show_shallow" argument
>    that gets called for every shallow boundary. The show_shallow
>    function passed would then simply keep a boolean if it is passed at
>    least once.
>  3 Add another loop over the commits _after_ the call to
>    mark_edges_uninteresting, that simply looks for any shallow boundary
>    commit.
>
> The last option seems sensible to me, since it prevents modifying the
> somewhat generic mark_edges_uninteresting function for this specific
> usecase. On the other hand, it does mean that the list of commits is
> looped twice, not sure what that means for performance.
>
> Before I go and implement one of these, which option seems best to you?

My gut feeling without looking at any patch is that the simplest
(i.e. 3.) would be the best among these three.

But I suspect, with any of these approaches, you would need to be
very careful futzing with the edge ones.  It may have an interesting
interactions with --thin transfer.
