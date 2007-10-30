From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 10/10] push: teach push to be quiet if local ref is strict subset of remote ref
Date: Tue, 30 Oct 2007 11:15:59 +0100
Message-ID: <52171BF7-50E2-473E-A0BD-CB64D38FD502@zib.de>
References: <1193593581312-git-send-email-prohaska@zib.de> <11935935812741-git-send-email-prohaska@zib.de> <1193593581114-git-send-email-prohaska@zib.de> <1193593581486-git-send-email-prohaska@zib.de> <11935935812185-git-send-email-prohaska@zib.de> <11935935822846-git-send-email-prohaska@zib.de> <11935935821136-git-send-email-prohaska@zib.de> <11935935823045-git-send-email-prohaska@zib.de> <11935935821800-git-send-email-prohaska@zib.de> <11935935823496-git-send-email-prohaska@zib.de> <11935935821192-git-send-email-prohaska@zib.de> <7vfxztm2dx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 11:16:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Imo8q-0000O9-BV
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 11:16:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992AbXJ3KP7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 06:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752017AbXJ3KP6
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 06:15:58 -0400
Received: from mailer.zib.de ([130.73.108.11]:47058 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751551AbXJ3KP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 06:15:58 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9UAEXW7007588;
	Tue, 30 Oct 2007 11:14:34 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9UAEXrU008980
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 30 Oct 2007 11:14:33 +0100 (MET)
In-Reply-To: <7vfxztm2dx.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


On Oct 30, 2007, at 9:29 AM, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>> git push now allows you pushing a couple of branches that have
>> advanced, while ignoring all branches that have no local changes,
>> but are lagging behind their matching remote refs. This is done
>> without reporting errors.
>>
>> Thanks to Junio C. Hamano <gitster@pobox.com> for suggesting to
>> report in the summary that refs have been ignored.
>
> I do not think this is a good idea at all.  Furthermore, I never
> suggested anything about summary.

Yeah, sorry. You only asked if the summary does mention
something; not suggesting it should do so.


> You are robbing the
> information from the pusher which ones are pushed and which ones
> are left behind.

Absolutely; because the branches left behind are not
interesting. The remote already is ahead of the local
branches. The local branches are just left were they are. They
have no new information on them.  Forcing an push would _rewind_
the remote without adding anything to it.

If you really intended to do a rewind you should have passed
'--force' in the first place and my report would never be
printed.


> It simply is insane to make this strange rule 10/10 introduces
> the default behaviour.  It is too specific to a particular
> workflow (that is, working with a shared central repository,
> having many locally tracking branches that are not often used
> and become stale, and working on only things to completion
> between pushes).

I don't think its very strange behaviour if you see it in the
light of what the user wants to achieve. We are talking about
the case were only fast forward pushes are allowed. So, we
only talk about a push that has the goal of adding new local
changes to the remote. The user says "git push" and means
push my new local changes to the remote.

Unfortunately, the remote may have advanced differently from
the local branch, and the push must fail because someone needs
to merge first. git push recommends to do a pull and retry, which
is the right thing to do.

My strange rule 10/10 adds a check that verifies if the local
side has something interesting to push. Only in this case a
pull make sense. If you do not have something new, a pull will
be a fast-forward, and just a waste of time.

In this light I think the current behaviour is insane, because
it asks the user to spend time on things that do not add any
value. No new commits, no new information, no need to merge, no
need to push again, no need to report errors ...

> I think we could live with an optional behaviour, in addition to
> the current "matching refs" behaviour, that is "matching refs,
> ignoring strict ancestors", though, but I doubt it is worth the
> addition.

... just ignore strict ancestors by default.

	Steffen
