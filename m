From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH V3 0/2] git-p4: improve client path detection when branches are used
Date: Thu, 23 Apr 2015 09:37:12 +0100
Message-ID: <9A7A7CAA-66D5-48B4-83E7-267FDDA7C66A@gmail.com>
References: <1429656570-21825-1-git-send-email-vitor.hda@gmail.com> <xmqqegncf5ps.fsf@gitster.dls.corp.google.com> <553808EE.8020404@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 10:37:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlCdl-0003zO-4c
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 10:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753903AbbDWIhd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2015 04:37:33 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:35826 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754294AbbDWIh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2015 04:37:26 -0400
Received: by widdi4 with SMTP id di4so206882359wid.0
        for <git@vger.kernel.org>; Thu, 23 Apr 2015 01:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to:cc
         :message-id;
        bh=Sfw1v/fUucmB3C1mmg91FdFCwh6xl6pyfrc966pB9Zg=;
        b=V6yvd/dP18xK5TieRNoKtv/+O1HfHYot8dnTRIxf61lJl1NjH7iSHf0qbe1P6DrJ+D
         vztZ2hELkQO/7HMIttOtzHCkCLURrG4A6qQklFIPJUsSi1UKP0nVxFhvZ4k61cZQIpm8
         PV50DCHF14pFmiAVlHkxHJcVaxomeG437E+IECAubkkQGSR2VmYHcazkk/pfzwlMvffX
         SxJDG1QcWOJ+/mQMRPiPgXpWEJcBScAjh03vxVo+4aSbdTwk48C6zqlid9FOAK38mFdv
         puBqHj4t7Rk5LGusSAsHQ3gXH4i/oQkxalOfFMS4ph+QdU/wVvAalk+0zP07c6gRQdTM
         RTag==
X-Received: by 10.180.93.193 with SMTP id cw1mr13631238wib.12.1429778245274;
        Thu, 23 Apr 2015 01:37:25 -0700 (PDT)
Received: from android-339016f4e6b2c83f.lan (88.41.108.93.rev.vodafone.pt. [93.108.41.88])
        by mx.google.com with ESMTPSA id e18sm11003288wjz.27.2015.04.23.01.37.21
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 23 Apr 2015 01:37:24 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <553808EE.8020404@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267680>

On April 22, 2015 9:47:42 PM GMT+01:00, Luke Diamand <luke@diamand.org> wrote:
>On 22/04/15 18:11, Junio C Hamano wrote:
>> Vitor Antunes <vitor.hda@gmail.com> writes:
>>
>>> The updates introduced in the third revision of these two patches
>consist only
>>> on updates to the commit messages to better clarify what they
>implement.
>>>
>>> Vitor Antunes (2):
>>>    t9801: check git-p4's branch detection with client spec enabled
>>>    git-p4: improve client path detection when branches are used
>>>
>>>   git-p4.py                |   13 ++++--
>>>   t/t9801-git-p4-branch.sh |  106
>++++++++++++++++++++++++++++++++++++++++++++++
>>>   2 files changed, 115 insertions(+), 4 deletions(-)
>>
>> Thanks; will re-queue.  Luke, could you comment?
>
>First off: kudos to Vitor for daring to enter this particular dragon's 
>den. The combination of branch-detection and use-client-spec isn't so 
>bad, but throwing in the handling of excluding bits of the tree via the
>
>P4 client spec (like, who would even do that?) makes it into a real
>mind 
>twister!
>
>I've held off commenting as I don't feel I know the branch detection 
>code as well as I would like. The change though seems a lot more robust
>
>now that the search is anchored. Having a test case is always good!
>
>However, playing around with this (incredibly complex and obscure) 
>scenario, I'm not yet sure about it.
>
>I created a depot that had //depot/main and //depot/branch, and a
>branch 
>mapping between the two. I cloned that in git using --use-client-spec 
>and --branch-detect, and all was well.
>
>I then modified my client spec to exclude //depot/main/excluded, and 
>then started adding files in git to the 'excluded' directory. When I 
>submit them, I get:
>
>$ echo hello >excluded/f1.c
>$ echo hello >f2.c
>$ git add excluded/f1.c f2.c
>$ git commit -m 'Partially excluded'
>$ git-p4.py submit
>DEBUG: self.useClientSpec = True
>Perforce checkout for depot path //depot/main/ located at 
>/home/lgd/p4-hacking/cli/main/
>Synchronizing p4 checkout...
>... - file(s) up-to-date.
>Applying 51f187b Excluded added from git
>excluded/c - file(s) not in client view.
>excluded/c - file(s) not opened on this client.
>Could not determine file type for excluded/c (result: '')
>
>When I reverted this change, it failed differently, and appeared to be 
>extremely confused in the way that I think Vitor originally describes, 
>getting hopelessly baffled by the client spec layout.
>
>It's entirely possibly I've messed up my manual testing though. I need 
>to go and have a very strong cup of tea before I can look at this
>again.
>
>Thanks!
>Luke

That was a good combination to test. In fact, I am using such
a client spec at my work place to exclude the import from
Perforce of a folder that only contains binary files, but I never
even considered to add files to that folder from git!
Although I do agree that git-p4 should be able to exit sanely
in this scenario, it is also my opinion that this is a different
scenario from the one I'm tryig to fix in this set of patches and
that it should not be enough to stop this merge.

I will take this scenario into consideration, create a new test
case and finally fix git-p4 to exit sanely in such a scenario.
This new test will also be able to show that folder exclusion
is working perfectly during import, which is important to
guarantee that that functionality is not broken in future.

BTW, no kudos is necessary because I've already walked this
path before :) I've introduced branchList and improved how
git-p4 looks for the original changelist used to create the new
branch in Perforce side. If I remember correctly, many of the
test cases in 9801 file were also created by me before Pete
started splitting the git-p4 test file into topics.
