From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC] git-am: handling unborn branches
Date: Thu, 4 Jun 2015 10:27:17 -0700
Message-ID: <CAGZ79kbvWjoCx0VFJS+B-mvxE62_PaRixMjUSWXwsO-c+LonVQ@mail.gmail.com>
References: <CACRoPnSmF0ym7ONnLAfL=o5ouSrP2Ucxdh40k6Ps-hnTsSUx4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 19:27:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0YvL-0003Kn-Kh
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 19:27:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753872AbbFDR1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 13:27:19 -0400
Received: from mail-qc0-f182.google.com ([209.85.216.182]:35651 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348AbbFDR1S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2015 13:27:18 -0400
Received: by qczw4 with SMTP id w4so20473400qcz.2
        for <git@vger.kernel.org>; Thu, 04 Jun 2015 10:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5MCcErlhvXoZhoDvA5xhF8debbLsmpHO0wepmW+ps2M=;
        b=H9cK9i4bkOPcTlvtuufJPBZRXAl8cxe1vm7B8H1QZ+U2oqRSSIfsRTTtJvfmzav8H9
         xhPaTijUc3fin/zlo/O7W6+uqsoXenzs7x3/tZsbqfQnoc3ZbA2DgAc1AHmpc6py8MzM
         lO947zR2suLcnGYyMPAk2oErbjYj1xWdRbetmYKpegLDwjphbJQBM8f9YBzja9LHU9Wt
         sieCykCoXt8uIcZXQtqeHhAvZzJ4hBs9pjOYUAa7DwfgwKs3TAIFAtjCa7P9tTWlcIEo
         iMZaIeBxgMFBrfZBIP0XGyPhz9UBauBVFQN67klvgDbYHTphsUKHENUHYqXKC70Cr2E1
         xZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=5MCcErlhvXoZhoDvA5xhF8debbLsmpHO0wepmW+ps2M=;
        b=fIUTEY5GBSlZydHEJxAaNxnmKBZ3QMYJU15w8f7MMItyqq7b09jmtpA188FDDMTgp/
         kjyN6dqAZ47SlQqrWlAzqOlOK4s+FObszWYlqW1CpnqczQDlrOO7glcrSa60KHyweaW2
         9T/voBx1CBixKFnfUbm2v8ITAfrdimgjRHEXKT0zWVVeHGpuChmmt4qjxdskrFha/p6A
         rLilRuEqUV/WI5jWuIv8B53oPI1jGPJzfvev8lJ8d3L1KSrI9+t+paLFaMj+CJyYsd7P
         m26mIWhgkLXCTfzJ93Tlho8u2DRIpA65SfOD6LZ8sYj8peENkJmGXbuRDSy6S370/nkf
         mWDg==
X-Gm-Message-State: ALoCoQlIiYyokmgz0OtJxBaOf+xonq4RbVZ5F8LQ0eookGeZ4aT0WiuI9NGoekfgiPRvMvnHy3wN
X-Received: by 10.140.19.48 with SMTP id 45mr20927941qgg.50.1433438837544;
 Thu, 04 Jun 2015 10:27:17 -0700 (PDT)
Received: by 10.140.101.115 with HTTP; Thu, 4 Jun 2015 10:27:17 -0700 (PDT)
In-Reply-To: <CACRoPnSmF0ym7ONnLAfL=o5ouSrP2Ucxdh40k6Ps-hnTsSUx4w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270787>

On Thu, Jun 4, 2015 at 3:34 AM, Paul Tan <pyokagan@gmail.com> wrote:
> Hi,
>
> git-am generally supports applying patches to unborn branches.
> However, there are 2 cases where git-am does not handle unborn
> branches which I would like to address before the git-am rewrite to C:
>
> 1. am --skip
>
> For git am --skip, git-am.sh does a fast-forward checkout from HEAD to
> HEAD, discarding unmerged entries, and then resets the index to HEAD
> so that the index is not dirty.
>
>         git read-tree --reset -u HEAD HEAD
>         orig_head=$(cat "$GIT_DIR/ORIG_HEAD")
>         git reset HEAD
>         git update-ref ORIG_HEAD $orig_head
>
> This requires a valid HEAD. Since git-am requires an empty index for
> unborn branches in the patch application stage anyway, I think we
> should discard all entires in the index if we are on an unborn branch?

That makes sense.

>
> Or, the current behavior of git-am.sh will print some scary errors
> about the missing HEAD, but will then continue on to the next patch.
> If the index is not clean, it will then error out. Should we preserve
> this behavior? (without the errors about the missing HEAD)
>
> 2. am --abort
>
> For git am --abort, git-am.sh does something similar. It does a
> fast-forward checkout from HEAD to ORIG_HEAD, discarding unmerged
> entries, and then resets the index to ORIG_HEAD so that local changes
> will be unstaged.
>
>         if safe_to_abort
>         then
>             git read-tree --reset -u HEAD ORIG_HEAD
>             git reset ORIG_HEAD
>         fi
>         rm -fr "$dotest"
>
> This, however, requires a valid HEAD and ORIG_HEAD. If we don't have a
> HEAD or ORIG_HEAD (because we were on an unborn branch when we started
> git am), what should we do? (Note: safe_to_abort returns true if we
> git am with no HEAD because $dotest/abort-safety will not exist)
> Should we discard all entires in the index as well? (Since we might
> think of the "original HEAD" as an empty tree?)
>
> Or, the current behavior of git-am.sh will print some scary errors
> about the missing HEAD and ORIG_HEAD, but will not touch the index at
> all, and still delete the rebase-apply directory. Should we preserve
> this behavior (without the errors)?

I guess so, looking at the documentation
       --abort
           Restore the original branch and abort the patching operation.

a user may want to not go to the unborn branch, but rather to the previous
HEAD?


>
> Thanks,
> Paul
