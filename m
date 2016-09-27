Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F6A7207EC
	for <e@80x24.org>; Tue, 27 Sep 2016 02:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933214AbcI0CNb (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 22:13:31 -0400
Received: from mx2.imag.fr ([129.88.30.17]:47621 "EHLO mx2.imag.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932914AbcI0CNa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 22:13:30 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
        by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u8R2DNep010739
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Tue, 27 Sep 2016 04:13:24 +0200
Received: from z8-mb-verimag.imag.fr (z8-mb-verimag.imag.fr [129.88.4.38])
        by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u8R2DNCs013344;
        Tue, 27 Sep 2016 04:13:23 +0200
Date:   Tue, 27 Sep 2016 04:13:22 +0200 (CEST)
From:   Gustavo Grieco <gustavo.grieco@imag.fr>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Message-ID: <140080419.8376708.1474942402912.JavaMail.zimbra@imag.fr>
In-Reply-To: <xmqqtwd2sf9t.fsf@gitster.mtv.corp.google.com>
References: <1825523389.8224664.1474812766424.JavaMail.zimbra@imag.fr> <xmqqbmzbwmfc.fsf@gitster.mtv.corp.google.com> <790613313.8353074.1474912139102.JavaMail.zimbra@imag.fr> <xmqq37kmtukf.fsf@gitster.mtv.corp.google.com> <xmqqtwd2sf9t.fsf@gitster.mtv.corp.google.com>
Subject: Re: Stack read out-of-bounds in parse_sha1_header_extended using
 git 2.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [129.88.6.115]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF48 (Linux)/8.0.9_GA_6191)
Thread-Topic: Stack read out-of-bounds in parse_sha1_header_extended using git 2.10.0
Thread-Index: fLfagERWPSgNm6fR7/acxMnyHq/8Pw==
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Tue, 27 Sep 2016 04:13:24 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u8R2DNep010739
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: gustavo.grieco@imag.fr
MailScanner-NULL-Check: 1475547205.62871@AxRqlo0M3Od70vkJUw5qvw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Btw, this other test case will trigger a similar issue, but in another line of code:

To reproduce: 

$ git init ; mkdir -p .git/objects/b2 ; printf 'eJwNwoENgDAIBECkDsII5Z8CHagLGPePXu59zjHGRIOZG3OzI/lnRc4KemXDPdYSml6iQ+4ATIZ+nAEK4g==' | base64 -d > .git/objects/b2/93584ddd61af21260be75ee9f73e9d53f08cd0

Then:

$ git fsck

notice: HEAD points to an unborn branch (master)
=================================================================
==24569==ERROR: AddressSanitizer: stack-buffer-overflow on address 0x7ffe7645fda0 at pc 0x0000006fe799 bp 0x7ffe7645fc40 sp 0x7ffe7645fc30
READ of size 1 at 0x7ffe7645fda0 thread T0
    #0 0x6fe798 in parse_sha1_header_extended /home/g/Work/Code/git-2.10.0/sha1_file.c:1714
...

It will be nice to test the current patch.

----- Original Message -----
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I am inclined to say that it has no security implications.  You have
> > to be able to write a bogus loose object in an object store you
> > already have write access to in the first place, in order to cause
> > this ...
> 
> Note that you could social-engineer others to fetch from you and
> feed a small enough update that results in loose objects created in
> their repositories, without you having a direct write access to the
> repository.
> 
> The codepath under discussion in this thread however cannot be used
> as an attack vector via that route, because the "fetch from
> elsewhere" codepath runs verification of the incoming data stream
> before storing the results (either in loose object files, or in a
> packfile) on disk.
> 
> 
