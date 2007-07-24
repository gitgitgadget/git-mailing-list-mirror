From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] filter-branch: rewrite only refs which were not excluded 
 bythe options
Date: Tue, 24 Jul 2007 13:23:34 +0200
Organization: eudaptics software gmbh
Message-ID: <46A5E136.D413D3B7@eudaptics.com>
References: <Pine.LNX.4.64.0707231829210.14781@racer.site>
	 <46A5C615.24C24F0F@eudaptics.com> <Pine.LNX.4.64.0707241205480.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 24 13:23:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDIUH-0003Hq-FW
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 13:23:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763559AbXGXLXa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 07:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757825AbXGXLX3
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 07:23:29 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:22224 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754473AbXGXLX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 07:23:28 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtp (Exim 4.66)
	(envelope-from <J.Sixt@eudaptics.com>)
	id 1IDIU9-0005mV-4y; Tue, 24 Jul 2007 13:23:25 +0200
Received: from eudaptics.com (tethys.linz.eudaptics [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 2D7D255DD; Tue, 24 Jul 2007 13:23:25 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 2.3 (++)
X-Spam-Report: AWL=-1.355, BAYES_99=3.5, FORGED_RCVD_HELO=0.135
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53571>

Johannes Schindelin wrote:
> So really exclude excluded refs from being rewritten.  This also allows
> you to safely call
> 
>         git filter-branch <some-filter> --all <rev-list options>
> 
> to rewrite _all_ branches and tags.

BTW, '--all' in the argument list of filter-branch works only if it is
preceded by '--':

	git filter-branch <some-filter> -- --all <rev-list options>

> @@ -181,6 +181,7 @@ export GIT_DIR GIT_WORK_TREE=.
> 
>  # These refs should be updated if their heads were rewritten
> 
> +negatives="$(git rev-parse --revs-only "$@" | grep "^\^")"
>  git rev-parse --revs-only --symbolic "$@" |
>  while read ref
>  do
> @@ -196,7 +197,13 @@ do
>                         grep "refs/\(tags\|heads\)/$ref$")"
>         esac
> 
> -       git check-ref-format "$ref" && echo "$ref"
> +       # make sure we have a valid ref
> +       git check-ref-format "$ref" || continue
> +
> +       # if the ref has been excluded by the other options, skip it
> +       test -z "$(git rev-list -1 "$ref" $negatives)" && continue

Does this catch my use-case with --since? I think not, because:

$ git rev-parse --revs-only --since=2007.01.01 master topic
--max-age=1167606000
257061f3323dc0162f731d934f0870e919211fdf
3405729b94a654df8afbb9a1e13a4cf49a1c351c

There are no negatives. Does it help to filter the non-positives?

negatives=$(git rev-parse --revs-only "$@" | egrep -v '^[0-9a-f]{40}$')

(Except the the '{40}' part is not portable. Hmpf.)

-- Hannes
