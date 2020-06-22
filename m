Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA871C433DF
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 19:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91DF220702
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 19:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=smartsoftwareinc.com header.i=@smartsoftwareinc.com header.b="ck7Yod4o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbgFVTkV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 15:40:21 -0400
Received: from mail.smartsoftwareinc.com ([24.230.151.194]:35534 "EHLO
        mail.smartsoftwareinc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbgFVTkU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jun 2020 15:40:20 -0400
Received: from mward.lin.pirsss (unknown [10.0.0.166])
        by mail.smartsoftwareinc.com (Postfix) with ESMTPSA id D9A506331A
        for <git@vger.kernel.org>; Mon, 22 Jun 2020 14:40:15 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=smartsoftwareinc.com;
        s=default; t=1592854815;
        bh=UGN1uAH5PghRcT4AC8luw/egk9VR1aa5IcS4OI81nrk=;
        h=To:From:Subject:Date;
        b=ck7Yod4ohcpsRByRAvETUiY9WwTk5nxB3gc4XRHtj0kAztzBtCMZ1YWY7DlHEailW
         LAmHx/z0kSTu2XozYLcUnwZEWHht7ppwoHMXJlAvzh1dH1dMz4F7cOPa1ehUcYphG/
         sJPEsq0LAQSlRKJSkRep8sn2Kxf7OWYD6ZV7TUms=
To:     git@vger.kernel.org
From:   Michael Ward <mward@smartsoftwareinc.com>
Subject: Git 2 force commits but Git 1 doesn't
Organization: Smart Software Solutions, Inc.
Message-ID: <dea24348-770c-1228-115d-23153fbecebd@smartsoftwareinc.com>
Date:   Mon, 22 Jun 2020 14:40:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-smartsoftware-MailScanner-Information: Please contact the ISP for more information
X-smartsoftware-MailScanner-ID: D9A506331A.A8233
X-smartsoftware-MailScanner: Found to be clean
X-smartsoftware-MailScanner-SpamCheck: not spam (whitelisted),
        SpamAssassin (not cached, score=-1.6, required 4, autolearn=not spam,
        ALL_TRUSTED, BAYES_05, DKIM_SIGNED, DKIM_VALID, DKIM_VALID_AU)
X-smartsoftware-MailScanner-From: mward@smartsoftwareinc.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have some repositories we are hosting here using Apache's DAV module 
to handle remote connections.

The repositories are created using the following:

mkdir [reponame].git
cd [reponame].git
git --bare init
git update-server-info

Our Apache location directive is as follows:

<Location /[reponame].git>
         DAV on
         AuthType Basic
         AuthName "Git"
         AuthBasicProvider ldap
         AuthLDAPUrl [ldap server info]
         <RequireAny>
                 require [ldap filter]
         </RequireAny>
</Location>

The repository config generates with the values in the core section 
below, and we add the receive and advice sections:

[core]
         repositoryformatversion = 0
         filemode = true
         bare = true
[receive]
         denyNonFastForwards = true
         denyDeletes = true
[advice]
         pushFetchFirst = true

The odd behavior comes when we have git 1 vs git 2 clients attempting to 
push in changes on the same branch. Git 1 clients will prompt the user 
that they are out of date and need to pull. Git 2 clients don't and will 
force push and overwrite the head revision. This occurs with either Git 
1 or Git 2 on the server.

We've tested this with the latest Git 2 client on Fedora 32 and Git 1 
client on CentOS 7.8. The other oddity is that even when the Git 2 
client does a pull to receive changes before making changes and pushing, 
when another user pulls the change, there is a message shown that a 
commit was forced.

What am I missing in the repository settings to prevent forced pushes 
from working and force users to pull before being able to push?

Thanks!

Michael Ward
