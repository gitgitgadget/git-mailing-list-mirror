From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git checkout under 1.7.6 does not properly list untracked files
 and aborts
Date: Tue, 20 Sep 2011 17:10:26 +0200
Message-ID: <4E78ACE2.60306@drmicha.warpmail.net>
References: <4E6A7167.6070408@workspacewhiz.com> <4E779BA4.8070109@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Tue Sep 20 17:10:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R61y0-0003LG-In
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 17:10:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700Ab1ITPKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 11:10:30 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:44365 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750757Ab1ITPK3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Sep 2011 11:10:29 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id D03E42D99;
	Tue, 20 Sep 2011 11:10:28 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 20 Sep 2011 11:10:28 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=IbeLSloSTAmKflPxdF016P
	CmZcE=; b=ajDeKclbrsMotlW0t/7Kd2eVWZGPhtoDMOk7GFlTc/smxlF5DxBYce
	4D8eaiA0amf+ENad8w8xkQxWSifTYJQ4nNy19h7JFl9Wuh7wtN8kYJfymUNfPDj1
	hpErDEzqnk03uyE9vsUM8kTFXFACYj9ATlHpWjRZiraEXvpY1ialY=
X-Sasl-enc: xKsmsVlYQXsHG1TV2v60QQis8EPZ5JDdnHqX/efNFnlR 1316531428
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 535209213DE;
	Tue, 20 Sep 2011 11:10:28 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0.2) Gecko/20110906 Thunderbird/6.0.2
In-Reply-To: <4E779BA4.8070109@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181772>

Joshua Jensen venit, vidit, dixit 19.09.2011 21:44:
> ----- Original Message -----
> From: Joshua Jensen
> Date: 9/9/2011 2:04 PM
>> This may be an msysGit 1.7.6 issue, as that is what I am using.  It 
>> also occurs in msysGit 1.7.5, but I am almost certain it did not 
>> happen in msysGit 1.7.2.
>>
>> Given an untracked file in the working directory that has been added 
>> to an alternate branch, when switching to that alternate branch, 'git 
>> checkout' exits with an error code but does not print anything to the 
>> console.  It should print an untracked file error.
>>
>> I have been trying to track this down in code.  The point where the 
>> error messages are printed, display_error_msgs, is never hit.
> Okay, so I've tracked this down, but I am unsure what the correct fix is.
> 
> In unpack-trees.c's unpack_trees() function, there are some lines that read:
> 
>      if (ce->ce_flags & CE_ADDED &&
>          verify_absent(ce, ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN, o))
>              return -1;
> 
> If the 'return -1' is changed to 'goto return_failed', then a proper 
> error message appears:
> 
>      error: The following untracked working tree files would be 
> overwritten by checkout:
>          one/file/listed/here.txt
>      Please move or remove them before you can switch branches.
>      Aborting
> 
> The thing is, there are multiple files that would be overwritten by 
> checkout, and I believe an older version of Git showed me the entire 
> list before aborting.
> 
> What would be the proper fix here?  What am I doing wrong?

Can you provide a simple test case, such as this one:

---%<---
#!/bin/sh

rm -Rf utest || exit 1
mkdir utest || exit 1
cd utest || exit 1
git init
echo tracked >a
git add a
git commit -m a a
git branch side
echo tracked >b
git add b
git commit -m b
cat b
git checkout side
cat b
echo untracked >b
cat b
git checkout master
cat b
---%<---

With 1.7.6 and current next this gives (Linux):

Initialized empty Git repository in /tmp/t/utest/.git/
[master (root-commit) b462c80] a
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 a
[master 22d8f2f] b
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 b
tracked
Switched to branch 'side'
cat: b: No such file or directory
untracked
error: The following untracked working tree files would be overwritten
by checkout:
        b
Please move or remove them before you can switch branches.
Aborting
untracked

Does this test reproduce your problem on msysgit?

Michael
