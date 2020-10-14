Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99161C433DF
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 09:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D938206DD
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 09:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sebres.de header.i=@sebres.de header.b="h5fpnj67"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgJNJXv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 05:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731045AbgJNJXN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 05:23:13 -0400
Received: from sebres.de (sebres.de [IPv6:2a03:4000:3f:185::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D26BC0613DA
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 02:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sebres.de;
         s=dkim; h=Message-ID:Reply-To:From:Date:Content-Transfer-Encoding:
        Content-Type:MIME-Version:Subject:To:Sender:Cc:Content-ID:Content-Description
        :Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=duE05f7YaFGi38JxlQN/OoB/QhB9TwPTf6cb5oPSpR8=; b=h5fpnj67RgSpYE3fK5DN9e10jV
        3rTOuwQqYeBayYFGV7vd9zXdn099H5Ayb8yJeLJfhT0yz3Q0KyY46hEFzpiu6eRAnM5aIQ+Q/Fv9j
        bxeXMIHTyA0d3oge27WzWDoynRxD+XIzC/w3wa6+OmbDMePfod6fncue5xq8O4/iGWZNDKc6tS+1d
        EpLK6qfxqFM6cT2gEbs48p8MQorZz3of4RwQC1YyeHA/dFB5zE1bxWFVtyd9kuO0njFBhDrzyguKR
        Res9FY0SIf/ecW/51O/6+fgIEWEaoCAAOTEMqsq87tBF+P7jQoylpS+dGnQOYN3gXNccrNr4dOzSF
        5w+HJc+Q==;
To:     git@vger.kernel.org
Subject: git fast-import leaks memory drastically, so crashes with out of  memory by attempt to import 22MB export dump
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 14 Oct 2020 11:22:03 +0200
From:   "Dipl. Ing. Sergey Brester" <serg.brester@sebres.de>
Reply-To: serg.brester@gmx.net
Mail-Reply-To: serg.brester@gmx.net
Message-ID: <1eeb49305cb7c712e141dcae2c434d96@sebres.de>
X-Sender: serg.brester@sebres.de
User-Agent: Webmail/1.0.3
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Steps to reproduce the issue:

  1. export from fossil and import the dump to the git:
```
fossil export --git --import-marks .git/.fossil2git-fssl --export-marks 
.git/.fossil2git-fssl.tmp ^
  | git fast-import --import-marks=.git/.fossil2git-git 
--export-marks=.git/.fossil2git-git.tmp
```
  during the import git-fast-import.exe is growing on memory (more than I 
have physically, e.g. noticed over 20GB),
  SO FINALLY IT IS CRASHING WITH:
```
fatal: Out of memory, malloc failed (tried to allocate 2097152 bytes)
fast-import: dumping crash report to .git/fast_import_crash_1800
```
  the crash report contains:
```
fast-import crash report:
  fast-import process: 1800
  parent process : 1
  at 2020-10-13 18:55:19 +0000

fatal: Out of memory, malloc failed (tried to allocate 2097152 bytes)

Most Recent Commands Before Crash
---------------------------------

Active Branch LRU
-----------------
  active_branches = 0 cur, 5 max

  pos clock name
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Inactive Branches
-----------------

Marks
-----
  exported to .git/.fossil2git-git.tmp

-------------------
END OF CRASH REPORT
```

  2. if I do the export firstly (redirect to file), fossil creates 22MB 
large export dump-file,
  if I import it via git hereafter, it crashes in the same way.
```
fossil export --git --import-marks .git/.fossil2git-fssl --export-marks 
.git/.fossil2git-fssl.tmp > tmp-dump-out-of-mem.txt

dir tmp-dump-out-of-mem.txt
13.10.2020 20:37 22.916.280 tmp-dump-out-of-mem.txt

type tmp-dump-out-of-mem.txt | git fast-import 
--import-marks=.git/.fossil2git-git 
--export-marks=.git/.fossil2git-git.tmp

fatal: Out of memory, malloc failed (tried to allocate 2097152 bytes)
fast-import: dumping crash report to .git/fast_import_crash_1800
```

I did not see any issues with (even much larger) imports, before I 
upgraded git to 2.28.0 (from 2.25.1, I guess).

[System Info]
git version:
git version 2.28.0.windows.1
cpu: x86_64
built from commit: 77982caf269b7ee713a76da2bcf260c34d3bf7a7
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
uname: Windows 10.0 18363
compiler info: gnuc: 10.2
libc info: no libc information available
$SHELL (typically, interactive shell): <unset>

An attempt to repeat this with 2.27.0 (portable) changes nothing 
(crashed with the same issue).

BUT TRYING THAT WITH 2.14.4 (MINGIT-2.14.4.WINDOWS.7-64-BIT) WORKS WELL:
```
C:SoftDevGit-2.14mingw64bingit-fast-import.exe statistics:
---------------------------------------------------------------------
Alloc'd objects: 130000
Total objects: 591 ( 80 duplicates )
  blobs : 224 ( 0 duplicates 151 deltas of 224 attempts)
  trees : 260 ( 80 duplicates 191 deltas of 260 attempts)
  commits: 107 ( 0 duplicates 0 deltas of 0 attempts)
  tags : 0 ( 0 duplicates 0 deltas of 0 attempts)
Total branches: 201 ( 46 loads )
  marks: 1048576 ( 129437 unique )
  atoms: 1503
Memory total: 10439 KiB
  pools: 4346 KiB
  objects: 6093 KiB
---------------------------------------------------------------------
pack_report: getpagesize() = 65536
pack_report: core.packedGitWindowSize = 1073741824
pack_report: core.packedGitLimit = 35184372088832
pack_report: pack_used_ctr = 131659
pack_report: pack_mmap_calls = 119
pack_report: pack_open_windows = 66 / 66
pack_report: pack_mapped = 488903419 / 488903419
---------------------------------------------------------------------
```

The crash with newer versions is pretty well reproducible, so I have 
frozen this state to be able to test it later (or check whether it gets 
fixed).
Don't hesitate to ping me if you need some data or tests.

-- 

Regards,
Sergey Brester
