Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC7DC28CF5
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 13:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbiAZNJr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 08:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbiAZNJr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 08:09:47 -0500
X-Greylist: delayed 926 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Jan 2022 05:09:46 PST
Received: from mail.inka.de (mail.inka.de [IPv6:2a04:c9c7:0:1073:217:a4ff:fe3b:e77c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1368C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 05:09:46 -0800 (PST)
Received: from raven.inka.de (uucp@[127.0.0.1])
        by mail.inka.de with uucp (rmailwrap 0.5) 
        id 1nChoY-005KNv-5j; Wed, 26 Jan 2022 13:54:18 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
        id 803BF60339; Wed, 26 Jan 2022 13:52:09 +0100 (CET)
Date:   Wed, 26 Jan 2022 13:52:09 +0100
From:   Josef Wolf <jw@raven.inka.de>
To:     git@vger.kernel.org
Subject: clean/smudge-filter with "attached file"?
Message-ID: <20220126125209.GD16463@raven.inka.de>
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I have an application, which creates XML data files with attached
checksum (uuencoded sha1) files. For example, the application might
create

  a/b/c              # XML file
  a/b/c.chsum        # chsum of this file
  a/b/d/e            # another XML file
  a/b/d/e.chsum      # chsum of this file

It creates hundreds of those files, some with chsum-files attached
and some not. And some of those files are XML, other are binary or
simple text.

In addition, this application "shuffles" content of those XML files,
which results in a lot of clutter when those files are tracked by git.

Unfortunately, the application refuses to load those files when the
checksum file does not match its contents.

Those files seemed to be good candidates for git's clean/smudge-filter.

A clean-filter would bring the files into a canonical format (that is,
sorted and whitespace-normalized) when the file is to be committed.

A smudge-filter would be used to re-calculate the checksum-files on
checkout/update.

Unfortunately, the description of clean/smudge-filters states:

   Note that "%f" is the name of the path that is being worked on.
   Depending on the version that is being filtered, the corresponding
   file on disk may not exist, or may have different contents. So,
   smudge and clean commands should not try to access the file on disk, but
   only act as filters on the content provided to them on standard input.

Uh! That means that the content the filter emits on stdout does not
nececcerily match the content that is supposed to be in the file when the
git command finishes? Thus, simply calculate the checksum and store it in
associated checksum file might result in a checksum failure when the
application tries to load those files?

Am I missing something? Or am I completely off the road?

Any help?

-- 
Josef Wolf
jw@raven.inka.de
