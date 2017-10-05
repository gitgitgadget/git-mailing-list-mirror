Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FF4D2036D
	for <e@80x24.org>; Thu,  5 Oct 2017 09:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751450AbdJEJPS (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 05:15:18 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:33492 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751278AbdJEJPR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 05:15:17 -0400
Received: from [172.27.0.114] (unknown [92.154.11.170])
        (Authenticated sender: slash.tmp)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id 232D45FF20;
        Thu,  5 Oct 2017 11:15:09 +0200 (CEST)
To:     git <git@vger.kernel.org>
From:   Mason <slash.tmp@free.fr>
Subject: Quoted-printable support in git am
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Message-ID: <165c9648-e7f0-66de-b3b9-023c48c49d95@free.fr>
Date:   Thu, 5 Oct 2017 11:15:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone,

Recently, the SMTP server we use at work started mangling outgoing
messages, by converting them to quoted-printable, whatever their
original encoding (even 7-bit clean, pure ASCII).

This breaks patches I send to Linux mailing lists, because it changes
TAB to =09, EQUAL to =3D, TRAILING SPACE to =20 and also wraps long
lines using a "=" continuation.

It looks like 'git am' doesn't support decoding this mess.
(I tried git version 2.14.2)

$ git am ~/rc.patch
Applying: media: rc: Add driver for tango IR decoder
error: patch failed: drivers/media/rc/Kconfig:469
error: drivers/media/rc/Kconfig: patch does not apply
error: patch failed: drivers/media/rc/Makefile:44
error: drivers/media/rc/Makefile: patch does not apply
Patch failed at 0001 media: rc: Add driver for tango IR decoder
The copy of the patch that failed is found in: .git/rebase-apply/patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

Is there a magic option I should be passing to git am?


The patch header contains:

Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


The drivers/media/rc/Kconfig:469 part is

--- a/drivers/media/rc/Kconfig
+++ b/drivers/media/rc/Kconfig
@@ -469,6 +469,11 @@ config IR_SIR
  =09   To compile this driver as a module, choose M here: the module will
  =09   be called sir-ir.
 =20
+config IR_TANGO
+=09tristate "Sigma Designs SMP86xx IR decoder"
+=09depends on RC_CORE
+=09depends on ARCH_TANGO || COMPILE_TEST
+
  config IR_ZX
  =09tristate "ZTE ZX IR remote control"
  =09depends on RC_CORE


Googling a bit...
https://stackoverflow.com/questions/6289001/git-am-format-patch-control-format-of-line-endings
https://public-inbox.org/git/24940e12-3f72-1ef0-0983-58523d8dec51@redhat.com/t/

Looks like it should work...

Maybe I hit some weird corner case?

Regards.
