Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD962C433E2
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 00:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 905B520707
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 00:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgIBAhu convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 1 Sep 2020 20:37:50 -0400
Received: from outgoing-exchange-3.mit.edu ([18.9.28.13]:37440 "EHLO
        outgoing-exchange-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726167AbgIBAhs (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 Sep 2020 20:37:48 -0400
X-Greylist: delayed 615 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Sep 2020 20:37:47 EDT
Received: from oc11exedge2.exchange.mit.edu (OC11EXEDGE2.EXCHANGE.MIT.EDU [18.9.3.18])
        by outgoing-exchange-3.mit.edu (8.14.7/8.12.4) with ESMTP id 0820RTP0017908
        for <git@vger.kernel.org>; Tue, 1 Sep 2020 20:27:30 -0400
Received: from oc11expo12.exchange.mit.edu (18.9.4.17) by
 oc11exedge2.exchange.mit.edu (18.9.3.18) with Microsoft SMTP Server (TLS) id
 15.0.1293.2; Tue, 1 Sep 2020 20:27:19 -0400
Received: from oc11expo12.exchange.mit.edu (18.9.4.17) by
 oc11expo12.exchange.mit.edu (18.9.4.17) with Microsoft SMTP Server (TLS) id
 15.0.1365.1; Tue, 1 Sep 2020 20:27:30 -0400
Received: from oc11expo12.exchange.mit.edu ([18.9.4.17]) by
 oc11expo12.exchange.mit.edu ([18.9.4.17]) with mapi id 15.00.1365.000; Tue, 1
 Sep 2020 20:27:30 -0400
From:   Anish R Athalye <aathalye@mit.edu>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Bug report: git cat-file -e / rev-list disagree with git fsck on
 empty tree
Thread-Topic: Bug report: git cat-file -e / rev-list disagree with git fsck on
 empty tree
Thread-Index: AQHWgL/XxGAauMcqHUOGucHqPrmTZg==
Date:   Wed, 2 Sep 2020 00:27:30 +0000
Message-ID: <1006A7F3-8C48-46E3-8F7C-3F82181E3619@mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [173.76.136.164]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <01A7F8C67EC42941BA07C6FA1A2A85E4@exchange.mit.edu>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is related to the change made in f06ab027efd2 (rev-list: allow cached
objects in existence check).

That patch seemed designed to allow the workflow where the empty tree is
missing from the object store, so
`git cat-file -e 4b825dc642cb6eb9a060e54bf8d69288fbee4904` and
`git rev-list --objects 4b825dc642cb6eb9a060e54bf8d69288fbee4904`
both return success even when the object is not physically present.

However, in the same situation:

    $ git fsck
    [...]
    missing tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904

I'm not sure if this is the intended behavior (the tree is indeed missing, so
in some sense, this is reasonable). But it seems somewhat confusing that it
disagrees with the interrogation commands.
