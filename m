From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/10] push: teach push to be quiet if local ref is strict subset of remote ref
Date: Fri, 02 Nov 2007 03:44:11 -0700
Message-ID: <7v7il13p1g.fsf@gitster.siamese.dyndns.org>
References: <1193593581312-git-send-email-prohaska@zib.de>
	<11935935823045-git-send-email-prohaska@zib.de>
	<11935935821800-git-send-email-prohaska@zib.de>
	<11935935823496-git-send-email-prohaska@zib.de>
	<11935935821192-git-send-email-prohaska@zib.de>
	<7vfxztm2dx.fsf@gitster.siamese.dyndns.org>
	<52171BF7-50E2-473E-A0BD-CB64D38FD502@zib.de>
	<7vejfcl8aj.fsf@gitster.siamese.dyndns.org>
	<F5F68690-68A3-4AFC-A79C-FF02910F0359@zib.de>
	<7v8x5jiseh.fsf@gitster.siamese.dyndns.org>
	<B3C76DB8-076D-4C43-AC28-99119A05325C@z ib.de>
	<7vve8nglrt.fsf@gitster.siamese.dyndns.org>
	<B16F7DA1-E3E5-47A4-AFD3-6680741F38F1@zib.de>
	<7vlk9jgeee.fsf@gitster.siamese.dyndns.org>
	<6B0CD829-A964-410B-8C23-74D26BD2C0FA@zib.de> <!
	47299855.9010204@op5.se> <3550D197-CA8C-4B06-9A95-3C7F18EBEFA7@zib.de>
	<7vfxzpbtxv.fsf@gitste! r.siamese.dyndns.org>
	<63FCD695-B952-4624-854C-0F1C662D94D1@zib.de>
	<7vk5p15bkv.fsf@gitster.s! iamese.dyndns.org>
	<417C801B-5DFF-4753-AB32-0FA1EB30C8E2@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri Nov 02 11:44:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inu0v-0001I9-TJ
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 11:44:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753473AbXKBKoU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 06:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753449AbXKBKoT
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 06:44:19 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:39434 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118AbXKBKoS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 06:44:18 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id B19EC2EF;
	Fri,  2 Nov 2007 06:44:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 03FBB906B4;
	Fri,  2 Nov 2007 06:44:34 -0400 (EDT)
In-Reply-To: <417C801B-5DFF-4753-AB32-0FA1EB30C8E2@zib.de> (Steffen Prohaska's
	message of "Fri, 2 Nov 2007 11:03:45 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63101>

Steffen Prohaska <prohaska@zib.de> writes:

> - in a pull-oriented workflow (Linux kernel, git) ...
>   ... There's maybe also less need to push to heads named
>   differently on the local and the remote (though I'm not sure
>   if this really true).

That's far from true but is irrelevant to the discussion of
supporting shared repositories better.

> - in a workflow that is base on shared branches (CVS-style),
>   ...
>   In addition push should push back to the remote branch a local
>   topic was originally branched off.

Why?  If it is shared, and if you are shooting for the simplest
set of commands, wouldn't you work this way?

	$ git clone $public my-work-dir
        $ cd my-work-dir
        $ git checkout -b --track foo origin/foo
        $ hack hack hack, commit, commit, commit *on* *foo*
        $ git push $public foo

I think the recent git defaults to --track anyway so the third
step do not spell out --track.

With your "remote.$public.push = HEAD", the last step would be
"git push" without any parameter.

If you do use private topics, then the story would change this
way:

        $ git checkout -b --track foo origin/foo
        $ git checkout -b topic1 foo ;# or origin/foo
        $ hack hack hack, commit, commit, commit on topic1
        $ git checkout -b topic2 foo ;# or origin/foo
        $ hack hack hack, commit, commit, commit on topic2
        $ git checkout foo
        $ git merge topic1
        $ test test test; # test _your_ changes
        $ git merge topic2
        $ test test test; # test _your_ changes
        $ git push ;# again push 'foo' out

This may fail to fast forward.  You may at this time want to
"git fetch" first, rebase topic1 or topic2 that conflict with
the other side on top of updated origin/foo, rebuild foo and
push the result out, like this:

	$ git fetch
        $ git rebase origin/foo topic1
        $ git branch -f foo origin/foo
        $ git checkout foo
        $ git merge topic1
        $ git merge topic2
        $ test test test
        $ git push

>   ... This makes the need for
>   pushing to a branch named differently on the remote side more
>   likely than in a pull-oriented workflow,

So I do not understand this remark.
