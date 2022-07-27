Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5952C04A68
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 20:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbiG0UVu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 16:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiG0UVs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 16:21:48 -0400
Received: from mail.pkts.ca (172.103.241.96.cable.tpia.cipherkey.com [172.103.241.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF825F999
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 13:21:45 -0700 (PDT)
Received: from Roundcube.pkts.ca (localhost [127.0.0.1])
        (authenticated bits=0)
        by mail.pkts.ca (8.15.2/8.15.2) with ESMTPSA id 26RKLhG9013755
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jul 2022 13:21:44 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.pkts.ca 26RKLhG9013755
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ch.pkts.ca;
        s=default; t=1658953304;
        bh=Mr1rjT1taySkKi1Pg0TEAUPWnB5isawBQWb2ZNPgStw=;
        h=Date:From:To:Subject:From;
        b=W0AZovfXIJkrYja+OAg4AFYxKj2DhuFHbOc4KT90TQmQVrBK0+UiS7I/YwMXnv0/Q
         xiSNWBvcGZyzq5fVgCkp2Rksxxpi49iqN6ejVPa5RXLoowiCrtu5tqfKZ6oAc+oTci
         NkFh+2bIEmJM4+gMqYg6ZSj4kHgtWpHkDPGhQR+I=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 27 Jul 2022 13:21:43 -0700
From:   CH <ch-and-git.vger.kernel.org@ch.pkts.ca>
To:     git@vger.kernel.org
Subject: Feature request: better error messages when UTF-8 bites
Message-ID: <f5a49da29fd0e5577083f1006d394158@ch.pkts.ca>
X-Sender: ch-and-git.vger.kernel.org@ch.pkts.ca
User-Agent: Roundcube Webmail/1.3.10
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi;

Just found an annoyance in `git log` (and likely elsewhere) that may 
warrant a change:

Somehow when copying and pasting a commit from a website to the command 
line, a UTF-8 Byte Order Mark (BOM) 
[https://en.wikipedia.org/wiki/Byte_order_mark] was appended to one of 
the commit ids.  BOMs are invisible, as are many other UTF-8 code 
points.  The upshot was that Git didn't like it, and complained 
bitterly:

> $ strace -etrace=execve -s 200 git diff 
> 038179704f0066aa815d5429221cf381ff4ef289  
> 47346a462d8ba40b9a8b073e351c362522c46aa6
> 
> execve("/usr/bin/git", ["git", "diff", 
> "038179704f0066aa815d5429221cf381ff4ef289\357\273\277", 
> "47346a462d8ba40b9a8b073e351c362522c46aa6"], 0x7fffec3c4bb0 /* 80 vars 
> */) = 0
> 
> fatal: ambiguous argument '038179704f0066aa815d5429221cf381ff4ef289': 
> unknown revision or path not in the working tree.
> Use '--' to separate paths from revisions, like this:
> 'git <command> [<revision>...] -- [<file>...]'
> +++ exited with 128 +++

Feature request:
================

When printing the "fatal: ambiguous argument '......': ....", perhaps 
escape (url or otherwise) the ambiguous argument when printing it in the 
error message, or maybe add a sentence about non-ASCII characters being 
found.

This is sort of a difficult corner-case, in that it is perfectly legal 
to have UTF-8 characters in a branch or tag name (see 
git-check-ref-format for the allowed characters), so someone could 
indeed create a branch named 
"038179704f0066aa815d5429221cf381ff4ef289\357\273\277" if they were a 
tortured soul bent on overthrowing polite society.  Rejecting input 
because it has bytes with values above \177 is therefore not a solution.

Similarly, scanning the input for invisible UTF-8 characters (or even 
invalid UTF-8 sequences) is leaning too far the other way: git should 
not be validating character encodings.  It should stay encoding-neutral, 
as the alternative leads to madness, driving developers into becoming 
tortured souls bent on rigidly enforcing polite society.  We have enough 
of those already.

It's unclear as to whether violent overthrow or rigid enforcement is the 
lesser of two evils, but let's not perform the experiment to find out.  
:-)

Cheers!

-- 
CH (ch-and-git.vger.kernel.org@ch.pkts.ca)
