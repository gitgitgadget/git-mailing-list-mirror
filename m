Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF0B920D09
	for <e@80x24.org>; Sat, 27 May 2017 13:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756789AbdE0Nbh (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 May 2017 09:31:37 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:34949 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756626AbdE0Nbg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 May 2017 09:31:36 -0400
Received: by mail-qt0-f174.google.com with SMTP id v27so26013934qtg.2
        for <git@vger.kernel.org>; Sat, 27 May 2017 06:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=0kiS0ZIeE4bqrF49ClZFx+F/Deykg82RG0XS7WjCsI8=;
        b=DX3wLx7zZih1cd1YbC9mUqKLFNn+EmQUGv61xgmZ08r5gOjpHI/2UrtcaKRmQ3TTCG
         b8y4EaRJfGeboVWErFkiW7xsmZGAgr5d74IvxnjdYfPl+rDIjT4eQGphD2Qjt3aR9G5A
         rwHLOn6NE07fKQm8n77m6niuwd52zyELFl5z60YoL7Df1FrOFdbWzOIRyB1wn/n37GUL
         Oc0U2Z4v29s/tgpEWmgE6Atm7rprWaDILJIlEV3YYKIx0cJbB3XhSipt7nN4NvRpdmjh
         82W7yy40WNrt/4mnajdbpUUYUB2D/F+SoZjX5gKrbEr5RweL2RMQf2z+f/nBD42gMYrF
         1n3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=0kiS0ZIeE4bqrF49ClZFx+F/Deykg82RG0XS7WjCsI8=;
        b=uB6JgiQoYOUGGT0wK2BOgt8fbro6uKohk0m8PMs53nRBpLNXkRpFTcNNy2JlH5I1u7
         KjZsu+b6qixFTREWF5cdS7wF0XXI1/l+LS5vZtC/FYADEq+nivaS3PanJ28Z7UAhpSyv
         H12Fk52379EkDhbTekfr4fqAqKX6Tg65Xknhw5yCsT2+90bQQiYrC5eZKtCUdge3UY4h
         /S3Wwr4tZbpYqop26u3HuwSbeq9nOeAhpEjfOukxwMgdn6uK64tfUYajd4oLzcs4JQuh
         KHtVKreEbZ/qrlEtdTnoYjyUnVz009+LXbgdNc2aTxXVR1lIOTI7N8B3Kqc2EkA7Tfjh
         4hIA==
X-Gm-Message-State: AODbwcDYTkEKykwaljAxeFdQH8bOvE3Z4Sl896LO4DyF0/vnaM66Ob7R
        Z9B3bKvAuoPXVX6T/K6Z92jtyHf7QRHkKdk=
X-Received: by 10.200.51.148 with SMTP id c20mr8328450qtb.56.1495891895423;
 Sat, 27 May 2017 06:31:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.86.48 with HTTP; Sat, 27 May 2017 06:31:15 -0700 (PDT)
From:   John Shahid <jvshahid@gmail.com>
Date:   Sat, 27 May 2017 09:31:15 -0400
Message-ID: <CAE5=+KX57KM+6n9NpePw9KYPXFy7UH-WRgSwaJDnvRofYFXm7Q@mail.gmail.com>
Subject: git push recurse.submodules behavior changed in 2.13
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

It looks like the git push recurse-submodules behavior has changed.
Currently with 2.13 you cannot run "git push
--recurse-submodules=on-demand" if the parent repo is on a different
branch than the sub repos, e.g. parent repo is on "develop" and
sub-repo on "master". I created a test that can be found here [1].

A bisect shows that the change to propagate refspec [2] to the
submodules is the culprit. imho this is an undesired change in
behavior. I looked at the code but couldn't see an easy way to fix
this issue without breaking the feature mentioned above. The only
option I can think of is to control the refspec propagation behavior
using a flag, e.g. "--propagate-refspecs" or add another
recurse-submodules option, e.g. "--recurse-submodules=propagate"

What do you all think ?

[1] https://gist.github.com/jvshahid/b778702cc3d825c6887d2707e866a9c8
[2] https://github.com/git/git/commit/06bf4ad1db92c32af38e16d9b7f928edbd647780
