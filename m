From: Jonathan del Strother <jdelstrother@gmail.com>
Subject: Expected behaviour of 'git log -S' when searching in a merged/deleted file?
Date: Wed, 22 Dec 2010 13:37:19 +0000
Message-ID: <AANLkTimXk6ei6EAQfvTTfnMzdBqYHkNoaxkEab+atnHd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 22 14:37:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVOsz-0004k7-Rg
	for gcvg-git-2@lo.gmane.org; Wed, 22 Dec 2010 14:37:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428Ab0LVNhk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Dec 2010 08:37:40 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:60042 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924Ab0LVNhk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Dec 2010 08:37:40 -0500
Received: by qwa26 with SMTP id 26so5127049qwa.19
        for <git@vger.kernel.org>; Wed, 22 Dec 2010 05:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=LVXQDxRbSfbae6gMkohLtIZmSpMmJJnczfi/x5zbzpI=;
        b=dIENfBrI87nvCiQF2lP45thsDuryVjplGHS+8cJ/SnTRY0ZSmWys5xWkc8GCCUDIhe
         FKDyTN1OK8DtKI1YDYPDGAIMfyjryVb+KnNrGF0Kyc4gvDZfy7NoVf3Yg8fVYFDm3DP8
         NDQXAnK/cYxOrowKZCiplh9f1kZ8IIjRTKq4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=hHB8pCPtce+2PSk6+GdV1xeu1mpsDmndfhBevwabxPIHvEg3Fo7v6wUGjBGurxioND
         ewhQLTOyuleToZdXHWAfg+3QcrghYxeiJRD52+axFqv5DPVb6yG+qP2Hu+/YGHxzCL3B
         UBotMCRdM9f7/7N1x3ZckUZrI5AsN8LI0WJXY=
Received: by 10.229.191.85 with SMTP id dl21mr5736807qcb.149.1293025059320;
 Wed, 22 Dec 2010 05:37:39 -0800 (PST)
Received: by 10.229.86.201 with HTTP; Wed, 22 Dec 2010 05:37:19 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164085>

Hi,

I was trying to find a particular string in my project this morning.
'git grep mystring' suggested that the string didn't exist in my repo,
but 'git log -Smystring' turned up a single commit that had added it.
It took me a long time to figure out that in the past, a branch had
added that string to foo.c, but a second branch deleted foo.c, and the
two branches were later merged (deleting foo.c and ignoring mystring).
 I was surprised that 'git log -S' didn't show the merge commit as the
point at which the string had been removed.

I've attached a testcase which I would expect to pass (perhaps
naively), but doesn't.  Is this a git bug, or do I misunderstand git
log -S?

--


#!/bin/sh

test_description='git log'

. ./test-lib.sh

test_expect_success setup '
	echo haystack\\nhaystack\\nhaystack\\nhaystack\\n > haystack &&
	git add haystack &&
	test_tick &&
	git commit -m initial &&

	git checkout -b branchA &&
	echo needle >haystack &&
	git add haystack &&
	test_tick &&
	git commit -m "adding needle" &&

	git checkout -b branchB HEAD~1 &&
	git rm haystack &&
	test_tick &&
	git commit -m "removing haystack" &&

	git merge branchA || git rm haystack &&
	test_tick &&
	git commit -m "merging: haystack and needle removed"
'

printf "merging: haystack and needle removed\nadding needle" > expect
test_expect_success 'log -S in a merge-deleted file' '

	git log -Sneedle --pretty="format:%s" > actual &&
	test_cmp expect actual
'

test_done
