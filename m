Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E83C433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 21:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbiADVGI convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 4 Jan 2022 16:06:08 -0500
Received: from elephants.elehost.com ([216.66.27.132]:20489 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbiADVGH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 16:06:07 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 204L62D1079583
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 4 Jan 2022 16:06:03 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'AJ Henderson'" <ahenderson@datto.com>, <git@vger.kernel.org>
References: <CACEm96jjWALB=iPiBNr0P5HrX9Oo3bXm_k1PpxsHm4Ns9M-vOQ@mail.gmail.com>
In-Reply-To: <CACEm96jjWALB=iPiBNr0P5HrX9Oo3bXm_k1PpxsHm4Ns9M-vOQ@mail.gmail.com>
Subject: RE: Stash Apply/Pop not restoring added files when conflict occurs on restore
Date:   Tue, 4 Jan 2022 16:05:57 -0500
Organization: Nexbridge Inc.
Message-ID: <004201d801ae$e238f330$a6aad990$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHvSvxZvxpetdcVU8RqYmGwJWQKLKwku+vg
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 4, 2022 2:00 PM, AJ Henderson wrote:
> I have had two developers have this problem 3 times.  When they are doing a
> stash push with newly created files and old files, when they go to do a stash
> pop, if there is no conflict, the files show up as expected, but when there is a
> conflict, the modified files are restored (and placed in a conflict state as
> expected), however, the new files are not restored.
> 
> We are able to work around this issue by grabbing the files directly out of the
> log for the stash head, but are unsure why this behavior isn't working as
> expected.  It seems to be a new change in behavior as we had never
> previously seen this issue, but have seen it 3 times now in the last few
> weeks.
> 
> We are running 64 bit Windows with Git For Windows version
> 2.34.1.windows.1

This looks like a regression from 2.33.0 to 2.34.1 in git. I can recreate the problem in 2.34.1, as follows:

$ mkdir test
$ cd test
$ git init
$ cat >a <<-EOF
Hi
EOF
$ cat >b <<-EOF
There
EOF
$ git add .
$ git commit -m "First"
$ cat >a <<-EOF
Hello
EOF
$ cat >c <<-EOF
Something
EOF
$ git stash push --include-untracked
$ cat >a <<-EOF
Conflict
EOF
$ git add a
$ git commit -m "Second"
$ git stash pop
Auto-merging a
CONFLICT (content): Merge conflict in a
The stash entry is kept in case you need it again.

* d8411cf (HEAD -> master) Second
| *   0bf6efc (refs/stash) WIP on master: c9bfeb9 First
|/|\
| | * 002560a untracked files on master: c9bfeb9 First
| * 6ad65b4 index on master: c9bfeb9 First
|/
* c9bfeb9 First

The stash contains c but has not been restored. In 2.33.0, c was restored and the conflict for a identified. In both versions, the stash is retained.
--Randall


