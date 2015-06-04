From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] git-am: handling unborn branches
Date: Thu, 04 Jun 2015 10:26:34 -0700
Message-ID: <xmqqpp5bv0z9.fsf@gitster.dls.corp.google.com>
References: <CACRoPnSmF0ym7ONnLAfL=o5ouSrP2Ucxdh40k6Ps-hnTsSUx4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 19:26:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0Yug-0002q3-6Q
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 19:26:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617AbbFDR0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 13:26:38 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:33422 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348AbbFDR0h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2015 13:26:37 -0400
Received: by iebgx4 with SMTP id gx4so40893585ieb.0
        for <git@vger.kernel.org>; Thu, 04 Jun 2015 10:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=a609piFdCl5pHhFa7It2L6XatSKWhH1DBnaUWBp2OxM=;
        b=VrwiIJf6At6xaCRHDY+LJ3be9HiQoByWfjU3BtIpWjF0zDEBBO8m+QT6QMBFg7thYz
         uyjV3cZHghZ+eAIoohOB6gzrbUqkmDrgDcf1ymSgEV0mFbtlCnr4EhsIY+zLx96M1u7s
         q6InYBtJaYv/fxjOTdy9fvaoUqRxxitJx8w0MAHIinnqOXPu4sh7jAd4FCPqAggm+u/h
         SRT2Bmx6sz7vtX6Hfqxmk7HGu64o/WX4hwxoFjQVgWXClPHbFlOXj7vqWoY+GwaW9pca
         WVmy7rVFqme5LcILs6Lm7hc53X4jkrjwO+s2RmMFis7Ap3FUZM+UG44Gy7F+MHQfWXR3
         +UxQ==
X-Received: by 10.42.146.202 with SMTP id k10mr5727149icv.34.1433438796493;
        Thu, 04 Jun 2015 10:26:36 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:9816:1e41:550:d20e])
        by mx.google.com with ESMTPSA id av6sm14616254igc.17.2015.06.04.10.26.35
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Jun 2015 10:26:35 -0700 (PDT)
In-Reply-To: <CACRoPnSmF0ym7ONnLAfL=o5ouSrP2Ucxdh40k6Ps-hnTsSUx4w@mail.gmail.com>
	(Paul Tan's message of "Thu, 4 Jun 2015 18:34:13 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270786>

Paul Tan <pyokagan@gmail.com> writes:

> git-am generally supports applying patches to unborn branches.
> However, there are 2 cases where git-am does not handle unborn
> branches which I would like to address before the git-am rewrite to C:

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

Yes, and it should also remove the new files the failed application
brought in to the working tree, if any, to match the "--skip" done
in the normal case (i.e. when we already have a history to apply
patches to), I would think.

> 2. am --abort
>
> For git am --abort, git-am.sh does something similar. It does a
> fast-forward checkout from HEAD to ORIG_HEAD, discarding unmerged
> entries, and then resets the index to ORIG_HEAD so that local changes
> will be unstaged.

In general, the "apply to nothing" is more or less an afterthought
and was not done as carefully as the rest of the program, so view
whenever you see a strange behaviour as not a "strange spec" but
likely to be a bug.  You would do OK if you imagine what should
happen if you were doing the same operation on top of a commit that
records an empty tree and try to match the behaviour to that case.

Thanks.
