Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C04711F404
	for <e@80x24.org>; Wed, 21 Feb 2018 13:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935292AbeBUNrv (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 08:47:51 -0500
Received: from homie.mail.dreamhost.com ([208.97.132.208]:59721 "EHLO
        homiemail-a37.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932772AbeBUNrt (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 21 Feb 2018 08:47:49 -0500
X-Greylist: delayed 86719 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Feb 2018 08:47:49 EST
Received: from homiemail-a37.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a37.g.dreamhost.com (Postfix) with ESMTP id C14B620806E
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 05:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
        message-id:subject:from:to:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=
        mattmccutchen.net; bh=qyDX3igq0m+p1pk0/MUGfqtUVd8=; b=sgM4SyUh6J
        1UVtw+i1eSZsq7Fi75GYyKkiBC14hPblv+Pe4D1gKBPZey5T1is5f/afWMJ97gCK
        5b3lVmXUXa8mL0PR6tJnyigkVQICxRuX09FIEaP8kwhdXU4KfBXK8IQ1jNiOR3Wa
        EIgCUMxDLVHWkn11X2sRaC17I61wVOpko=
Received: from main (c-73-149-22-67.hsd1.ma.comcast.net [73.149.22.67])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: matt@mattmccutchen.net)
        by homiemail-a37.g.dreamhost.com (Postfix) with ESMTPSA id 5E75220806C
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 05:47:48 -0800 (PST)
Message-ID: <1519220864.3059.14.camel@mattmccutchen.net>
Subject: Re: Duplicate safecrlf warning for racily clean index entry
From:   Matt McCutchen <matt@mattmccutchen.net>
To:     git <git@vger.kernel.org>
Date:   Wed, 21 Feb 2018 08:47:44 -0500
In-Reply-To: <1519134146.6055.23.camel@mattmccutchen.net>
References: <1519134146.6055.23.camel@mattmccutchen.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2018-02-20 at 08:42 -0500, Matt McCutchen wrote:
> In either case, if "git update-index --refresh" (or "git status") is
> run before "git add", then "git add" does not print the warning.  On
> the other hand, if line endings in the working tree file are changed,
> then git shows the file as having an unstaged change, even though the
> content that would be added to the index after CRLF conversion is
> identical.  So it seems that git remembers the pre-conversion file
> content and uses it for "git update-index --refresh" and would just
> need to use it for "git add" as well.

On further testing, this analysis is wrong.  What I was seeing is that
if the size of the working tree file has changed, git reports an
unstaged change.  (I suppose that reporting an unstaged change in this
case without checking whether the post-conversion content has changed
may be an important optimization.)  If the line endings are changed
without changing the size or post-conversion content, then no unstaged
change is reported.  It does not appear that git saves the pre-
conversion content.

Thus, if it were possible to create a file that doesn't need a safecrlf
warning, add it to the index, and then modify it so that it does need a
safecrlf warning without changing the size or post-conversion content,
we would have a bug where no warning is shown in the case where "git
status" is run before the second "git add".  I believe this bug can't
occur in the particular case of CRLF conversion without other filters
because the file that doesn't need a safecrlf warning has a unique
minimum (LF) or maximum (CRLF) size, though I presume it could occur
with custom filters.  My proposal would then be that "git add" should
not show a safecrlf warning if the size and post-conversion content
haven't changed; it would merely bring "git add" to parity with the
potential bug in the "git status" case.

Matt
