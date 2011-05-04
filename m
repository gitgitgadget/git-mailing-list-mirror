From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Add default merge options for all branches
Date: Wed, 04 May 2011 14:35:35 -0700
Message-ID: <7vei4edu8o.fsf@alter.siamese.dyndns.org>
References: <20110503090351.GA27862@elie> <4DC0608F.9040208@dailyvoid.com>
 <20110503204442.GI1019@elie> <7vsjsvgzzf.fsf@alter.siamese.dyndns.org>
 <7vzkn3f5wo.fsf@alter.siamese.dyndns.org> <4DC0D605.20204@dailyvoid.com>
 <20110504045802.GF8187@elie> <4DC1A1BC.5010601@dailyvoid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	vmiklos@frugalware.org
To: Michael Grubb <devel@dailyvoid.com>
X-From: git-owner@vger.kernel.org Wed May 04 23:35:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHjjg-0006qi-3V
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 23:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753458Ab1EDVfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 17:35:51 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33177 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753169Ab1EDVfv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 17:35:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 07B48483B;
	Wed,  4 May 2011 17:37:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ecVN3h10/FlbG1HkP2jq76+nr2A=; b=vfeYMG
	DiwW3PK7oWlGyS+yVBdMQnKILrrHBYpr3GhTZxNqIKA7Hin4HyFb7bW61WjOYom6
	ZWDM+w1eBb5nvw/es563LK74Dv0qJQTWW9iI81rmDuN1UZg5iO4UtdkYPljPoWCe
	UJEjjC0+pbVQEPoOUgCehGzz4V26X401KqQd4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tD9oQon8EsvXedqzik2tmjfk2uQMuAWv
	8RbjmG45naCHbfo3+4tKhKoRGliR8Pgdx5NBVGgXG6j4YAQ5Yq2vB6PvMaFRb5++
	iAktPxncNVmcWNt831zG3ATG7M66HqoRw3V8U0N1KZwUD7UGiwS5F9ivb40buk0I
	QrGAq+yLvgc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B97914836;
	Wed,  4 May 2011 17:37:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4FB064822; Wed,  4 May 2011
 17:37:41 -0400 (EDT)
In-Reply-To: <4DC1A1BC.5010601@dailyvoid.com> (Michael Grubb's message of
 "Wed, 04 May 2011 13:58:04 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C06F4B04-7696-11E0-B322-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172772>

Michael Grubb <devel@dailyvoid.com> writes:

> Well, it certainly serves *my* immediate needs and addresses the
> specific use case that I was originally working on.  Though I think that
> what we've come up with would benefit the codebase in general if for no
> other reason than it lays some ground work for future features...

The discussion was fruitful, I think, and it may have laid the groundwork
at the _conceptual level_.  I however do not think that the approach the
patch takes is generic enough, even if we add globbing of the branch name,
to build on other things that can come out of the future directions the
discussion suggested.

For example, why does "merge.c" hold the parser for "branch.*.*", when
there are a lot more configuration variables that apply per branch that
are totally unrelated to merge?  Don't these branch.*.* variables benefit
from having a wildcard support as well?  If we wanted to add such support,
which configuration parser should be called by many pgorams that deal with
branches (e.g. "checkout -b", "branch", "fetch", ...), and where that
parser should be defined in?  I suspect the answer might be "branch.c",
but I do not htink we explored the uses widely enough to make that
decision yet.

Even if I limit the discussion to "mergeoptions" [*1*], why can I specify
the merge options based on what branch I am currently on, but not based on
what branch I am merging to my current branch?  When on master branch,
should branch.*.mo augument what I have in branch.master.mo, or should it
overwrite it?  I may want to say "all my merges should use --log" and
"when on master I want --no-ff". Should branch.master.mo repeat "--log",
or should the values on the two variables automatically combine? If so in
what order? Am I allowed to say "Use 5 lines of --log" for generic one,
and then "Use 10 more lines of --log than generic" for branch.master.mo,
so that later I can easily change my mind and update branch.*.mo to use 10
lines, and I get automatically 20 lines for the master branch?  If not why
not?

etc.etc.etc....

I am not saying some of these issues are unsolvable, nor we should solve
all these problems right now, but I do not think these issues are
something you are trying to solve with this patch, nor the approach this
patch happens to use was designed with these problems in mind (I certainly
didn't, when I made many suggestions I see in this round of your patch) to
become a foundation to solve them in the future.

The suggestion by Jonathan does not have such a design issue that requires
us to open a huge can of worms right now and potentially result in a
solution that is overengineered to address a wrong problem [*2*].

If it solves the original issue without such downsides, that would be more
preferrable, I think; no?

[Footnote]

*1* I personally think "branch.<name>.mergeoptions" was a mistake.  If it
were separate "branch.<name>.merge-ff", "branch.<name>.merge-log", ... it
might have been more clear what the combining semantics should be.  But
that is not going to change, so I'd rather not to extend the support for
it, until we come up with something more sensible.

*2* For example, globbing to match the current branch name could become an
overengineered solution to a wrong problem, if it turns out that it is not
useful to decide things based solely on the current branch name.
