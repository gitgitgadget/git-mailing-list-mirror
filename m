Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AADAF1FD09
	for <e@80x24.org>; Tue, 30 May 2017 11:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751025AbdE3LDl (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 07:03:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52174 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750912AbdE3LDk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 07:03:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DA19DC056791;
        Tue, 30 May 2017 11:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com DA19DC056791
Authentication-Results: ext-mx08.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx08.extmail.prod.ext.phx2.redhat.com; spf=pass smtp.mailfrom=lersek@redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.redhat.com DA19DC056791
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-87.phx2.redhat.com [10.3.116.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 21264183CB;
        Tue, 30 May 2017 11:03:38 +0000 (UTC)
Subject: Re: FORMAT_PATCH_NAME_MAX increase
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <99ac8ee7-67b5-5ae7-51cf-6be38de6217f@redhat.com>
 <xmqqh903dt4w.fsf@gitster.mtv.corp.google.com>
From:   Laszlo Ersek <lersek@redhat.com>
Message-ID: <70d34f37-7209-e392-c269-21a61228a041@redhat.com>
Date:   Tue, 30 May 2017 13:03:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqh903dt4w.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 30 May 2017 11:03:40 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/30/17 03:34, Junio C Hamano wrote:

> I cannot offhand guess what other places would suffer from such a
> project convention, because I do not work with such a project, but
> you may be able to come up with a list of various places in Git
> where the commit titles are used, and that if there were a mechanism
> to take these commit titles, pass them to your cutomization script,
> which abbreviates these "long common prefixes" to a shorter string,
> and to use the output from that script instead of the actual commit
> title, it would help all of these places.

The problem is that I can't really automate the subject munging. The
concrete subjects in this case were:

> OvmfPkg/QemuFwCfgLib: Implement SEV internal function for SEC phase
> OvmfPkg/QemuFwCfgLib: Implement SEV internal functions for PEI phase
> OvmfPkg/QemuFwCfgLib: Implement SEV internal function for Dxe phase

which got formatted as

> 0010-OvmfPkg-QemuFwCfgLib-Implement-SEV-internal-function.patch
> 0011-OvmfPkg-QemuFwCfgLib-Implement-SEV-internal-function.patch
> 0012-OvmfPkg-QemuFwCfgLib-Implement-SEV-internal-function.patch

and these filenames differ only in the running counter on the left.

The patch subjects themselves aren't overlong (the longest is 68
characters).

At best I could "normalize away" the "OvmfPkg/QemuFwCfgLib" prefix, but
that exact prefix is pretty accidental. Any standalone module (driver or
library instance) in the edk2 project is supposed to be named like this
in patch subjects, so all those prefixes would have to be normalized
somehow.

We generally try to limit subjects (and commit messages in general) to
74 columns. I think for one source of inspiration, we used the kernel
documentation, when setting that limit.
<https://www.kernel.org/doc/Documentation/process/submitting-patches.rst>
says, under section 14, "The canonical patch format",

> The canonical patch subject line is::
>
>     Subject: [PATCH 001/123] subsystem: summary phrase
>
> The canonical patch message body contains the following:
>
>   [...]
>
>   - The body of the explanation, line wrapped at 75 columns, which will
>     be copied to the permanent changelog to describe this patch.

It does not specify the subject length, but perhaps we can apply the
body line length to the subject as well.

So, even in kernel land, if subjects up to 75 columns are permitted, but
FORMAT_PATCH_NAME_MAX is 64, conflicts are possible, at least in theory,
aren't they? With the numbers stripped, of course.

Thanks,
Laszlo
