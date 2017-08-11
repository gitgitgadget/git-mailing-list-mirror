Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_HK_NAME_DR
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BAD4208B8
	for <e@80x24.org>; Fri, 11 Aug 2017 07:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752538AbdHKHJ7 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 11 Aug 2017 03:09:59 -0400
Received: from mail.absint.com ([212.88.138.67]:44102 "EHLO mail.absint.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752526AbdHKHJ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 03:09:58 -0400
X-Greylist: delayed 310 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Aug 2017 03:09:58 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.absint.com (Postfix) with ESMTP id AE80E601E23D6
        for <git@vger.kernel.org>; Fri, 11 Aug 2017 09:04:46 +0200 (CEST)
Received: from mail.absint.com ([127.0.0.1])
        by localhost (mail.absint.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 8wd3A3KzejMe for <git@vger.kernel.org>;
        Fri, 11 Aug 2017 09:04:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.absint.com (Postfix) with ESMTP id 174D760CCE59D
        for <git@vger.kernel.org>; Fri, 11 Aug 2017 09:04:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at absint.com
Received: from mail.absint.com ([127.0.0.1])
        by localhost (mail.absint.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zucebc2PFJ6X for <git@vger.kernel.org>;
        Fri, 11 Aug 2017 09:04:46 +0200 (CEST)
Received: from mail.absint.com (lipwig.absint.com [192.168.8.152])
        by mail.absint.com (Postfix) with ESMTP id DE905601E23D6
        for <git@vger.kernel.org>; Fri, 11 Aug 2017 09:04:45 +0200 (CEST)
Date:   Fri, 11 Aug 2017 09:04:45 +0200 (CEST)
From:   "Dr.-Ing. Christoph Cullmann" <cullmann@absint.com>
To:     git@vger.kernel.org
Message-ID: <1232852793.287524.1502435085656.JavaMail.zimbra@absint.com>
Subject: Bug with corruption on clone/fsck/... with large packs + 64-bit
 Windows, problem with usage of "long" datatype for sizes/offsets?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [192.168.8.158]
X-Mailer: Zimbra 8.7.0_GA_1659 (ZimbraWebClient - GC59 (Linux)/8.7.0_GA_1659)
Thread-Index: K+kpkc6g5MRGQVp6/ia7/9/hD8DuIw==
Thread-Topic: Bug with corruption on clone/fsck/... with large packs + 64-bit Windows, problem with usage of "long" datatype for sizes/offsets?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

on Windows 64-bit, for a repository having a .pack file > 4GB I get during cloning:

$ git clone file:///repositories/test.git test
Cloning into 'test'...
remote: Counting objects: 210294, done.
remote: error: bad object header
remote: error: bad object header
remote: fatal: packed object cae50116ebe36de8bded4811bd262d90670bde2f (stored in ./objects/pack/pack-30ba8b19b029cc6554853ae07729aa807995ebb8.pack) is corrupt
error: git upload-pack: git-pack-objects died with error.
fatal: git upload-pack: aborting due to possible repository remote: aborting due to possible repository corruption on the remote side.
corruption on the remote side.
fatal: early EOF
fatal: index-pack failed

We use git 2.14.1, the 64-bit version.

On systems which have (long int) == 64-bit datatype, all works well, e.g. Linux 64-bit.
(same goes for fscks/...., they work on this git on Linux 64-bit, not on Windows 64-bit)

It seems the Windows port did take care of using the right 64-bit offsets and all
in the OS specific parts, but things like pack-objects.c in the generic parts use "unsigned long"
like it behaves like size_t (at least on the first glance).

As I think the issue is in the generic part, I report this here, not on the Windows list,
thought it seems to be an IL32P64 related issue.

Greetings
Christoph

-- 
----------------------------- Dr.-Ing. Christoph Cullmann ---------
AbsInt Angewandte Informatik GmbH      Email: cullmann@AbsInt.com
Science Park 1                         Tel:   +49-681-38360-22
66123 Saarbrücken                      Fax:   +49-681-38360-20
GERMANY                                WWW:   http://www.AbsInt.com
--------------------------------------------------------------------
Geschäftsführung: Dr.-Ing. Christian Ferdinand
Eingetragen im Handelsregister des Amtsgerichts Saarbrücken, HRB 11234
