Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B3CC4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 23:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C2D42371F
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 23:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730766AbgLPX22 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 18:28:28 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:37498 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgLPX22 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 18:28:28 -0500
X-Greylist: delayed 2074 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Dec 2020 18:28:27 EST
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1kpffT-001GeP-Bh; Wed, 16 Dec 2020 15:53:11 -0700
Received: from mta5.zcs.xmission.com ([166.70.13.69])
        by in01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <seth@eseth.com>)
        id 1kpffS-0003ee-Cn; Wed, 16 Dec 2020 15:53:10 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta5.zcs.xmission.com (Postfix) with ESMTP id 32C141280BD3;
        Wed, 16 Dec 2020 15:53:10 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta5.zcs.xmission.com
Received: from mta5.zcs.xmission.com ([127.0.0.1])
        by localhost (mta5.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hUlqNIB_W5Nr; Wed, 16 Dec 2020 15:53:10 -0700 (MST)
Received: from zms05.zcs.xmission.com (zms05.zcs.xmission.com [166.70.13.75])
        by mta5.zcs.xmission.com (Postfix) with ESMTP id 08CB01280BC7;
        Wed, 16 Dec 2020 15:53:10 -0700 (MST)
Date:   Wed, 16 Dec 2020 15:53:09 -0700 (MST)
From:   Seth House <seth@eseth.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        David Aguilar <davvid@gmail.com>, Johannes Sixt <j6t@kdbg.org>
Message-ID: <105041520.23756286.1608159189934.JavaMail.zimbra@eseth.com>
In-Reply-To: <xmqqa6ud2xuw.fsf@gitster.c.googlers.com>
References: <20201216174345.28146-1-felipe.contreras@gmail.com> <xmqqa6ud2xuw.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.60.10.209]
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - FF83 (Linux)/8.8.15_GA_3968)
Thread-Topic: mergetool: use resolved conflicts in all the views
Thread-Index: 6TTPYSebax0Im9qfQQj7F8sIKhj/gQ==
X-XM-SPF: eid=1kpffS-0003ee-Cn;;;mid=<105041520.23756286.1608159189934.JavaMail.zimbra@eseth.com>;;;hst=in01.mta.xmission.com;;;ip=166.70.13.69;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.69
X-SA-Exim-Mail-From: seth@eseth.com
Subject: Re: [RFC/PATCH] mergetool: use resolved conflicts in all the views
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I appreciate Felipe getting the discussion started.

On Wed, Dec 16, 2020 at 02:24:23PM -0800, Junio C Hamano wrote:
> If there is none, then what is the benefit of doing the same thing
> without running 3 checkout-index?

I wasn't aware of this plubming when I wrote the initial shell-script
version of the technique. This is a much better approach (even *if*
there's a negligible performance penalty). This nicely avoids
UNIX/Windows line-ending surprises, and instead leans on
already-configured Git defaults for those. Plus the non-text files
benefit you mentioned is also huge.

> as I understand "mergetool" is handed an
> already conflicted state and asked to resolve it, it would not be
> possible without at least looking at the stage #1 to recover the
> base for folks who do not use diff3 style.

I feel strongly that LOCAL, REMOTE, and BASE should be left intact for
this reason, Also because they aid readers in understanding the
pre-conflicts versions of the file.

Rather mergetools (that support it) should be given the stage 1-3
versions of the file in addition to the usual, unmodified, above three.
Then each tool can decide whether or how to show each. Some graphical
tools might be able to make effective use of all five (six?).

(Feedback & other ideas are very welcome.)

