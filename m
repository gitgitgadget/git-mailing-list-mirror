From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] add t3420-rebase-topology
Date: Tue, 18 Sep 2012 00:51:14 -0700
Message-ID: <7vzk4nojkd.fsf@alter.siamese.dyndns.org>
References: <1347949878-12578-1-git-send-email-martinvonz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 09:51:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDsaf-0006ex-Co
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 09:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329Ab2IRHvS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 03:51:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50591 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932098Ab2IRHvR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 03:51:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 108724CC4;
	Tue, 18 Sep 2012 03:51:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rm01Yr1nNgzq5hjaNG3DJ90ijYI=; b=pwiyLA
	1umux/OM1x7ZcajmJUNLLOGiDxtL585tamlwAlRCOxbd0DYVPfkf55PkAZW1/Oll
	R6Xecbd283XYx2efQXomWVFe1HhvDFty/Nju6unLAdz14CoNK5xWdno2A+sQPu6w
	eryicOUFAoOV8AkzW4mTdDMajuLeDuvzZtj2s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fOqARhqwArXnmk5pcBWFmm11MUW0Mkd2
	7EeMYYnz9W5z6tL/7P/096X3Iev9/+O2s4qZu6QDMq/ItSn/xsKr2DMxo8zIMXyN
	JIXHzN8IT/S66uLHImUUdi2YIttGRFbYR3VOeqq3dadTFwsRcpoi1GO3KXqpubME
	nDHXVBz/aTs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1C074CC3;
	Tue, 18 Sep 2012 03:51:16 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2A79C4CC2; Tue, 18 Sep 2012
 03:51:16 -0400 (EDT)
In-Reply-To: <1347949878-12578-1-git-send-email-martinvonz@gmail.com> (Martin
 von Zweigbergk's message of "Mon, 17 Sep 2012 23:31:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9FF9EFAE-0165-11E2-BF1D-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205805>

Martin von Zweigbergk <martinvonz@gmail.com> writes:

> do you agree
> that 'rebase --onto does not re-apply patches in onto' is desirable?

This depends on how you look at --onto.  Recall the most typical and
the original use case of rebase:

                               A'--C' your rebased work
                              /
  ---o---o---o---F---B'--o---T master
     ^            \
     v1.7.12       A---B---C your work

You could view "git rebase master" as a short-hand for

        $ git rebase --onto $(git merge-base master HEAD) master

i.e.

        $ git rebase --onto F master

If you view "onto" that way, you would certainly do not want to see
B replayed on top of T, which already contains another replay of B
in its history.

The intended use case for "--onto", however, is primarily to replay
a history to older base, i.e.


       A'--B'--C' your rebased work
      /
  ---o---o---o---F---B'--o---T master
     ^            \
     v1.7.12       A---B---C your work


        $ git rebase --onto v1.7.12 master

which is a moral equivalent of

        $ git checkout v1.7.12
        $ git cherry-pick A B C ;# or git cherry-pick master..HEAD

You could argue that you can compute the patch equivalence between
the commits in "onto..master" and commits in "master..HEAD" and
filter out the equivalent commits to reach the expected results in
either cases, and at the logical level, it certainly will produce
the result I showed in the above illustrations.

But there are two flaws in such an argument.

The "replay to an updated base" case (i.e. without "--onto") expects
to see duplicated commits in the updated history.  That is the only
reason you would want to rebase---otherwise you can keep the old
fork point and keep polishing your work and merge when it is truly
ready.  More importantly, the old master (the fork point F) and
updated master (the current tip T) are expected to have some
ancestry relationship between them.  For these reasons, running the
equivalent of "git cherry" to filter commits with patch equivalence
makes perfect sense.

On the other hand, when the user replays to an older base, she has
some idea what constitutes "a series" that she is replaying (i.e.
"$(git merge-base master HEAD)..HEAD").  It smells to go against the
user's world model if the command silently filtered commits by patch
equivalence.  The user wanted to replay A, B and C in that case, and
it is better to stop the process and make her inspect the history
when the older base happened to have a patch-equivalent commit that
would cause a conflict. That would give her a chance to assess the
situation, instead of silently dropping some of these three commits
that she initially thought constitutes the series and ending up with
a series with only two commits.

Besides, the whole point of a separate "onto" is to allow the user
to specify a commit that does not have a straightforward ancestry
relationship with the bottom of the series (i.e. either "master" or
"F"), and computation of patch equivalence is expected to be much
higher.  Given that it is unlikely to find any match, it feels
doubly wrong to always run "git cherry" equivalent in that case.

So I dunno, as I can argue both ways.

My gut feeling is that "git rebase master" and "git rebase --onto F
master" should not be identical in this regard and an explicit
"onto" should omit the patch equivalence filtering, but I can be
persuaded otherwise with good arguments.

> How about 'rebase --root is not a no-op'?

  ---o---o---o---F---B'--o---T master
     ^            \
     v1.7.12       A---B---C your work

If "git rebase F" when you are at C in the above illustration
(reproduced only the relevant parts) is a no-op (and I think it
should be), "git rebase --root" in the illustration below ought to
be as well, no?

                 F---B'--o---T master
                  \
                   A---B---C your work
