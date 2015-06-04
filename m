From: Paul Tan <pyokagan@gmail.com>
Subject: [RFC] git-am: handling unborn branches
Date: Thu, 4 Jun 2015 18:34:13 +0800
Message-ID: <CACRoPnSmF0ym7ONnLAfL=o5ouSrP2Ucxdh40k6Ps-hnTsSUx4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 04 12:34:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0STd-0004R9-0z
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 12:34:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbbFDKeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 06:34:16 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:33682 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbbFDKeP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2015 06:34:15 -0400
Received: by labpy14 with SMTP id py14so28659706lab.0
        for <git@vger.kernel.org>; Thu, 04 Jun 2015 03:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=V7i6DkCP6InXjWwCogu60Tn+eNF5ZrX06Pee/+m3u1Y=;
        b=0Y5gDns40RDE2cinUTYLpLMaUn2Oo2bckyWfcZTH7xOefpZeiBLdSGCUXSmBqK/rCx
         mi7W6HXdMpFB7jjdIOjNZzDpNu7LTOCFRPs5cDE5TwIRFrLiiAeQR1b/5V1t+GzGDDRH
         HTCmEvzMRdzwoudJpJAakr3I6oaguDyIK9S5Czkz1f/JgC075smZvKajowyLldusJa1A
         pNAQy4rn1ebCJnFGzRl9xWkUZRU8eX+ROw4Gv00V+f6ROoa7eoGR4MlZkDuLvFI8Kvhj
         hVvOld80yzg+2PBTv45hwQJ2YqjxRIjMhA3JbWTVhknV9SZI/Aj+it6LNoulVyOabr8G
         YUuA==
X-Received: by 10.152.164.193 with SMTP id ys1mr7434285lab.65.1433414053517;
 Thu, 04 Jun 2015 03:34:13 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Thu, 4 Jun 2015 03:34:13 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270764>

Hi,

git-am generally supports applying patches to unborn branches.
However, there are 2 cases where git-am does not handle unborn
branches which I would like to address before the git-am rewrite to C:

1. am --skip

For git am --skip, git-am.sh does a fast-forward checkout from HEAD to
HEAD, discarding unmerged entries, and then resets the index to HEAD
so that the index is not dirty.

        git read-tree --reset -u HEAD HEAD
        orig_head=$(cat "$GIT_DIR/ORIG_HEAD")
        git reset HEAD
        git update-ref ORIG_HEAD $orig_head

This requires a valid HEAD. Since git-am requires an empty index for
unborn branches in the patch application stage anyway, I think we
should discard all entires in the index if we are on an unborn branch?

Or, the current behavior of git-am.sh will print some scary errors
about the missing HEAD, but will then continue on to the next patch.
If the index is not clean, it will then error out. Should we preserve
this behavior? (without the errors about the missing HEAD)

2. am --abort

For git am --abort, git-am.sh does something similar. It does a
fast-forward checkout from HEAD to ORIG_HEAD, discarding unmerged
entries, and then resets the index to ORIG_HEAD so that local changes
will be unstaged.

        if safe_to_abort
        then
            git read-tree --reset -u HEAD ORIG_HEAD
            git reset ORIG_HEAD
        fi
        rm -fr "$dotest"

This, however, requires a valid HEAD and ORIG_HEAD. If we don't have a
HEAD or ORIG_HEAD (because we were on an unborn branch when we started
git am), what should we do? (Note: safe_to_abort returns true if we
git am with no HEAD because $dotest/abort-safety will not exist)
Should we discard all entires in the index as well? (Since we might
think of the "original HEAD" as an empty tree?)

Or, the current behavior of git-am.sh will print some scary errors
about the missing HEAD and ORIG_HEAD, but will not touch the index at
all, and still delete the rebase-apply directory. Should we preserve
this behavior (without the errors)?

Thanks,
Paul
