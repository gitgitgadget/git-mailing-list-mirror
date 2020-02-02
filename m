Return-Path: <SRS0=xuSa=3W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BED0C3524A
	for <git@archiver.kernel.org>; Sun,  2 Feb 2020 12:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696FB206E6
	for <git@archiver.kernel.org>; Sun,  2 Feb 2020 12:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=devup.no header.i=@devup.no header.b="gh1aN3P+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgBBMAO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Feb 2020 07:00:14 -0500
Received: from out.migadu.com ([91.121.223.63]:60560 "EHLO out.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgBBMAN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Feb 2020 07:00:13 -0500
X-Greylist: delayed 452 seconds by postgrey-1.27 at vger.kernel.org; Sun, 02 Feb 2020 07:00:13 EST
Received: (Migadu outbound); Sun, 02 Feb 2020 11:52:39 +0000
Authentication-Results: out.migadu.com; auth=pass (plain)
Received: from localhost (ti0006q161-3035.bb.online.no [84.202.69.253])
        by out.migadu.com (Haraka/2.8.16) with ESMTPSA id 4A319F14-C2E8-4158-BCA8-3DDD84F8C7E1.1
        envelope-from <marius@devup.no> (authenticated bits=0)
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 verify=FAIL);
        Sun, 02 Feb 2020 11:52:35 +0000
From:   Marius Bakke <marius@devup.no>
To:     git@vger.kernel.org
Subject: RFC: Merge hints
Date:   Sun, 02 Feb 2020 12:52:24 +0100
Message-ID: <87pnexmcjr.fsf@devup.no>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1;a=rsa-sha256;bh=xQyCEEqZob/09JwXRi7QfjaexOeDcvifW1I8HZU1K6U=;c=relaxed/simple;d=devup.no;h=from:subject:date:to;s=default;b=gh1aN3P+ouyyGeT5/VvCAZFqKK6svSzMFiAfWgWGUBfbJr0IhnTLI2J+6P1ugk4W758BzuToBTGdkSLYaZwYCn+PY+ryFxbJ2jBoUBtGN7IaAkzLR7Kp9U/IiBh9TLSTk9MNl/KMwmbzh7lLGavO6biEckvVoAGeLN4qv/vXSD4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

It would be convenient if git had a facility for adding "merge hints",
both for automatic conflict resolution, as well as giving clues to
persons inheriting or merging a branch.

The main use case here is aiding long-running branches.  Imagine a
feature branch where all uses of FOO_STR is replaced with STR.  For
various reasons this branch cannot be merged to master, yet it needs to
be kept up to date, and new uses of FOO_STR keeps getting added.

If you are lucky, your compiler will complain that FOO_STR is undefined
when running whatever tests you have after a merge.  But perhaps the new
code is for a different platform and not reached during a test run.  A
diligent developer might also run 'git grep FOO_STR' *if* they know
about the change.  Fixing these trivial problems is boring and manual.

A more tricky case is where...

  def foo(a,b)

has become

  def foo(a,b,c)

...and c is a required positional argument.  Any new uses of 'foo' will
need to be adjusted during a merge.  This function can be multi line and
not easily greppable.

The diligent developer is in no shortage of tools: "git log -G foo
..master" will reveal any potential problems, even before the merge.
Yet, they still have to 1) know about the change; and 2) fix up the uses
manually.

It seems to me that git could offer better tools to deal with this.
Perhaps a ".mergehints", where you could provide a regular expression
either for automatic merge resolution, or just have git complain loudly
when a given pattern is merged (say, introduce conflict markers even
though there were no "real" conflicts).  I.e.:

[hint1]
files = *.c
pattern = FOO_STR
transform = s/FOO_STR/STR

[hint2]
files = *.py
pattern = 'foo('
conflict = true

Thoughts?  Are there other tools at the diligent developers disposal
that can aid with these kinds of problems?
