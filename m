From: Junio C Hamano <gitster@pobox.com>
Subject: Re: about rev-parse's quietness
Date: Thu, 15 Oct 2015 12:59:27 -0700
Message-ID: <xmqqk2qnhpi8.fsf@gitster.mtv.corp.google.com>
References: <561F7F5A.4060708@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: <stefan.naewe@atlas-elektronik.com>
X-From: git-owner@vger.kernel.org Thu Oct 15 21:59:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmogY-00022h-KP
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 21:59:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752221AbbJOT73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 15:59:29 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34931 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbbJOT73 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 15:59:29 -0400
Received: by pabur7 with SMTP id ur7so14143928pab.2
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 12:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=QtkVTG+DAG8lZB513V0ODmY962AluKhoKvcHLpCVrpc=;
        b=hDoSDTTGlHg2U1z3tGLdVYvaLI6nxMV31CeHXs7hBxZgnVNFHJnvc4Qb+68kEgH7ar
         nnhPzEwDV57aGv0guPAXbzr1S3+IgDGZyO8Ze6ODRkbPa7KIAuNvI3ohVE6j3wWRLcvL
         bCeafZg3F34YCCm8PlZoVduUHOFz8KRmwHsSMBZhpyuqndXbFC+eVD8sQ2yHotmgV8J0
         tgWsIehreJySeqGpg09gY6u5IiNZd0QPcYettqmw2jzOe+sn9Kl4u9pbrk2/JbQSQtc7
         aCdPKPLevc9ImVZW04Kut9Z0b+FY0yNAsUdTjbE1maLCTHZJZUUaXYuJRzUrP0CsBGDB
         js1g==
X-Received: by 10.66.141.199 with SMTP id rq7mr12020708pab.140.1444939168531;
        Thu, 15 Oct 2015 12:59:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7964:41eb:7b4:cd77])
        by smtp.gmail.com with ESMTPSA id iy1sm16894498pbb.85.2015.10.15.12.59.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 Oct 2015 12:59:27 -0700 (PDT)
In-Reply-To: <561F7F5A.4060708@atlas-elektronik.com> (stefan naewe's message
	of "Thu, 15 Oct 2015 12:26:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279707>

<stefan.naewe@atlas-elektronik.com> writes:

> Let's see:
> $ git rev-parse --verify --quiet master@{xyz} || echo No
> No
>
> $ git rev-parse --verify --quiet master@{u} || echo No
> fatal: no upstream configured for branch 'master'
> No

Yup, that is unfortunate.  The above two pass different codepaths in
sha1_name.c::get_sha1_basic().

 * The code first notices "master@{anything}" has @{anything}
   suffix, which could be @{123} (counted reflog), @{1.hour.ago}
   (timed reflog), @{-1} (prior checkout---valid only when nothing
   comes before "@{...}") or @{upstream}/@{push}.

 * The first two goes through dwim_log(), together with
   'master@{xyz}' to locate the reflog of 'master' (i.e. what comes
   before that @{anything}) and identifies that we need to look at
   the log for 'refs/heads/master', looks up an appropriate entry,
   and the processing ends there, returning success.  However, 'xyz'
   is not a valid specification for either counted or timed reflog,
   so the function returns failure for 'master@{xyz}', letting the
   remainder of the callchain to take care of it.
 
 * The third one goes to interpret_nth_prior_checkout() and the
   processing ends there, returning success.

 * The last one goes to dwim_ref(), together with just 'master'
   without any @{anything}.  It tries to turn master@{upstream} or
   master@{push} to refs/remotes/origin/master and then it is used
   to grab the object name pointed by it.

The helper function dwim_ref() calls to turn master@{upstream} to
refs/remotes/origin/master, interpret_branch_name(), is designed to
die() when fed a ref without upstream (or @{push} when there is no
such thing).

Naively, one would imagine that the die() can be demoted to an
internal error return to the caller (just like 'master@{xyz}' is
rejected silently in the dwim_log() codepath) and everything else
should go well.  It is unfortunately not sufficient, though, as the
other callers to interpret_branch_name() rely on the function to
die and are not prepared to show the error messages themselves.

So I think this is fixable and the right approach to fix it is as
hinted above, i.e.

 * audit callers of interpret_branch_name() and find the ones that
   depend on the function to die (i.e. it does not handle the case
   where interpret_branch_name() notices that 'master@{upstream}'
   does not exist).  Change them to die with an appropriate message
   themselves.

 * change interpret_branch_mark(), which is actually where the die()
   happens, so that it can notice a request to use 'master@{upstream}' 
   when there is no such upstream and signal an error to the caller.

I am not saying that you should be the one to fix it, though ;-) The
above is to help those who may be interested to look into the codepath
to do so.

Thanks.
