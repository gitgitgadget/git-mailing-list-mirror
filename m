From: John Arthorne <arthorne.eclipse@gmail.com>
Subject: Re: receive.denyNonNonFastForwards not denying force update
Date: Mon, 10 Sep 2012 09:24:20 -0400
Message-ID: <CAHgXSoqZMPC8uawL7f+7iq-L=Ns+G2w4kh3_oV3DB=WXnTg+Ug@mail.gmail.com>
References: <CAHgXSop42qWcAEGn6=og8Pistv_Jrwhgcnv3B_ORVtSMi1fCHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 10 15:31:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB45K-0004vJ-Bd
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 15:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754716Ab2IJNbV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 09:31:21 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35569 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010Ab2IJNbU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 09:31:20 -0400
Received: by obbuo13 with SMTP id uo13so2883870obb.19
        for <git@vger.kernel.org>; Mon, 10 Sep 2012 06:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=ZYPilibyORBzvk+cMozgr0IE+Yes4SJEnLJhxfmkoGo=;
        b=pKboqPIYpPR2olHW+Eajzg0+7CCthDRsISCc8HrL1r63bBq4U69qpLLKFGrvqTrM/6
         4GAvminItEgSz0rX6vpJZVidYeA+T2W8AeYO3g46hf3LNqtncLz2IO2CFty7mvzRc4y0
         WB6NJOG5loLCB6i0lNpqYSVTnU/VlINJVgxDUEAF4VuYLnQShIpNq4OiPtL2em+WsDqv
         jiAcrcid6LnjDngGQUEg2mgsPHpRHETiS7uaNBvRa2SaMk16xoFQu2ERQD4INyHaUQ7Y
         b0YFPUra/uWGVkD8tNNo5nRJ8wRufjaMIeqCQdFR55oMvXKL2O3rYSxyoEa29Gelo8iL
         dOkA==
Received: by 10.182.76.161 with SMTP id l1mr14401854obw.72.1347283480559; Mon,
 10 Sep 2012 06:24:40 -0700 (PDT)
Received: by 10.182.144.66 with HTTP; Mon, 10 Sep 2012 06:24:20 -0700 (PDT)
In-Reply-To: <CAHgXSop42qWcAEGn6=og8Pistv_Jrwhgcnv3B_ORVtSMi1fCHA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205123>

Just to close the loop on this thread, it did turn out to be a
permission problem in our case. It was difficult to track down because
it was only a problem on one server in the cluster. Each server had a
system git config file at /usr/local/etc/gitconfig. This was a symlink
pointing to a single common config file at /etc/gitconfig. This real
file had correct content and permissions, and all the machines where
eclipse.org allows shell access had correct symlinks. So any tests on
the command line always showed that the system config looked fine.
However on git.eclipse.org, which is the machine with the central
repositories we are pushing to, the symlink was missing o+rx. For
security reasons this machine doesn't allow shell access, but our
pushes to this machine were failing to honour the system
configuration. I gather the patch prepared earlier in this thread will
cause an error to be reported when the system config could not be
read, which sounds like a good fix to help others track down problems
like this.

John Arthorne


On Fri, Aug 17, 2012 at 12:26 PM, John Arthorne
<arthorne.eclipse@gmail.com> wrote:
> At eclipse.org we wanted all git repositories to disallow non-fastforward
> commits by default. So, we set receive.denyNonFastForwards=true as a system
> configuration setting. However, this does not prevent a non-fastforward
> force push. If we set the same configuration setting in the local repository
> configuration then it does prevent non-fastforward pushes.
>
> For all the details see this bugzilla, particularly comment #59 where we
> finally narrowed this down:
>
> https://bugs.eclipse.org/bugs/show_bug.cgi?id=343150
>
> This is on git version 1.7.4.1.
>
> The Git book recommends setting this property at the system level:
>
> http://git-scm.com/book/ch7-1.html (near the bottom)
>
> Can someone confirm if this is intended behaviour or not.
>
> Thanks,
> John Arthorne
