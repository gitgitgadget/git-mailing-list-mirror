From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] git blame-tree
Date: Wed, 02 Mar 2011 15:22:14 -0800
Message-ID: <7v39n5az15.fsf@alter.siamese.dyndns.org>
References: <20110302164031.GA18233@sigill.intra.peff.net>
 <20110302171653.GA18957@sigill.intra.peff.net>
 <7vbp1tcr25.fsf@alter.siamese.dyndns.org>
 <20110302210434.GB20400@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 03 00:22:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuvNE-0004Cn-7F
	for gcvg-git-2@lo.gmane.org; Thu, 03 Mar 2011 00:22:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752551Ab1CBXWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 18:22:23 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33922 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989Ab1CBXWW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 18:22:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DBB323236;
	Wed,  2 Mar 2011 18:23:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=KgTgXLpgNRb/XHjgfNQTvE3xx54=; b=fYeQc45L/l2xuahrVDL8sZu
	c9nZy7N2f/fYgmSMLbvbJCXh1tQGFtnMX8SqZ5hJodWN5mDvr/R/u22iL2KO9ZgY
	StbGRe+aGqfmKog8tA5L4roXDWGdChizz8SUhq6J5BYnEm64rMkdeTDObZm0Eyb5
	kTkxP48Nst4Q17YfkCl0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=qpjXcOrwVsZYQki1p5l4QYcniMJFN4Rpq2TDu211/xR9Id3QX
	B7XUaswct0vSK9YNgEJ8lfsAPDvF6W22uOojGFZ2m9/hWlAtneQ9NwuMIri6f4BH
	pU4Mrz6OtVEmHCLT1v3g+8J43le1lIZ3pEvsfwFhCtEN71IciV30H8BBKU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B777E3232;
	Wed,  2 Mar 2011 18:23:40 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8F53B322A; Wed,  2 Mar 2011
 18:23:37 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1BB52A14-4524-11E0-A788-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168361>

Jeff King <peff@peff.net> writes:

> With sensible semantics, we can turn off --no-merges and still get good
> results. And anybody who cares for something different can use
> --no-merges themselves. Though I expect the opposite to be the case; I
> can imagine somebody wanting --first-parent to blame files only to
> merges.  I'll have to make sure that works properly in my re-roll.

I still do not understand why anybody would even want to say --no-merges.

What does this even mean?

	git blame --no-merges master..pu -- builtin | builtin/push.c

It may find ab/i18n or mm/push-default-advice depending on the timestamp,
by ignoring a content-level merge but is it a useful information?

> I was thinking something like:
>
>   git blame-tree dir branch1 branch2
>
> where branch2 is actually _ahead_ of branch1. We take the file list from
> branch1, but may blame commits on branch2. It's probably a little bit of
> a crazy thing to ask for, though.

To be compatible with all the git commands, the order of parameters should
be revs first and then pathspec, i.e. "git blame-tree branch1 branch2 dir".
But that is a tangent.

Again, the same "what does that mean" applies.

>> The second point is "why didn't you use pathspec, but chose to take only
>> one path?"  It would be useful if you can say
>> 
>> 	$ git blame v2.6.24..v2.6.37 -- net include/net
>> 
>> no?
>
> ...  So in the
> traversal above, if 2.6.25 removes net/foo.c, then a regular traversal
> will think that's interesting and mention it.  But for blame-tree, we
> don't want that. We want to mention net/foo.c only if it existed at the
> beginning.

Of course, if v2.6.37 that is the endpoint of the history (i.e. "at the
beginning" above) didn't have net/foo.c, then we shouldn't show it.

But that doesn't change my question.  Why are you taking a single
directory and doing "ls-tree $endpoint $that_directory" to populate the
set of paths to find who touched them last, instead of using the args as
regular pathspecs and running "ls-tree $endpoint -- net include/net" to
populate the set?

> Of course it would be easy enough to parse the revision parameters, then
> create our initial path list by combining the initial tree and the
> pathspecs....

As I said already, it does not make any sense to have more than one
endpoint to begin with when you are asking "what is the last one that
touched things", and that also applies to the regular blame, which I think
already has a logic to make sure you have only one positive commit in the
starting rev list.

> ... When net/subdir/foo.c changes, we do care, we just say
> "net/subdir" changed.

I think you would want diff-tree with or without -r then.  I suspect
people may want to pass --recursive to this command.

> The expensive part is actually looking at the tree and doing even the
> raw diff for each commit.

... which may probably be helped by limiting the recursion of that diff
with pathspec, but I realize that you are not by default running recursive
diff, so...

It also occurs to me that it may also be a plausible implementation to
hook this into the usual revision traversal machinery.

> I'm not sure if we do that optimization. Even if we do, I'm not sure how
> much practical difference it will make. I expect most of the time is
> spent getting the tree out of storage at all, not walking the entries.

Yeah, my "pathspec" comment primarily comes from my expectation that this
would want to be recursive.  If you are only scanning a single flat tree
without recursing, then there is no need.

> And then I _will_ need to feed the proper pathspecs to diff. Because it
> won't be a matter of looking at a few extra entries in a tree we have
> already pulled from storage. We need to tell diff not to delve into
> those extra trees at all...

Yes.
