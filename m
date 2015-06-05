From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [RFC] git-am: handling unborn branches
Date: Fri, 5 Jun 2015 16:32:18 +0800
Message-ID: <CACRoPnTf+4_=B7CWY_XBOaK0vWXit9tDf2pbO-T=q7JoWjhtLA@mail.gmail.com>
References: <CACRoPnSmF0ym7ONnLAfL=o5ouSrP2Ucxdh40k6Ps-hnTsSUx4w@mail.gmail.com>
	<CAGZ79kbvWjoCx0VFJS+B-mvxE62_PaRixMjUSWXwsO-c+LonVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 10:32:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0n3C-00032E-Vx
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 10:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754035AbbFEIcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 04:32:22 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:36178 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753518AbbFEIcU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 04:32:20 -0400
Received: by laei3 with SMTP id i3so48858726lae.3
        for <git@vger.kernel.org>; Fri, 05 Jun 2015 01:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rvTY+L3tXsP0vUMak4RpDyWf53yj6q7DcDWEQx+81c0=;
        b=P4A1JHVfykplWHdVXnE18pEfyU7olfSN9p2zi0tkjBEOHgRWKTXtkejUqB0NlwCq5E
         Wrq5nYPPd/sjs3ZpHo8/sur9ge1P4VqE7A/XEVPIRVW5y4CyVt4IanSS5LsCytnUHWyR
         5NN4rd3nJynEgY2jcpkqJFwt9+2Wi88ImtucvLmPblg6RUj8N+GQJA7mfSJm12GBTA4x
         KHUXtGDv9Kd5y7uErJdFJ+qZdJvH69XBLsBDOUucs4gQByzanITNcQI3xj6XrxenZe8B
         Mgx6F4gzDDIdfBXhPtRLKNKfSy8a1l+jto+3sdvQWJ/TrHa6WH36g+OFG8EYsrjVj/Nh
         IeLw==
X-Received: by 10.112.182.4 with SMTP id ea4mr2288611lbc.35.1433493138946;
 Fri, 05 Jun 2015 01:32:18 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Fri, 5 Jun 2015 01:32:18 -0700 (PDT)
In-Reply-To: <CAGZ79kbvWjoCx0VFJS+B-mvxE62_PaRixMjUSWXwsO-c+LonVQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270817>

On Fri, Jun 5, 2015 at 1:27 AM, Stefan Beller <sbeller@google.com> wrote:
> On Thu, Jun 4, 2015 at 3:34 AM, Paul Tan <pyokagan@gmail.com> wrote:
>> Or, the current behavior of git-am.sh will print some scary errors
>> about the missing HEAD, but will then continue on to the next patch.
>> If the index is not clean, it will then error out. Should we preserve
>> this behavior? (without the errors about the missing HEAD)
>>
>> 2. am --abort
>>
>> For git am --abort, git-am.sh does something similar. It does a
>> fast-forward checkout from HEAD to ORIG_HEAD, discarding unmerged
>> entries, and then resets the index to ORIG_HEAD so that local changes
>> will be unstaged.
>>
>>         if safe_to_abort
>>         then
>>             git read-tree --reset -u HEAD ORIG_HEAD
>>             git reset ORIG_HEAD
>>         fi
>>         rm -fr "$dotest"
>>
>> This, however, requires a valid HEAD and ORIG_HEAD. If we don't have a
>> HEAD or ORIG_HEAD (because we were on an unborn branch when we started
>> git am), what should we do? (Note: safe_to_abort returns true if we
>> git am with no HEAD because $dotest/abort-safety will not exist)
>> Should we discard all entires in the index as well? (Since we might
>> think of the "original HEAD" as an empty tree?)
>>
>> Or, the current behavior of git-am.sh will print some scary errors
>> about the missing HEAD and ORIG_HEAD, but will not touch the index at
>> all, and still delete the rebase-apply directory. Should we preserve
>> this behavior (without the errors)?
>
> I guess so, looking at the documentation
>        --abort
>            Restore the original branch and abort the patching operation.
>
> a user may want to not go to the unborn branch, but rather to the previous
> HEAD?

I think we need to be consistent with the non-unborn-branch behavior
of git-am. In normal use am --abort would reset the branch back to
ORIG_HEAD, which is the HEAD when am was first run, thus losing all
the applied commits. However, since f79d4c8 (git-am: teach git-am to
apply a patch to an unborn branch, 2009-04-10) if git-am is run
without a HEAD, no ORIG_HEAD would be created.

I guess if we are to follow this normal behavior, we need to destroy
the current branch as well.

So the abort logic would be something like:

1. If we are still on an unborn branch, we clear the index.

2. If we are not on an unborn branch, but we have no ORIG_HEAD because
we started from an unborn branch, then we destroy the current branch.

3. If we are not on an unborn branch, and we have an ORIG_HEAD, then
we do the normal behavior of fast-forwarding and resetting the index
to ORIG_HEAD.

We also need to consider safe_to_abort() as well though, which was
introduced in 7b3b7e3 (am --abort: keep unrelated commits since the
last failure and warn, 2010-12-21). Specifically,

safe_to_abort () {
...
    if ! test -s "$dotest/abort-safety"
    then
        return 0
    fi
...
}

where we are allowed to reset HEAD if the abort-safety file is empty
or does not exist. If patch application failed while we are on an
unborn branch, we will have no abort-safety file. However, the user
may have made commits since then, and we should not make the user lose
those commits. As such, we should probably not reset HEAD if there is
no abort-safety file.

Thanks,
Paul
