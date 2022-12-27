Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF4CC4167B
	for <git@archiver.kernel.org>; Tue, 27 Dec 2022 23:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiL0XAm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Dec 2022 18:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiL0XAj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2022 18:00:39 -0500
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A439765EE
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 15:00:38 -0800 (PST)
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 2BRN0bBd015593
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 18:00:37 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: [BUG] fatal: transport 'file' not allowed during submodule add
Date:   Tue, 27 Dec 2022 18:00:32 -0500
Organization: Nexbridge Inc.
Message-ID: <00f901d91a47$09400110$1bc00330$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdkaRV0dWy0uQ8lgRJiwVXAaNxv4rg==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As of 2.39.0, I am now getting fatal: transport 'file' not allowed when
performing a submodule add after a clone -l. The simple reproduce of this
is:

1. Start with an empty bare repository, src.git.
2. Create an empty non-bare repository and set the upstream remote to the
bare repo.
3. Populate the non-bare repository with:
	touch .gitignore &&
	git add .gitignore &&
	touch file1 &&
	git add file1 &&
	git commit -m initial &&
	git remote add origin ../src.git &&
	git push --set-upstream origin master
4. Create another empty bare repository to be used as the submodule,
subsrc.git.
5. Create another empty non-bare repository and set the upstream remote to
the bare repo for the submodule.
6. Populate the non-bare submodule repository with
	touch .gitignore &&
	git add .gitignore &&
	git commit -m initial &&
	git add .gitignore &&
	touch file2 &&
	git add file2 &&
	git commit -m initial &&
	git remote add origin ../subsrc.git &&
	git push --set-upstream origin master
7. Clone the main repo using -l or without it (makes no difference):
	git clone -l src.git dest
8. Attempt to add the submodule:
	cd dest &&
	git submodule add -- ../subsrc.git subsrc

This results in:
Cloning into 'dest'...
done.
Cloning into '/home/randall/dest/subsrc'...
fatal: transport 'file' not allowed
fatal: clone of '/home/randall/subsrc.git' into submodule path
'/home/randall/dest/subsrc' failed

This happens for any submodule add on the same system. Some online research
indicates that there was a security patch to git causing this, but I can't
find it. This does not seem correct to me or how this improves security.
Help please - this is causing some of my workflows to break.

Thanks,
Randall
--
Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)
NonStop(211288444200000000)
-- In real life, I talk too much.



