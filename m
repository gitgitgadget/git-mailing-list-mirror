Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA86C433F5
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 19:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbiBAT7Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 14:59:16 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52948 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234782AbiBAT7P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 14:59:15 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 784C72110A
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 19:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643745554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a1iuc1pNxgjfllTnCrdekVkY9aiOjNWjPGg7GnK4RJY=;
        b=kjuFYBqC4GdYTe0Hwo14Svh+Vf0dSy8j4gR4Q+MX66f/vhO2CE3XQvnbKeAVj5ejlWpd4T
        Eki0MQyqjvf4jDrub96f2ELdjjn07WCEswTQCEAS99lzYRRYpR0B0bL1MHnRiW4vjSdu/X
        61Wz+goFCWGnXNY4qPfARLfVLkeZRgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643745554;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a1iuc1pNxgjfllTnCrdekVkY9aiOjNWjPGg7GnK4RJY=;
        b=6GmcgwbTtGr5oLUCtP9FnYf9HvOyGf7qkGaeiEodAeklU6F+ch0WTHdt9mpoiwexhaC1HZ
        gu+6x9gFJaG+DOBQ==
Received: from kunlun.suse.cz (unknown [10.100.128.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 706D9A3B87
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 19:59:14 +0000 (UTC)
Date:   Tue, 1 Feb 2022 20:59:13 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     git@vger.kernel.org
Subject: Re: Getting rid of "hint: Using 'master' as the name for the initial
 branch." when not initializing a repository with pygit
Message-ID: <20220201195913.GV3113@kunlun.suse.cz>
References: <20220201184128.GT3113@kunlun.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220201184128.GT3113@kunlun.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 01, 2022 at 07:41:28PM +0100, Michal Suchánek wrote:
> Hello,
> 
> I am running some tests of a project that uses pygit, and the test
> creates a test repository .. using pygit.
> 
> I noticed that in some environments the default branch warning is
> displayed and not others because the git version varies.
> 
> The warning is just noise in the test log so I would like to avoid it,
> and I would like to find a solution that works for git that predates the
> introduction of this warning and the option to silence it as well as
> the future git versions in which the default is subject to change.
> 
> AFAICT there is no clean way to do it. I can set up the global option to
> whatever but I don't want to do that just to run tests.
> 
> I could set the repo local option but before calling
> pygit2.init_repository() there is no repository to configure, and after
> it is too late because I expect the message to be printed by this call.
> 
> Also I cannot rely on pygit to have some latest bells and whistles
> because like git it varies across environments and the whole point of
> running the test in different environments is to verify that it works
> with whatever tool versions are avaialble there.

Actually, I found that the code uses a mix of pygit2 and direct git
calls, and it's the direct call to git init that prints the warning
which can be fixed trivially by using pygit:
@@ -460,7 +460,7 @@ class TestMergeTool(unittest.TestCase):
         self.ks_dir = tempfile.mkdtemp(prefix="gs_ks")
         os.chdir(self.ks_dir)
 
-        subprocess.check_call(("git", "init", "./",), stdout=subprocess.DEVNULL)
+        pygit2.init_repository("./")
         subprocess.check_call(
             ("git", "config", "--add", "mergetool.git-sort.cmd",
              "%s $LOCAL $BASE $REMOTE $MERGED" % (

which begs the question how would I fix it if I was not using pygit. The
git version that does not produce the warning also does not support -b
so it cannot be be universally used with git init. Is there some
reasonable waey to detect this?

Thanks

Michal
