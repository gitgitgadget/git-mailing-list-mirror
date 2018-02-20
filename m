Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A70A81F404
	for <e@80x24.org>; Tue, 20 Feb 2018 13:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751825AbeBTNmb (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 08:42:31 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:60249 "EHLO
        hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751738AbeBTNma (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 08:42:30 -0500
Received: from homiemail-a9.g.dreamhost.com (homie.mail.dreamhost.com [208.97.132.208])
        by hapkido.dreamhost.com (Postfix) with ESMTP id 669A78C5F5
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 05:42:30 -0800 (PST)
Received: from homiemail-a9.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a9.g.dreamhost.com (Postfix) with ESMTP id D945E5BE06F
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 05:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
        message-id:subject:from:to:date:content-type:mime-version:
        content-transfer-encoding; s=mattmccutchen.net; bh=exnA12fmuSpCd
        XGWfql0UO/uOPM=; b=P/GjQdalMq9gBsf6A5+8KTcjtv1PXkF+xGbI8mA1xgSKl
        Vn0BrNNuN4gMdohqWWKUP0gCYhLUSiMBadObWbc2pKgeW60SppypzCHCYh+9wqN+
        Wx6958TuWkJc8uVYYvJYczcSo4a7dQseXIqZ5t1jss4QFagcdBv51/wnvV7iWA=
Received: from main (c-73-149-22-67.hsd1.ma.comcast.net [73.149.22.67])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: matt@mattmccutchen.net)
        by homiemail-a9.g.dreamhost.com (Postfix) with ESMTPSA id 780895BE064
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 05:42:29 -0800 (PST)
Message-ID: <1519134146.6055.23.camel@mattmccutchen.net>
Subject: Duplicate safecrlf warning for racily clean index entry
From:   Matt McCutchen <matt@mattmccutchen.net>
To:     git <git@vger.kernel.org>
Date:   Tue, 20 Feb 2018 08:42:26 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I noticed that if a file subject to a safecrlf warning is added to the
index in the same second that it is created, resulting in a "racily
clean" index entry, then a subsequent "git add" command prints another
safecrlf warning.  I reproduced this on the current "next"
(499d7c4f91).  The procedure:

$ git init
$ git config core.autocrlf true
$ echo foo >file1 && git add file1 && git add file1
warning: LF will be replaced by CRLF in file1.
The file will have its original line endings in your working directory.
warning: LF will be replaced by CRLF in file1.
The file will have its original line endings in your working directory.
$ echo bar >file2 && sleep 1 && git add file2 && git add file2
warning: LF will be replaced by CRLF in file2.
The file will have its original line endings in your working directory.

This came up when I ran the test suite for Braid on Windows
(https://github.com/cristibalan/braid/issues/77).

The phenomenon actually seems to be more general: touching the file
causes the next "git add" to print a safecrlf warning, suggesting that
the warning occurs whenever the index entry is dirty.  One could argue
that a new warning is reasonable after touching the file, but it seems
clear that "racy cleanliness" is an implementation detail that
shouldn't have user-visible nondeterministic effects.

In either case, if "git update-index --refresh" (or "git status") is
run before "git add", then "git add" does not print the warning.  On
the other hand, if line endings in the working tree file are changed,
then git shows the file as having an unstaged change, even though the
content that would be added to the index after CRLF conversion is
identical.  So it seems that git remembers the pre-conversion file
content and uses it for "git update-index --refresh" and would just
need to use it for "git add" as well.

Thoughts about the proposed change?  Does someone want to work on it or
give me a pointer to where to get started?

Thanks,
Matt
