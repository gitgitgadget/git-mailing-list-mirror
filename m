From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase --fix: interactive fixup mode
Date: Sun, 08 Jan 2012 14:58:42 -0800
Message-ID: <7vfwfpg5st.fsf@alter.siamese.dyndns.org>
References: <20120108213134.GA18671@ecki.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun Jan 08 23:58:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rk1hU-0006Se-Fa
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 23:58:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754758Ab2AHW6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jan 2012 17:58:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55762 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754602Ab2AHW6p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 17:58:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B642B7CD2;
	Sun,  8 Jan 2012 17:58:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bBgvB9G87n2CCJCqyn7ULsE/gt0=; b=OVQdN5
	Izd5LYsdDJs81wABHoqsC+o2UW2/8sOEc1uT+wbsRrIy9lXgcV1iduptl2D9PHT8
	vGd9mkDe2S/2xV4G1xI/YBBjnCzkxnT0b9/izAyHu0RhteygK9jqg/zBGBE+RAxu
	VvmfCF1K3h5SJQpTXSWcjZZshU0+QwCLQnkHo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nbMSvnYN0IqZ9QgG50YKv6/rPZ7DIa31
	SY4UP6o/ak2AZ7zB8f6NPE9ignzKJ3iBP9kxpKH2kuYsejdFM31WX7JLkVYMFw4V
	dgYlHRzmLtY7tUxTEOKwZtVl+sjVKIxKNpoQ00DuVkdh/ukv1QGvd2vnom7UXSEH
	XnGhL2ZT0LQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD2887CD1;
	Sun,  8 Jan 2012 17:58:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 07CC87CCD; Sun,  8 Jan 2012
 17:58:43 -0500 (EST)
In-Reply-To: <20120108213134.GA18671@ecki.lan> (Clemens Buchacher's message
 of "Sun, 8 Jan 2012 22:31:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5081AE0C-3A4C-11E1-A422-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188150>

Clemens Buchacher <drizzd@aon.at> writes:

> Interactive rebase is frequently used not to rebase history, but to
> manipulate recent commits. This is typically done using the following
> command:
>
>  git rebase -i HEAD~N
>
> Where N has to be large enough such that the the range HEAD~N..HEAD
> contains the desired commits. At the same time, it should be small
> enough such that the range HEAD~N..HEAD does not include published
> commits or a merge commit. Otherwise, the user may accidentally change
> published history. Rebasing a merge commit can also have the generally
> undesirable effect of linearizing the merge history.
>
> In order to determine a suitable range automatically, it is a reasonable
> heuristic to rebase onto the most recent merge commit.

I understand the problem you are trying to solve, but I am not sure if
this is a good idea from the UI point of view for two reasons.

 - "We want to limit the extent of the operation to commits since the last
   merge" is by itself a reasonable thing to ask, and I do not think it
   should be limited to "rebase". If we had an extended SHA-1 syntax to
   express it, for example, you may want to say "I want to see what I did
   since the last merge" and run "git log $last_merge_before_HEAD..".
   Perhaps HEAD~{merge} or something?

 - If your "rebase --fix" is to "fix" things, what is "rebase -i" about?
   Isn't it also about fixing? I imagine that ordinary people expect a
   "fix" option that takes a parameter would take a commit to be fixed,
   and drive the rebase machinery to quickly fix it; in other words,

	$ git rebase --fix=':/^reword the greeting message'

   may internally run "rebase -i $(git rev-parse ':/^rewor...')^", with
   the insn sheet already prepared to "edit" the first commit in it, and
   may even return the control back to the user without showing the insn
   sheet in the editor.

Hmm?

   
