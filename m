Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2ACC11FC96
	for <e@80x24.org>; Sat,  3 Dec 2016 05:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750878AbcLCFEm (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Dec 2016 00:04:42 -0500
Received: from mail-io0-f177.google.com ([209.85.223.177]:33446 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750721AbcLCFEm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Dec 2016 00:04:42 -0500
Received: by mail-io0-f177.google.com with SMTP id j65so516946441iof.0
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 21:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=boBfBWNRjdnW5TxihRRmp3aFKz8CLjsgGB4mx5Z56sY=;
        b=gvaoILEh19ZQuokZsgfagFb5EH6aEIB7mfohCsQVzAQMPqRQxxUiszSOCZYsih+8h0
         Hf+Fzwuc7w8ocHB6wqP2HS9kQoGcsgp5+biaYaSFuT0SfZoyK4uoBbvYyvOF9/upY0ZH
         wwxgsZCdbxUJqWfImcQjlLpoQVq/8h37zDHQ+W2xuu0rQHjycS2HGCDE8eeefKQHG5vl
         v8kUPr7+jAnqDghytEnYDt3JAHI1Qg+coUYtmmWhTztC4WunRC0kF5X+mfPw2iyYtVs0
         qyrhk8VOGS/2WFdqi5pSImdue8Ftp0cxIXqc1UcAFy5DaPAzkAoYR886911wcDxUYahO
         43rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=boBfBWNRjdnW5TxihRRmp3aFKz8CLjsgGB4mx5Z56sY=;
        b=KDc2dMaV9Tbx9SVHGC0u2BqsEphNUrxk/ilEZY8gYGPWE76ku2vkpsQWkxt7R3WOqE
         B5qJ/T11rYfEcCJhgtC7L1tx1pJ/4xsQMB25pVDAgFvzRjwMpCUMIL3YCq0a059kBjcU
         uagDRuIG1U01kCUbY1hThv7NJZ0Z6NSRcZuoghnGTGiBgbz9GHPMvaBmShNDmVT2zv3I
         v/P5lbkuAAf2FYUyeEmfj8L6CIJyFugIWzhggCWSWtOmI86ABEcqcE9gwPafRMiJejVu
         DwroJAqpGNI6ETo8Alc6punvk4pW/u5e2lA22rvqKlpii5TNwSD1wrTjUSsWaG0jAmGU
         SzMw==
X-Gm-Message-State: AKaTC02rasbCxNyi1UX7ZEVl7zLumCuWjAxhJwsgqhvWjooYCtjhMuq6Eb0td3KiZ37fPXV69/MJp3XNJ22/3g==
X-Received: by 10.36.219.196 with SMTP id c187mr522933itg.23.1480741480878;
 Fri, 02 Dec 2016 21:04:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.30.196 with HTTP; Fri, 2 Dec 2016 21:04:40 -0800 (PST)
From:   Julian de Bhal <julian.debhal@gmail.com>
Date:   Sat, 3 Dec 2016 15:04:40 +1000
Message-ID: <CAJZCeG1Eu+5DfaxavX_WGUCa+SY+yepDWZhPXxiFcV__h0xjrw@mail.gmail.com>
Subject: git reset --hard should not irretrievably destroy new files
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If you `git add new_file; git reset --hard`, new_file is gone forever.

This is totally what git says it will do on the box, but it caught me out.

It might seem a little less stupid if I explain what I was doing: I was
breaking apart a chunk of work into smaller changes:

git commit -a -m 'tmp'           # You feel pretty safe now, right?
git checkout -b backup/my-stuff  # Not necessary, just a convenience
git checkout -
git reset HEAD^                  # mixed
git add new_file
git add -p                       # also not necessary, but distracting
git reset --hard                 # decided copy from backed up diff
# boom. new_file is gone forever


Now, again, this is totally what git says it's going to do, and that was
pretty stupid, but that file is gone for good, and it feels bad.

Everything that was committed is safe, and the other untracked files in
my local directory are also fine, but that particular file is
permanently destroyed. This is the first time I've lost something since I
discovered the reflog a year or two ago.

The behaviour that would make the most sense to me (personally) would be
for a hard reset to unstage new files, but I'd be nearly as happy if a
commit was added to the reflog when the reset happens (I can probably make
that happen with some configuration now that I've been bitten).

If there's support for this idea but no-one is keen to write the code, let
me know and I could have a crack at it.

Cheers,

Julian de Bh=C3=A1l
