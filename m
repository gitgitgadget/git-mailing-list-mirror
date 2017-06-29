Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7733A20281
	for <e@80x24.org>; Thu, 29 Jun 2017 18:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752992AbdF2Ssj (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 14:48:39 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:36688 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752584AbdF2Ssh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 14:48:37 -0400
Received: by mail-pg0-f43.google.com with SMTP id u62so51975470pgb.3
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 11:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=5MFIFhQptZhcio/8Mj0nFhqfYPc7fzxV43G/dhftcSs=;
        b=nV7YFAoMAqb33xAh+52sfDHSJF8jp3Ynxf3UEK2FdzzR4MD1Ezb/QwlmwXlWWcfQcy
         RjwPuju2uOH0Z9zLhPmgwDZH1zlOq2FAag8rXSxRj5zZa/PDRjDvFP9VPa6Jls3+Mrcu
         YhOpMyyqWZFv2OLq6zcV1/twvvSMBaNCjDd8DPYaGVliPwN9SdkerqU8LGaWsi6PNPZJ
         RbkkXsdl4JIGvZ+WHwxBluon/zm5qjcdjXH76XCav9NYNuiDBObjuCYGiQqAzaDUE0fS
         N4Xkw04voXWdSvp20R3DJV9aulPSw7kjvgCxto3NXiQxli+oeh3EVydkSN5wxbh7r0hA
         zeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=5MFIFhQptZhcio/8Mj0nFhqfYPc7fzxV43G/dhftcSs=;
        b=mnerSCS+HQszzB8ckVOE9ZDVAHx0u54Jlje5fvTXRcKxeGl9op7iXGOJkn1NSTOwOf
         0AhGbvII+JuEFPGwJ2MtiThA8w+PBAHUQ1RkLVtJZ1P8YXc+l/4Gu2s4tVUeRRwJu6VV
         yf7rHWs5ZQ1oUsexpFRqUZ/8lk1HEdnhefsTg5u4gdr7/GrItKzXZv+VuMz9a2q0x9/Y
         1adD8tpB9Dvg+fN1+DP8NOTSng25iepYwU9pcgc6pR1AXKldOGr6bJhXH7woW5WmL6qu
         ztfCM/B8J0+DnaHSjk/0R9PJgQQD7EpiHEkDDsn7+LY+yK9JqW1aRZnMIiDPQBFQ3TiS
         fmuw==
X-Gm-Message-State: AKS2vOzctxccpKIngX0HkGZof7SWwPfMP21kbk2i8quwtVbdE/eikvTG
        i2lVo7ff2RMkW91GpxllKQ==
X-Received: by 10.99.161.25 with SMTP id b25mr17032576pgf.26.1498762116637;
        Thu, 29 Jun 2017 11:48:36 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:9c45:a1b1:af2b:48b0])
        by smtp.gmail.com with ESMTPSA id c19sm13257407pfj.15.2017.06.29.11.48.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 29 Jun 2017 11:48:36 -0700 (PDT)
Date:   Thu, 29 Jun 2017 11:48:30 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>
Subject: RFC: Missing blob hook might be invoked infinitely recursively
Message-ID: <20170629114830.39dc2161@twelve2.svl.corp.google.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As some of you may know, I'm currently working on support for partial
clones/fetches in Git (where blobs above a user-specified size threshold
are not downloaded - only their names and sizes are downloaded). To do
this, the client repository needs to be able to download blobs at will
whenever it needs a missing one (for example, upon checkout).

So I have done this by adding support for a hook in Git [1], and
updating the object-reading code in Git to, by default, automatically
invoke this hook whenever necessary. (This means that existing
subsystems will all work by default, in theory at least.) My current
design is for the hook to have maximum flexibility - when invoked with a
list of SHA-1s, it must merely ensure that those objects are in the
local repo, whether packed or loose.

I am also working on a command (fetch-blob) to be bundled with Git to be
used as a default hook, and here is where the problem lies.

Suppose you have missing blob AB12 and CD34 that you now need, so
fetch-blob is invoked. It sends the literals AB12 and CD34 to a new
server endpoint and obtains a packfile, which it then pipes through "git
index-pack". The issue is that "git index-pack" wants to try to access
AB12 and CD34 in the local repo in order to do a SHA-1 collision check,
and therefore fetch-blob is invoked once again, creating infinite
recursion.

This is straightforwardly fixed by making "git index-pack" understand
about missing blobs, but this might be a symptom of this approach being
error-prone (custom hooks that invoke any Git command must be extra
careful).

So I have thought of a few solutions, each with its pros and cons:

1. Require the hook to instead output a packfile to stdout. This means
that that hook no longer needs to access the local repo, and thus has
less dependence on Git commands. But this reduces the flexibility in
that its output must be packed, not loose. (This is fine for the use
cases I'm thinking of, but probably not so for others.)

2. Add support for an environment variable to Git that suppresses access
to the missing blob manifest, in effect, suppressing invocation of the
hook. This allows anyone (the person configuring Git or the hook writer)
to suppress this access, although they might need in-depth knowledge to
know whether the hook is meant to be run with such access suppressed or
required.

3. Like the above, except for a command-line argument to Git.

What do you think? Any solutions that I am missing?

[1] Work in progress, but you can see an earlier version here: https://public-inbox.org/git/b917a463f0ad4ce0ab115203b3f24894961a2e75.1497558851.git.jonathantanmy@google.com/
