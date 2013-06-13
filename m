From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/6] Fix git checkout - with rebase
Date: Thu, 13 Jun 2013 19:02:23 +0530
Message-ID: <1371130349-30651-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 13 15:31:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Un7c9-0003x5-7r
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 15:30:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758562Ab3FMNak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 09:30:40 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:60509 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758178Ab3FMNah (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 09:30:37 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so11398309pdj.28
        for <git@vger.kernel.org>; Thu, 13 Jun 2013 06:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=81JBnqjwBf8qC0pBsqk/Reo9IAghwKvkjKX+s5Pyclk=;
        b=css7ZnT7fbZkks5pKQZGOel/mpHfTrDV1WlGPMzscrzC3luy/Vg3jpBvvvVbOsG0nY
         5QjQr5cna7r/RcpUmt9lRXDXW0RUmonm+CwuDVfGrmvtqv20kLuAuFd8Q9CYPLnf92DD
         gAkv0dHhnUukari4b57b12GJT2ZKNs/S9JqFGHQH4twH1edHefdWmKvG/9y/8d7X2XV5
         ADtNEDiXGgBVft9C/Q7kYs1JgkNmeWzfdV+PA6+3yd3R/3FmFRIh1xQaQdknsokLk1zW
         hjlOuCSmTQcFeQsCEi9mknf3H7SM6elGPIZlSi+luwvKehVulEV4uVLFoRPtDin7aiiN
         7xnw==
X-Received: by 10.68.137.1 with SMTP id qe1mr463978pbb.100.1371130235754;
        Thu, 13 Jun 2013 06:30:35 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id re16sm4581222pac.16.2013.06.13.06.30.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 13 Jun 2013 06:30:34 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.384.g7cec0b4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227731>

Hi,

I'm happy to report that I have found a reasonable solution
to the problem: see [5/6].

The larger problem still persists: in my opinion, b397ea4 takes the
wrong approach to the problem it is attempting to solve; nobody cares
_how_ I got to a detached HEAD state; what is important is that I'm
stuck in such a state and need useful information.

The correct approach, in my opinion, is already taken by my prompt:
use git describe.

  artagnon|checkout-dash=$ git checkout @~1
  artagnon|(checkout-dash~1):~/src/git$

Now compare this with the approach taken by the patch:

  artagnon|(checkout-dash~1):~/src/git$ git status
  # HEAD detached at 7aa7992
  nothing added to commit but untracked files present

Completely useless.

Unfortunately, it is too late to revert b397ea4, as too much stuff
already depends on it now (see builtin/branch.c for example).
Reworking the code to use describe is not an easy task at all:
describe has no exposed API, and is polluted with die() statements.
Nevertheless, it can be a fruitful exercise for someone who is willing
to take on the challenge.

Thanks.

Ramkumar Ramachandra (6):
  t/checkout-last: checkout - doesn't work after rebase
  rebase: prepare to write reflog message for checkout
  rebase -i: prepare to write reflog message for checkout
  wt-status: remove unused field in grab_1st_switch_cbdata
  status: do not depend on flaky reflog messages
  checkout: respect GIT_REFLOG_ACTION

 builtin/checkout.c         | 11 ++++++++---
 git-rebase--interactive.sh |  2 ++
 git-rebase.sh              |  2 ++
 t/t2012-checkout-last.sh   | 16 ++++++++++++++++
 t/t7512-status-help.sh     | 37 +++++++++++++++++--------------------
 wt-status.c                | 13 ++++---------
 6 files changed, 49 insertions(+), 32 deletions(-)

-- 
1.8.3.1.384.g7cec0b4
