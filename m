Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80BC220986
	for <e@80x24.org>; Thu,  6 Oct 2016 09:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942386AbcJFJqx (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 05:46:53 -0400
Received: from blade12.connectinternetsolutions.com ([193.110.243.152]:33294
        "EHLO blade12.connectinternetsolutions.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S942231AbcJFJqu (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 6 Oct 2016 05:46:50 -0400
X-Greylist: delayed 1851 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Oct 2016 05:46:50 EDT
Received: from [10.0.2.1] (linux01.cis [10.0.2.1])
        (authenticated bits=0)
        by blade12.connectinternetsolutions.com (8.13.8/8.13.8) with ESMTP id u969FnbO032022
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
        for <git@vger.kernel.org>; Thu, 6 Oct 2016 10:15:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=connectinternetsolutions.com; s=default; t=1475745350;
        bh=5GP/aPo3J+GtfnY3dj0kCsIG/RNRr/Ol2l149wZNwmk=;
        h=To:From:Subject:Date;
        b=i4JEZ/A5BbAgsxKVv2X0gs5RJ86MUQkePdaXZlEfWHa9jp1wTH6Ej/8ZIorFU02iF
         zOVRh6EmEsyzAPeDuKwWH9zHPfFj/HVFeUpcMrvSEMQlBmPzQO3QdfN3AX9jtPiP21
         P5OdnmGF3tklGcEWOSf5IhL1+r0kJwUhNAQbqTjs=
To:     git@vger.kernel.org
From:   Richard Lloyd <richard.lloyd@connectinternetsolutions.com>
Subject: Systems with old regex system headers/libraries don't pick up git's
 compat/regex header file
Message-ID: <9f43a2f1-5d7e-3a2e-5a83-40e92ab0d7b5@connectinternetsolutions.com>
Date:   Thu, 6 Oct 2016 10:15:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Company-Sig: added
X-Scanned-By: MIMEDefang 2.70 on 10.0.1.186
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (blade12.connectinternetsolutions.com [10.0.1.186]); Thu, 06 Oct 2016 10:15:50 +0100 (BST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git ships with a compat/regex tree containing a recent regex
release, presumably with the intention of allowing systems with
either no regex or an old regex installed to use the newer compat
version.

With the release of git-2.10.1, the use of a recent regex
is now specifically checked in git-compat-util.h via a
#ifndef REG_STARTEND check at line 979.

Unfortunately, on systems with an older regex shipped as
standard (e.g. HP-UX 11), the include path picks up
/usr/include/regex.h first, which doesn't define REG_STARTEND
and the git-compat-util.h check fails.

The fix I applied on HP-UX 11 was to add -Icompat/regex
to the CFLAGS ahead of other -I directives. Another possible
change needed might be to line 69 of compat/regex/regex.c:

#include "regex.h"

This is to ensure that /usr/include/regex.h isn't picked up
(since git ships its own regex.h in the compat/regex
dir, it probably shouldn't #include <regex.h> anyway,
which risks picking up an incompatible regex.h).

Richard K. Lloyd,           E-mail: richard.lloyd@connectinternetsolutions.com
Connect Internet Solutions,    WWW: https://www.connectinternetsolutions.com/
4th Floor, New Barratt House,
47, North John Street,
Liverpool,
Merseyside, UK. L2 6SG



-- 
This e-mail (and any attachments) is private and confidential. If you have 
received it in error, please notify the sender immediately and delete it 
from your system. Do not use, copy or disclose the information in any way 
nor act in reliance on it.

Any views expressed in this message are those of the individual sender,
except where the sender specifically states them to be the views of Connect
Internet Solutions Ltd. This e-mail and any attachments are believed to be
virus free but it is the recipient's responsibility to ensure that they are.

Connect Internet Solutions Ltd
(A company registered in England No: 04424350)
Registered Office: 4th Floor, New Barratt House, 47 North John Street,
Liverpool, L2 6SG
Telephone: +44 (0) 151 282 4321
VAT registration number: 758 2838 85
