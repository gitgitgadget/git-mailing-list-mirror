Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A663220951
	for <e@80x24.org>; Fri, 17 Mar 2017 21:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751098AbdCQVJf (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 17:09:35 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36369 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751129AbdCQVJd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 17:09:33 -0400
Received: by mail-wm0-f42.google.com with SMTP id n11so24594678wma.1
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 14:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=py3eAVYC/e834tGMwr04o2xy9R37MxNkK4oo+toOmRQ=;
        b=bahQH2wdtHyvy+HL/CLe0j3mFGx23jbhPq1utvU2ptdHvxhgAF9W7LlKSNGyZuP9Fk
         2h1h4Cg2PDzsuA3zzU+HwT/x+XPnG1ynnKiNK/cxW2D79hIopg0KDIU+zljgeCqpwhKp
         onnzaaL1oSCwRhdu8nSaab+5u7XyhWTqtIDvJjDZth0ziyvx0WRoNWGdLGVuvpvUpJx/
         Mh61HxXrXJaj5rOvAWXvWnp2+6W8uXNBGxF1WqgLCmtTPdbHIG52fhztiUFJhfn/bOxO
         /c1G5Cym6rn0b/i0aUFbMz9HD+7sU93mWnj8Y6XlMUV4NehvUompBNWLflXy9bJY3eZV
         2mog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=py3eAVYC/e834tGMwr04o2xy9R37MxNkK4oo+toOmRQ=;
        b=bcl3HFNRTxSae1kH1ZmPZJSVhxWxr8+/a0jCH2cfCYauPyYS6e5pJicg2OqbTYl82A
         La9f0ptqLHIatw24SHDeLwlbcgTfbxnMFK2wL5HxJ6vj9oQ1WY7Lkq+/+wSBdELDKgN2
         h98QVBaSmGy2IxpRtjEXNjQsIPORJ13eC7bjPI6rJmwLj/rGZ2TB2QGPZ345v0hwzewd
         y9awv3Dns18l4q5hoqug6u2RNK2wdD1Plc5PFM+5Uok7PYE+mIAQIzh9n2aqlVyB6OrZ
         bx1Y5RNrdSqQH0b+k0uVdBs/k/5fhOC/Y/vqeWyXBKdwhxJ0WbllcZ9tIqHCjUDlkH8d
         8q3Q==
X-Gm-Message-State: AFeK/H0A1fZdJv10TYNS1gzOpCMl1X2IGPJcRSOTReZKJHrrHp/8fQWG2oqrMUSoyHXopl/CJs/RrgF2BL3yDg==
X-Received: by 10.28.138.134 with SMTP id m128mr120481wmd.121.1489783376104;
 Fri, 17 Mar 2017 13:42:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.130.1 with HTTP; Fri, 17 Mar 2017 13:42:35 -0700 (PDT)
From:   Nevada Sanchez <sanchez.nevada@gmail.com>
Date:   Fri, 17 Mar 2017 16:42:35 -0400
Message-ID: <CAPUVn2u0Uos2mT5+4ejj8m0okNK6XwerL6ce2miHfhtuEs-ZnQ@mail.gmail.com>
Subject: Bug with .gitignore and branch switching
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's an easy to reproduce bug. It's the only example I know of where
git legitimately loses data in a way that is unrecoverable,
unexpected, and without warning.

```
git --version
# git version 2.12.0

mkdir git-demo
cd git-demo

git init

# Commit a file that will end up in .gitignore
echo 'original settings' > mine.conf
git add mine.conf
git commit -m "Unknowingly committed my settings."

echo '*.conf' > .gitignore
git add .gitignore
git commit -m "Users shouldn't commit their settings"

# Spin off a feature branch here (but don't check it out)
git branch feature

# Realize that we don't want that file committed
git rm mine.conf
git commit -m "Delete mine.conf"

echo 'Lots of laboriously tuned settings' > mine.conf

# Hop on the feature branch to do some work
git checkout feature

# Hmmm... My settings are gone
cat mine.conf
# original settings

# Lemme hop back
git checkout master

# Wait... they are gone for good!
cat mine.conf
# cat: mine.conf: No such file or directory
```
