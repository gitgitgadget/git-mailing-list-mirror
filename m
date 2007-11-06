From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-revert is one of the most misunderstood command in git, help users out.
Date: Tue, 06 Nov 2007 03:08:53 -0800
Message-ID: <7vk5oviqbe.fsf@gitster.siamese.dyndns.org>
References: <1194289301-7800-1-git-send-email-madcoder@debian.org>
	<CD2E6759-9E7E-41E6-8B58-AB6CA9604111@midwinter.com>
	<7vlk9cmiyq.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0711052325090.4362@racer.site>
	<7vsl3kjdct.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 06 12:09:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpMJ8-00026b-1d
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 12:09:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756035AbXKFLJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 06:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756025AbXKFLJE
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 06:09:04 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:41004 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755197AbXKFLJC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 06:09:02 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 91FBC2EF;
	Tue,  6 Nov 2007 06:09:23 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id E723A91BAE;
	Tue,  6 Nov 2007 06:09:16 -0500 (EST)
In-Reply-To: <7vsl3kjdct.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 05 Nov 2007 18:51:14 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63660>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> In the same way, I would expect "git revert <commit> -- file" to undo the 
>> changes in that commit to _that_ file (something like "git merge-file 
>> file <commit>:file <commit>^:file"), but this time commit it, since it 
>> was committed at one stage.
>
> Allowing people to revert or cherry pick partially by using
> paths limiter is a very good idea; ...

As Pierre said earlier, a partial revert via "revert <commit> --
<paths>" and a partial cherry-pick would make quite a lot of
sense, and in addition, it should not be too hard to add.

Reusing the 'merge-recursive' part should be almost trivial.
The only tricky part is coming up with a fake tree using base
and next commit in revert_or_cherry_pick() for this purpose.

When replaying the change from A->B (when cherry-picking, A is
the parent and B is what was named from the command line; when
reverting, they are the other way around), instead of doing the
three-way merge using:

	merge-recursive A HEAD B

you would first come up with a modified tree B' that has the
identical contents to A _except_ the parts the path limiters
specify which are taken from B.  Then running

	merge-recursive A HEAD B'

would replay the revert or cherry-pick of change from A->B,
limited by the path, on top of the current HEAD.

As to "reverting to the index" case, if somebody is interested
in doing a builtin-checkout.c, please keep in mind that major
parts of that work should be made available to the
implementation of "git revert [--] <paths>", as it appears that
it will be exactly the same as "git checkout" with the same set
of options.

I am wondering what "git cherry-pick -- <paths>" should do.  My
current thinking is that it would not make any sense at all.
