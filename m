From: Dave Olszewski <cxreg@pobox.com>
Subject: Re: Re: [PATCH] rebase--interactive: don't enforce valid
 branch
Date: Mon, 15 Mar 2010 01:41:30 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1003150132060.4362@narbuckle.genericorp.net>
References: <1268628502-29696-1-git-send-email-cxreg@pobox.com> <7vsk82i2kd.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.1003142227100.796@narbuckle.genericorp.net> <7vvdcygmz8.fsf@alter.siamese.dyndns.org> <7vd3z6f6wt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 15 09:41:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nr5rm-000116-2s
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 09:41:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935747Ab0COIld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 04:41:33 -0400
Received: from 62.f9.1243.static.theplanet.com ([67.18.249.98]:55775 "EHLO
	62.f9.1243.static.theplanet.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935693Ab0COIlc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Mar 2010 04:41:32 -0400
X-Envelope-From: cxreg@pobox.com
Received: from localhost (count@narbuckle [127.0.0.1])
	(authenticated bits=0)
	by 62.f9.1243.static.theplanet.com (8.13.8/8.13.8/Debian-3) with ESMTP id o2F8fUu8013158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 15 Mar 2010 03:41:31 -0500
X-X-Sender: count@narbuckle.genericorp.net
In-Reply-To: <7vd3z6f6wt.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142195>

On Sun, 14 Mar 2010, Junio C Hamano wrote:

> Ahh, Ok, the point is that when we start this sequence we are on a branch,
> and then you want to end up on a detached HEAD that points at the result
> of the branch.

Yep, you got it


> I'll queue it in 'pu', but with a little tweak to the test to make it
> clear what is going on, perhaps like this.
>
>    test_expect_success 'rebase while detaching HEAD' '
>            git symbolic-ref HEAD &&
>            grandparent=$(git rev-parse HEAD~2) &&
>            test_tick &&
>            FAKE_LINES="2 1" git rebase -i HEAD~2 HEAD^0 &&
>            test $grandparent = $(git rev-parse HEAD~2) &&
>            test_must_fail git symbolic-ref HEAD
>    '

Good idea.  Thanks.


> We may need to document this behaviour, by the way, if we make it official
> that the extra "branch to be rewritten" parameter can be a non-branch.
> Two points are that you can give arbitrary commit, and that you will end
> up with a detached HEAD that points at the result if you did so.
>
> Also I did't followed the code, but does it behave sanely when you say
> "rebase --abort"?

Good question.  It turns out that both rebase and rebase -i will end
up on the commit specified by <branch>, whether it's a branch or not.
That might be the expected and desired behavior, though:

   [Starting on branch A]
   git rebase origin/B B
   git rebase --abort
   [HEAD is now a symref to B]

   [Starting on branch A]
   git rebase origin/B B^0
   git rebase --abort
   [HEAD is now detached at B^0]
