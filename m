From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/2] Port `git submodule init` from shell to C
Date: Fri, 12 Feb 2016 15:39:14 -0800
Message-ID: <1455320356-15778-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com,
	Jens.Lehmann@web.de
X-From: git-owner@vger.kernel.org Sat Feb 13 00:39:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUNJ6-00005f-JW
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 00:39:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbcBLXjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2016 18:39:20 -0500
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34064 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974AbcBLXjT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 18:39:19 -0500
Received: by mail-pf0-f175.google.com with SMTP id x65so54795988pfb.1
        for <git@vger.kernel.org>; Fri, 12 Feb 2016 15:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=+fUrcaF03yAlZbBWMMN5+rTfWhQNQ7Zz6XCaxkH1AUQ=;
        b=gIH1s+kLKm+skoWC2x2QwVC3mg2qeiY8sl0Z8bKC5VQBBgaQXfCAmVF+gB43IDpWtW
         KDqPqHuFeWNi7HhyGVVqfvqi0dSm5pL72oOZpiRSy2vxJE7KeLOKm0oWFvKwhEAv8rpM
         3w5vnrxIpGofhFI4l4tL5wJcr5QQrwvhA9/NwU8tWG+vVh2UkMpleEM76YlGz/H7JJTS
         IHoWiWZIIX7rro+yVfwTzF98N/qmn/kh+pmL9IoKT7HhL2l4tUyV4jzO7ON2hj5Ac/R1
         RrdzsBJ45GAyGMyL6h1sCT+ip9BZzgjAo6CoqnmwLqZOpIut+HFvj3WYhLMDCXW+m57c
         q9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+fUrcaF03yAlZbBWMMN5+rTfWhQNQ7Zz6XCaxkH1AUQ=;
        b=BKBZQ5JbqZxqA1qw8NCMUWG6y3ZkTyqykKhSbTdEs1hxsy226lQPmk7tKSAFNkP6Og
         v9iFPUcO1FrfDFZ6K6nEKucRDgR5epWr5nb2RVbNtc8VQdMiemqp8IqAfKltB4ZBugpF
         HHc5vmIiJpwFMYZ/JtBWz87OnrV6xaGV35IiN/Zi3Mw5v8AGTXNB+va/uIS+p1sl0pVl
         eVKScbSCI2g4mdSYOeKp1VPxFLbleyXpTNKH01N+cHZKFAd+tjeoF79bYISL58kkAMbz
         4sbQ+MLbT/2aw+H4ZR5ZryXxREsi90lbEpcgR+CKfoCZAtWwAMmYYqkTSjmc5INypzz3
         /tMA==
X-Gm-Message-State: AG10YOSk//bFzneddKB05P0Mry1XMUfquTV90e5YNwCP994SuCPrvxJKo8qaltsK79fpXJ5H
X-Received: by 10.98.0.71 with SMTP id 68mr5991540pfa.156.1455320359096;
        Fri, 12 Feb 2016 15:39:19 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:f1e7:203f:9d1e:8193])
        by smtp.gmail.com with ESMTPSA id xz6sm21855159pab.42.2016.02.12.15.39.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 12 Feb 2016 15:39:18 -0800 (PST)
X-Mailer: git-send-email 2.7.1.292.g18a4ced.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286092>

This applies on top of the just sent series which is going to replace
sb/submodule-parallel-update, replacing sb/submodule-init.

* Using enums for the submodule update strategy now.

Thanks,
Stefan

Stefan Beller (2):
  submodule: port resolve_relative_url from shell to C
  submodule: port init from shell to C

 builtin/submodule--helper.c | 315 +++++++++++++++++++++++++++++++++++++++++++-
 git-submodule.sh            | 118 +----------------
 submodule.c                 |  21 +++
 submodule.h                 |   1 +
 t/t0060-path-utils.sh       |  42 ++++++
 5 files changed, 382 insertions(+), 115 deletions(-)

-- 
2.7.1.292.g18a4ced.dirty
