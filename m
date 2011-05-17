From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] rebase -p loses commits
Date: Mon, 16 May 2011 17:54:54 -0700
Message-ID: <7vpqnii1sx.fsf@alter.siamese.dyndns.org>
References: <20110516103354.GA23564@sigill.intra.peff.net>
 <7vfwoel6vw.fsf@alter.siamese.dyndns.org> <4DD1C277.9070605@sohovfx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Andrew Wong <andrew.w@sohovfx.com>
X-From: git-owner@vger.kernel.org Tue May 17 02:55:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QM8Z6-0008NP-Pw
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 02:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752822Ab1EQAzG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 20:55:06 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38764 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277Ab1EQAzF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 20:55:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9DD1C5F14;
	Mon, 16 May 2011 20:57:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Fo1jZd1IFH2LGj8uqMmAbLmccno=; b=VSslOq
	rspVLE4Oq/JWP2st0n6ysIZfrPcvihTHvzhh/zPepR4ScHpHggUYVVtPsUZLZwuj
	sBAx7ff5CMp2Yz45IAUwAemAisBDGLaCDcQVDCbz4IK1Lis41P2jDrh2f1vzjYOQ
	Fle5svR976Y1hH5id4kvY8Ap5VT26ZHe5eZDI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B5nphv3eT2MvbY0uVMbn7FHBZaxhLi6k
	kO9fPl3TvvSsgPLmDnmU/lgjjMb919CU7I/awErqIiReYzYjuLA9FWJIxiJQt9Ty
	4iLfBDwrBROiz1HryUBXutBvk3lYlgc0gG248d6977VEk5kJGyMcxiju1BemokZq
	G6zvFU8aMCw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6A9BA5F13;
	Mon, 16 May 2011 20:57:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D24435F0D; Mon, 16 May 2011
 20:57:02 -0400 (EDT)
In-Reply-To: <4DD1C277.9070605@sohovfx.com> (Andrew Wong's message of "Mon,
 16 May 2011 20:33:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9682490C-8020-11E0-BEFF-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173777>

Andrew Wong <andrew.w@sohovfx.com> writes:

> On 05/16/2011 04:36 PM, Junio C Hamano wrote:
>>     F---*  feature
>>    /   /
>>   B---M    master
>>
>> But what does it mean to rebase that on top of master, preserving merges
>> in the first place? You are already on top of 'master' and '*' itself
>> should be what you should get, no?  IOW, shouldn't you already be
>> up-to-date?
>>    
> Since preserve-merge uses the interactive-rebase, I think
> interactive-rebase should still pick the merge commit, which will then
> be consistent with what's happening if we rebase onto "F". So, without
> knowing whether "F" or "M" is the first-parent, I think
> interactive-rebase onto "F" and onto "M" should have the same
> effect. i.e. interactive-rebase picks the merge commit

I agree that changing the behaviour based on the "first-ness" of the
parent is a wrong thing to do in general. But even then, I have a more
fundamental question.

What does rebasing that '*' on top of M really mean?

Does it mean this?

    F---*                 F'--*'
   /   /   --->          /   /
  B---M             B---M---/

In other words:

	Take all the commits reachable from '*', exclude the ones that are
	ancestors of M, and make sure that commit that corresponds to each
	of the remaining commits (in this case, F' and *' correspond to F
	and * respectively) are decendants of M, and reconstruct the graph
	preserving the parenthood relationship between corresponding
	commits.

I would understand why some project may want to require you to rebase to
the tip to keep a linear history, and the above sentence would be the
right specification for linearizing rebase except for the "and reconstruct
the graph" part.

But the above "preserving" rewrite does not even preserve the topology of
the graph (the original * is a true merge between two forks, but *' is
not) to begin with.  Also, if you want to _usefully_ place F' on top of M,
such a rewrite should resolve possible conflicts that was resolved at * in
the original graph at F' anyway, which would mean that the resulting *'
should become a totally empty commit.

Why would anybody want to do such a thing to begin with?
