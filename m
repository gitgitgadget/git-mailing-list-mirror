Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DD7C433EF
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 15:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD45960EE4
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 15:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbhIWPUS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 11:20:18 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:57571 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233080AbhIWPUS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 11:20:18 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mTQUn-0001rv-6X; Thu, 23 Sep 2021 16:18:45 +0100
Subject: Re: potentially unexpected credential-helper behavior when using Git
 CLI from Junit test started by Ant script running in Karaf environment
 installed as a Windows service
To:     Nate Kerkhofs <Nate.Kerkhofs@ikan.be>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <AM0P191MB08040357C47BE834BB3EDEA5EBA39@AM0P191MB0804.EURP191.PROD.OUTLOOK.COM>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <277c8421-6173-efb4-437d-98058a35a139@iee.email>
Date:   Thu, 23 Sep 2021 16:18:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <AM0P191MB08040357C47BE834BB3EDEA5EBA39@AM0P191MB0804.EURP191.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Nate,
On 23/09/2021 10:06, Nate Kerkhofs wrote:
> Hi,
>
> We at Ikan maintain Ikan ALM, a commercial devops product that we use ourself. As part of this devops product, we recently implemented an option to clone a single branch using --filter=blob:none for performance reasons. We had to upgrade the Git client we used for this from 2.26 to 2.33. We did not uninstall the old version because it was still in use by older scripts.
>
> After installing this new Git version and configuring our test scripts to use it, we found that our headless builds on our build server started freezing, completely stopping partway through our tests. After a day of investigation, I tracked down the cause and found that the new Git client was installed with the credential-helper feature enabled. This meant that as part of the clone command, Git would at some point run sh -c "git credential-helper-selector store" "git credential-helper-selector store", which triggered an invisible credential-helper modal dialog during our headless script, causing the build script to freeze until someone would accept it, which of course no one could do because due to the headless execution, no one was around to accept it.

I think this has been raised on the Git-for-Windows issues discussions
https://github.com/git-for-windows/git/issues?q=is%3Aissue+authentication
and possibly fixed in a snapshot.

It sounds very much like
https://github.com/git-for-windows/git/issues/3284 "Git bash on windows
doesn't prompt in case github authentication is required and commands
freeze indefinitely."


>  Weirdly enough, when I manually ran the git clone command which caused this dialog to appear, the clone worked just fine and no dialog would appear, which lead me to believe that this might be an issue with Git with regards to running it from a headless script. It is unclear to me why running the same command from a headless environment and from a normal command line environment would have different functionality in these cases. I fixed the issue by disabling the credential-helper.
>
> Some details about the environment these tests are ran in: our product uses a Karaf 4.0.7 based agent, which runs as a Windows 2019 service running as an administrative user. Karaf starts an Ant 1.10.3 script in a JDK 11.0.7 Java environment. This ant script starts a Junit 4 test suite, which in turn starts Git 2.33.0.2 from the command line. The command that was executed was (some details redacted):
>
> git.exe clone http://USERNAME:PASSWORD@GITSERVERHOSTNAME/git/GITREPONAME.git -b tag1.1 --single-branch --filter=blob:none e:/ikan/alm/test/repositories/git/workdir
>
> I executed this command with the same user outside of the Karaf environment, and it would clone the repo without asking me to select the credential-manager. When the command was executed from the above described environment, it would roughly start the following Git Command tree:
>
> - Git.exe clone
> - Git-remote-http.exe (unsure what command)
> - Git.exe
> - Sh -c "git credential-helper-selector store" "git credential-helper-selector store"
> - Git.exe credential-helper-selector store
> - Git-credential-helper.exe
>
> The last 3 steps appears like they should have just configured the credential helper selector to use the store credential manager, but instead it would show the git credential helper and ask which credential manager to use.
>
> I'm not sure if this is the intended behavior, but It feels somewhat unlikely for an invisible dialog appearing like this to be intended.
>
> If any more information is needed, let me know and I'll share more details.
>
> Kind regards,
>
> Nate Kerkhofs
--
Philip
