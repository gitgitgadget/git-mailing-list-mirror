From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Wed, 4 Sep 2013 09:10:47 +0100
Message-ID: <20130904081047.GB2582@serenity.lan>
References: <1377988690-23460-1-git-send-email-felipe.contreras@gmail.com>
 <xmqqd2opu8hr.fsf@gitster.dls.corp.google.com>
 <CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com>
 <xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 04 10:11:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VH8Ba-0002L1-4W
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 10:11:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934370Ab3IDIL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 04:11:28 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:34711 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934321Ab3IDILA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 04:11:00 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 56E3FCDA5EE;
	Wed,  4 Sep 2013 09:10:59 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fzMaL-0TWy7X; Wed,  4 Sep 2013 09:10:56 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id A499ECDA5B9;
	Wed,  4 Sep 2013 09:10:49 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233819>

On Tue, Sep 03, 2013 at 03:38:58PM -0700, Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > On Tue, Sep 3, 2013 at 12:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
> >>
> >>> Junio already sent a similar patch, but I think this is simpler.
> >>
> >> I agree that this is simpler, but I am not sure if the behaviour is
> >> necessarily better (note that this is different from saying "I think
> >> the behaviour of this patch is worse").  The motivation I read from
> >> the original discussion was that new people did "git pull" (no other
> >> parameters) to "sync my tree with the central repository" as if it
> >> were SVN, and because we are not SVN, projects that prefer rebases
> >> were unhappy, and the other one was to address *only* that use case.
> >> I do not personally like that special casing (i.e. "only when no
> >> 'integrate with what from where' is given"), and applying the "you
> >> must be explicit between rebase and merge" like this series does
> >> uniformly might (or might not) be a good thing.  I dunno.
> >
> > As I already said; there's is essentially no difference between "git
> > pull" and "git pull origin".
> 
> We know what you said earlier. That does not make it right or wrong,
> but I do not think it is in line with the original discussion (that
> is why John Keeping is kept on the Cc: line).

I think there are two distinct uses for pull, which boil down to:

    (1) git pull
    (2) git pull $remote $branch

For (1) a merge is almost always the wrong thing to do since it will be
backwards and break --first-parent.

But for (2) a merge is almost always the correct thing to do (in fact it
may even be correct to create a merge commit even when this fast
forwards) because this most likely comes for a pull request workflow.

> I do not think we know what we want is to affect "git pull origin".

I consider "git pull $remote" to be an artifact of the way git-pull is
implemented on top of git-fetch; perhaps I'm missing something but I
can't see a scenario where this is useful.  In the series currently in
"next", we treat this as (2) above but that's primarily because it is
difficult to differentiate these in git-pull.sh without adding code to
understand all of the options to git-fetch (or at least those that can
accept unstuck arguments).

Changing this so that "git pull $remote" is treated as (1) would be
better, but I think it is more important to avoid catching case (1) in
the same net which is why jc/pull-training-wheel simply checks if "$#"
is zero; the cost of getting this completely right outweighed the
benefit of getting code in that will catch 99% of users.
