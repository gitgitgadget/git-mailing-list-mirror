Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 887ED1FAFB
	for <e@80x24.org>; Sun,  9 Apr 2017 14:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752243AbdDIOPk convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 9 Apr 2017 10:15:40 -0400
Received: from vps.dannysauer.com ([72.4.146.113]:44418 "EHLO
        smtp2.dannysauer.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752075AbdDIOPj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Apr 2017 10:15:39 -0400
Received: from humpy.home.dannysauer.com (home.dannysauer.com [50.44.186.177])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "mail.home.dannysauer.com", Issuer "Danny Sauer" (verified OK))
        by smtp2.dannysauer.com (Postfix) with ESMTPS id 08116789C011;
        Sun,  9 Apr 2017 09:15:38 -0500 (CDT)
Received: from [192.168.0.230] (unknown [192.168.0.230])
        by humpy.home.dannysauer.com (Postfix) with ESMTPS id 33B3F20807;
        Sun,  9 Apr 2017 09:15:36 -0500 (CDT)
Subject: Re: [PATCH] Make git log work for git CWD outside of work tree
References: <20170409022128.21337-1-danny@dannysauer.com>
 <alpine.DEB.2.20.1704091238560.4268@virtualbox>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     git@vger.kernel.org
From:   Danny Sauer <danny@dannysauer.com>
Message-ID: <413a1456-cac6-56c8-ea45-38f14cf958ae@dannysauer.com>
Date:   Sun, 9 Apr 2017 09:15:36 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1704091238560.4268@virtualbox>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/9/2017 5:54 AM, Johannes Schindelin wrote:
> Hi Danny,
>
> On Sat, 8 Apr 2017, Danny Sauer wrote:
>> diff --git a/git.c b/git.c
>> index 8ff44f0..e147f01 100644
>> --- a/git.c
>> +++ b/git.c
>> @@ -440,7 +440,7 @@ static struct cmd_struct commands[] = {
>>  	{ "init", cmd_init_db },
>>  	{ "init-db", cmd_init_db },
>>  	{ "interpret-trailers", cmd_interpret_trailers, RUN_SETUP_GENTLY },
>> -	{ "log", cmd_log, RUN_SETUP },
>> +	{ "log", cmd_log, RUN_SETUP | NEED_WORK_TREE },
>>  	{ "ls-files", cmd_ls_files, RUN_SETUP | SUPPORT_SUPER_PREFIX },
>>  	{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
>>  	{ "ls-tree", cmd_ls_tree, RUN_SETUP },
> This may work for you, but it does not work for me, as I often call `git
> log` in a bare repository. And that call works, and it should keep
> working.

I was wondering about that situation, but honestly I wasn't positive how
to test it and sort of just went on the hope that the read_mailmap_blob
mechanism would continue handling it.  So, I guess there's another test
case which would be useful, as passing the test cases is what gave me
that undeserved confidence. :)  And I'm going to need to read a bit more
to figure out what a bare repository actually is...

> Instead, I think, you need to figure out why the .mailmap file is not read
> correctly when you use the GIT_DIR & GIT_WORK_TREE approach. My vague
> hunch is that you need to replace the ".mailmap" in read_mailmap()
> (defined in mailmap.c):
>
>         err |= read_mailmap_file(map, ".mailmap", repo_abbrev);
>
> by something like mkpath("%s/%s", get_git_work_tree(), ".mailmap"), but
> probably only after testing that we're not in a bare repository (which
> would also fix a bug, I suspect, as `git log` in a bare repository
> probably heeds a .mailmap file in the current directory, which is
> incorrect). I.e. something like:
>
> 	if (!is_bare_repository()) {
> 		const char *path = mkpath("%s/%s",
> 					  get_git_work_tree(), ".mailmap")
> 		err |= read_mailmap_file(map, path, repo_abbrev);
> 	}

That's feedback I was looking for - what's the "right" way to get the
path to the file.  The call as-is works in any subdirectory of a
repository, because there's some logic buried along the way which puts
you in the top level of the repo if you started underneath.  But if
you're outside, it does the same chdir to verify that the top level is a
real repo and then returns you to where you started (which is perfectly
reasonable).

In comparing how shortlog works v/s log, the main difference I could see
is the use of RUN_SETUP_GENTLY instead of RUN_SETUP as the flag, which
itself seems to only differ by passing in a true value for nongit_ok in
run_setup, ultimately leading to "some different directory checks" -
which I somewhat got lost in due partially to not fully knowing what a
bare repository is. :)  But changing that didn't make it work in my
(poorly-formalized) testing.

I'm on-board with a proper test case being the first situation which
needs rectifying.  It's off to learn stuff for me, then.  Thanks!

--Danny

