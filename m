Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B16A1F404
	for <e@80x24.org>; Thu, 14 Dec 2017 21:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753298AbdLNVHe (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 16:07:34 -0500
Received: from elephants.elehost.com ([216.66.27.132]:24843 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753236AbdLNVHV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 16:07:21 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea ([70.25.22.42])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id vBEL7F4V050745
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 14 Dec 2017 16:07:16 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Josef Wolf'" <jw@raven.inka.de>, <git@vger.kernel.org>
References: <20171214130933.GA18542@raven.inka.de>
In-Reply-To: <20171214130933.GA18542@raven.inka.de>
Subject: RE: Need help migrating workflow from svn to git.
Date:   Thu, 14 Dec 2017 16:07:15 -0500
Message-ID: <005801d3751f$859f6c50$90de44f0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIA5x5KlHQcMIqb62PQwdaAr7U4AKLobwfQ
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On December 14, 2017 8:10 AM, Josef Wolf wrote:
> Subject: Need help migrating workflow from svn to git.
> 
> Hello folks,
> 
> I am wondering whether/how my mode of work for a specific project
> (currently based on SVN) could be transferred to git.
> 
> I have a repository for maintaining configuration of hosts. This
repository
> contains several hundered scripts. Most of those scripts are don't depend
on
> each other.
> 
> Every machine has a working copy of the repository in a specific
directory. A
> cron job (running every 15 minutes) executes "svn update" and executes the
> scripts which are contained in this working copy.
> 
> This way, I can commit changes to the main repository and all the hosts
will
> "download" and adopt by executing the newest revision of those scripts.
> (The sripts need to be idempotent, but this is a different topic).
> 
> NORMALLY, there are no local modifications in the working copy. Thus,
> conflicts can not happen. Everything works fine.
> 
> Sometimes, I need to fix a problem on some host or need to implement a
> new feature. For this, I go to the working copy of a host where the change
> needs to be done and start haking. With svn, I don't need to stop the cron
> job. "svn update" will happily merge any in-coming changes and leave alone
> the files which were not modified upstream. Conflicts with my local
> modifications which I am currently hacking on are extremely rare, because
> the scripts are pretty much independent. So I'm pretty much happy with
this
> mode of operation.
> 
> With git, by contrast, this won't work. Git will refuse to pull anything
as long
> as there are ANY local modifications. The cron job would need to
> 
>    git stash
>    git pull
>    git stash pop
> 
> But this will temporarily remove my local modifications. If I happen to do
a
> test run at this time, the test run would NOT contain the local
modifications
> which I was about to test. Even worse: if I happen to save one of the
> modified files while the modifications are in the stash, the "git stash
pop" will
> definitely cause a conflict, although nothing really changed.
> 
> So, how would I get this workflow with git? Is it possible to emulate the
> behavior of "svn update"?
> 
> Any ideas?

You might want to consider a slight modification to your approach as
follows. 
Instead of using git pull, use git fetch.
Have each system on its own branch (sys1 = my-sys1-branch, for example) so
you can track who has what.
In your scripts, consider:
git fetch
if nothing changed, done
git status
if no changes, git merge --ff  master && git push origin my-sys1-branch &&
done
if changes, send an email whining about the changes
your script could then (depending on your environment) git commit -a && git
merge && git push origin my-sys1-branch && done

This would allow you to track the condition of each system at your single
upstream repository. 

Just my $0.02

Cheers.
Randall\
-- Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)/NonStop(211288444200000000)
-- In my real life, I talk too much.



