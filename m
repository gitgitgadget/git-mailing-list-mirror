Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4E8C4708C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 04:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05A9C613DD
	for <git@archiver.kernel.org>; Fri, 28 May 2021 04:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbhE1EUC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 00:20:02 -0400
Received: from a48-109.smtp-out.amazonses.com ([54.240.48.109]:34201 "EHLO
        a48-109.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230245AbhE1EUB (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 28 May 2021 00:20:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=fdkgysj4d6avsn5zuujkcsdbm45he5c2; d=cd-net.net; t=1622175498;
        h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
        bh=jzm3JjQfEbNNLBRpCb/lsQ/zLVQzRhjsrDv3Vvm0O0A=;
        b=IKFE2uNwK3lge2xGpycAmOehXZtB4++N4rA/VCVsW4XyRMrPSDb0rEA4ysI2VCcx
        J79e9/TjKYZxkQ2Q6PRlx3R1lx6DOoffMbaH3gYZOSs7JGT5ODMQy2GhI/SKn03LTDo
        b3Pv/LgS7dE9C8DA0RqRbQ3rSzcZEf9NCi7m/jFM=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1622175498;
        h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type:Feedback-ID;
        bh=jzm3JjQfEbNNLBRpCb/lsQ/zLVQzRhjsrDv3Vvm0O0A=;
        b=CYBqxmgxnEEVRaURaz8oyuiw9hcSmw8LAyyJzem74KwAPnNyVz9wSdaJ2YGFvDqq
        Qs2OfVtSlKbnItzLSI4cxEg2BycJUGiY8Cmz5zJ7wjDSBuixnzTQs5ocx17ShP9qOVP
        twEAeQKkFJSs0Yn6gAPzYUKoetVxtktfLnUE4qNE=
X-Gm-Message-State: AOAM5328ViiIucvJOVLfw1ZW30rbpHu7xvOrgsfQCQJRRBNjZxiTEgee
        jGdHmGkGbiFn3AYLCV+ZMhzb9umkR+ojzMeZfYU=
X-Google-Smtp-Source: ABdhPJxtY+dl6WeQnEhBJWBgCFxrxqPFQRZRz7JcQnEtbhmp/PbJ/q7r3wVvJ/APTdW3MqaX9K03qVYxXXv8vX1NjjM=
X-Received: by 2002:aa7:c7cc:: with SMTP id o12mr7821687eds.291.1622175496774;
 Thu, 27 May 2021 21:18:16 -0700 (PDT)
MIME-Version: 1.0
From:   Arthur Moore <Arthur.Moore.git@cd-net.net>
Date:   Fri, 28 May 2021 04:18:18 +0000
X-Gmail-Original-Message-ID: <CA+r_57kvFPzQknXXwtZ-5Un7+NToF-7BszqqSNCHc=e=PAYmLQ@mail.gmail.com>
Message-ID: <01000179b131beca-113a6722-77cb-4320-8930-6904b197a003-000000@email.amazonses.com>
Subject: Bug: git p4 clone fails if non unicode files with +k or+ko attributes
 are present
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Feedback-ID: 1.us-east-1.rLDyHFYOzPV7e19tS4xTUdfsiKkyYL2gTUUJtpmYKQw=:AmazonSES
X-SES-Outgoing: 2021.05.28-54.240.48.109
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I would like to report a problem which is preventing me from using
git's Perforce integration.

Problem Command:
git p4 clone //path/to/files/

Steps to reproduce:
* Create/have a configured and running Perforce server and client.
* Create a file with any encoding aside from UTF-8 or UTF-16
containing at least one character outside the ASCII range.
* Adjust the file's type to text and include the "+k" or "+ko" attributes.
  * This can be done in the graphical p4v client by right clicking the
file and selecting "Change Filetype"
* Submit that file to Perforce.
* Attempt to run `git p4 clone //path/to/files/`

Expected behavior:
The Perforce repository is successfully cloned.

Actual behavior:

The clone failed with the following error:
```
Traceback (most recent call last):
  File "/usr/libexec/git-core/git-p4", line 4441, in <module>
    main()
  File "/usr/libexec/git-core/git-p4", line 4435, in main
    if not cmd.run(args):
  File "/usr/libexec/git-core/git-p4", line 4187, in run
    if not P4Sync.run(self, depotPaths):
  File "/usr/libexec/git-core/git-p4", line 4053, in run
    self.importHeadRevision(revision)
  File "/usr/libexec/git-core/git-p4", line 3761, in importHeadRevision
    self.commit(details, self.extractFilesFromCommit(details), self.branch)
  File "/usr/libexec/git-core/git-p4", line 3311, in commit
    self.streamP4Files(files)
  File "/usr/libexec/git-core/git-p4", line 3155, in streamP4Files
    p4CmdList(["-x", "-", "print"],
  File "/usr/libexec/git-core/git-p4", line 784, in p4CmdList
    cb(entry)
  File "/usr/libexec/git-core/git-p4", line 3142, in streamP4FilesCbSelf
    self.streamP4FilesCb(entry)
  File "/usr/libexec/git-core/git-p4", line 3090, in streamP4FilesCb
    self.streamOneP4File(self.stream_file, self.stream_contents)
  File "/usr/libexec/git-core/git-p4", line 3035, in streamOneP4File
    text = ''.join(decode_text_stream(c) for c in contents)
  File "/usr/libexec/git-core/git-p4", line 3035, in <genexpr>
    text = ''.join(decode_text_stream(c) for c in contents)
  File "/usr/libexec/git-core/git-p4", line 184, in decode_text_stream
    return s.decode() if isinstance(s, bytes) else s
UnicodeDecodeError: 'utf-8' codec can't decode byte 0xde in position
6276: invalid continuation byte
```

Failure Analysis:

The problem appears to be partly in `streamOneP4File` and partly in `
p4_keywords_regexp_for_type`.

Perforce allows embedding special keywords in files that are expanded
at checkout, and this function strips the expansion.
To do so,  it converts the binary data to a real string, performs a
regex replace, then converts it back to binary data.
Unfortunately, that assumes the file is encoded in UTF-8, and when
this is not the case an uncaught exception is thrown.

Importantly, perforce also allows injecting those keywords in raw
binary files, so this goes beyond a simple "support more encodings"
issue.

https://community.perforce.com/s/article/3482

[System Info]
git version 2.31.1

[Enabled Hooks]
not run from a git repository - no hooks to show

Sincerely,
Arthur Moore
