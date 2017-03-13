Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8061F1FC43
	for <e@80x24.org>; Mon, 13 Mar 2017 14:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751359AbdCMOWJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 10:22:09 -0400
Received: from mail-ot0-f170.google.com ([74.125.82.170]:33909 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751356AbdCMOWH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 10:22:07 -0400
Received: by mail-ot0-f170.google.com with SMTP id o24so113172453otb.1
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 07:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ibsX/IXfUWs8VoFhHzAyCc0HK9FcJ55QopmSdbB5vhQ=;
        b=BQIz+OSl+hY2T+IZvsV1kvg+cszJFRb/buauzde6BPD9wDTorvemjQA+/Ah2bHVxfk
         B4L8wlLsfdo4h4cfk6km3wUanv+hujFe6rjjQvt9ia1YH3n7NVUv1EOi4TiA/MPGMu8h
         HJoJNO6tA1ugEPv0MTraVGd5a/HMCI2SVfPrES/vM15SYWRtDdQDAvJxlLY6iIY+Av8N
         GxMPRzQ61Cv0OT8rGHOi6nMYAX4J2WWhZVwa1kbPLBjXqYElW5iVPqIef1pOwgybzPBA
         nwObFu7G0SQeLtfQnGVNpws8fyx7wxeerYA82byzySvvTvUvITWHp4YebzMv1Mz21uT4
         OiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ibsX/IXfUWs8VoFhHzAyCc0HK9FcJ55QopmSdbB5vhQ=;
        b=cyEKEdaXvQ7d6n1boQZJ43w6amND0eaKG9hXMq5MFP5ErtojujU5mU8sZpyBSJXOzS
         vmR++2/x4L6W99Dz0csApAPjIAT+7vFi9tfap/v/OFd4VMl3Oym4CiPjeX+XFLetj2cg
         UhwWWFFqCJX5FznK2CCBmElnXl2sVBCD/K9Uo9qO9pxDJ0jIKYD9kV0xJk30qEYhgpLs
         A1DCqvJd3NLklEjshHWfjpZvFdchtyAUG69M4E9iZ9dTAdeuJLlzEJw5EVaK5wk1YlqE
         mOSI5Fnd4IGHkak1hUjbOKauYsiIsKI4kUy+35ENA9ts28Yc1stkrT53hs7cFHO40zHA
         vLBA==
X-Gm-Message-State: AFeK/H3yrKn6Zz8W72hlaKrB4lLj5iuax40brWxM2V0sB6O6g7gFMFGIyKVnAzIDf9nqqzzdl6criUUbboog/g==
X-Received: by 10.157.89.143 with SMTP id u15mr16996461oth.176.1489414926309;
 Mon, 13 Mar 2017 07:22:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.66.23 with HTTP; Mon, 13 Mar 2017 07:22:05 -0700 (PDT)
From:   Christian Jaeger <chrjae@gmail.com>
Date:   Mon, 13 Mar 2017 14:22:05 +0000
Message-ID: <CAEjYwfWP50JGd7HmP4hVq=Fob3nV0xqc9AuJ0wHreq4HTeSsWw@mail.gmail.com>
Subject: [ANNOUNCE] git-sign, simple scripts to generate and verify securely
 signed Git checkouts
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

Mostly as a proof of concept, I've created two scripts to sign and
verify Git checkouts (I'm saying checkouts since it (both for
simplicity, and probably trust) is based on the working directory
contents, not the tree referred to by the signed commit). Like some
other such solutions, this adds secure hashes to the signed tag
message. There are two drawbacks and one advantage versus other
solutions:

- meant for small repositories only (each file in the repository takes
up a line in the tag message)
- relatively hacky, e.g. newlines in file names may be problematic,
doesn't currently use gpg's --status-fd or --with-colons, and doesn't
check git config
+ easily verifiable scripts, checking can even be done manually (hence
no need for casual users to (blindly) trust third party code)

https://github.com/pflanze/git-sign

Christian.
