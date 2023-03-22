Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BAFC77B61
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 17:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjCVRYL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 13:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjCVRXy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 13:23:54 -0400
Received: from a8-80.smtp-out.amazonses.com (a8-80.smtp-out.amazonses.com [54.240.8.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35FC168A9
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 10:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=l2757w2o7iq54ibo32ir6iyygq36w7v5; d=neosmart.net; t=1679505474;
        h=Content-Type:From:To:Subject:Message-ID:Date:Content-Transfer-Encoding:MIME-Version;
        bh=QXCKfBG6IMZudIShId+4GgyamA5j1ZP2KW11vBeDJ/s=;
        b=SpNixxUeRYWan5gmZq6lP7enzxqk4rIZdMYjJ8a0NTxsUYrPUli95GXRU3MtiAxm
        1F/Lt5WeP4GRpL/Wd0mEQEcaTdpp5Cjk/KCqr058RsnsufX8b7B4YgdtOuTwKo/Z0IJ
        Pj/Bud7yxHVfyETlFVjRAH1LpHhwdGWtAGJ6I0/E=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1679505474;
        h=Content-Type:From:To:Subject:Message-ID:Date:Content-Transfer-Encoding:MIME-Version:Feedback-ID;
        bh=QXCKfBG6IMZudIShId+4GgyamA5j1ZP2KW11vBeDJ/s=;
        b=kGUkmCnmi8SVOlHOWma6Ut0dmWe9TbD2WjUoC+HwtbSZQ7LK6UcTMKP3j8kArYK/
        iFdowk7C1e7J2GyCJkvHCUyLZR2A0XdnNSeoitjCnAsvhdZwGtcAvUJv7djQF6SKDXr
        Mz+qdaBycmqCNmwtzujV6RfCvK2SP5jQUswvg+i4=
Content-Type: text/plain; charset=utf-8
From:   mqudsi@neosmart.net
To:     mqudsi@neosmart.net
Subject: Supporting automated removal of the UTF-8 BOM
Message-ID: <010001870a53c24c-52985ae7-dcb7-4422-96cd-ef88a01f138d-000000@email.amazonses.com>
Date:   Wed, 22 Mar 2023 17:17:54 +0000
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Feedback-ID: 1.us-east-1.nNbpVB4qVtOGdLGl74CK867J9o9iwXfc5N//KCr9kLQ=:AmazonSES
X-SES-Outgoing: 2023.03.22-54.240.8.80
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello team,

I am curious if you would be open to an effort to extend git with the
ability to actively manage the presence of a UTF-8 BOM in the index (and
working tree), probably via the .gitattributes interface. I'm aware that
the existing encoding mechanism is already BOM-aware can deduce from its
presence the charset of a file, but unfortunately it doesn't seem to be
possible to have git strip the BOM from *UTF-8* content (or particular
content) before storing it in the index without the use of precommit
hooks.

After giving it some thought and assuming that you would be open to the
idea in principle, I can see several different approaches or
possibilities.

One option would be to add a new charset named UTF-8-BOM for the express
purpose of allowing particular filetypes to always be stored BOM-free in
the index (as iconv does not itself recognize this as a separate
charset). This would be along the same vein in which support was added
for UTF-16XX-BOM such that content can be converted to (BOM-free) UTF-8
for storage in the index and then converted back to UTF-16XX-BOM when
checked out.

While it's true that most editors that emit UTF-8 files w/ a BOM will
still work with them if the BOM is removed (obviating the *need* to
convert back to UTF-8-BOM on checkout, unlike how editors expecting
UTF-16LE-BOM will fail if the file is checked out as UTF-8), this would
prevent users on other platforms from having to deal with the BOM when a
Windows user checks the file in, and would also prevent the needless
churn from carelessly committed diffs adding or removing the BOM.

An alternative option that wouldn't involve adding a new UTF-8-BOM
charset would be to make core git aware of the BOM and able to treat its
presence/absence as consequential or to be ignored in the same fashion
as how git currently has an option to transparently convert line endings
between lf and crlf at commit/checkout, but I was under the impression
that this is largely considered a dirty hack to handle a very common
problem and not something that the team would be eager to expand on by
adding a similar option for BOM markers.

One other option would be to add support for BOM removal only through
.gitattributes but not via an explicit charset conversion, i.e. by
adding a "bom" option like the "eol" option that could be specified for
particular file types, for example,

    *.csproj text=auto eol=crlf bom=[add|strip]

With bom=add, the file would be stored in the index without a BOM but it
would be added on checkout (as a parallel to how eol=crlf acts). With
bom=strip, the file would again be stored in the index without a BOM and
git would prevent addition of the BOM on checkout.

Curious about your thoughts on the matter. I've gone to great lengths to
purge the BOM from my machine and have managed to hack most of
Microsoft's tools to refrain from adding it but alas Visual Studio still
insists on inserting the BOM to machine-generated content (for the
reset, I use a VS extension to strip the BOM from regular code files
opened/saved through Visual Studio).

Thanks for the time,

Mahmoud
