Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55F792042F
	for <e@80x24.org>; Wed, 16 Nov 2016 20:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753896AbcKPUTM (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 15:19:12 -0500
Received: from mail-qt0-f176.google.com ([209.85.216.176]:34245 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752546AbcKPUTK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 15:19:10 -0500
Received: by mail-qt0-f176.google.com with SMTP id n6so115845103qtd.1
        for <git@vger.kernel.org>; Wed, 16 Nov 2016 12:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yanofsky.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=3A4KtZ1ptA4AEWk95v5rUbAqLWFXeXMuC/wWZr0rTzA=;
        b=XXal6rGlP6SgxueaeTSA6oWneV2Bdrb4WTGy0gf4VYPSmS8D1EaNsVrRWb9eiKNp6N
         MdCBC7pg3iMxHEUk1ki/zupWW0IUjiXjslp8ZmAl89CJ/pwo4T6DKN8RMueI0V4AGk1t
         1MbB1YG8eTc1LfmXeVXyhsfstd7dNqDzee6Jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3A4KtZ1ptA4AEWk95v5rUbAqLWFXeXMuC/wWZr0rTzA=;
        b=jGSLjL5J9bFNXXXmwy7IaU9JhztGpgTwNX2Kdg+txSjhIXEzXVVzWYB7cHiCkBSDno
         GR1nwLuzRS+NP3hByjJ9I5F4wojA5y8Xczh57EXogVvEwe8oJct9nf8CByZV2kHd5n4s
         zlGGBEdt37JywFVowype+ukgd9rQ53CzwzzFu2YrPoTOmr1CDUwB9dPOtP+BL8WOH8sq
         Q2j+1YE5+7QveCb9KFPtBAr3wWsCDDhkhc1kdjZcAoXELJagc8GKD2yRZfJ/5dVKhm/K
         9co3kEoDIOXbWNPejzxcu5U/tNy1B+lBP5SzeEyqyYejI0hGmJhH4CHG0keYAnSbzlW2
         qMkg==
X-Gm-Message-State: ABUngveQMeeH6aEvBhYY1MwKSNmj2rWQQKOVCeab3v8zQgJbyFRqfIH2UuxWDivvmJxRJuOBmOLJsXQJBPvEQ42T
X-Received: by 10.25.92.74 with SMTP id q71mr1697563lfb.140.1479327549576;
 Wed, 16 Nov 2016 12:19:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.114.1.111 with HTTP; Wed, 16 Nov 2016 12:19:09 -0800 (PST)
From:   Russell Yanofsky <russ@yanofsky.org>
Date:   Wed, 16 Nov 2016 15:19:09 -0500
Message-ID: <CA+ip-Bt96KRfv_UdYKDTEzDgR0QLtPshsZszXsnCw8wRTBG2WQ@mail.gmail.com>
Subject: git stash can recursively delete a directory with no warning
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using git 2.10.1, I recently lost the contents of an entire directory
by running a "git stash" command. I don't know if this known behavior,
but it seems pretty dangerous. To trigger the bug, all you have to do
is check out a repository containing a symlink, delete the symlink,
and then create a directory with files at the path where the deleted
symlink was. After this, running "git stash" will recursively delete
the directory, leaving no way to recover the data.

Here are minimal steps to reproduce:

mkdir test-repo
cd test-repo
git init
ln -s location symlink
git add symlink
git commit -m'add symlink'
rm symlink
mkdir symlink
echo important-data > symlink/important-data
git stash # recursively deletes entire contents of "symlink" directory
