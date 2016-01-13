From: Doug Kelly <dougk.ff7@gmail.com>
Subject: [PATCH v4 0/4] gc: Clean garbage .bitmap files from pack dir
Date: Wed, 13 Jan 2016 11:07:08 -0600
Message-ID: <cover.1452704305.git.dougk.ff7@gmail.com>
References: <1450483600-64091-1-git-send-email-dougk.ff7@gmail.com>
Cc: peff@peff.net, sbeller@google.com, Doug Kelly <dougk.ff7@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 13 18:08:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJOtw-0005S6-3f
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 18:08:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754539AbcAMRH2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 12:07:28 -0500
Received: from mail-ob0-f195.google.com ([209.85.214.195]:34685 "EHLO
	mail-ob0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890AbcAMRH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 12:07:27 -0500
Received: by mail-ob0-f195.google.com with SMTP id x5so526350obg.1
        for <git@vger.kernel.org>; Wed, 13 Jan 2016 09:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YtbQXuyoP5ugUhosisCr6PkvJipgMNEW5igdJ+uiNfs=;
        b=NIAMqMiXoJnxSwSGwRmAXxhBAAWt7JVBGoVGmBJt+28fPWuDjQE/8nnkgu0jeXxDJ7
         tw6e08DOtMd0/fQMqn2dQj2jEIpwDmGp65zbbfO1hujOF3IazTqowJj8G7jDiKixP6Wo
         t3tRkdwwWDuSRdehuWj1ZdvprVIV/g4o1BEOCDrdGYJrfHajO7uLJtPvGolETBWs9DTn
         OuUlT9KFsXOCTetzwyJF3FWu7ZKhZ3Zu1jWMKBiLIOgktTekdFfGNsQyUSPC2Ziy1zmI
         j/kHs6mVmxGZy4rcTFPlSC/+4hL9jCmjAu17kkLPj3kEVo1IFN+EZ5MsggZMiJc+UcPf
         Tt9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YtbQXuyoP5ugUhosisCr6PkvJipgMNEW5igdJ+uiNfs=;
        b=KYOkmgmYe0FtI7YX+gRfB1CQb+i4zmqmHWFbYdyL2ZHrde0CncogMGqxMlSn2OM6Ap
         93S4nr3jyAH6Y1XGPasdUq0X0mjG+GWlXrqHJQXc2SwE1lmJyv9LJ2yxmSBByHgyFYg7
         st1TBx8LG/aLJluRM+/wN0Ggx+Y8QWCJpuUqCLoMhugdR2OOH6nNsPxc/ClCW59W1/yR
         TP/d7j7W9C9WeHXSPduawrjK2hbpgWPbyK4K4vb30NCf7M47Vf03uO/jFSYAAkvmmhNU
         laO2u+Eka3w4pHn5m1CtrBFSGvShYzVHL4+Z89k2Tp/GE8LXNE4Y6gK6jE8sVrfO3fCm
         a/sA==
X-Gm-Message-State: ALoCoQlgaeX5wlTwyOZR3oP7cNuoGvvfP8QMjCJZ5/D+SgCgcG26Pv2ukTAKaBXO3tjoUUdZJJmBYYZ78n6R9NexeYGJB4FEZQ==
X-Received: by 10.182.19.131 with SMTP id f3mr108114319obe.26.1452704847125;
        Wed, 13 Jan 2016 09:07:27 -0800 (PST)
Received: from localhost.localdomain ([204.77.163.41])
        by smtp.gmail.com with ESMTPSA id dh8sm996371obb.2.2016.01.13.09.07.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Jan 2016 09:07:26 -0800 (PST)
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1450483600-64091-1-git-send-email-dougk.ff7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283942>

Updated version to prepare_packed_git based on additional feedback,
including Peff's idea to explicitly call out each file we want to
handle in gc.  Also adds a test case in t5304 to ensure files we
explicitly don't wnat to touch are not modified.

Doug Kelly (4):
  prepare_packed_git(): find more garbage
  t5304: Add test for .bitmap garbage files
  t5304: Ensure wanted files are not deleted
  gc: Clean garbage .bitmap files from pack dir

 builtin/count-objects.c | 16 ++++++----------
 builtin/gc.c            | 35 ++++++++++++++++++++++++++++++++++-
 cache.h                 |  4 +++-
 sha1_file.c             | 12 +++++++++---
 t/t5304-prune.sh        | 37 +++++++++++++++++++++++++++++++++++++
 5 files changed, 89 insertions(+), 15 deletions(-)

-- 
2.6.1
