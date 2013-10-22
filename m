From: Dan Fabulich <dan@fabulich.com>
Subject: Re: Bug report: OS X git-merge deletes recapitalized files when rename detection fails
Date: Mon, 21 Oct 2013 21:27:37 -0700
Message-ID: <55E4066B-A15A-47DF-AD84-49268DA4B31F@fabulich.com>
References: <83737702-F966-457E-A77D-85CCD06FFECA@fabulich.com> <1BABBB4C-F461-40B7-97C6-3E90364D37E8@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>,
	Eric Boxer <boxerspam1@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 22 06:27:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYTZR-0008IX-JY
	for gcvg-git-2@plane.gmane.org; Tue, 22 Oct 2013 06:27:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161Ab3JVE1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Oct 2013 00:27:36 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:54986 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750868Ab3JVE1f convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Oct 2013 00:27:35 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 4016922B81;
	Tue, 22 Oct 2013 00:27:35 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute6.internal (MEProxy); Tue, 22 Oct 2013 00:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-type:mime-version:subject:from
	:in-reply-to:date:content-transfer-encoding:message-id
	:references:to; s=smtpout; bh=ep6PkzEocEvXmIbAI+Da2eN62+w=; b=hn
	ogyPee1BAbqFotF5jzx9My23Jg73rdW4wQ0zwQJKtOqQ15lQh1kNA7DBuXj93iBq
	RIk9nV7mPh4dHf0KcF9HL9wzeo/jVwzWs86dv7wGNg6qF8CdBCc1J+5nNtFW9kd+
	L+U+q0m+1KDc4SHwsACnUmpXiOZp9kdve0eTAFlxE=
X-Sasl-enc: gFd7vRzhO7mR3N8yGf5vrJRTpDEsu/p5TUgoTLw1pOJF 1382416054
Received: from [192.168.2.102] (unknown [107.204.214.139])
	by mail.messagingengine.com (Postfix) with ESMTPA id C2EBEC00E8D;
	Tue, 22 Oct 2013 00:27:34 -0400 (EDT)
In-Reply-To: <1BABBB4C-F461-40B7-97C6-3E90364D37E8@gmail.com>
X-Mailer: Apple Mail (2.1510)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236453>

Eric, are you still investigating this bug? (I note that your reply, which cc:ed the list, doesn't seem to have been mailed out to the list, or added to mailing list archives.)

On Oct 10, 2013, at 17:13 , Eric Boxer <boxerspam1@gmail.com> wrote:

> I'm on it and I'll follow up shortly.
> 
> 
> On Thu, Oct 10, 2013 at 05:46 PM, Dan Fabulich wrote:
>> On case-insensitive filesystems, git-merge deletes files that were recapitalized in another branch if rename detection fails.
>> 
>> To repro: Run this script with git 1.8.4 on a case-insensitive filesystem. It repros for me on the default HFS filesystem on OS X 10.8, and also on Win7 NTFS.
>> 
>> #!/bin/sh -x
>> # create git repo
>> git --version
>> rm -rf caps
>> git init caps
>> cd caps
>> git config --get core.ignorecase
>> # commit empty file called "file"
>> echo file > file
>> git add .
>> git commit -am "initial commit"
>> # create branch called "branch"
>> git branch branch
>> # rename "file" to "File"
>> # using --force per http://stackoverflow.com/questions/6899582
>> git mv --force file File
>> echo "completely different content" > File
>> git commit -am "renamed to File"
>> # switch to branch, make a non-conflicting commit
>> git checkout branch
>> echo newfile > newfile
>> git add .
>> git commit -am "branch commit"
>> # merge master into branch, commit merge
>> git merge --verbose --commit --no-edit master
>> ls File
>> git status
>> 
>> Actual: At the end of the script, the renamed File has been deleted by git-merge. "ls: File: No such file or directory" According to git-status, the deletion is not yet staged.
>> 
>> Expected: There should be no untracked changes at the end of this script. The script runs as expected on Linux or case-sensitive HFS.
>> 
>> -Dan Fabulich
>> 
>> P.S. On case-insensitive HFS, git-init will automatically set core.ignorecase to true. For the sake of the experiment, I also tried setting core.ignorecase to false in the test repository.
>> 
>> When I did that, I was unable to even checkout the "branch" branch without using --force. ("The following untracked working tree files would be overwritten by checkout: file" But git-status reported no untracked changes.)
>> 
>> And then, once I did use force to switch to the branch, I was unable to merge from master at all. ("The following untracked working tree files would be overwritten by merge: File" But again, git-status reported no untracked changes.)
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
