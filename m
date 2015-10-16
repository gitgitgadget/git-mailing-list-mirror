From: Stefan Beller <sbeller@google.com>
Subject: [RFC PATCHv1 00/12] git submodule update in C with parallel cloning
Date: Thu, 15 Oct 2015 18:52:01 -0700
Message-ID: <1444960333-16003-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 16 03:52:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmuC0-000264-GT
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 03:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752243AbbJPBwS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 21:52:18 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34128 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099AbbJPBwR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 21:52:17 -0400
Received: by payp3 with SMTP id p3so56444278pay.1
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 18:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ccm60c4PkroiP1a2G0SlKcX1h5DDcWSMXWn9IsCTcxg=;
        b=ArRnxrKWfnRaoVsjycTNElIoCR0tVzWQtuS2Ahh7Fe6jyXu6yHmYImZZGFFbrvY99P
         cZy8fA8fE00JKQFEqaLs8nhVofZFFohyngY6rmcaT1NWcNU9EPHSbfO/8nLAX1shUGZW
         papvyQFgBvhZXk7m8hqn/0AQFptmokHXbyznKcbX/0RvGUKzXgPfZlpdhpWgso2KhRLD
         pGHfQO/JeE6P9i8mP862nm3mltQG7XyEzUG7lsRBj3z1sbIn5Qrr2z4RZ1GS5SYyViOz
         wFFyE4GoReDysy1c6Sdmciiv0L1tLEulJYaGEpTs56eeWZocRF+giL2hcd6VMUU2f9C1
         0W2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ccm60c4PkroiP1a2G0SlKcX1h5DDcWSMXWn9IsCTcxg=;
        b=WoPbsWdT4Gcrq4/zFjpmCqjZk6tXc0ua1WoTKE86voDMi5pwJyWwxAAnnxvlY9bZj2
         IvPjOqfb1dAverw2WGYD5KQFC61UakotB5CGeTAe2J6LzeJk+eSYsyxDuDEeL0eCy1qG
         Ihna95Ku8hwi0BULfLCgprA8ukgggJDojR7ZoHXQJaXS+xbFIc0Jop1rSUSLI8dUjU2S
         PUWdM3P3Vi3ZuoDw9ZzwnAwuHt4W1Jmxk6llnqGtX4hHpb7x+NQffPcyWZ4UQrSwMZ/q
         UYflfb0zrYv5+K0jAbTba5NlxAxnmqbkmQbEayGVaDnPOJtxN6K5SY/yMV6eKvWhEh48
         r0xQ==
X-Gm-Message-State: ALoCoQn2oKR1pCtyJSRb5SU1VeQLPml+ZBoJyqn4Jsg6YZhJjWwkMBDs9tkEh9f1MXvjtXHWXgby
X-Received: by 10.67.1.73 with SMTP id be9mr13407581pad.35.1444960336543;
        Thu, 15 Oct 2015 18:52:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:8909:dd69:53c0:2cb6])
        by smtp.gmail.com with ESMTPSA id qj10sm485453pbb.8.2015.10.15.18.52.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 Oct 2015 18:52:15 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.277.gfdc362b.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279717>

So eventually we want to have projects with lots of submodules such as Android
(which would have O(1000) submodules).

The very first thing a user does is cloning a project, so we want to impress
with speed there as well. git clone however is lazy and just calls
`git submodule update --init --recursive`. So we need to make that fast.

This series rewrites parts of git submodule update in C and in the second-last
patch it separates cloning and doing the other actions(checkout/rebase/merge etc)
by doing the cloning first and then the rest.

The last patch (which is broken in the first version of the series), then 
proceeds to put the cloning of the submodules into the get_next_task callback
of the parallel process API.

That said, the first few patches introduce some churn in the behavior and tests
of Git, so maybe put your eyes there?

Thanks for any advice,
Stefan

Stefan Beller (12):
  git submodule update: Announce skipping submodules on stderr
  git submodule update: Announce uninitialized modules on stderr
  git submodule update: Move branch calculation to where it's needed
  git submodule update: Announce outcome of submodule operation to
    stderr
  git submodule update: Use its own list implementation.
  git submodule update: Handle unmerged submodules in C
  submodule config: keep update strategy around
  git submodule update: check for "none" in C
  git submodule update: Check url in C
  git submodule update: Clone projects from within C
  submodule--helper: Do not emit submodules to process directly.
  WIP/broken Clone all outstanding submodules in parallel

 builtin/submodule--helper.c | 221 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  38 +++-----
 submodule-config.c          |  11 +++
 submodule-config.h          |   1 +
 t/t7400-submodule-basic.sh  |  12 +--
 t/t7406-submodule-update.sh |  12 +--
 6 files changed, 256 insertions(+), 39 deletions(-)

-- 
2.5.0.277.gfdc362b.dirty
