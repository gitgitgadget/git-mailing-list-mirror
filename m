Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643A5C33CA9
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 05:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27804207FF
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 05:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=twitter.com header.i=@twitter.com header.b="S9FqdMsK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgANFdb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 00:33:31 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:41745 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgANFdb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 00:33:31 -0500
Received: by mail-ot1-f47.google.com with SMTP id r27so11450071otc.8
        for <git@vger.kernel.org>; Mon, 13 Jan 2020 21:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twitter.com; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=UYwt7oknz3QQmY7FlDhYg2PomLWGE84iuuvL7cOMHRg=;
        b=S9FqdMsKbmysJ47ugovENktBv0VL2YSN2jtYr11iEbTXUjClXRPk3nzBtyErvMjM8Y
         sSWVHDVAinU6qsnsZ7w4aWJXzvi2XGU6s98bjLT6zq37gbSi6s1VTW2nnT0OjLUSlc/8
         ZLiyKVFbNRGi2NsthjjAbPWcDbUPXjEYwGR9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=UYwt7oknz3QQmY7FlDhYg2PomLWGE84iuuvL7cOMHRg=;
        b=J+ZzCGtbK9wcUJn1IxhxSFn8GfzzX1xqS4doRDpgHuk5NHW7cyogRk/ozCGNd78EJd
         FSCQr3BaoWYeAa+zy7sf1AcnrUny1+ipr6MfCumYUlyzpte5sBMTcKgIuDEnte7AwKI9
         ZPnxcPFb969bggbdjoHljNKOgE56OxVXUR2YpF1E55K03TZoKjT9Id2ylAX3PgLZ7Tj0
         JE6D62Fi1zeyKYc6B4tIUNHQJKvGpjg4TVPclPBwlcco4jhhUqtDa0nvWeiNMFT0DhFg
         xhjd74w9DEJEzrHbIVbN91TlqxYk2U/t/p/WuM2vtudF9LSgoxdE0kSr4FCZL2VUrvPp
         ahRw==
X-Gm-Message-State: APjAAAXv34AFBCLOwYPtcQaflW1CDgSVQIdabYVDve0bcUKZJ5ppV/9k
        r/C7fWTqbi5dNqp+BQOcSIKucKWYrlQAT8pJp5MTMOXUsg==
X-Google-Smtp-Source: APXvYqxHj+bNx7Foir9R3Pdk2CFj76aeSZFb3YbPImajNdiGxPb1wpHtWMnfik1ruPS3Df8rLXLHg44YQ4fygFeSHsk=
X-Received: by 2002:a9d:4692:: with SMTP id z18mr15328021ote.163.1578980010236;
 Mon, 13 Jan 2020 21:33:30 -0800 (PST)
MIME-Version: 1.0
From:   Kaushik Srenevasan <kaushik@twitter.com>
Date:   Mon, 13 Jan 2020 21:33:19 -0800
Message-ID: <CAN_uzpK1m42J19Xi8oc3Dwmhk9qF1n4hFrBVqD+0RHZuZ_15Jw@mail.gmail.com>
Subject: [RFC] Extending git-replace
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We=E2=80=99ve been trying to get rid of objects larger than a certain size
from one of our repositories that contains tens of thousands of
branches and hundreds of thousands of commits. While we=E2=80=99re able to
accomplish this using BFG[0] , it results in ~ 90% of the repository=E2=80=
=99s
history being rewritten. This presents the following problems
1. There are various systems (Phabricator for one) that use the commit
hash as a key in various databases. Rewriting history will require
that we update all of these systems.
2. We=E2=80=99ll have to force everyone to reclone a copy of this repositor=
y.

I was looking through the git code base to see if there is a way
around it when I chanced upon `git-replace`. While the basic idea of
`git-replace` is what I am looking for, it doesn=E2=80=99t quite fit the bi=
ll
due to the `--no-replace-objects` switch, the `GIT_NO_REPLACE_OBJECTS`
environment variable, and `--no-replace-objects` being the default for
certain git commands. Namely fsck, upload-pack, pack/unpack-objects,
prune and index-pack. That Git may still try to load a replaced object
when a git command is run with the `--no-replace-objects` option
prevents me from removing it from the ODB permanently. Not being able
to run prune and fsck on a repository where we=E2=80=99ve deleted the objec=
t
that=E2=80=99s been replaced with git-replace effectively rules this option
out for us.

A feature that allowed such permanent replacement (say a
`git-blacklist` or a `git-replace --blacklist`) might work as follows:
1. Blacklisted objects are stored as references under a new namespace
-- `refs/blacklist`.
2. The object loader unconditionally translates a blacklisted OID into
the OID it=E2=80=99s been replaced with.
3. The `+refs/blacklist/*:refs/blacklist/*` refspec is implicitly
always a part of fetch and push transactions.

This essentially turns the blacklist references namespace into an
additional piece of metadata that gets transmitted to a client when a
repository is cloned and is kept updated automatically.

I=E2=80=99ve been playing around with a prototype I wrote and haven=E2=80=
=99t observed
any breakage yet. I=E2=80=99m writing to seek advice on this approach and t=
o
understand if this is something (if not in its current form, some
version of it) that has a chance of making it into the product if we
were to implement it. Happy to write up a more detailed design and
share my prototype as a starting point for discussion.

                                           -- Kaushik

[0] https://rtyley.github.io/bfg-repo-cleaner/
