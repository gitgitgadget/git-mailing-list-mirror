Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32193C4363A
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 15:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0EE0208B3
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 15:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eof-studios.com header.i=@eof-studios.com header.b="vpYeGwlH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465515AbgJWPCa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 11:02:30 -0400
Received: from mail-proxyout-mua-8.websupport.eu ([37.9.172.158]:38771 "EHLO
        mail-proxyout-mua-8.websupport.eu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S461452AbgJWPCa (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 23 Oct 2020 11:02:30 -0400
X-Greylist: delayed 565 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Oct 2020 11:02:29 EDT
Received: from in-4.websupport.sk (unknown [10.10.2.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail-proxyout-mua-8.websupport.eu (Postfix) with ESMTPS id 4A078E4959
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 16:53:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eof-studios.com;
        s=mail; t=1603464782;
        bh=yN3w2vWUZHC020n/TLapiFXvMdakQ87NOxNWPFau2h8=;
        h=To:From:Subject:Date;
        b=vpYeGwlHtUYrw53tR1bBBTUuSRLAnSxKIS2XDg5Asqn1SjtbTxrb/xb/frLGSzodo
         9XHoVoX6C+eTx/eaZ25kLwW1j6rk10TWee3yfePSeApPfVLhbcCOhUOIFLyjcUBfSW
         lPTTKg+cpwgvXQSwF4Uh3RVpSqHlHTEy8dI35jgo=
Received: from [192.168.1.16] (unknown [90.64.166.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mrva@eof-studios.com)
        by in-4.websupport.sk (Postfix) with ESMTPSA id 4CHnKB0cvMz11NBm
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 16:53:02 +0200 (CEST)
To:     git@vger.kernel.org
From:   Marek Mrva <mrva@eof-studios.com>
Subject: [bug] Stashes lost after out-of-memory situation
Message-ID: <65a3061a-47ef-9ca6-2468-5449cfc5b37c@eof-studios.com>
Date:   Fri, 23 Oct 2020 16:53:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Out-Rspamd-Queue-Id: 4CHnKB0cvMz11NBm
Authentication-Results: in-4.websupport.sk;
        auth=pass smtp.auth=mrva@eof-studios.com smtp.mailfrom=mrva@eof-studios.com
X-Out-Rspamd-Server: mail-antispam-5
X-Out-Spamd-Result: default: False [-2.10 / 1000.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         TO_DN_NONE(0.00)[];
         RCPT_COUNT_ONE(0.00)[1];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:15962, ipnet:90.64.0.0/16, country:SK];
         MID_RHS_MATCH_FROM(0.00)[];
         BAYES_HAM(-2.00)[99.99%]
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, hopefully this is the correct mailing list - apologies if it is not.

After issuing "git stash pop" while being low on memory, the following 
was printed to the console:

       0 [main] git 2061 fhandler_disk_file::fixup_mmap_after_fork: 
requested 0x6FFFC1550000 != 0x0 mem alloc base 0x0, state 0x10000,
size 17545957736448, Win32 error 1455
   36836 [main] git 2061 C:\cygwin64\bin\git.exe: *** fatal error in 
forked process - recreate_mmaps_after_fork_failed
   37523 [main] git 2061 cygwin_exception::open_stackdumpfile: Dumping 
stack trace to git.exe.stackdump
       0 [main] git 2056 dofork: child -1 - forked process 12100 died 
unexpectedly, retry 0, exit code 0x100, errno 11
error: cannot fork() for status: Resource temporarily unavailable
Dropped refs/stash@{0} (06d44ccc5ed2ac93b370100f481147ae4f0065db)
error: cannot fork() for rev-parse: Resource temporarily unavailable

Afterwards, the result of "git stash list" is empty, even though there 
used to be more than 10+ stashes saved.

Obviously while being low on memory, one should not expect commands to 
run properly. Losing all the *other* stashes could hopefully be somehow 
avoided, if possible. It is worth mentioning this happened in a cygwin 
environment on Windows.

Any help would be greatly appreciated! :)


With best regards,
Marek Mrva

