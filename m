Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 378081F453
	for <e@80x24.org>; Thu, 18 Oct 2018 20:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbeJSEPB (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 00:15:01 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:43910 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725751AbeJSEPB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 00:15:01 -0400
Received: by mail-oi1-f181.google.com with SMTP id s69-v6so25044873oie.10
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 13:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neosmart.net; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=NWMtk9B+0E/vhsYURmEOhqwFObMatVZ2oHHl9/BLB5Q=;
        b=nrV3x7NKAEfNEpCtq0woi/CZnMpwftHXXNA6oAyn4xgyPpjzwuo+M++2DYGaalgJpO
         vPvc8/zwe5u3A4iXmWLcdCzXZBgrDxIAgBxbEAW7T/MxCUURGbGgM7PGejJpJJdGr6n3
         dP/439bDiOJNhqsB3KVB2noW2Pqa1jKWcdKwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=NWMtk9B+0E/vhsYURmEOhqwFObMatVZ2oHHl9/BLB5Q=;
        b=MaUm2pi+CVBEntnQpMyq9StcN7qHQtug2bupOgLsp6mTxtpvgtn0H7tBMC0alCcoN4
         NgNVKBSmBsmLc7aXiz1N93kj4Kj2fbtD2PurFeEgp/Z/x6Sc10RgC8Spf+AmfC8WKJSl
         eS9U22hFjtxUPtgU3m8CLSXr/dhJMupyiYSYoqS4kKk+q8j4GhznU0Um/JcIkhrwfdyd
         hCgrORGHd66G/xZ4r6fBFFJPTegoFr5/frnIK3tbX7NSIoBvek7MT73/1d8M+XoKAjR/
         XyM1fguIGkxGGKxbeuB8H6wQg6qKX/7AqS6rH4YPo7DM/xSkGKNfHPiQZgiRPKkzS06E
         +IbQ==
X-Gm-Message-State: ABuFfoiD0+qZ0xbrXpUERC/RGspwAxsdfC8RXkXJTXgkQhGGZOUTF4t4
        fcEAhC1jjBMrD4SaNYuvJLqWnsyDy3aSQEljRZv8nevEXQa5CA==
X-Google-Smtp-Source: ACcGV63XB0nCrC8W7mEPmwSMxICS3fGfY0MCbBgzwzAEBzd3SxzVmVR09xJBFdH1HGijd4LjYPqYz1f5YJtz3BB+8Q8=
X-Received: by 2002:aca:4083:: with SMTP id n125-v6mr17752322oia.108.1539893542623;
 Thu, 18 Oct 2018 13:12:22 -0700 (PDT)
MIME-Version: 1.0
From:   Mahmoud Al-Qudsi <mqudsi@neosmart.net>
Date:   Thu, 18 Oct 2018 15:12:09 -0500
Message-ID: <CACcTrKfVZsRC8y-89mnj6LnRHnT6ivQCHpc0p5ABXk4kds6MbA@mail.gmail.com>
Subject: Shouldn't git be able to apply diffs that it created with --ignore-whitespace?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello again all,

I think I've previously broached this subject before, but I think I perhaps
wasn't clear enough about what I was trying to do or why I feel that git is at
fault here.

(I'm running git 2.19.1)

Starting with a fully-committed, not-dirty codebase, I open(ed) a poorly
formatted, mixed-whitespace file (that I absolutely did not author!) under
version control and make some very localized changes. My editor, being very
smart and helpful, fixes up the line ending on save, and I exit.

At this point, my source file contains a) deliberate changes I want, and b)
whitespace changes I wish I could commit but that should not be a part of my
patch.

Shouldn't the following workflow be supported:

~> git diff -w > foo.diff
~> git reset --hard
~> git apply [--ignore-whitespace] < foo.diff

Because that throws an error in this case:

> error: patch failed: includes/helpers/class.phpmailer.php:1182
> error: includes/helpers/class.phpmailer.php: patch does not apply

I feel like this did work, once upon a time. Perhaps prior to the same that
broke `git add -p` when whitespace was mangled on editor exit/save (2b8ea7f3c7)?

To help debug this, I'm attaching the output of the following taken after I've
made my changes to the file and wish to generate a clean diff, the former of
which applies just fine after `git reset --hard`, while the latter does not:

~> git diff > with_whitespace.diff
~> git diff -w > without_whitespace.diff

(I can also privately share the original file off-list if needed.)

I don't believe the list allows binary attachments and because we're dealing
with line-ending mangling I definitely do not want to include them inline, so
I've uploaded them here:

* http://share.neosmart.net/View/Index/nGujqm.diff
* http://share.neosmart.net/View/Index/f4dkVF.diff

(You can download them as-is by clicking the floppy icon in the top-right)

With thanks,

Mahmoud Al-Qudsi
NeoSmart Technologies
