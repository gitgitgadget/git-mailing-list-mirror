Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D23C433EF
	for <git@archiver.kernel.org>; Sun, 26 Jun 2022 00:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbiFZAJz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jun 2022 20:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiFZAJy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Jun 2022 20:09:54 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E097913E9E
        for <git@vger.kernel.org>; Sat, 25 Jun 2022 17:09:53 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:40322)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o5Fqa-009DWA-Ip; Sat, 25 Jun 2022 18:09:52 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:57614 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o5FqZ-00AXYY-KA; Sat, 25 Jun 2022 18:09:52 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stephen Smith <ischis2@cox.net>, git <git@vger.kernel.org>
References: <12011256.O9o76ZdvQC@thunderbird>
        <220621.86sfnyuvt0.gmgdl@evledraar.gmail.com>
        <YrI9dvfoc5NYgVDq@tapette.crustytoothpaste.net>
        <YrWXdNGZGN7gXL40@coredump.intra.peff.net>
        <YrbNIUnftj+Ooumo@tapette.crustytoothpaste.net>
Date:   Sat, 25 Jun 2022 19:09:45 -0500
In-Reply-To: <YrbNIUnftj+Ooumo@tapette.crustytoothpaste.net> (brian
        m. carlson's message of "Sat, 25 Jun 2022 08:53:53 +0000")
Message-ID: <87czewxp2u.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1o5FqZ-00AXYY-KA;;;mid=<87czewxp2u.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18t20/hJznirrHNxz4F+FjJ8fZZMQQlRJA=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Plan for SHA-256 repos to support SHA-1?
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Is there at this point a solid plan for how SHA-256 repos will support
access SHA-1 only clients?

I remember reading a discussion of having a table somewhere that would
translate SHA-256 to SHA-1 when needed.

I had a brainstorm which is probably the uniformed opinion of an
outsider.

I was thinking in server settings that a well-packed pack of all of the
objects is kept to make it quick for git clone to do it's work.

I was thinking perhaps in a repo that wanted to support access from
SHA-1 clients it might makes sense to have three packs instead of the
standard 1.

A pack of all of the blobs with no oid references.  So that either
a SHA-256 or a SHA-1 client could consume it (modulo header changes that
are needed).

The pack of blobs could have both an ordinary SHA-256 index and a SHA-1
index.

Then there could be two packs of metadata (aka trees and commits and
tags that embed oids).  One pack in SHA-256 and one pack in SHA-1.

Then with a little header surgery git clone could be served with
sendfile and gluing the pack of blobs and pack of object together.


In the normal end user client case that is doesn't seem to make a lot of
sense as all that is needed is to figure out which oid to use and always
display SHA-256.

My naivete suggests that just keeping the SHA-1 metadata in a SHA-256
repo could be simple enough to implement that it would allow the
transition to start happening, and it could be optimized away later.

Eric
