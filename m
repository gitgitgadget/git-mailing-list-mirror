From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC 4/4] rebase -i: add --refs option to rewrite heads
 within branch
Date: Tue, 22 Dec 2009 15:37:54 -0800
Message-ID: <7vzl5awpf1.fsf@alter.siamese.dyndns.org>
References: <20091222222032.GU30538@dr-wily.mit.edu>
 <20091222222316.GY30538@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Greg Price <price@ksplice.com>
X-From: git-owner@vger.kernel.org Wed Dec 23 00:38:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNEJ2-0000nX-2f
	for gcvg-git-2@lo.gmane.org; Wed, 23 Dec 2009 00:38:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202AbZLVXiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2009 18:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752183AbZLVXiI
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Dec 2009 18:38:08 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56924 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093AbZLVXiF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2009 18:38:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 75FBB8AFCA;
	Tue, 22 Dec 2009 18:38:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j9yNLELbobMuTKxc/lHfk06VGyc=; b=OPVmsP
	jgJye4JUaKU3uIG278GKltq8sxMRwqEpebPotLQtAGBxlhUwfM6Vjg2rkryYh5xX
	gUePsJGHeJxTngihuMcWj6MLXwFvfPi+f/cbJD/m5McG24ahcLtR2dk4Z9uRSsnM
	5eUTjqFPVT+tC3SL4BikkigIuwJMFKn7DcMjM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mcxZ54nX0d+6X+4VTnzIksFU444ttYN+
	FlliNi7IyM+rqe2vSyKDh6VI/6QuG+9knlcfPJW7saEn0LZPxvpd+QsATRCbRKUK
	WkdLRhZzniJpsalrgsriBVIwAAuHO5DwEAm+LHhzE5Y8h8fi+MQDryuKg43SAGvJ
	RMbCoe0NU0U=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 42AF48AFC9;
	Tue, 22 Dec 2009 18:38:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 510578AFC8; Tue, 22 Dec
 2009 18:37:56 -0500 (EST)
In-Reply-To: <20091222222316.GY30538@dr-wily.mit.edu> (Greg Price's message
 of "Tue\, 22 Dec 2009 17\:23\:16 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0A55E862-EF53-11DE-BC1C-033CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135606>

Greg Price <price@ksplice.com> writes:

> The new option --refs causes the TODO file to contain a "ref" command
> for each head pointing to a selected commit, other than the one we are
> already rebasing.  The effect of this is that when a branch contains
> intermediate branches, like so:
>
>       part1 part2 topic
>         |     |     |
>         v     v     v
>   A--*--*--*--*--*--*
>    \
>     B <--master
>
> a single command like "git rebase -i --refs master topic" suffices to
> rewrite all the heads that are part of the topic, like so:
>
>         part1 part2 topic
>   A       |     |     |
>    \      v     v     v
>     B--*--*--*--*--*--*
>     ^
>     |
>     master
>
> Signed-off-by: Greg Price <price@ksplice.com>
> ---

Two comments and a half.

 - As decoration is a fairly expensive operation (which is the reason why
   loading_ref_decorations() is called lazily by format_decoration() in
   the first place, especially in repositories with tons of refs), you
   shouldn't give --format=%D to rev-list when the new feature is not
   asked for.

 - This seems to rewrite only branch heads; don't you want to allow users
   to rewrite lightweight tags and possibly annotated ones as well, by
   perhaps giving "--rewrite-refs=refs/heads/" or "--rewrite-refs=refs/"
   to limit what parts of the ref namespace to consider rewriting?

 - Otherwise the option should not be called "refs" but be named using the
   word "branch" to clarify that it affects _only_ branches.

Obviously the series also needs tests.

I also have to wonder if this feature should also handle a case like this:

                  side
                  |
                  V
                  *
                 /
        part1   *    topic
          |    /      |
          v   /       v
    A--*--*--*--*--*--*
     \
      B <--master

===>

                     side
                     |
                     V
                     *
                    /
           part1   *    topic
     A       |    /      |
      \      v   /       v
       B--*--*--*--*--*--*
       ^
       |
       master

especially if it were to be specific to branch management.

On the other hand, if the "partN" markers in your example workflow are
primarily meant to be used to mark places on a branch (as opposed to
arbitrary branch tips that independent development starting from them can
further continue), it would make a lot more sense to use lightweight or
annotated tags for them, and instead of "--refs" that rewrites only other
branch tips, it might make a lot more sense to have "--rewrite-tags" that
rewrites tags that point at the commits that are rewritten, without
touching any branch tip.
