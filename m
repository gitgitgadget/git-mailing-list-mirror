From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Premerging topics
Date: Tue, 23 Apr 2013 22:48:30 -0700
Message-ID: <7vzjwofpht.fsf@alter.siamese.dyndns.org>
References: <CALWbr2wocjqs1mpa+yuQ_Zw8m+SX24q6Pby3E3v3-jd-0w1pvQ@mail.gmail.com>
	<CALKQrgfO9fd+EEA=Vwe94tJbxkX89uDmMHm9rj6L=d4x7JJjaQ@mail.gmail.com>
	<CALWbr2x5HDU2t7hpSCkZnuKjTJ1KxYC0v50wsDPT0fm4LyvzWw@mail.gmail.com>
	<CALKQrgeGPo--cYoGZ30nSfASh4CPzqGXQojkG9Ve96NFr+LrjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Apr 24 07:48:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUsZL-0002bI-P3
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 07:48:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170Ab3DXFse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 01:48:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45759 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752017Ab3DXFse (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 01:48:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 08DC61472A;
	Wed, 24 Apr 2013 05:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=UrWCK0JoIW+R8n4JxO/drBRi/3Q=; b=n1MSTKM5NxsTjhvEbb45
	nFM2M2q+MPk6TzhuPIu4YRJ1bkcN3PcpZG3KT0q/WsDmzJjLlJF5q6PJKnuM1Amw
	IqfuPAybcXItRDrNXpVZYeqAgVYZdAPGHJ3GHSAsVstx7t1LVfxNw8KNnxq11QJI
	tY2SR3zJf4uDyYZTo8XvYSU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Zeu9OuvmsMdrFFCkRQBTE04jR7ZZLP03sati7xLzyElxzt
	SKCUfdJzAWxHQawAbdMz7wcwiD9CgGYOf+b9HF+KubBucule4nPRU48Qmae4XNbH
	6iMpuFBoOIKnI3Iu/ULqx4at6tO5ghL/lRF5YpXShYeyPjrK6nuvC0VHnJ0/4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F045C14729;
	Wed, 24 Apr 2013 05:48:32 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 27D5A14728;
	Wed, 24 Apr 2013 05:48:32 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 98BD8F96-ACA2-11E2-B6AE-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222223>

Johan Herland <johan@herland.net> writes:

>> But P is a commit(/merge with two parents), not a blob. Can we have trees
>> pointing to commits instead of blobs ?
>
> Sort of. We do so when recording submodules in regular git trees.

You are using notes to maintain reachability, aren't you?  Because
commit objects that appears in trees are not treated as reachable
from the trees, that won't fly.

I think you guys are making it unnecessarily complex by using notes.
To record a prepared evil merge for merging branch that contains A
with another branch that contains B (assuming that the interation
between A and B is what makes the evil merge necessary, e.g. A
renames a function foo() to bar(), while B adds new callsite that
calls foo()), we can store a single commit that records the prepared
evil merge under "refs/merge-fix/$A-$B" where A and B are their
object names.

Then when merging a branch Y that contains B into our history X that
already contains A (or vice versa),

  ---o---o---A---o---X... ???
      \                  .
       \                .
        \              .
         o---B----o---Y

we can enumerate the commits that appear in "log --left-right X...Y"
on the left/right side and notice there is refs/merge-fix/$A-$B.

So the simplest implementation of "an efficient data store to record
a commit for <A,B> pair" turns out to be just a ref namespace ;-)

There may be other <C,D> pairs in X...Y history, and it probably is
the sane thing to do to replay prepackaged evil merges from older to
newer in the topological sense, but that loop would be trivial, once
we understand how to replay a single such evil merge.

The actual merge-fix data should be just a commit with a single
parent. The easiest way to prepare it would be like this:

  ---o---o---A
      \       \
       \       M---F
        \     /
         o---B

where M is the result of mechanical merge between A and B (there
could be textual conflicts and you could choose to leave them in, or
you could choose to have rerere resolve it.  As long as you do the
same when replaying this prepackaged evil merge, this choice does
not matter, but using rerere will make your life easier), and F is
the final result you would want, with semantics conflicts resolved.
In other words, in the ideal world, you would have resolved a merge
between A and B to record the tree of F.

Point "F" with refs/merge-fix/$A-$B and you are done.

When you replay this prepackaged evil merge, first you mechanically
merge X and Y without worrying about M or F to produce N.  If you
allowed rerere to resolve textual conflicts between A and B when you
recorded M, allow rerere to resolve this merge.  Otherwise leave the
textual conflict in.

  ---o---o---A---o---X
      \               \
       \               N
        \             /
         o---B---o---Y

Then on top of N, you cherry-pick F, which will bring the semantic
conflict resolution between M and F on top of N.

  ---o---o---A---o---X
      \               \
       \               N---F'
        \             /
         o---B---o---Y

Once you know the tree shape of F', then you no longer need N.  Just
amend it away and make the tree recorded in F' the result of the
merge between X and Y.

  ---o---o---A---o---X---.
      \                   \
       \                  F''
        \                /
         o---B---o---Y--.
