From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] disallow branch names that start with a hyphen
Date: Sun, 22 Aug 2010 14:20:17 -0700
Message-ID: <7vsk262vla.fsf@alter.siamese.dyndns.org>
References: <20100822140801.GA6574@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun Aug 22 23:20:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnHy1-0005Vt-Qs
	for gcvg-git-2@lo.gmane.org; Sun, 22 Aug 2010 23:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756Ab0HVVU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Aug 2010 17:20:26 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55983 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729Ab0HVVU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Aug 2010 17:20:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B9FB9CFD7E;
	Sun, 22 Aug 2010 17:20:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=d58ELzRjrgn+XhDDqhevxmsTU8Q=; b=oKiDpzcG+Igmv0uqFSbt5yk
	QqwMS21OTjlEx21lZ76bBJ/1J8qsrhjrVIyrOucQdibhCCRE0QdgJXpBIik17Fzd
	38fkLAWzKzW5KnP4tKvRAczsirwJl1gtl5EAMYv93ATR+p4XZTyGvM/Sfuzd24do
	C0K5Iw+Bdjv27L1axFbo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=ij7jK9xzRzl+YheJAepI9LXVA5ryJKuV5MkSvJD1zBYn4S0X3
	EmskseELnzAJFgkihkwzW098suG4bQkc7zA+/B2iA1LDnguUm0XuDbVKaxK44BTn
	Q27tzrY+Wfwkv4tTrWjEeWF4Vx+6R7W/29G/T46CJ1Sfb8jiA4nn9mKU1M=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 84BFBCFD7C;
	Sun, 22 Aug 2010 17:20:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AE779CFD7A; Sun, 22 Aug
 2010 17:20:18 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 12BA550C-AE33-11DF-ACD4-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154194>

Clemens Buchacher <drizzd@aon.at> writes:

> Branch names such as "-", "--" or even "---" do
> not work with git checkout. Anything that starts
> with a hyphen is also potentially ambiguous with a
> command option.
>
> In order to avoid mistakes, do not allow such
> branch names.
>
> Signed-off-by: Clemens Buchacher <drizzd@aon.at>
> ---
>  refs.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

While the inconsistency between "git branch -- -foo" (which succeeds and
creates refs/heads/-foo) and "git checkout -foo" (whcih does not work) is
a valid issue to address, I think this patch does so at a wrong level of
abstraction.  The abstractions implemented by refs.c and friends are at
the plumbing layer that is accessible by Porcelain scripts other people
write, and we should try not to break them with policy decisions the
Porcelains (e.g. "git checkout") we ship as part of the core git (e.g. we
do not like a branch whose name begins with a dash).

Currently these succeed:

    git update-ref refs/mine/-foo HEAD
    git update-ref -d refs/mine/-foo

so it is reasonable to expect that somebody has a Porcelain that uses a
convention to use its own refs namespace "mine" with leading dash to mean
something to it.  Your patch would break such a Porcelain rather badly,
but I do not think we have to break this to fix your problem.

Two valid approaches would be: (1) teach a syntax to checkout to allow
checking out such a branch; or (2) forbid "checkout -b" and "branch" from
creating such a branch.

I do not think in the context of the core git Porcelain it is necessary
to start allowing checking out "-foo" which we didn't before, so how about
fixing this by tightening the command line parsing rules for Porcelain
commands that create a new branch?

Note that either way update-ref should be kept as is, to allow third party
Porcelains to keep doing what they have been doing, _and_ to allow
unfortunate users who ran a broken "git branch" command with "-- -foo" as
its arguments to recover from it.

Hmm?
