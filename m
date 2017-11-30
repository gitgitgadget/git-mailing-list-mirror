Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3A7F20954
	for <e@80x24.org>; Thu, 30 Nov 2017 10:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750918AbdK3K2S (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 05:28:18 -0500
Received: from mail-ot0-f171.google.com ([74.125.82.171]:41394 "EHLO
        mail-ot0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbdK3K2R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 05:28:17 -0500
Received: by mail-ot0-f171.google.com with SMTP id b54so5674489otd.8
        for <git@vger.kernel.org>; Thu, 30 Nov 2017 02:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=LLgZayrx2BE/KYigOqAkfliesbs2lncR1gS6aYo2jLI=;
        b=EgGBRE8fng9BrcutXHmakYNZIbpxRrA+nydgCSfNuuDLGtJOsFv4ZYXYS3MywFKmVG
         Q3ZXPnaAaZ2yQ+BiZrm9gwOclLCpmVU4e/CV9POc79DAmGnnXLvuZHc0m2lm4A6SyU9x
         FA/O+Jz2SrX1B9Qqq7NrQQrtjvz1q9y996m17/70uSUuVGl2M9i2Tb2qkBxeAw3qt+BO
         CVQx+j2LGIizhqn+57clB95fw/rLozvMZaG89hgXXJqNqfDUCVQobSdy/LhFsPMN4Xwu
         ucsy5WSScdZokcpy2Po6wEutCDjqwdQAi4w1wB5RcTzHef9cDpG+goM7LKPdWeUmod1E
         FvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=LLgZayrx2BE/KYigOqAkfliesbs2lncR1gS6aYo2jLI=;
        b=c5VQ91ZI9MCgm/fnF7pZJJeC/FGDr7rBFRx927TXF4VFoKm+YcDJLKR2QHyN39DmhX
         LCLD7gPJR9TGY8Aex+4FAxEJTF/FYjvavRuHTkgjJ0Gh4+CDrnUnP6A2c2L50ZIspFQB
         He3WvV+zuaJQ243C7Op24taDM+CwjUE57Y5fkbkwxJCtToRysP6qwkW1iBWa7CvTYjwC
         J2q7JCHwCxlPinkBtOR5oINOyHNTtRb3x21tu4/VVe1lkZQH2mmWtvwuRNzCGPcFY8JJ
         CEUPIqEagu15hIC6myNXrdEEw0HUBWrt7gY1DEoX76p6mhQncKdz/30O15HsX8+Nr2IE
         q8oQ==
X-Gm-Message-State: AJaThX5d47hVOrVExDPfNq6aUZNQPko2lkUJzzfQuaNEWfEzWUHjVTFp
        zEgxftfiT+owCxhFQVSOWdn2koINlfkdUJquxJaNDDlN
X-Google-Smtp-Source: AGs4zMZkO6l1G0/Dz24O73ipKM7dL1dvIcGJX401kUXK/BiSV1oO4srm9pLz9C91a3zANzHTIEfRdRFdc1JlcWIHLrg=
X-Received: by 10.157.12.65 with SMTP id 59mr4432212otr.183.1512037696938;
 Thu, 30 Nov 2017 02:28:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.1.161 with HTTP; Thu, 30 Nov 2017 02:28:16 -0800 (PST)
From:   Dmitry Neverov <dmitry.neverov@gmail.com>
Date:   Thu, 30 Nov 2017 11:28:16 +0100
Message-ID: <CAC+L6n3D1O+7U2F4sn6O+UD25t6hMGECMYZWgb45_FW6TBLz1g@mail.gmail.com>
Subject: Bare repository fetch/push race condition
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It looks like there is a race condition between fetch and push in a
bare repository in the following setup. There is a bare git repository
on a local file system. Some process pushes to this repository via
jgit. There is a cron task which pushes this repository to the backup
remote repo over ssh. We observe the following in the reflog:

6932a831843f4dbe3b394acde9adc9a8269b6cf1
57b77b8c2a04029e7f5af4d3b7e36a3ba0c7cac9 XXX 1505903078 +0200    push:
forced-update
57b77b8c2a04029e7f5af4d3b7e36a3ba0c7cac9
44a221b0271b9abc885dd6e54f691d5248c4171f XXX 1505905206 +0200    push:
forced-update
44a221b0271b9abc885dd6e54f691d5248c4171f
57b77b8c2a04029e7f5af4d3b7e36a3ba0c7cac9 YYY    1505905217 +0200
update by push

Where XXX is the process pushing via jgit and YYY is the cron task. It
looks like the cron task started a push when the ref was pointing to
57b77b8c2a04029e7f5af4d3b7e36a3ba0c7cac9 and push finished when the
ref was already updated to 44a221b0271b9abc885dd6e54f691d5248c4171f.
The push unconditionally updated the local tracking branch back to the
commit 57b77b8c2a04029e7f5af4d3b7e36a3ba0c7cac9 and we lost the commit
44a221b0271b9abc885dd6e54f691d5248c4171f since the next push from the
local process created a new commit with
57b77b8c2a04029e7f5af4d3b7e36a3ba0c7cac9 as a parent.

Shouldn't the update_ref at transport.c:308 specify the expected
old hash, like this:

    update_ref("update by push", rs.dst, ref->new_oid.hash,
ref->old_oid.hash, 0, 0);

at least for bare repositories?
