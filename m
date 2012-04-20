From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: avoid checking out $branch when possible
Date: Fri, 20 Apr 2012 08:52:06 -0700
Message-ID: <xmqqwr5atn89.fsf@junio.mtv.corp.google.com>
References: <fee3225e29915e1b61e29a5d2fe37db20fa4b596.1334933837.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Shezan Baig <shezbaig.wk@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Apr 20 17:52:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLG89-0005D5-2t
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 17:52:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110Ab2DTPwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Apr 2012 11:52:10 -0400
Received: from mail-bk0-f74.google.com ([209.85.214.74]:33908 "EHLO
	mail-bk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753686Ab2DTPwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2012 11:52:09 -0400
Received: by bkcjm19 with SMTP id jm19so468585bkc.1
        for <git@vger.kernel.org>; Fri, 20 Apr 2012 08:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=T1rr1Xv8gXkuBGwh0I/J66xgDPogpTM36grVJeUBbGE=;
        b=ne2HYue3BNnaBOhlv2jV9GqQIA2v6Rg8jRRWsPwX/sLIXu5pqpS9fFUOzsr2L2Ra18
         ewq69topemioVHnMbXB/cJlvnfpycORhAbatea+OffxC3UOwX7yJcwapxf/nvjJPVEPo
         kTUo2VdWkvEqPVQSzhLgsrAG5rhBaEIxoRU24vMg7Nmvskpe3hZaKKjHtnf+xbCV/Vn3
         IWmYS9GKT5jsBGt0X+Ec0JYPPzDRNRUbCgB/H9PyrpI+7l9ovTcw8UnydcWpUV/pinPg
         JGEq7N2rz+KjQKzWNZXmiaak2MF09a3uqum6wJjFvbSFrD2irFeCCkbQ6TNOYeYy9Ddb
         Kmlw==
Received: by 10.213.108.146 with SMTP id f18mr635391ebp.13.1334937127499;
        Fri, 20 Apr 2012 08:52:07 -0700 (PDT)
Received: by 10.213.108.146 with SMTP id f18mr635378ebp.13.1334937127365;
        Fri, 20 Apr 2012 08:52:07 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id s9si5652602eei.3.2012.04.20.08.52.07
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Fri, 20 Apr 2012 08:52:07 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id 2D9F4200057;
	Fri, 20 Apr 2012 08:52:07 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 6A35FE120A; Fri, 20 Apr 2012 08:52:06 -0700 (PDT)
In-Reply-To: <fee3225e29915e1b61e29a5d2fe37db20fa4b596.1334933837.git.trast@student.ethz.ch>
	(Thomas Rast's message of "Fri, 20 Apr 2012 17:05:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQmLXgGeGB4Adb23FjuzPqWrdJp2ohFF7edF8QVFbTfSsuRyJg87BzcFacPzfqrO415jyf+xiHoluh6936M5iPuXpgCeMal+gPpSDy7Zu9883h/nQAjNd0XjaMUTokVAQGz9VOm25yPK1afnAmYbZA3P/uBiM+KnnBmRcIUjTOo5MyeOzp4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196004>

Thomas Rast <trast@student.ethz.ch> writes:

> I was a bit torn on whether I should abort with checkout, or without
> it.  The manual clearly states that rebase "will perform an automatic
> git checkout <branch> before doing anything else", which mandates at
> least *trying* the checkout in the error path, hence this version.
>
> However, in contrived cases this can lead to strange behavior.  For
> example, a checkout conflict with a file in the worktree may prevent
> the abort path from working correctly, even though going through with
> the rebase itself may succeed.

Given all that contortion, is it even worth doing this?
