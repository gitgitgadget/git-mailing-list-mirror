Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C0591FC96
	for <e@80x24.org>; Sat,  3 Dec 2016 01:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759368AbcLCBog (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 20:44:36 -0500
Received: from mail-io0-f175.google.com ([209.85.223.175]:34419 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753119AbcLCBof (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 20:44:35 -0500
Received: by mail-io0-f175.google.com with SMTP id c21so468499755ioj.1
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 17:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=a/3iJ+X9SUQv1MK71ZUQ8wpLFjOadqBCFQ1Ao85zmAY=;
        b=XCA0FCSK0xA+tqk0zY7bM9FuIdQyca48bK3rozISS3zyJs3mkECYXc8qiF8S10OmAY
         J1aB3AD8+7j+BL0z/jyq2SG44k/LOgOY8znpbJXROigWb6W4YKtfXCwA8yUbCfc94NrE
         AL9Sb5hzb/uSkZMa146DR0yZPgS3bYDEOe6y0cbcW66m92nT3JlumobSca3YsDeNScLr
         1wlgebrWhrdGpgGZNCuZ7vyxLKEAgG7jqESnppPhvK+/rIfB49G4itGVxL2wil4xGayO
         gpeCViUzTkpNpuaZSzKRXb2NQYXtannk/26Ja0ROHTFx5/Yu9jgFdPqk1hZiI8ni8Fz+
         aMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=a/3iJ+X9SUQv1MK71ZUQ8wpLFjOadqBCFQ1Ao85zmAY=;
        b=HTRY3qYSq0NPW1DlGwRB6/pq75FP4+4Ev+8lHOZbPzoTj2Gv1yBcLCzxa1h0TvYPZQ
         BAwLnS9cLpz+r9ON6l5jsQncqSD6+1acrg6XPY/CiW8GX4PKladpGo+ghFKSJK0pzCgb
         W0YFa6JysQeZMELs1zKYwQPIgcjLyrSv7yuLtAIz3NTxTikMD11NKkH9+K2/IDkXRoV9
         Rf+2uJvvOvtR1rhV9Y1oLOSi0oFwjgfG9/zeD+rYEbsfBFaTHkhNZi1rkqru2FBVlrCL
         yQ3IeJGq1j6nYkDWFpkLG4V4TglfP/eWKFJ4GEqGaOaTZdj0JcyEKkHdI2Cee2J6RVPW
         5bXg==
X-Gm-Message-State: AKaTC03FkCa5f0ZYfblJoflkQ/tOArkBTKy0nzeGuj/ayX+d/dYiHsR5AsyMK+ZrdNLZCi5VqfVjxLhttlNRpA+j
X-Received: by 10.36.93.137 with SMTP id w131mr69007ita.97.1480729473949; Fri,
 02 Dec 2016 17:44:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.12.219 with HTTP; Fri, 2 Dec 2016 17:44:33 -0800 (PST)
From:   Robbie Iannucci <iannucci@google.com>
Date:   Fri, 2 Dec 2016 17:44:33 -0800
Message-ID: <CA+q_oBdHytoeSD-hmLx_N473M8XinjqckvE35Re3eNpQRWYjHQ@mail.gmail.com>
Subject: [BUG] Index.lock error message regression in git 2.11.0
To:     git@vger.kernel.org
Content-Type: multipart/mixed; boundary=001a1143d4924e56060542b7322e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--001a1143d4924e56060542b7322e
Content-Type: text/plain; charset=UTF-8

Hello,

I just upgraded to 2.11.0 from 2.10.2, and I noticed that some
commands no longer print an error message when the `index.lock` file
exists (such as `git merge --ff-only`).

It appears this bug was introduced in
55f5704da69d3e6836620f01bee0093ad5e331e8 (sequencer: lib'ify
checkout_fast_forward()). I determined this by running the attached
bisect script (on OS X, but I don't think that matters; I've also seen
the error message missing on Linux):

$ cd /path/to/git/src
$ git bisect start v2.11.0-rc0 v2.10.2
$ git bisect run /path/to/bisect.test.sh

(my original version of the script also includes some other makefile
parameters to get a modern version of gettext and openssl too, but
they're not relevant to this ML).

I'm not certain that I have enough context to propose a meaningful
patch though :/.

Cheers,
Robbie

--001a1143d4924e56060542b7322e
Content-Type: application/octet-stream; name="bisect.test.sh"
Content-Disposition: attachment; filename="bisect.test.sh"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_iw8k1ux70

IyEvYmluL2Jhc2gKCm1ha2UgLWogOCAyPiYxID4gL2Rldi9udWxsCmlmIFtbICQ/ICE9IDAgXV07
IHRoZW4KICAjIHNraXAgdGhpcyB2ZXJzaW9uCiAgZXhpdCAxMjUKZmkKZ2l0PWByZWFscGF0aCAu
L2dpdGAKCnJtIC1yZiAudGVzdF9yZXBvIHx8IHRydWUKbWtkaXIgLnRlc3RfcmVwbwoKY2QgLnRl
c3RfcmVwbwokZ2l0IGluaXQKCmVjaG8gSEVMTE8gPiBhCiRnaXQgYWRkIGEKJGdpdCBjb21taXQg
LW0gJ2luaXRpYWxfY29tbWl0JwokZ2l0IGJyYW5jaCAtLXRyYWNrIG5ld19icmFuY2gKCiRnaXQg
Y2hlY2tvdXQgbWFzdGVyCmVjaG8gSEVMTE8gPj4gYQokZ2l0IGFkZCBhCiRnaXQgY29tbWl0IC1t
ICdzZWNvbmRfY29tbWl0JwoKJGdpdCBjaGVja291dCBuZXdfYnJhbmNoCgp0b3VjaCAuZ2l0L2lu
ZGV4LmxvY2sKaWYgJGdpdCBtZXJnZSAtLWZmLW9ubHkgbWFzdGVyIDI+JjEgfCBncmVwIC1GICJp
bmRleC5sb2NrIiA7IHRoZW4KICBlY2hvIE9LCiAgZXhpdCAwCmZpCmVjaG8gTWVzc2FnZSBpcyBt
aXNzaW5nCmV4aXQgMQo=
--001a1143d4924e56060542b7322e--
