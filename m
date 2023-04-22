Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BF3C7618E
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 18:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjDVSkQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 14:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDVSkP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 14:40:15 -0400
X-Greylist: delayed 2292 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 22 Apr 2023 11:40:14 PDT
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [IPv6:2a0c:5a00:149::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4A31726
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 11:40:14 -0700 (PDT)
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
        by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <admin@game-point.net>)
        id 1pqHYd-0090Dr-7f
        for git@vger.kernel.org; Sat, 22 Apr 2023 20:01:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=game-point.net; s=selector2; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To;
        bh=al2GHbge6lnsTvKiSFxD6j3ROebOSzToT8hV/KtsY2c=; b=WGnSRFgAJwxApHfpm0J650bKr1
        M5eZkOcRbOxfSkZQR/CXuySFciIG7fp6QvnEw/yE49M9S91YH2of1eH51G6bTBurcAF7ZMdM1PUji
        Bgffel7knCzMUfsKpAsNHf1Zzt76xmNZdo+G4H98rP7W5/qXS2lZAh1OrpXSd6Gm1mfHHQsbj683K
        RifRfgq2Kh4otLoXxFEqUmChvBjCy8q1oGffhjap5/TW50iYra6fns+hyC+SOvCp/8IbxuBXgahpP
        T9K3dw12TWAhcoas/5Fe7DNrCJQPZQq5PM+M0wFlqh39pJpI2nA6BaxxJetMSYSwN4mlBaSoLHbts
        Vtb6WHSQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
        by mailtransmit03.runbox with esmtp (Exim 4.86_2)
        (envelope-from <admin@game-point.net>)
        id 1pqHYc-0006Ny-Qo
        for git@vger.kernel.org; Sat, 22 Apr 2023 20:01:59 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (956903)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1pqHYU-0005fP-7q
        for git@vger.kernel.org; Sat, 22 Apr 2023 20:01:50 +0200
To:     git@vger.kernel.org
From:   Jeremy Morton <admin@game-point.net>
Subject: Proposal: tell git a file has been renamed
Message-ID: <8fe188a9-c01f-9fb5-5877-8ff508094b22@game-point.net>
Date:   Sat, 22 Apr 2023 19:01:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yes, I know Linus specifically doesn't store file rename info in Git. 
The trouble is, every now and then, I'll come across a situation where 
Git doesn't successfully detect that I've renamed a file because I'm 
doing something like renaming a class at the same time.  So I'll have 
a file OldClassNameTests.cs and a NewClassNameTests.cs but a bunch of 
lines in that file have also changed from OldClassName.DoThing() to 
NewClassName.DoThing().  I can clearly see that this is a rename, but 
Git sees enough changed content that it doesn't realize it, and puts 
it in as a delete/add, losing the content history.

The standard answer for this is to rename the file in one commit, then 
make the changes.  That's fine if you know ahead of time you'll want 
to do this.  However it's a total PITA if you have a bunch of changes 
and you realize that a rename has caused this problem.  You now have 
to back out your changes to the renamed file, add the rename, commit 
it, then re-apply the changes.

Could a command be added to git that means you tell Git that counts as 
a file rename?  Git would add a marker to the staging area that the 
file has been renamed, and upon commit, would first generate an 
additional commit for each rename before generating the main commit, 
ensuring the rename operation counts as an actual rename, and the 
content's history is maintained.

-- 
Best regards,
Jeremy Morton (Jez)
