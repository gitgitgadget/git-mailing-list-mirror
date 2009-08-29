From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How does git follow branch history across a merge commit?
Date: Fri, 28 Aug 2009 17:01:16 -0700
Message-ID: <7vy6p38p4j.fsf@alter.siamese.dyndns.org>
References: <8363c75zug.fsf@torus.sehlabs.com>
 <7vskfbcy9n.fsf@alter.siamese.dyndns.org>
 <7vmy5jbjkr.fsf@alter.siamese.dyndns.org> <831vmv5wh7.fsf@torus.sehlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Steven E. Harris" <seh@panix.com>
X-From: git-owner@vger.kernel.org Sat Aug 29 02:01:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhBNr-0003PW-27
	for gcvg-git-2@lo.gmane.org; Sat, 29 Aug 2009 02:01:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbZH2ABW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 20:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbZH2ABV
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 20:01:21 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33157 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbZH2ABV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 20:01:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DE7231C590;
	Fri, 28 Aug 2009 20:01:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rNFF59Il8U9deYzMPSJE6IgT1U0=; b=Cx1yVs
	zzfA6R8/C6rOBQvH05xgCcnteUgJR/F28tWdfYXsCUVXRYBpXezcViLzCsygWIP2
	eZbyT0/n5MUha0B9v7gYDkBsTzwCvmiiccP0S4QgXBHo748DqfUH3IODr8peB54F
	MdJihWoEirj3pSaEqV1QwKw0DGVLyDJXHfzFs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KMjGkwQnTjp21A36Z5dSJxF07vu0vBND
	GWepN55UXZyCYiWPTGrGFGN6NkKqLAifijX3fjjo0M3SNOMEMHC4NZST3Xvga7Z/
	iFVBYnlc/PV4QIhge+FlZNssYZOH7Fp0d66HRbKwxxxNgIpeeejbI3XnJd5rWykj
	oR+X0QDTX44=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BE8681C58E;
	Fri, 28 Aug 2009 20:01:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 222241C58C; Fri, 28 Aug
 2009 20:01:17 -0400 (EDT)
In-Reply-To: <831vmv5wh7.fsf@torus.sehlabs.com> (Steven E. Harris's message
 of "Fri\, 28 Aug 2009 19\:50\:44 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 153017E6-942F-11DE-BC57-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127365>

"Steven E. Harris" <seh@panix.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> If you merge competition into your master, the resulting commit will
>> have your master as its first parent.  If check out competition and
>> merge master in your example, the resulting merge will have
>> compatition as the first parent.
>
> I see, having run a few more experiments to confirm this.
>
> I missed the point that merge commits are not "predecessor neutral";
> they apparently have a bias indicating "/this branch/ received content
> from /that branch/ (or /those branches/)".

We are in principle pretty much neutral, but in certain places you
obviously cannot avoid tiebreaking.  A commit object has to record parents
in a bytestream in its representation, and inevitably one parent must come
before another one.

You also must give your users some way to refer to each of its parents, so
naturally we count from one, and call them $it^ (== $it^1), $it^2, etc.
We do not have "$it^?" that lets you pick its parents at random, as we
haven't found a good use case for such a feature.

One place we tiebreak favoring earlier parents over later ones, even
though there is no logical reason to do so, is merge simplification [*1*].
When more than one parents have the same tree, with respect to pathspec
given, while traversing the history, we pick the earliest one, because
that is just as good as choosing one at random, and would give us a
reproducible result.  For a similar reason, when blame follows a merge
from identical parents, it assigns blame to earlier parents.

And at the end-user workflow level, people tend to think "I merge others
work into mine", so the log family of commands have --first-parent option
to follow only that ancestry, but that logic kicks in only while browsing,
not while building histories.

[Footnote]

*1* If you do not know what a merge simplification is, refer to e.g.
http://gitster.livejournal.com/35628.html and notice there is a place
where we follow "a parent that is the same as the merge result".
