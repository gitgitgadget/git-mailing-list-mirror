Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4468BC433DF
	for <git@archiver.kernel.org>; Mon, 18 May 2020 09:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1192C207ED
	for <git@archiver.kernel.org>; Mon, 18 May 2020 09:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=vivaldi.com header.i=@vivaldi.com header.b="R502seKd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgERJ3Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 05:29:25 -0400
Received: from mail.vivaldi.com ([31.209.137.20]:36034 "EHLO mail.vivaldi.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgERJ3Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 05:29:24 -0400
X-Greylist: delayed 504 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 May 2020 05:29:24 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.vivaldi.com (Postfix) with ESMTP id 4E0941F93D5
        for <git@vger.kernel.org>; Mon, 18 May 2020 09:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vivaldi.com; h=
        user-agent:message-id:organization:from:from
        :content-transfer-encoding:mime-version:subject:subject:date
        :date:content-type:content-type:received:received; s=2019; t=
        1589793658; bh=qmPtrJxYmfHu4nPfTkz5LlIQMWP2VfTE892WHbdn+Zg=; b=R
        502seKdyvb3corTQvaiAW6Cwd4cS3hPeUVjtYvhtCxzNY8+DSlc3r25rOI8WhaBT
        o0TLO5LsptqfvrieiROB+jLz3POlte9zWXsyw6ElprQphsVBO3hFu2tiOp41hQol
        mn/SHof6fwUE1hH01QpZgB+OJ2StVLJZhBOZWxiEEPDgZSQ4AS+lmaCMoWDmUNVy
        JJPhG9jbj0ST3vhQ5RK8G+yuehGULhjWqc8nKfAee2v6W5JcucbGspuoYEac+txl
        EthietaQaWUERsEoxkHg2DCZ86qSpury8dVOF5nkVl/Q/7vUgijhgNXnO6lWfyc6
        wLi1BW3F4/k05otvMoVTg==
X-Virus-Scanned: Debian amavisd-new at vivaldi.com
Received: from mail.vivaldi.com ([127.0.0.1])
        by localhost (staffmail.viv.dc01 [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id It1ueQ3QePRd for <git@vger.kernel.org>;
        Mon, 18 May 2020 09:20:58 +0000 (UTC)
Received: from rowan.vivaldi (195-159-146-211.customer.powertech.no [195.159.146.211])
        by mail.vivaldi.com (Postfix) with ESMTPSA id DD9F11F8B98
        for <git@vger.kernel.org>; Mon, 18 May 2020 09:20:57 +0000 (UTC)
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
Date:   Mon, 18 May 2020 11:20:57 +0200
To:     git@vger.kernel.org
Subject: Git error message "Server does not allow request for unadvertised
 object"  
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Yngve N. Pettersen" <yngve@vivaldi.com>
Organization: Vivaldi Technologies AS
Message-ID: <op.0ks2w7r1pvqxoc@rowan.vivaldi>
User-Agent: Opera Mail/1.0 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

A while back I reported an issue to the Windows Git project  
<https://github.com/git-for-windows/git/issues/2218> that I observed in  
Git for Windows 2.21.

The error message "Server does not allow request for unadvertised object"  
is reported when a commit updating a submodule pointer points to a commit  
that does not exist in the repository for that submodule, even if later  
commits in the branch points to a commit that do exist in the submodule  
repo.

This circumstance can easily occur if a developer (e.g)

  * interactively rebases a branch "foo" in the submodule (e.g to integrate  
commits from another branch before a larger rebase)
  * commits the resulting submodule pointer "A" in the branch to the parent  
repo
  * then do further rebasing in the submodule, e.g to move up on top of the  
"bar" branch
  * commits that pointer "B" to the parent repo
  * forgets to squash the history in the parent repo
  * pushes the updated submodule "foo" branch to the online repo. (NOTE:  
"B" is pushed, not "A")
  * pushes the parent module branch to its online repo

When the parent repo is pulled by another developer, or an autobuild  
system, the fetch operation fails with the message "Server does not allow  
request for unadvertised object". A second fetch will complete  
successfully.

IMO this kind of check should only happen if a commit with pointer to a  
missing submodule is actively checked out. At most the above message  
should be a warning, not a fatal error.

For manual fetch operations this is mostly a nuisance, but for  
autobuilders this breaks the update operation, and the entire build  
operation fails. That is unacceptable behavior in an automatic system  
(errors if it breaks the checkout, yes; issues that are not relevant to  
the actual checkout, no).

This issue prevents upgrading past 2.17 (since 2.18 and 2.19 had other  
blocking issues, and 2.20 apparently introduced this issue). I have not  
tested 2.22+ since I have not noticed any changelog messages that seem  
related.

A test case can be found in issue 2218, linked above.

For reference, we do have a server-side git hook that verifies that  
submodule pointers for the production branch is correct and exists in the  
submodule's repo, and also is on branches that follows certain naming  
conventions.


As an aside, I think this kind of error message would be have been better  
suited as either a client-side push check, to prevent pushes of references  
to such missing commits (Smartgit seems to have something like it, but I  
think it only checks for the current branch in the submodule, not all  
submodule reference commits). Alternatively, there could be a check of  
this server-side.


Related to this, but not as problematic, just irritating, and also seen in  
2.17, is a message "warning: Submodule in commit deadbee at path: '(NULL)'  
collides with a submodule named the same. Skipping it." I think it is  
related to recreating a git modules file on a different branch.

-- 
Sincerely,
Yngve N. Pettersen
Vivaldi Technologies AS
