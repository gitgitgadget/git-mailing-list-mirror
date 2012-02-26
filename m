From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 4-way diff (base,ours,theirs,merged) to review merge results
Date: Sun, 26 Feb 2012 00:12:07 -0800
Message-ID: <7vpqd2f1yg.fsf@alter.siamese.dyndns.org>
References: <jicafn$gnj$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Neal Kreitzinger" <neal@rsss.com>
X-From: git-owner@vger.kernel.org Sun Feb 26 09:12:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1ZDM-00068c-Fv
	for gcvg-git-2@plane.gmane.org; Sun, 26 Feb 2012 09:12:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306Ab2BZIML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Feb 2012 03:12:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57519 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751074Ab2BZIMK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2012 03:12:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6EE5C421A;
	Sun, 26 Feb 2012 03:12:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M/NErtncK+4X8AdHno9vVoZG7bg=; b=rclI1M
	+RAp71yzg7h5i2bijxFXGJDZmjaIqdBCDE4jqx130tUdc9y5qfqcN/kMcdxTZp43
	8HnjYW5jcst1v12gNAw6AxhvJwdHb8Nq6cJxoXz3RVC1BUfu58vLh/4rBTrjwihT
	gCMuxdz4h600MjAj480y8cS+Qd8GHZ9hIpHAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pUm6yIoUbMypY+EXPaPH2wp1EIQi6e3V
	F4k1G12nUVRHTTlXbAS1mCskUSDYcGHmTuovkvJPH+k0jrp8nj/E1CRNUirwAZy1
	0NrNm8p5MPRH2VPdh5PVqRI+du6rpXTjZoTIk1OtdaaCTmFL32USvxHJWX4ddsaR
	8Of2JJILH8Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 663194219;
	Sun, 26 Feb 2012 03:12:09 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E2D554217; Sun, 26 Feb 2012
 03:12:08 -0500 (EST)
In-Reply-To: <jicafn$gnj$1@dough.gmane.org> (Neal Kreitzinger's message of
 "Sat, 25 Feb 2012 21:55:37 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 93FEE840-6051-11E1-8B00-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191555>

"Neal Kreitzinger" <neal@rsss.com> writes:

> (Combined diff)
> ours:  has line-x
> theirs (master):  does not have line-x
> merged:  has line-x
> merge-base (older master):  *may-or-may-not* have line-x
> conclusion:  I'm not very sure if "merged" should have line-x or not...

When I need this information to resolve a merge in an area of the code
that I am not very familiar with, the first thing I do is this:

  $ git merge $other
  $ git diff
  ... yikes, that is a complex conflict!

  $ git checkout --conflict=diff3 $the_path_with_difficult_conflict
  $ git diff

The output will also show the lines from the merge base.

The default style of showing the conflict we use is called the "merge"
style (it originally came from the "merge" program of the RCS suite), and
it only gives the two sides without the base version.  It is sufficient
when the person who is making the merge is familiar with the baseline
history of the code (e.g. in a contributor-to-integrator pull based
workflow, especially when contributors are encouraged to keep their topics
focused and short). The "diff3" style that also gives the base version is
needed less often in such a setting. That, and also the resulting output
is much shorter, is the reason why "merge" style is the default.

When the person who is making the merge is not very familiar with the
baseline history (e.g. when using Git as an improved CVS and a contributor
pulls the updated upstream into his history), however, "diff3" style may
be more often helpful---as you mentioned, "merge" style requires that you
know your code well enough to either already know or be able to guess how
the version in the merge base looked like, but by definition, pulling the
updated upstream into your work will pull more stuff (because many other
people are working on the code on the other side) than pulling one topic
from a contributor into the integrator tree, so there may be more need to
see the version from the merge base in such a workflow.

By setting the configuration variable "merge.conflictstyle" to "diff3",
you would get the base version by default whenever there is a conflict.
