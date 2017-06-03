Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A620A209FD
	for <e@80x24.org>; Sat,  3 Jun 2017 23:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751177AbdFCXlm (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Jun 2017 19:41:42 -0400
Received: from fallback7.mail.ru ([94.100.181.128]:34192 "EHLO
        fallback.mail.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751077AbdFCXll (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jun 2017 19:41:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:To:Message-ID:Reply-To:From:Date; bh=/mZ0L+2susnai1JiGnSoPiNXYWlFNVetnA9lW5NaDy8=;
        b=noK8Xa9rhjVmACJ4S0R3bmjoShUd3UsEphzYuyKQSBXSVFH04YkTdfSOjBPwf77GQhnUJLJmffgJyd78Ga6xNyRPrgv7w/N7rJSllJl4FLiBAwcW6z/Opk3k/3ZpJqntV899P2cyD4RonhYVEB66SrcU50ls5+GozAFUHdKzy+o=;
Received: from [10.161.76.76] (port=53040 helo=smtp17.mail.ru)
        by fallback7.mail.ru with esmtp (envelope-from <andry@inbox.ru>)
        id 1dHIfq-0004Gx-Pz
        for git@vger.kernel.org; Sun, 04 Jun 2017 02:41:39 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:To:Message-ID:Reply-To:From:Date; bh=/mZ0L+2susnai1JiGnSoPiNXYWlFNVetnA9lW5NaDy8=;
        b=noK8Xa9rhjVmACJ4S0R3bmjoShUd3UsEphzYuyKQSBXSVFH04YkTdfSOjBPwf77GQhnUJLJmffgJyd78Ga6xNyRPrgv7w/N7rJSllJl4FLiBAwcW6z/Opk3k/3ZpJqntV899P2cyD4RonhYVEB66SrcU50ls5+GozAFUHdKzy+o=;
Received: from [91.215.123.55] (port=5654 helo=[10.58.100.33])
        by smtp17.mail.ru with esmtpa (envelope-from <andry@inbox.ru>)
        id 1dHIfo-0004Pn-QH
        for git@vger.kernel.org; Sun, 04 Jun 2017 02:41:37 +0300
Date:   Sun, 4 Jun 2017 02:36:31 +0300
From:   Andry <andry@inbox.ru>
Reply-To: Andry <andry@inbox.ru>
Message-ID: <1187166615.20170604023631@inbox.ru>
To:     git@vger.kernel.org
Subject: issue: "git subtree split" vs "git svn fetch" consequences
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-7FA49CB5: 0D63561A33F958A526F0D52D4BCAFA8F45AF357036FFBCA858083734737DD3D2725E5C173C3A84C3AA8C68A3574AB3B4D5E55C0B9A996F7D5E1C53F199C2BB95B5C8C57E37DE458B4C7702A67D5C3316FA3894348FB808DBCF17F1EDFBC1FB573B503F486389A921A5CC5B56E945C8DA
X-Mailru-Sender: C4E1A13722825DD95AC38BE660A0BED3BAE032957C97A7D39914847989BC631B3411EB38E91E6EFCD28863E40B4596773DDE9B364B0DF2898A5A4B3F8965010C02DB81B281332CC1AE208404248635DF
X-Mras: OK
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, git folks!

I think i've found something about inconsistency between "git subtree split" and "git svn fetch".

First of all, "git subtree split" ignores commits with 0 changed files, when the "git svn fetch" is not.
For example, it could be an svn commit where only properties has changed, but no file changes.

Second, seems "git subtree split" and "git svn fetch" produces different commit hashes for the same commits.

Experiment:

For instance, we have SVN repo: repoA with project in subdirectory, say repoA/B.

If try to make "git svn clone repoA A.git" and "git svn clone repoA/B B.git", then you will get totally different commit's hash list:

>cd A.git
>git log --pretty=oneline master
<GUID_A1> (HEAD -> master, git-svn) A1
<GUID_B1x> B1
<GUID_A2> A2
<GUID_B2x> B2
...
<GUID_AN> AN
<GUID_BNx> BN

>cd ../B.git
>git log --pretty=oneline master
<GUID_B1> (HEAD -> master, git-svn) B1
<GUID_B2> B2
...
<GUID_BN> BN

,where <GUID_Bk> not equal to the same commit <GUID_Bkx>, where k=1..N.

I beleave git does create a commit hash using eigher distance to the root, or previous commit hash in a commit chain.
Anyway, whatever it does this all leads to unavailability to synchronize such working copies which has been made through the "git svn clone repoA"+"git subtree split --prefix=B"+"git clone repoB.git"
with the SVN repository referenced by next call to the "git svn init repoA/B".

In another words, say we already have a git repository made from "git subtree split" - repoB.git.

Now, this set of commands looks resonable:

>git clone repoB.git B.git
Cloning into 'B.git'...
remote: Counting objects: 931, done.
remote: Compressing objects: 100% (395/395), done.
remote: Total 931 (delta 517), reused 931 (delta 517), pack-reused 0
Receiving objects: 100% (931/931), 10.15 MiB | 475.00 KiB/s, done.
Resolving deltas: 100% (517/517), done.

>cd B.git

>git log --pretty=online --grep=git-svn-id: master
<GUID_B1> (HEAD -> master, git-svn) B1
<GUID_B2> B2
...
<GUID_BN> BN

>git svn init repoA/B

>git update-ref refs/remotes/git-svn <GUID_B1>

(This one is important here, otherwise the next "git svn fetch" will retake whole svn repository from 0, which is might be too long if there is hundreds of revisions.)

(take a notice, the problem goes from here, see details below)

>git svn fetch
Rebuilding .git/svn/refs/remotes/git-svn/.rev_map.<A_GUID> ...
r4 = <GUID_BN>
r6 = <GUID_BN-1>
r12 = <GUID_BN-2>
...
rM-1 = <GUID_B2>
rM = <GUID_B1>
Done rebuilding .git/svn/refs/remotes/git-svn/.rev_map.<A_GUID>
        <some taken files here>
rNEW = <GUID_NEW> (refs/remotes/git-svn)

>git svn rebase
First, rewinding head to replay your work on top of it...
Fast-forwarded master to refs/remotes/git-svn.

>git push origin master
Counting objects: 3, done.
Delta compression using up to 6 threads.
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 375 bytes | 0 bytes/s, done.
Total 3 (delta 2), reused 0 (delta 0)
remote: Resolving deltas: 100% (2/2), completed with 2 local objects.
To repoB.git
   <GUID_B1>..<GUID_NEW>  master -> master

And it seems is all ok, but for one exception. The repoB.git is not the subtree splitted repository.
This is repository directly cloned from the SVN repoA/B just before rNEW commit has made into the SVN repository which is made in turn after the clone.

The real output is this:

>git svn fetch
Rebuilding .git/svn/refs/remotes/git-svn/.rev_map.<A_GUID> ...
Done rebuilding .git/svn/refs/remotes/git-svn/.rev_map.<A_GUID>
Rebuilding .git/svn/refs/remotes/git-svn/.rev_map.<A_GUID> ...
Done rebuilding .git/svn/refs/remotes/git-svn/.rev_map.<A_GUID>
Rebuilding .git/svn/refs/remotes/git-svn/.rev_map.<A_GUID> ...
Done rebuilding .git/svn/refs/remotes/git-svn/.rev_map.<A_GUID>
Index mismatch: <GUID_X> != <GUID_Y>
rereading <GUID_Z>
        <some taken files here>
W: -empty_dir: blabla1
W: -empty_dir: blabla2
...
W: -empty_dir: blablaL
Last fetched revision of refs/remotes/git-svn was r92, but we are about to fetch: r4!

I googled the whole internet inside out, but there is just no any solution for it.
It's broken and nothing about it.

The only solution i see here is just throw "git subtree split" as a hindering garbage for the sake of git-svn synchronization.

