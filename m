From: Junio C Hamano <gitster@pobox.com>
Subject: Re: (Ab)using filter-branch from a post-receive hook
Date: Sat, 14 Jul 2012 22:25:14 -0700
Message-ID: <7vipdp61fp.fsf@alter.siamese.dyndns.org>
References: <8D1AF968-AF34-4590-AB8F-E644C534A928@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun Jul 15 07:26:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqHLI-0008QE-Pc
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jul 2012 07:26:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822Ab2GOFZV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jul 2012 01:25:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41045 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750807Ab2GOFZT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2012 01:25:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E27006A4E;
	Sun, 15 Jul 2012 01:25:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Xdgi5zLKiOkvcxQk4P3lTgWJvBY=; b=UTmCEl
	r1Zxxqg0dCENYP0hCc2i5ZU4LfpKeX/OetoqdLYP5amN+fdsDYOqqyLNulEtlX1e
	m8eno4Flto+pD9qEf2241NpEIV4nbuhkhk8ZLPjGJq89oBYIG3TNoO8cRK4GQMQc
	VK4uIi7gMgPTet5dfNo2gbrZ6sumvHVn30J5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ngzcqLm8HSMZGH1BUbu6H6YAp5JRH714
	1WothcO6s1DljYxoBpywL7BQ+Uy3oZNt6Pt9HrkL5KVyOJ0UC0po1MlJFrJJADuE
	SMIff/F1MALhcWkVmLUTOf5V6qbH5faThhFokcK7yHgsMygR+CJpa//i4IlhIf2r
	egIMTXZCtT8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CFE696A4D;
	Sun, 15 Jul 2012 01:25:16 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3B3076A4C; Sun, 15 Jul 2012
 01:25:16 -0400 (EDT)
In-Reply-To: <8D1AF968-AF34-4590-AB8F-E644C534A928@wincent.com> (Wincent
 Colaiuta's message of "Sat, 14 Jul 2012 21:01:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 75CCC414-CE3D-11E1-9B18-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201467>

Wincent Colaiuta <win@wincent.com> writes:

> At $day_job we want to start publishing a subtree of our codebase as
> open source. As we audit and prep more sections of the code base,
> we'll be broadening the subtree(s) that we export, until eventually we
> want as close as possible to the whole thing to be open source.
>
> The resulting public repo would only contain commits from the master
> branch that touch the "open" parts of the tree, so while the result
> wouldn't be complete or coherent, it would produce a "read-only" open
> source artifact and allow us to start sharing code today rather than a
> year or two years from now when the entire code base is audited.
>
> I'm thinking of (ab)using filter-branch from a post-receive hook as a
> means to do this. Does this sound sane, or are there better options?
>
> Specifically, I was thinking of doing the following:
>
> - on pushing into our authoritative repo, we replicate to a second
> "scratch" repo where all the dirty work gets done
>
> - the scratch repo has a master branch, and an initial "open" branch
> created using `git filter-branch`

Who controls when "authoritative" to "scratch" transfer happens?
Using post-receive-hook in "authoritative" sounds like a sensible
way to do this.

> - a post-receive hook in the scratch repo, given a series of commits
> A..B on the master branch, cherry-picks them onto the "open" branch,
> producing commits A'..B'

Are there mechanisms to add commits to the "scratch" repository
other than the one that relays the changes from "authoritative"?  If
so, post-receive in "scratch" may be inevitable, but otherwise, I do
not know why you need this processing triggered by the post-receive
in the scratch.  Wouldn't it suffice to make the post-receive in the
"authoritative" do all of these?

I did not see anything wrong doing what you described in the
post-receive, even though having the hook in the "scratch" felt
strange, as the "copying from authoritative" would also want to be
automated and the natural triggering mechanism to do so would be a
post-receive there.  What issues were you worried about?
